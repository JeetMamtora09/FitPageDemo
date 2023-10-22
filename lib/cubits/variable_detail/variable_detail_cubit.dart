import 'package:fitpagedemo/models/criteria.dart';
import 'package:fitpagedemo/cubits/variable_detail/variable_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VariableDetailCubit extends Cubit<VariableDetailState> {
  VariableDetailCubit() : super(InitialVariableDetail());

  void fetchPageType(Variable args) {
    if (state is IndicatorVariable) {
      emit(RenderIndicatorView());
    } else if (state is ValueVariable) {
      emit(ValueVariableView());
    } else {
      throw FlutterError("The variable type is not supported");
    }
  }
}
