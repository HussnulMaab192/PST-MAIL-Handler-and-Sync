// ignore: unused_import
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pst1/Screens/selectServer.dart';

TextButton buildButton(
    IconData icon, String title, Color background, BuildContext context) {
  // onPressed()function
  return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SelectServer()));
      },
      // onPressed: () async {
      //   await reg();
      // },

      style: TextButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.grey),
        //  minimumSize: const Size(155, 40),
        // fixedSize: const Size.fromHeight(70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        primary: Colors.white,
        backgroundColor: background,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Icon(icon), Text(title)],
      ));
}
