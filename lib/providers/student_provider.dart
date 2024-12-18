import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';


class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier() : super([]) {
    fetchStudents();
  }

  final DatabaseReference _db = FirebaseDatabase.instance.ref('students');
  Student? _pendingDelete;
  int? _pendingDeleteIndex;
  bool isLoading = true; 

  Future<void> fetchStudents() async {
    try {
      final snapshot = await _db.get();

      // Simulate a loading time to show the Loading element
      await Future.delayed(const Duration(seconds: 3));

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final fetchedStudents = data.entries.map((entry) {
          final studentData = entry.value as Map<dynamic, dynamic>;
          return Student(
            firstName: studentData['firstName'],
            lastName: studentData['lastName'],
            department: Department.values.firstWhere(
              (d) => d.toString() == studentData['department'],
            ),
            grade: studentData['grade'],
            gender: Gender.values.firstWhere(
              (g) => g.toString() == studentData['gender'],
            ),
          );
        }).toList();
        state = fetchedStudents;
      }
    } catch (e) {
      print('Failed to fetch students: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> addStudent(Student student) async {
    try {
      final newRef = _db.push();
      await newRef.set({
        'firstName': student.firstName,
        'lastName': student.lastName,
        'department': student.department.toString(),
        'grade': student.grade,
        'gender': student.gender.toString(),
      });
      state = [...state, student];
    } catch (e) {
      print('Failed to add student: $e');
    }
  }

  void addStudentAt(int index, Student student) {
    final students = [...state];
    students.insert(index, student);
    state = students;

    _pendingDelete = null;
    _pendingDeleteIndex = null;
  }

  Future<void> editStudent(int index, Student updatedStudent) async {
    try {
      final studentKey = state[index];
      final snapshot = await _db.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final studentId = data.keys.elementAt(index);
        final ref = _db.child(studentId);

        await ref.update({
          'firstName': updatedStudent.firstName,
          'lastName': updatedStudent.lastName,
          'department': updatedStudent.department.toString(),
          'grade': updatedStudent.grade,
          'gender': updatedStudent.gender.toString(),
        });

        final updatedState = [...state];
        updatedState[index] = updatedStudent;
        state = updatedState;
      }
    } catch (e) {
      print('Failed to edit student: $e');
    }
  }

  void deleteStudent(int index) {
    _pendingDelete = state[index];
    _pendingDeleteIndex = index;

    final students = [...state];
    students.removeAt(index);
    state = students;
  }

  Future<void> finalizeDelete() async {
    if (_pendingDelete != null && _pendingDeleteIndex != null) {
      try {
        final snapshot = await _db.get();
        if (snapshot.exists) {
          final data = snapshot.value as Map<dynamic, dynamic>;
          final studentId = data.keys.elementAt(_pendingDeleteIndex!);

          await _db.child(studentId).remove();
        }
        _pendingDelete = null;
        _pendingDeleteIndex = null;
      } catch (e) {
        print('Failed to finalize delete: $e');
      }
    }
  }
}

final studentProvider = StateNotifierProvider<StudentNotifier, List<Student>>(
  (ref) => StudentNotifier(),
);

final departmentStudentCountsProvider = Provider<Map<Department, int>>((ref) {
  final students = ref.watch(studentProvider);

  final counts = <Department, int>{
    for (var department in Department.values) department: 0,
  };

  for (var student in students) {
    counts[student.department] = (counts[student.department] ?? 0) + 1;
  }

  return counts;
});

class DeletedStudentNotifier extends StateNotifier<Map<int, Student>> {
  DeletedStudentNotifier() : super({});

  void setDeletedStudent(int index, Student student) {
    state = {index: student};
  }

  void clearDeletedStudent() {
    state = {};
  }
}

final deletedStudentProvider =
    StateNotifierProvider<DeletedStudentNotifier, Map<int, Student>>(
  (ref) => DeletedStudentNotifier(),
);
