import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'tarefas_page.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime diaSelecionado = DateTime.now();
  DateTime focoDia = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendário"),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focoDia,
              selectedDayPredicate: (day) => isSameDay(day, diaSelecionado),

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  diaSelecionado = selectedDay;
                  focoDia = focusedDay;
                });
              },

              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF6C63FF),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TarefasPage(data: diaSelecionado),
                  ),
                );
              },
              child: const Text("Selecionar o dia"),
            ),
          ],
        ),
      ),
    );
  }
}
