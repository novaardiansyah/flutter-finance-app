import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:finance_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CalendarAppBar(
            accent: Colors.lightBlue,
            backButton: false,
            locale: 'id',
            lastDate: DateTime.now(), 
            firstDate: DateTime.now().subtract(const Duration(days: 140)),
            onDateChanged: (value) => {}
        ),
        body: const HomePage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SizedBox(
          height: 65,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                const SizedBox(width: 20),
                IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
              ],
            ),
          ),
        ));
  }
}
