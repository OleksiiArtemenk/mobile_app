import 'package:flutter/material.dart';
import 'package:oleksiiartemenko/models/student.dart';
import 'package:oleksiiartemenko/widgets/text_input_field.dart';
import 'package:oleksiiartemenko/widgets/dropdown_input_field.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key, required this.onSave, this.existingStudent});

  final Function(Student) onSave;
  final Student? existingStudent;

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController gradeController;

  Gender selectedGender = Gender.male;
  Department selectedDepartment = Department.finance;

  @override
  void initState() {
    super.initState();

    final existingStudent = widget.existingStudent;
    firstNameController =
        TextEditingController(text: existingStudent?.firstName ?? '');
    lastNameController =
        TextEditingController(text: existingStudent?.lastName ?? '');
    gradeController = TextEditingController(
        text: existingStudent != null ? existingStudent.grade.toString() : '');
    selectedGender = existingStudent?.gender ?? Gender.male;
    selectedDepartment = existingStudent?.department ?? Department.it;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    gradeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // first name input
          TextInputField(
            controller: firstNameController,
            labelText: 'First Name',
            maxLength: 50,
          ),
          const SizedBox(height: 16.0),

          // last name input
          TextInputField(
              controller: lastNameController,
              labelText: 'Last Name',
              maxLength: 50),
          const SizedBox(height: 16.0),

          // grade input
          TextInputField(
            controller: gradeController,
            labelText: 'Grade',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),

          // gender dropdown input
          DropdownInputField<Gender>(
            value: selectedGender,
            items: Gender.values,
            onChanged: (value) {
              setState(() {
                selectedGender = value!;
              });
            },
            labelText: 'Gender',
          ),
          const SizedBox(height: 16.0),

          // department dropdown input
          DropdownInputField<Department>(
            value: selectedDepartment,
            items: Department.values,
            onChanged: (value) {
              setState(() {
                selectedDepartment = value!;
              });
            },
            labelText: 'Department',
          ),
          const SizedBox(height: 16.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newStudent = Student(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    department: selectedDepartment,
                    grade: int.parse(gradeController.text),
                    gender: selectedGender,
                  );
                  widget.onSave(newStudent);
                  Navigator.of(context).pop();
                },
                child: const Text('Save Student'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
