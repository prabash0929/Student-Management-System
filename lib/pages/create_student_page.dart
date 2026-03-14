import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/student_service.dart';
import '../widgets/student_form.dart';

class CreateStudentPage extends StatelessWidget {
  const CreateStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: StudentForm(
        submitLabel: 'Submit',
        onSubmit: (student) async {
          await studentService.createStudent(
            Student(
              id: '',
              name: student.name,
              studentId: student.studentId,
              email: student.email,
              course: student.course,
              age: student.age,
            ),
          );

          if (!context.mounted) {
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student created successfully')),
          );
        },
      ),
    );
  }
}

