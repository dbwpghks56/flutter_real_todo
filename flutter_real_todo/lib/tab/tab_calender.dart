import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_todo/controller/controller_event.dart';
import 'package:flutter_real_todo/model/model_event.dart';
import 'package:flutter_real_todo/model/model_todo.dart';
import 'package:flutter_real_todo/util/tag_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../controller/controller_user.dart';
import '../utils.dart';

class TabCalender extends StatefulWidget {
  @override
  _TabCalenderState createState() => _TabCalenderState();
}

class _TabCalenderState extends State<TabCalender> {
  final todoModel = Get.put(RxTodoModel());
  var eventName = TextEditingController();
  var tagName = TextEditingController();
  var eventService = Get.put(MyController());
  final eventModel = Get.put(RxEventModel());
  final userController = Get.put(UserController());
  final rangeColor =  const Color(0xff8FBDD3);
  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
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
              height: 500,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: DateTimePicker(
                      type: DateTimePickerType.Date,
                      initialSelectedDate: _rangeStart ?? _selectedDay,
                      datePickerTitle: "약속 시작 일",
                      onDateChanged: (date) {
                        eventModel.eventStart(date);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: DateTimePicker(
                      type: DateTimePickerType.Date,
                      initialSelectedDate: _rangeEnd ?? _selectedDay,
                      datePickerTitle: "끝나는 일",
                      onDateChanged: (date) {
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
                      controller: tagName,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "태그할 사용자를 입력하세요."
                      ),
                    ),
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
            calendarFormat: CalendarFormat.month,
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
              selectedDecoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffB1B2FF),
                border: Border.all(color: const Color(0xffB1B2FF), width: 1.5),
              ),
              rangeHighlightColor: rangeColor,
              rangeStartDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color:  rangeColor,
                border: Border.all(color: rangeColor, width: 1.5),
              ),
              rangeEndDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: rangeColor,
                border: Border.all(color: rangeColor, width: 1.5),
              ),
              holidayTextStyle: const TextStyle(color: Colors.red),
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendTextStyle: const TextStyle(color: Colors.red),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffD3CEDF),
                border: Border.all(color: const Color(0xffD3CEDF), width: 1.5),
              ),
              canMarkersOverflow: true,
              markerDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigoAccent,
                    Color(0xff49a09d)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
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
                return value.isNotEmpty ? ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: value[index].complete ? const Color(0xffBCCEF8) : const Color(0xffD3CEDF),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () {},
                        title: Container(
                          margin: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(value[index].toString(), style: const TextStyle(color: Colors.white),),
                              TagCard(tagName: value[index].tag, textColor: Colors.white,),
                            ],
                          ),
                        ),
                        subtitle: Text(value[index].start == value[index].end ? convertFormat(value[index].end) :
                        "${convertFormat(value[index].start)} ~ ${convertFormat(value[index].end)}",
                          style: const TextStyle(color: Colors.white),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(onTap: () async {
                              await eventService.updateComplete(value[index].eid, value[index].complete ? 0 : 1);
                            },
                            child: value[index].complete ? const Icon(Icons.check_box_outlined, color: Colors.white,) :
                            const Icon(Icons.check_box_outline_blank, color: Colors.white,),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            InkWell(onTap: () async {
                              await eventService.deleteEvent(value[index].eid);
                            },
                              child: const Icon(Icons.delete, color: Colors.white,),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ) :
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("등록된 일정이 없습니다.",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String convertFormat(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}

