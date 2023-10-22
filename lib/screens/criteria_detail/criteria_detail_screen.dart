import 'package:fitpagedemo/models/scanner.dart';
import 'package:fitpagedemo/screens/criteria_detail/criteria_detail_list_item.dart';
import 'package:fitpagedemo/utils.dart';
import 'package:flutter/material.dart';

class CriteriaDetailScreen extends StatelessWidget {
  const CriteriaDetailScreen({super.key});

  static const String routName = "/detailScreen";

  @override
  Widget build(BuildContext context) {
    final Scanner scannerOBj = context.args<Scanner>()!;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [Text(scannerOBj.name), Text(scannerOBj.tag,style: TextStyle(fontSize: 12),)]),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: scannerOBj.criteria.length,
        itemBuilder: (context, index) =>
            CriteriaDetailListItem(criteria: scannerOBj.criteria[index]),
        separatorBuilder: (context, index) => scannerOBj.criteria.length > 1
            ? const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("and"),
              )
            : Container(),
      ),
    ));
  }
}
