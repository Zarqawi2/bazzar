import 'package:flutter/material.dart';

class TopTitels extends StatelessWidget {
  final String title, subtitle;
  const TopTitels({super.key, required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        if (title == 'چوونەژوورەوە' || title == 'دروستکردنی هەژمار')
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Color.fromARGB(255, 0, 223, 164),
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'speda',
              color: Color.fromARGB(255, 255, 133, 81)),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'speda',
          ),
        ),
      ],
    );
  }
}
