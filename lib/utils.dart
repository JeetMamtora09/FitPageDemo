
import 'package:flutter/material.dart';

extension ArgsExts on BuildContext {
  T? args<T>() => ModalRoute.of(this)?.settings.arguments as T;
}