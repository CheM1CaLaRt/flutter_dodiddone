// import 'package:flutter/material.dart';
// import 'package:flutter_dodiddone/pages/login_page.dart';
// import 'package:flutter_dodiddone/screens/profile.dart'; // Импортируем profile_page
// import 'package:flutter_dodiddone/screens/all_tasks.dart';
// import '../theme/theme.dart';


// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     TasksPage(),
//     Text('Сегодня'),
//     ProfilePage(), // Отображаем profile_page при выборе "Профиль"
//     Text('Выполнено'),
        
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               DoDidDoneTheme.lightTheme.colorScheme.secondary,
//               DoDidDoneTheme.lightTheme.colorScheme.primary,
//             ],
//           ),
//         ),
//         child: Center(
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.task_alt),
//             label: 'Задачи',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Сегодня',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Профиль',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_circle),
//             label: 'Выполнено',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_dodiddone/pages/login_page.dart';
import 'package:flutter_dodiddone/screens/profile.dart'; // Импортируем profile_page
import 'package:flutter_dodiddone/screens/all_tasks.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart'; // Импортируем пакет intl

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TasksPage(),
    Text('Сегодня'),
    Text('Выполнено'),
    ProfilePage(), // Отображаем profile_page при выборе "Профиль"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Функция для показа диалогового окна
  void _showAddTaskDialog() {
    // Инициализируем переменную для хранения выбранного дедлайна
    DateTime? selectedDeadline;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog( // Используем Dialog вместо AlertDialog
          child: Container( // Добавляем Container для ограничения ширины
            width: 400, // Устанавливаем ширину диалогового окна
            padding: EdgeInsets.all(16), // Добавляем отступ
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Название задачи',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Описание',
                  ),
                ),
                // Поле для выбора дедлайна
                Padding( // Добавляем Padding для отступа кнопки
                  padding: const EdgeInsets.only(top: 16), // Отступ сверху
                  child: ElevatedButton(
                    onPressed: () {
                      // Покажем диалог выбора дедлайна
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          selectedDeadline = pickedDate;
                        }
                      });
                    },
                    child: Text('Выбрать дедлайн'),
                  ),
                ),
                // Добавьте другие поля для ввода данных задачи, например, дедлайн
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DoDidDoneTheme.lightTheme.colorScheme.secondary,
              DoDidDoneTheme.lightTheme.colorScheme.primary,
            ],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Вызываем диалоговое окно при нажатии
        child: Icon(Icons.add),
      ),
    );
  }
}

