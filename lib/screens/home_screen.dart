// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'development_screen.dart';
import 'routine_screen.dart';
import 'calendar_screen.dart';
import 'checklist_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E5FC), // Azul pastel
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.child_friendly, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Desenvolvimento Infantil',
              style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bem-vindo ao app de Desenvolvimento Infantil',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF616161),
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCustomButton(
                    context,
                    'Desenvolvimento Mês a Mês',
                    Icons.timeline,
                    DevelopmentScreen(),
                  ),
                  SizedBox(height: 10),
                  _buildCustomButton(
                    context,
                    'Rotina do Bebê',
                    Icons.schedule,
                    RoutineScreen(),
                  ),
                  SizedBox(height: 10),
                  _buildCustomButton(
                    context,
                    'Calendário',
                    Icons.calendar_today,
                    CalendarScreen(),
                  ),
                  SizedBox(height: 10),
                  _buildCustomButton(
                    context,
                    'Checklist',
                    Icons.checklist,
                    ChecklistScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(
      BuildContext context, String text, IconData icon, Widget screen) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Color(0xFFB3E5FC),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 3,
      ),
      icon: Icon(icon, size: 24),
      label: Text(
        text,
        style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
