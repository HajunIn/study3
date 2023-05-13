import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:study3/model/schedule.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
  ],
)
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  // select
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  // insert
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  //delete
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // 드리프트 데이터 베이스 클래스느 필수로 schemaVersion값을 지정해줘야함
  // 기본적으로 1부터 시작하고 테이블 변화가 있을떄마다 1씩 올려줘서 테이블 구조가 변경된다는 걸 드리프트에 인지 시켜주는 기능

  @override
  int get schemaVersion => 1;
}

// 데이터 베이스 파일을 생성 하고 연동 작업
// 드리프트 데이터 베이스 객체는 부모 생성자에 LazyDatabase 필수로 넣어줘야 함
// LazyDatabase 객체에는 데이터 베이스를 생성할 위치에 대한 정보를 입력해주면 됨
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    //getApplicationDocumentsDirectory 함수 사용하면 현재 앱으ㅔ 배정된 폴더의 경로를 받을수 있음
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
