import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  const Student({
    required this.id,
    required this.name,
    required this.studentId,
    required this.email,
    required this.course,
    required this.age,
    this.createdAt,
  });

  final String id;
  final String name;
  final String studentId;
  final String email;
  final String course;
  final int age;
  final DateTime? createdAt;

  factory Student.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    return Student(
      id: doc.id,
      name: data['name'] as String? ?? '',
      studentId: data['studentId'] as String? ?? '',
      email: data['email'] as String? ?? '',
      course: data['course'] as String? ?? '',
      age: (data['age'] as num?)?.toInt() ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'studentId': studentId,
      'email': email,
      'course': course,
      'age': age,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  Student copyWith({
    String? id,
    String? name,
    String? studentId,
    String? email,
    String? course,
    int? age,
    DateTime? createdAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
      course: course ?? this.course,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
