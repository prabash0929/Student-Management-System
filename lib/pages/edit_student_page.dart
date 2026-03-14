import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/student_service.dart';
import '../widgets/student_form.dart';

class EditStudentPage extends StatelessWidget {
  const EditStudentPage({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();

    return Scaffold(
      appBar: AppBar(title: const Text('Update')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StudentForm(
          initialStudent: student,
          submitLabel: 'Update',
          onSubmit: (updatedStudent) async {
            await studentService.updateStudent(
              updatedStudent.copyWith(id: student.id),
            );

            if (!context.mounted) {
              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Student updated successfully')),
            );
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

