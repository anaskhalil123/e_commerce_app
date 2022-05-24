import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 0),
                    color: Colors.black.withOpacity(0.21),
                    blurRadius: 6)
              ]),
              child: const CircleAvatar(
                radius: 50,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'USER NAME',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'email@app.com',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
            const Divider(
              height: 40,
              thickness: 1,
            ),
          ],
        ));
  }
}
