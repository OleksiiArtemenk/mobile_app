import 'package:flutter/material.dart';
import 'package:oleksiiartemenko/models/department.dart';
import 'package:oleksiiartemenko/models/student.dart';

final List<DepartmentModel> departments = [
  DepartmentModel(
    id: '1',
    name: 'IT',
    color: Colors.black,
    icon: Icons.computer,
    enumValue: Department.it,
  ),
  DepartmentModel(
    id: '2',
    name: 'Finance',
    color: Colors.yellow,
    icon: Icons.account_balance,
    enumValue: Department.finance,
  ),
  DepartmentModel(
    id: '3',
    name: 'Law',
    color: Colors.green,
    icon: Icons.gavel,
    enumValue: Department.law,
  ),
  DepartmentModel(
    id: '4',
    name: 'Medical',
    color: Colors.blue,
    icon: Icons.medical_services,
    enumValue: Department.medical,
  ),
];
