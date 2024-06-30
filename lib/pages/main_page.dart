import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:finance_app/pages/category_page.dart';
import 'package:finance_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _children = [const HomePage(), const CategoryPage()];
  int currentIndex = 1;

  void onTapTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0) ? _calendarAppBar() : _normalAppBar(),
      body: _children[currentIndex],
      floatingActionButton: Visibility(
        visible: currentIndex == 0,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => onTapTapped(0), icon: Icon(Icons.home, color: (currentIndex == 0) ? Colors.lightBlue : Colors.black)),
              const SizedBox(width: 20),
              IconButton(onPressed: () => onTapTapped(1), icon: Icon(Icons.list, color: (currentIndex == 1) ? Colors.lightBlue : Colors.black)),
            ],
          ),
        ),
      )
    );
  }

  PreferredSize _normalAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), 
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Text('Categories', style: GoogleFonts.montserrat(
          fontSize: 20,
        )),
      )
    );
  }

  CalendarAppBar _calendarAppBar() {
    return CalendarAppBar(
        accent: Colors.lightBlue,
        backButton: false,
        locale: 'id',
        lastDate: DateTime.now(), 
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        onDateChanged: (value) => {}
    );
  }
}
