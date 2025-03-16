import 'dart:developer';

import 'package:dio/dio.dart';

class NetService {
  final dio = Dio();

  static final NetService _instance = NetService._internal();

  NetService._internal();

  factory NetService() {
    return _instance;
  }

  Future<Map?> getModules(String ip) async {
    try {
      Response response = await dio.get(
        ip,
        data: {},
      );
      print(response.data);
      return response.data['message'];
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<double?> getWeather({required String lan, required String lon, required String date}) async {
    try {
      Response response = await dio.get(
          'https://api.open-meteo.com/v1/forecast?latitude=$lan&longitude=$lon&current=temperature_2m&start_date=$date&end_date=$date',
          data: {},
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
          ));
      return response.data['current']['temperature_2m'];
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
