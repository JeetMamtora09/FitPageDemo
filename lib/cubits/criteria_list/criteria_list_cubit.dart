import 'dart:convert';

import 'package:fitpagedemo/models/scanner.dart';
import 'package:fitpagedemo/cubits/criteria_list/criteria_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CriteriaListCubit extends Cubit<CriteriaListState> {
  CriteriaListCubit() : super(Initial());

  void fetchScannerList() async {
    emit(Loading());
    final response = await http
        .get(Uri.parse("http://coding-assignment.bombayrunning.com/data.json"));
    List<dynamic> listRes = json.decode(response.body);
    List<Scanner> scannerList = [];
    for (var element in listRes) {
      scannerList.add(Scanner.fromJson(element));
    }
    emit(ScannerLoaded(scannerList));
  }
}
