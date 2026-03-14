import 'package:flutter/material.dart';

import '../models/student.dart';

typedef StudentFormSubmit = Future<void> Function(Student student);

class StudentForm extends StatefulWidget {
  const StudentForm({
    super.key,
    required this.submitLabel,
    required this.onSubmit,
    this.initialStudent,
  });

  final String submitLabel;
  final StudentFormSubmit onSubmit;
  final Student? initialStudent;

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _emailController;
  late final TextEditingController _courseController;
  late final TextEditingController _ageController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final student = widget.initialStudent;
    _nameController = TextEditingController(text: student?.name ?? '');
    _studentIdController = TextEditingController(text: student?.studentId ?? '');
    _emailController = TextEditingController(text: student?.email ?? '');
    _courseController = TextEditingController(text: student?.course ?? '');
    _ageController = TextEditingController(
      text: student == null ? '' : student.age.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _courseController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final messenger = ScaffoldMessenger.of(context);
    try {
      await widget.onSubmit(
        Student(
          id: widget.initialStudent?.id ?? '',
          name: _nameController.text.trim(),
          studentId: _studentIdController.text.trim(),
          email: _emailController.text.trim(),
          course: _courseController.text.trim(),
          age: int.parse(_ageController.text.trim()),
          createdAt: widget.initialStudent?.createdAt,
        ),
      );

      if (widget.initialStudent == null) {
        _formKey.currentState!.reset();
        _nameController.clear();
        _studentIdController.clear();
        _emailController.clear();
        _courseController.clear();
        _ageController.clear();
      }
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Operation failed: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildTextField(
            controller: _nameController,
            label: 'Name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter the student name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _studentIdController,
            label: 'Student ID',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter the student ID';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter the email address';
              }
              final email = value.trim();
              if (!email.contains('@') || !email.contains('.')) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _courseController,
            label: 'Course',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter the course';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _ageController,
            label: 'Age',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter the age';
              }
              final age = int.tryParse(value.trim());
              if (age == null || age <= 0) {
                return 'Enter a valid age';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(widget.submitLabel),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
