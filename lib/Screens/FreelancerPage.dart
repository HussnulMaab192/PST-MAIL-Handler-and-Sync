import 'package:flutter/material.dart';

class FreelancerPage extends StatefulWidget {
  const FreelancerPage({Key? key}) : super(key: key);

  @override
  State<FreelancerPage> createState() => _FreelancerPageState();
}

class _FreelancerPageState extends State<FreelancerPage> {
  List<String> mailList = [
    'Mail 1',
    'Mail 2',
    'Mail 3',
    'Mail 4',
    'Mail 5',
    'Mail 6',
  ];

  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  // setState(() {
  //   _selectedIndex = index;
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freelancer'),
        // leading: IconButton(icon: Icon(Icons.fiber_new,),onPressed: (){},),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _selectedIndex,
        // onTap: _onItemTapped,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: mailList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.account_circle),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(mailList[index]),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
