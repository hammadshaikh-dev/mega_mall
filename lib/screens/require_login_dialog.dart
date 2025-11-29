import 'package:flutter/material.dart';
import 'package:mega_mall/screens/login_screen.dart';

class RequireLoginDialog extends StatelessWidget {
  const RequireLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Login Required",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text("Please login to continue using Mega Mall."),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
