import 'package:flutter/material.dart';

class ButtonClass extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color background;
  const ButtonClass(
      {Key? key,
      required this.title,
      required this.background,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onTap();
        },
        // onPressed: () async {
        //   await reg();
        // },
        style: TextButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.grey),
          minimumSize: const Size(155, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          primary: Colors.white,
          backgroundColor: background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Text(
              title,
            ),
          ],
        ));
  }
}
