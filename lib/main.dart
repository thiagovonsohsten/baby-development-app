import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/calendar_event.dart';
import 'models/routine.dart';
import 'screens/home_screen.dart';
import 'screens/development_screen.dart';
import 'screens/routine_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/checklist_screen.dart';
import 'screens/chat_screen.dart'; // Importar a tela de chat

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CalendarEventAdapter());
  Hive.registerAdapter(RoutineAdapter());
  runApp(BabyDevelopmentApp());
}

class BabyDevelopmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desenvolvimento Infantil',
      theme: ThemeData(
        primaryColor: Color(0xFFB3E5FC), // Azul pastel
       hintColor: Color(0xFFF48FB1), // Rosa claro para destaque
        fontFamily: 'Nunito',
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    DevelopmentScreen(),
    RoutineScreen(),
    CalendarScreen(),
    ChecklistScreen(),
    ChatScreen(), // Adicione a ChatScreen aqui
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
       
      ),*/
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  selectedItemColor: Color(0xFFB3E5FC),
  unselectedItemColor: Colors.grey[600],
  iconSize: 30,
  currentIndex: _selectedIndex,
  onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_friendly),
            label: 'Desenvolvimento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Rotina',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Checklist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat', // Ícone e rótulo para a tela de chat
          ),
        ],
      ),
    );
  }
}
