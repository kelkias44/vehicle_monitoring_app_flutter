import 'package:flutter/material.dart';

class TitledescriptionRow extends StatelessWidget {
  String title;
  String description;
  TitledescriptionRow(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        SizedBox(
          width: 16,
        ),
        Container(
          alignment: Alignment.topRight,
          width: 200,
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
