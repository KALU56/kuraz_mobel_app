import 'package:chatify/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      body: Column(

        children: [
          Icon(Icons.message,
          size: 60,
          color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: 50,),
          Text("welcome back  you",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),),
          SizedBox(height: 25,),
          MyTextfield(
            hintText: 'Email',
          ),
           SizedBox(height: 25,),
            MyTextfield(
            hintText: 'password',
          ),
        ],
      ),

    );
  }
}