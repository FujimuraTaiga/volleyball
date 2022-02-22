import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  final TextEditingController controller;

  const DateField(this.controller, {Key? key}) : super(key: key);

  @override
  DateFieldState createState() => DateFieldState();
}

class DateFieldState extends State<DateField> {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (widget.controller.text != '') {
      date = DateTime.parse(widget.controller.text);
    }

    return TextField(
      controller: widget.controller,
      decoration: decoration(),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2018),
          lastDate: DateTime.now().add(const Duration(days: 360)),
        );

        if (pickedDate != null) {
          setState(() => date = pickedDate);
          widget.controller.text = formatter.format(date);
        }
      },
    );
  }

  InputDecoration decoration() {
    return const InputDecoration(
      labelText: 'date',
      border: OutlineInputBorder(),
    );
  }
}
