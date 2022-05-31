import 'package:flutter/material.dart';
import 'package:pst1/Screens/ConfigureAccount.dart';
import 'package:pst1/Screens/app_theme.dart';
import 'package:pst1/Styles/app_colors.dart';

class OtherBrowserSearch extends StatefulWidget {
  const OtherBrowserSearch({Key? key}) : super(key: key);

  @override
  State<OtherBrowserSearch> createState() => _OtherBrowserSearchState();
}

class _OtherBrowserSearchState extends State<OtherBrowserSearch> {
  @override
  final TextEditingController _textEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/Images/register.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Search Server"),
            centerTitle: true,
            backgroundColor: AppColors.lightblueshade,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Enter Server Name',
                          hintStyle: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          side: const BorderSide(width: 1, color: Colors.black),
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          primary: AppColors.blackshade,
                          backgroundColor: AppColors.lightblueshade),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ConfigureAccount()));
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 25),
                      )), // ignore: prefer_const_constructors
                ],
              ),
            ],
          )),
    );
  }
}
