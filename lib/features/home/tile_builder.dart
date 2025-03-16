import 'package:flutter/material.dart';
import 'package:final_app/etc/models.dart';
import 'package:final_app/repos/database/db.dart';

class TileBuilder extends StatefulWidget {
  final int index;
  final List values;
  final Function updater;
  final List module_from;
  final bool show_modules;
  final List module_to;
  final bool show_stations;
  final List stations_E;
  final List spheres;
  final bool show_spheres;
  final List stations_K;
  const TileBuilder({
    super.key,
    required this.index,
    required this.show_spheres,
    required this.spheres,
    required this.updater,
    required this.values,
    required this.module_from,
    required this.module_to,
    required this.show_modules,
    required this.show_stations,
    required this.stations_E,
    required this.stations_K,
  });

  @override
  State<TileBuilder> createState() => _TileBuilderState();
}

class _TileBuilderState extends State<TileBuilder> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.values.length; i++)
              Container(
                color: (widget.index == widget.module_from[1] && i == widget.module_from[0] && widget.show_modules)
                    ? Color.fromARGB(255, 255, 0, 0)
                    : (widget.index == widget.module_to[1] && i == widget.module_to[0] && widget.show_modules)
                        ? Color.fromARGB(255, 0, 0, 255)
                        : (widget.stations_E.any((_) => _[0] == widget.index && _[1] == i) && widget.show_stations)
                            ? Color.fromARGB(255, 0, 255, 0)
                            : (widget.stations_K.any((_) => _[0] == widget.index && _[1] == i) && widget.show_stations)
                                ? Color.fromARGB(255, 255, 255, 0)
                                : (widget.spheres.any((_) => _[0] == widget.index && _[1] == i) && widget.show_spheres)
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : (170 < -(widget.values[i] - 255) && 255 >= -(widget.values[i] - 255))
                                        ? Color.fromARGB(-(widget.values[i] - 255), 0, 0, 0)
                                        : Color.fromARGB(-(widget.values[i] - 255), (widget.values[i]), 0, 0),
                alignment: Alignment.center,
                width: width / widget.values.length,
                height: width / widget.values.length,
                child: Text(""),
              )
          ],
        ));
  }
}
