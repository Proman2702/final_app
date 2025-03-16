import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_app/etc/models.dart';
import 'package:final_app/repos/database/db.dart';
import 'package:final_app/repos/net/get_info.dart';
import 'package:sqflite/sqflite.dart';

class AddDialog extends StatefulWidget {
  final Function updater;
  const AddDialog({super.key, required this.updater});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String? lan;
  String? lon;
  TextEditingController dateController = TextEditingController();
  double? temp;

  String? date;

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dateController.text = pickedDate.toIso8601String().split('T').first;
      setState(() {});
    }
  }

  bool checkAllFields() {
    if (lan != null && lon != null && dateController.text != '') {
      try {
        double.parse(lan!);
        double.parse(lon!);
        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        'Добавить инфу',
        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.deepPurple),
      )),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  onChanged: (value) => setState(() {
                    lan = value;
                  }),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Широта',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.black38),
                      maintainHintHeight: false,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      border: InputBorder.none),
                ),
              ),
              Text(
                'широта',
                style: TextStyle(color: Colors.black26),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  onChanged: (value) => setState(() {
                    lon = value;
                  }),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Долгота',
                      maintainHintHeight: false,
                      labelStyle: TextStyle(fontSize: 16, color: Colors.black38),
                      contentPadding: EdgeInsets.only(bottom: 12),
                      border: InputBorder.none),
                ),
              ),
              Text(
                'долгота',
                style: TextStyle(color: Colors.black26),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.center,
                    width: 170,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: dateController,
                      readOnly: true,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Дата',
                          labelStyle: TextStyle(fontSize: 16, color: Colors.black38),
                          maintainHintHeight: false,
                          contentPadding: EdgeInsets.only(bottom: 12),
                          border: InputBorder.none),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    height: 40,
                    width: 40,
                    child: IconButton(
                        onPressed: () async {
                          await _pickDate();
                        },
                        icon: Icon(Icons.calendar_month)),
                  )
                ],
              ),
              Text(
                'выбрать дату',
                style: TextStyle(color: Colors.black26),
              ),
            ],
          ),
          Container(
            height: 35,
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () async {
                  if (checkAllFields()) {
                    temp = await NetService().getWeather(lan: lan!, lon: lon!, date: dateController.text);

                    if (temp != null) {
                      await DatabaseService().insertItem(Item(
                          lan: double.parse(lan!),
                          lon: double.parse(lon!),
                          date: dateController.text,
                          temperature: temp!));
                    }
                    widget.updater();
                    Navigator.pop(context);
                  }
                },
                child: Text('Сохранить')),
          )
        ],
      ),
    );
  }
}
