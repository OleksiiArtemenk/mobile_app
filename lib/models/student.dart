enum Department { finance, law, it, medical }
enum Gender { male, female }


class Student {
  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });

  final String firstName;
  final String lastName;
  final Department department;
  final int grade;
  final Gender gender;
}
