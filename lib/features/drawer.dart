// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final int chosen;

  const AppDrawer({super.key, required this.chosen});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final double spacing = 7;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(color: Colors.deepPurple[300]),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text('MPPO App',
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito')),
              SizedBox(height: 10),
              Container(
                width: 140,
                height: 3,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 0) {
                    Navigator.of(context).pushNamed('/home');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 0 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Главное меню",
                        style: TextStyle(
                            fontFamily: 'Jura', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.chosen != 1) {
                    Navigator.of(context).pushNamed('/stats');
                  }
                },
                child: Container(
                  width: 230,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.chosen == 1 ? Colors.white24 : Colors.transparent),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Сканировать",
                        style: TextStyle(
                            fontFamily: 'Jura', fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Spacer(),
              SizedBox(
                  height: 50,
                  width: 170,
                  child: Text(
                    'Created and designed by Proman2702',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white24),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
