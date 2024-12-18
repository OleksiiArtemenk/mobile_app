import 'package:flutter/material.dart';
import 'package:oleksiiartemenko/models/student.dart';
import 'package:oleksiiartemenko/widgets/student_item.dart';
import 'package:oleksiiartemenko/widgets/new_student.dart';

class Students extends StatelessWidget {
  const Students({
    super.key,
    required this.students,
    required this.onDelete,
    required this.onEdit,
  });

  final List<Student> students;
  final Function(int) onDelete;
  final Function(int, Student) onEdit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Dismissible(
          key: Key(student.firstName + student.lastName),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            onDelete(index);
          },
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => NewStudent(
                  onSave: (updatedStudent) {
                    onEdit(index, updatedStudent);
                  },
                  existingStudent: student,
                ),
              );
            },
            child: StudentItem(student: student),
          ),
        );
      },
    );
  }
}
