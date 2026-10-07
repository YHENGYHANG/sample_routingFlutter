//bottom navigation bar - it is a widget that allows the user to navigate between different pages in the app. It is typically used in conjunction with a Scaffold widget, which provides a basic structure for the app's UI. The bottom navigation bar can be customized with different icons, labels, and colors to match the app's design.
import 'package:flutter/material.dart';

import 'home_page.dart'; //can be imported directly because it is in the same folder
import 'profile_page.dart';
import 'sample_page.dart';

//use a stateful widget because the bottom navigation bar changes the app's state depending on the page the user selects
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState(); //_mainScreenState is a private class that extends the State class. It is used to manage the state of the MainScreen widget. The underscore (_) before the class name indicates that it is a private class and can only be accessed within the same file.
}

//0 = sample page, 1 = home page, 2 = profile page
//make a list of pages to display on the main screen depending on the current index of the bottom navigation bar
class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1; //currentIndex is a variable that keeps track of the currently selected page in the bottom navigation bar. It is initialized to 0, which means that the first page (HomePage) is selected by default.
  final List<Widget> pages = const [SamplePage(), HomePage(), ProfilePage()];

  //building the UI of the main screen. It returns a Scaffold widget that contains the body of the app and the bottom navigation bar.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //dynamically change the app bar title depending on the current index of the bottom navigation bar
        title: Text(
          _currentIndex == 1
              ? 'Home Page'
              : _currentIndex == 2
              ? 'Profile Page'
              : 'Sample Page',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
        elevation: 2, //shadow of the app bar
        surfaceTintColor: Colors.transparent, //tint color of the app bar
      ),

      body: AnimatedSwitcher(
        //AnimatedSwitcher creates an animated switcher for a smooth transition when switching pages. It takes a child widget and animates it when it changes. In this case, the child widget is the current page that is selected in the bottom navigation bar.
        duration: const Duration(milliseconds: 400), //duration of the animation
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        }, //transitionBuilder is a function that takes the child widget and the animation as parameters and returns a widget that defines how the child widget should be animated. In this case, it uses a FadeTransition widget to fade in and out the child widget when it changes.
        child: pages[_currentIndex], //the current page to display on the main screen depending on the current index of the bottom navigation bar
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index; //update the current index when the user taps on a different item in the bottom navigation bar
          });
          //update the current index when the user taps on a different item in the bottom navigation bar
        },
        height: 65, //selectedIndex is a property of the BottomNavigationBar widget that indicates which item is currently selected. It is set to the value of _currentIndex, which is updated whenever the user taps on a different item in the bottom navigation bar.

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.article),
            selectedIcon: Icon(Icons.article_outlined),
            label: 'Sample',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(
              Icons.person_outlined,
            ), //responds when the profile page is selected
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
