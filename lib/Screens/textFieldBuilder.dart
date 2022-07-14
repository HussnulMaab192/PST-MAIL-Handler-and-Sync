import 'package:flutter/material.dart';
import 'package:pst1/Styles/app_colors.dart';

Widget buildTextField(
  IconData icon,
  String hintText,
  bool isPassword,
  bool isEmail,
  TextEditingController controller,
) {
  return Material(
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          
          maxLines: null,
          validator: (value) {
            if (value!.isEmpty) {
              if (hintText == "User Name") {
                return "Enter User Name";
              }
              if (hintText == "Enter Your Mail") {
                return "Enter Your Email First";
              }
              if (hintText == "Enter Password") {
                return "Enter Your Password First";
              }
              if (hintText == "Confirm Password") {
                return "Confirm Password can't be Empty";
              }
              if (hintText == "Enter Old Password") {
                return "Enter Your Password First";
              }
              if (hintText == "Enter new Password") {
                return "Enter Your Old Password First";
              }
              if (hintText == "Confirm new Password") {
                return "Enter Your new Password First";
              }
            }
          },
          // keyboardType:
          //     isEmail ? TextInputType.emailAddress  : TextInputType.text,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: AppColors.lightblueshade,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        )),
  );
}
