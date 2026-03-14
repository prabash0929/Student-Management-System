import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/student.dart';

class StudentService {
  StudentService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _students =>
      _firestore.collection('students');

  Stream<List<Student>> watchStudents() {
    return _students
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(Student.fromFirestore).toList());
  }

  Future<void> createStudent(Student student) async {
    final existingStudent = await findByStudentId(student.studentId);
    if (existingStudent != null) {
      throw StateError('A student with this student ID already exists');
    }

    await _students.add(student.toMap());
  }

  Future<void> updateStudent(Student student) async {
    final snapshot = await _students
        .where('studentId', isEqualTo: student.studentId.trim())
        .limit(2)
        .get();

    final duplicateExists = snapshot.docs.any((doc) => doc.id != student.id);
    if (duplicateExists) {
      throw StateError('A student with this student ID already exists');
    }

    await _students.doc(student.id).update(<String, dynamic>{
      'name': student.name,
      'studentId': student.studentId,
      'email': student.email,
      'course': student.course,
      'age': student.age,
    });
  }

  Future<void> deleteStudentByDocumentId(String id) async {
    await _students.doc(id).delete();
  }

  Future<Student?> findByStudentId(String studentId) async {
    final snapshot = await _students
        .where('studentId', isEqualTo: studentId.trim())
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return Student.fromFirestore(snapshot.docs.first);
  }

  Future<void> deleteStudentByStudentId(String studentId) async {
    final student = await findByStudentId(studentId);
    if (student == null) {
      throw StateError('Student not found');
    }

    await deleteStudentByDocumentId(student.id);
  }
}
