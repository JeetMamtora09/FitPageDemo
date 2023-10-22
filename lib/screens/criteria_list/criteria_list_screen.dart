import 'package:fitpagedemo/cubits/criteria_list/criteria_list_cubit.dart';
import 'package:fitpagedemo/cubits/criteria_list/criteria_list_state.dart';
import 'package:fitpagedemo/screens/criteria_list/criteria_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CriteriaListScreen extends StatelessWidget {
  const CriteriaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Scanner List"),
        ),
        body: BlocBuilder<CriteriaListCubit, CriteriaListState>(
            builder: (context, state) {
          if (state is Initial || state is Loading) {
            if (state is Initial) {
              _fetchScannerList(context);
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (state is ScannerLoaded) {
            final scannerList = state.scannerList;
            return RefreshIndicator(
              onRefresh: () => Future.delayed(const Duration(seconds: 1), () {
                _fetchScannerList(context);
              }),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: scannerList.length,
                itemBuilder: (context, index) =>
                    CriteriaItem(scannerList[index]),
              ),
            );
          } else {
            throw FlutterError("Not implemented this $state");
          }
        }),
      ),
    );
  }

  void _fetchScannerList(BuildContext context) {
    BlocProvider.of<CriteriaListCubit>(context).fetchScannerList();
  }
}
