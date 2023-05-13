import 'package:flutter/material.dart';
import 'package:study3/database/drift_database.dart';
import 'package:study3/screen/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  // 드리프트 초기화
  final database = LocalDataBase();
  // LocalDataBase 클래스 인스턴스 화
  // GetIt 으로 값을 등록하면 어디서든 처음에 주입한 값 즉, 같은 database 변수를 Get.it을
  // 통해서 프로젝트 어디서든 사용 가능
  GetIt.I.registerSingleton<LocalDataBase>(database);

  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}