import 'package:fitpagedemo/models/criteria.dart';
import 'package:fitpagedemo/screens/variable_detail/variable_detail_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CriteriaDetailListItem extends StatelessWidget {
  final Criteria criteria;

  const CriteriaDetailListItem({required this.criteria, super.key});

  @override
  Widget build(BuildContext context) {
    final regex = RegExp("(?={)|(?<=})");
    if (criteria is PlainTextContent) {
      return ListTile(title: Text(criteria.content));
    } else if (criteria is VariableContent) {
      final variableContent = criteria as VariableContent;
      final split = variableContent.content.split(regex);
      return ListTile(
        title: RichText(
            text: TextSpan(
          children: <InlineSpan>[
            for (String text in split)
              text.startsWith('{')
                  ? TextSpan(
                      text: text.substring(1, text.length - 1),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushNamed(VariableDetailScreen.routeName,
                                  arguments: variableContent.variable
                                      .firstWhere((element) {
                            return element.selectedText.contains(text);
                          }));
                        },
                    )
                  : TextSpan(
                      text: text, style: const TextStyle(color: Colors.black)),
          ],
        )),
      );
    } else {
      throw FlutterError("The content type is not supported");
    }
  }
}
