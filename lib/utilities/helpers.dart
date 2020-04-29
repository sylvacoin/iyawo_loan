import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Helper
{
  static String formatCurrency(number) {
    return NumberFormat.simpleCurrency(name: 'NGN').format(number).toString();
  }

  static int getColor(String input) {
    return int.parse(
        '0XFF' + md5.convert(utf8.encode(input)).toString().substring(0, 6));
  }

  static Color getCardStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.blue;
        break;
      case 'pending withdrawal':
        return Colors.yellow;
        break;
      case 'full':
        return Colors.green;
        break;
      default:
        return Colors.red;
    }
  }
}