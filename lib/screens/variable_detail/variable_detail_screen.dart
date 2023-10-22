import 'package:fitpagedemo/models/criteria.dart';
import 'package:fitpagedemo/cubits/variable_detail/variable_detail_cubit.dart';
import 'package:fitpagedemo/cubits/variable_detail/variable_detail_state.dart';
import 'package:fitpagedemo/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VariableDetailScreen extends StatelessWidget {
  const VariableDetailScreen({super.key});

  static const routeName = "/variableDetail";

  @override
  Widget build(BuildContext context) {
    final variableValue = context.args<Variable>()!;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: _buildAppBarWidget(variableValue),
      ),
      body: BlocBuilder<VariableDetailCubit, VariableDetailState>(
          builder: (context, state) {
        if (variableValue is IndicatorVariable) {
          final controller = TextEditingController(
              text: variableValue.defaultValue.toString());

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  variableValue.paramName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {
                      int number = int.tryParse(value) ?? 0;
                      if (number < variableValue.minValue ||
                          number > variableValue.maxValue) {
                        var snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Container(
                            color: Colors.red,
                            child: Text(
                              'The value should be from ${variableValue.minValue} to ${variableValue.maxValue}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }
                    },
                    maxLength: 3,
                    textAlign: TextAlign.center,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: '${variableValue.paramName} value',
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (variableValue is ValueVariable) {
          return ListView.builder(
              itemCount: variableValue.valueList.length,
              itemBuilder: (context, index) => Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: ListTile(
                        title: Text(
                      variableValue.valueList[index].toString(),
                    )),
                  ));
        } else {
          throw FlutterError("The variable type is not supported");
        }
      }),
    ));
  }

  Widget _buildAppBarWidget(Variable variableValue) {
    if (variableValue is IndicatorVariable) {
      return Column(
        children: [
          Text(variableValue.studyType.toUpperCase()),
          const Text(
            "Set Params",
            style: TextStyle(fontSize: 12),
          )
        ],
      );
    } else {
      return const Text("Value List");
    }
  }
}
