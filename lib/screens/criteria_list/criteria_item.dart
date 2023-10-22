import 'package:fitpagedemo/models/scanner.dart';
import 'package:fitpagedemo/screens/criteria_detail/criteria_detail_screen.dart';
import 'package:flutter/material.dart';

class CriteriaItem extends StatelessWidget {
  final Scanner scanner;

  const CriteriaItem(this.scanner, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context)
            .pushNamed(CriteriaDetailScreen.routName, arguments: scanner);
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: ListTile(
          title: Text(
            scanner.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            scanner.tag,
            style: TextStyle(
              fontSize: 12,
              color: scanner.color,
            ),
          ),
        ),
      ),
    );
  }
}
