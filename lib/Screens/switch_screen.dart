import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:product/Screens/add_screen.dart';
import 'package:product/Screens/home_screen.dart';
import 'package:product/Screens/profile_screen.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  int _page = 0;
  final List<Widget> _list = [HomeScreen(), AddScreen(), ProfileScreen()];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      ///---------------------------BottomNavigationBar------------------------------------
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        index: 0,
        items: const <Widget>[
          Icon(Icons.home_outlined ,color:Colors.pink , size: 30),
          Icon(Icons.add, color:  Colors.pink,size: 30),
          Icon(Icons.perm_identity,color: Colors.pink, size: 30),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),

      ///---------------------------Body------------------------------------
      body: _list[_page], 
    );
  }
}
