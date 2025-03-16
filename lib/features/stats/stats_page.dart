import 'package:flutter/material.dart';
import 'package:final_app/features/drawer.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(chosen: 1),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            toolbarHeight: 75,
            leadingWidth: 60,
            centerTitle: true,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            ),
            leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.white, size: 35)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            title: const Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Text('...',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
            ),
            actions: [
              //IconButton(
              //onPressed: () {
              //Navigator.of(context).pushNamed('/home/settings');
              //},
              //icon: const Icon(Icons.settings, color: Colors.white, size: 35)),
              //const SizedBox(width: 10),
            ],
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [Text('...')],
          ),
        ),
      ),
    );
  }
}
