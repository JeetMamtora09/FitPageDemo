import 'dart:ffi';

import 'package:flutter/cupertino.dart';

const String criTypePlainText = "plain_text";
const String criTypeVariable = "variable";
const String variableTypeValue = "value";
const String variableTypeIndicator = "indicator";

abstract class Criteria {
  final String content = "";

  factory Criteria.init(Map<String, dynamic> response, int variableIndex,
      Function incrementCallBack) {
    final criteriaType = response["type"];
    switch (criteriaType) {
      case criTypePlainText:
        return PlainTextContent.fromJson(response);
      case criTypeVariable:
        return VariableContent.fromJson(
            response, variableIndex, incrementCallBack);
      default:
        throw FlutterError("The criteria is not supported");
    }
  }
}

class PlainTextContent implements Criteria {
  @override
  final String content;

  PlainTextContent._init({required this.content});

  factory PlainTextContent.fromJson(Map<String, dynamic> response) {
    String content = response["text"] as String;
    content = content.replaceAll("â", "'");
    return PlainTextContent._init(content: content);
  }
}

class VariableContent implements Criteria {
  @override
  final String content;
  final List<Variable> variable;

  VariableContent._init({required this.content, required this.variable});

  factory VariableContent.fromJson(Map<String, dynamic> response,
      int variableIndex, Function incrementCallBack) {
    String content = "${response["text"]}";
    content = content.replaceAll("â", "'");
    final List<Variable> variableList = [];
    final Map<String, dynamic> res = response["variable"];
    for (int i = variableIndex;; i++) {
      if (res["\$$i"] == null) {
        break;
      } else {
        incrementCallBack.call();
        final variableValue = Variable._init(
          res["\$$i"],
        );
        if (variableValue is IndicatorVariable) {
          final defaultValue = "{${variableValue.defaultValue.toString()}}";
          variableValue.selectedText = defaultValue;
          content = content.replaceAll("\$$i", defaultValue);
        } else if (variableValue is ValueVariable) {
          final firstValue = "{${variableValue.valueList.first.toString()}}";
          variableValue.selectedText = firstValue;
          content = content.replaceAll("\$$i", firstValue);
        }
        variableList.add(variableValue);
      }
    }
    return VariableContent._init(content: content, variable: variableList);
  }

  @override
  String toString() {
    return 'VariableContent{content: $content, variable: $variable}';
  }
}

abstract class Variable {
  String selectedText = "";

  factory Variable._init(
    Map<String, dynamic> response,
  ) {
    final criteriaType = response["type"];
    switch (criteriaType) {
      case variableTypeIndicator:
        return IndicatorVariable.fromJson(response);
      case variableTypeValue:
        return ValueVariable.fromJson(
          response["values"],
        );
      default:
        throw FlutterError("The variable type is not supported");
    }
  }
}

class IndicatorVariable implements Variable {
  final String studyType;
  final String paramName;
  final int minValue;
  final int maxValue;
  final int defaultValue;
  @override
  String selectedText = "";

  IndicatorVariable({
    required this.studyType,
    required this.paramName,
    required this.minValue,
    required this.maxValue,
    required this.defaultValue,
  });

  factory IndicatorVariable.fromJson(Map<String, dynamic> response) =>
      IndicatorVariable(
        studyType: response["study_type"] as String,
        paramName: response["parameter_name"] as String,
        minValue: response["min_value"] as int,
        maxValue: response["max_value"] as int,
        defaultValue: response["default_value"] as int,
      );

  @override
  String toString() {
    return 'IndicatorVariable{studyType: $studyType, paramName: $paramName, minValue: $minValue, maxValue: $maxValue, defaultValue: $defaultValue, selectionIndex: $selectedText}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorVariable &&
          runtimeType == other.runtimeType &&
          studyType == other.studyType &&
          paramName == other.paramName &&
          minValue == other.minValue &&
          maxValue == other.maxValue &&
          defaultValue == other.defaultValue &&
          selectedText == other.selectedText;

  @override
  int get hashCode =>
      studyType.hashCode ^
      paramName.hashCode ^
      minValue.hashCode ^
      maxValue.hashCode ^
      defaultValue.hashCode ^
      selectedText.hashCode;
}

class ValueVariable implements Variable {
  final List<String> valueList;
  @override
  String selectedText = "";

  ValueVariable(
    this.valueList,
  );

  factory ValueVariable.fromJson(
    List<dynamic> response,
  ) {
    final List<String> valueList = [];
    for (var element in response) {
      valueList.add(element.toString());
    }
    return ValueVariable(
      valueList,
    );
  }

  @override
  String toString() {
    return 'ValueVariable{valueList: $valueList, selectionIndex: $selectedText}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueVariable &&
          runtimeType == other.runtimeType &&
          valueList == other.valueList &&
          selectedText == other.selectedText;

  @override
  int get hashCode => valueList.hashCode ^ selectedText.hashCode;
}
