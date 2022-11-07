import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_event.dart';
import 'package:flutter_real_todo/model/model_event.dart';
import 'package:flutter_real_todo/model/model_todo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../utils.dart';

class TabCalender extends StatefulWidget {
  @override
  _TabCalenderState createState() => _TabCalenderState();
}

class _TabCalenderState extends State<TabCalender> {
  final todoModel = Get.put(RxTodoModel());
  var eventName = TextEditingController();
  var eventService = Get.put(MyController());
  final eventModel = Get.put(RxEventModel());

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return eventService.showEvent(day) ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(Dialog(
            child:
            SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: DateTimePicker(
                      type: DateTimePickerType.Date,
                      startDate: DateTime.now(),
                      datePickerTitle: "약속 시작 일",
                      onDateChanged: (date) {
                        print(date);
                        eventModel.eventStart(date);
                        print(eventModel.eventStart);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: DateTimePicker(
                      type: DateTimePickerType.Date,
                      startDate: DateTime.now(),
                      datePickerTitle: "끝나는 일",
                      onDateChanged: (date) {
                        print(date);
                        eventModel.eventEnd(date);
                      },
                    ),
                  ),
                  Container(
                    width: 290,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child : TextField(
                      controller: eventName,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "약속이름을 설정해주세요."
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 200,
                    child:  BlockPicker(
                        pickerColor: Color(todoModel.tabColor.value),
                        onColorChanged: (color) {
                          todoModel.tabColor(color.value);
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text("cancel"),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                      ElevatedButton(
                        onPressed: () {
                          eventModel.eventName(eventName.text.trim());
                          eventService.insertEvents();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text("save"),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                    ],
                  )
                ],
              )
            )
          ));
        },
        child: const Text("+", style: TextStyle(fontSize: 25),),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            locale: 'ko-KR',
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            headerStyle: const HeaderStyle(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
              ),
              headerMargin: EdgeInsets.only(bottom: 10),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,),
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              holidayTextStyle: const TextStyle(color: Colors.red),
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendTextStyle: const TextStyle(color: Colors.red),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffB1B2FF),
                border: Border.all(color: const Color(0xffB1B2FF), width: 1.5),
              ),
              canMarkersOverflow: true,
              markerDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyan,
              )
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: value[index].complete ? const Color(0xffBCCEF8) : const Color(0xffFFACC7),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}',style: const TextStyle(color: Colors.white),),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

