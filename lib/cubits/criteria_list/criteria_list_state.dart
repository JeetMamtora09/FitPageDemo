import 'package:fitpagedemo/models/scanner.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CriteriaListState {}

class Initial extends CriteriaListState {}

class Loading extends CriteriaListState{}

class ScannerLoaded extends CriteriaListState {
  final List<Scanner> scannerList;
  ScannerLoaded(this.scannerList);
}
