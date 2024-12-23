import 'package:flutter/material.dart';

class ProfileWidget {
  static Widget buildInforCard(
    IconData icon,
    String title, {
      required String subtitle,
    }
    ) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon ( icon, color: Colors.black, size: 25.0),
              const SizedBox(width: 25.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ]
          )
        )
      );

    }
}