import 'package:flutter/material.dart';

import '../services/student_service.dart';

class DeleteStudentPage extends StatefulWidget {
  const DeleteStudentPage({super.key});

  @override
  State<DeleteStudentPage> createState() => _DeleteStudentPageState();
}

class _DeleteStudentPageState extends State<DeleteStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  bool _isDeleting = false;

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }

  Future<void> _deleteStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isDeleting = true;
    });

    final messenger = ScaffoldMessenger.of(context);
    try {
      await StudentService().deleteStudentByStudentId(_studentIdController.text);
      _studentIdController.clear();
      messenger.showSnackBar(
        const SnackBar(content: Text('Student deleted successfully')),
      );
    } on StateError {
      messenger.showSnackBar(
        const SnackBar(content: Text('Student ID not found')),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Delete failed: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _studentIdController,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter the student ID';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: _isDeleting ? null : _deleteStudent,
              child: _isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}

