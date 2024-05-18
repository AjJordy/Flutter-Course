import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  const AdaptativeDatePicker({
    required this.selectedDate,
    required this.onDateChange,
    super.key,
  });

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Container(
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          minimumDate: DateTime(2019),
          maximumDate: DateTime.now(),
          onDateTimeChanged: onDateChange,
        ),
      );
    }
    return Container(
      height: 70,
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Text(
                'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
          ),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () => _showDatePicker(context),
            child: const Text('Selecionar data'),
          ),
        ],
      ),
    );
  }
}
