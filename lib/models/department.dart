import 'package:flutter/material.dart';
import 'package:oleksiiartemenko/models/student.dart';

class DepartmentModel {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final Department enumValue;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.enumValue,
  });
}
