import 'package:fitpagedemo/cubits/criteria_detail/criteria_detail_cubit.dart';
import 'package:fitpagedemo/cubits/criteria_list/criteria_list_cubit.dart';
import 'package:fitpagedemo/cubits/variable_detail/variable_detail_cubit.dart';
import 'package:fitpagedemo/screens/criteria_detail/criteria_detail_screen.dart';
import 'package:fitpagedemo/screens/criteria_list/criteria_list_screen.dart';
import 'package:fitpagedemo/screens/variable_detail/variable_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CriteriaListCubit>(
            create: (context) => CriteriaListCubit(),
            child: const CriteriaListScreen(),
          ),
        );
      case CriteriaDetailScreen.routName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<CriteriaDetailCubit>(
            create: (context) => CriteriaDetailCubit(),
            child: const CriteriaDetailScreen(),
          ),
        );
      case VariableDetailScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<VariableDetailCubit>(
            create: (context) => VariableDetailCubit(),
            child: const VariableDetailScreen(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
