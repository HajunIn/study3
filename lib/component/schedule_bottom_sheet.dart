import 'package:flutter/material.dart';
import 'package:study3/component/custom_text_field.dart';
import 'package:study3/const/colors.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:study3/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectdDate; // 선택한 날짜 상위 위젝에서 입력 받기

  const ScheduleBottomSheet({required this.selectdDate, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey(); // 폼키 생성

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 +
              bottomInset, // ➋ 화면 반 높이에 키보드 높이 추가하기
          color: Colors.white,
          child: Padding(
            padding:
                EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(
              // ➋ 시간 관련 텍스트 필드와 내용관련 텍스트 필드 세로로 배치
              children: [
                Row(
                  // ➊ 시작 시간 종료 시간 가로로 배치
                  children: [
                    Expanded(
                      child: CustomTextField(
                        // 시작시간 입력 필드
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextField(
                        // 종료시간 입력 필드
                        label: '종료 시간',
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: CustomTextField(
                    // 내용 입력 필드
                    label: '내용',
                    isTime: false,
                    onSaved: (String? val) {
                      startTime = int.parse(val!);
                    },
                    validator: contentValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // [저장] 버튼
                    // ➌ [저장] 버튼
                    onPressed: onSavePressed,
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState!.validate()) {
      // 폼 검증하기
      formKey.currentState!.save(); //폼 저장하기

      // 일정 생성하기
      await GetIt.I<LocalDataBase>().createSchedule(
        SchedulesCompanion(
          startTime: Value(startTime!),
          endTime:Value(endTime!),
          content: Value(content!),
          date: Value(widget.selectdDate),
        )
      );
      
      // 일정 생성 후 화면 뒤로 거기
      Navigator.of(context).pop();
    }
  }

  // 시간 값 검증
  String? timeValidator(String? val) {
    if (val != null) {
      return "값을 입력해주세여";
    }

    int? number;

    try {
      number = int.parse(val!);
    } catch (e) {
      return "숫자를 입력해 주세요";
    }

    if (number < 0 || number > 24) {
      return "0시부터 24시 사이를 입력해 주세여";
    }

    return null;
  }

  // 내용값 검증
  String? contentValidator(String? val) {
    if (val != null) {
      return "값을 입력해주세여";
    }

    return null;
  }
}
