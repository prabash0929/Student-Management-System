import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/student_service.dart';
import 'edit_student_page.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentService = StudentService();

    return StreamBuilder<List<Student>>(
      stream: studentService.watchStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Failed to load students.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final students = snapshot.data ?? <Student>[];
        if (students.isEmpty) {
          return const Center(
            child: Text('No student records found.'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: students.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final student = students[index];
            return _StudentCard(student: student);
          },
        );
      },
    );
  }
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          student.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _InfoText(student.studentId),
              _InfoText(student.email),
              _InfoText(student.course),
              _InfoText('Age: ${student.age}'),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => EditStudentPage(student: student),
              ),
            );
          },
          icon: const Icon(Icons.edit, color: Colors.white),
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

