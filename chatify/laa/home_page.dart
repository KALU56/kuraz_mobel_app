import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'components/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: CustomButton(
          label: "Logout",
          onPressed: () async {
            await authService.logout();
          },
        ),
      ),
    );
  }
}
