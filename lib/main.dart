import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Progressive overload'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime _focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateFormat selectedDateFormat = DateFormat.MMMd();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final CalendarStyle _calendarStyle = const CalendarStyle(
    selectedDecoration:  BoxDecoration(color: Colors.grey)
  );

  void _onDaySelected (DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
    });
  }

  String formattedDate (DateTime date) {
    return selectedDateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              // TODO: Make firstDay and lastDay much more dynamic regarding 'focusedDay'
              firstDay: DateTime.utc(_focusedDay.year - 10, 1, 1),
              lastDay: DateTime.utc(_focusedDay.year + 10, 1, 1),
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              calendarFormat: _calendarFormat,
              calendarStyle: _calendarStyle,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              }
            ),
            Text("Selected Day: ${formattedDate(selectedDay)}")
          ],
        ),
      ),
    );
  }
}