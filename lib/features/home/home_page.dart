import 'dart:developer';
import 'dart:math';

import 'package:final_app/repos/net/get_info.dart';
import 'package:flutter/material.dart';
import 'package:final_app/etc/models.dart';
import 'package:final_app/features/drawer.dart';
import 'package:final_app/features/home/add_dialog.dart';
import 'package:final_app/features/home/tile_builder.dart';
import 'package:final_app/repos/database/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  List<Object?>? objects;
  DatabaseService db = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> heatmap = [];

  List module_from = [];
  List module_to = [];
  List stations_K = [];
  List stations_E = [];
  List st_sphere = [];
  bool show_modules = true;
  bool show_stations = true;
  bool show_spheres = true;
  bool updated = false;
  String? ip;

  @override
  void initState() {
    super.initState();
  }

  void update() async {
    //objects = await db.getItems();
    var res = await NetService().getModules(ip!);

    module_from = res!['sender'];
    module_to = res['listener'];

    for (var i in stations_K) {
      for (var j = 0; j < heatmap.length; j++) {
        for (var k = 0; k < heatmap[j].length; k++) {
          if (Point(k, j).distanceTo(Point(i[0], i[1])) <= 8) {
            st_sphere.add([k, j]);
          }
        }
      }
    }

    for (var i in stations_E) {
      for (var j = 0; j < heatmap.length; j++) {
        for (var k = 0; k < heatmap[j].length; k++) {
          if (Point(k, j).distanceTo(Point(i[0], i[1])) <= 8) {
            st_sphere.add([k, j]);
          }
        }
      }
    }
    updated = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: const AppDrawer(chosen: 0),
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
                child: Text('Отображение карты',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 24,
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: ListView(
                    children: [
                      ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: heatmap.length,
                          itemBuilder: (context, index) {
                            final tile = heatmap[index];
                            return TileBuilder(
                                index: index,
                                spheres: st_sphere,
                                values: heatmap[index],
                                stations_E: stations_E,
                                stations_K: stations_K,
                                module_from: module_from,
                                module_to: module_to,
                                updater: update,
                                show_modules: show_modules,
                                show_stations: show_stations,
                                show_spheres: show_spheres);
                          }),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: show_modules,
                    onChanged: (bool? value) {
                      setState(() {
                        show_modules = value!;
                      });
                    },
                  ),
                  Text('Отображение модулей'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: show_stations,
                    onChanged: (bool? value) {
                      setState(() {
                        show_stations = value!;
                      });
                    },
                  ),
                  Text('Отображение станций'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: show_spheres,
                    onChanged: (bool? value) {
                      setState(() {
                        show_spheres = value!;
                      });
                    },
                  ),
                  Text('Отображение сфер'),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  onChanged: (value) => setState(() {
                    ip = value;
                  }),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Ввод айпи',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.black38),
                      maintainHintHeight: false,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            update();
          },
          child: Icon(Icons.add),
        ));
  }
}
