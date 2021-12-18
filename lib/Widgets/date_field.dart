import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {

  final TextEditingController controller;

  DateField(this.controller);

  DateFieldState createState() => DateFieldState();
}

class DateFieldState extends State<DateField> {
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if(widget.controller.text != ''){
      date = DateTime.parse(widget.controller.text);
    }

    return TextField(
      controller: widget.controller,
      decoration: decoration(),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: new DateTime(2018),
          lastDate: new DateTime.now().add(new Duration(days: 360)),
        );

        if(pickedDate != null) {
          setState(() => date = pickedDate);
          widget.controller.text = formatter.format(date);
        }
      },
    );
  }

  InputDecoration decoration(){
    return InputDecoration(
      labelText: 'date',
      border: OutlineInputBorder(),
    );
  }
}
