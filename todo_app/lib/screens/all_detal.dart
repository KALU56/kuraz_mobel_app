import 'package:flutter/material.dart';

class AllDetal extends StatefulWidget {
  const AllDetal({super.key});

  @override
  State<AllDetal> createState() => _AllDetalState();
}

class _AllDetalState extends State<AllDetal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'All Task List',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(244, 250, 255, 1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(onTap: () {}, child: Text('Today')),
                        GestureDetector(onTap: () {}, child: Text('Daily')),
                        GestureDetector(onTap: () {}, child: Text('Monthly')),
                        GestureDetector(onTap: () {}, child: Text('weekly')),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      opensmallscreen();
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future opensmallscreen() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(' add new task'),
      content: TextField(
        decoration: InputDecoration(hintText: 'ENTER YOUR TASK'),
      ),
      actions: [
        TextButton(onPressed: (){}, child: Text('save'))
      ]
    ),
  );
}