import 'package:flutter/material.dart';
import 'package:oleksiiartemenko/models/department.dart';

class DepartmentItem extends StatelessWidget {
  final DepartmentModel department;
  final int studentCount;

  const DepartmentItem({
    super.key,
    required this.department,
    required this.studentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [
              department.color.withOpacity(0.8),
              department.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                department.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Students enrolled: $studentCount',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  department.icon,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
