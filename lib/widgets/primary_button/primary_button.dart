import 'package:flutter/material.dart';

class primaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const primaryButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 0, 200, 150)),
        ),
        onPressed: onPressed,
        child: Text(
          title,
        ),
      ),
    );
  }
}
