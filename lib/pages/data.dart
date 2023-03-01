
import 'package:flutter/material.dart';

class date extends StatefulWidget {
  const date({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<date> createState() => _dateState();
}

class _dateState extends State<date> {

  var _date = null;
  var _time = null;
  
  Future<void> _dateSelection() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030)
    );
    if(_pickedDate != null) {
      setState(() {
        _date = _pickedDate;
      });
    }
  }

  Future<void> _timeSelection() async {
    TimeOfDay? _pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if(_pickedTime != null) {
      setState(() {
        _time = _pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: const Text("Open DatePicker", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  elevation: MaterialStateProperty.all(8)
                ),
                onPressed: _dateSelection,
            ),
            ElevatedButton(
              child: const Text("Open TimePicker", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  elevation: MaterialStateProperty.all(8)
              ),
              onPressed: _timeSelection,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            const Text("Picked date is: "),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Text(
                _date == null ? "No picked date!" : '${_date.day}/${_date.month}/${_date.year}',
              style: _date == null
                  ? const TextStyle(color: Colors.blue)
                  : const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            const Text("Picked time is: "),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(
              _time == null ? "No time chosen!" : '${_time.format(context)}',
              style: _time == null
                  ? const TextStyle(color: Colors.blue)
                  : const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
          ],
        ),
      ),
    );
  }
}