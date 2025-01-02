import 'package:flutter/material.dart';

class CustomButtonUser extends StatelessWidget {

  const CustomButtonUser({super.key, required this.title, this.onTap, this.icon});

  final String title;
  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 80,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    if( title == 'Đăng xuất' ) Text('Đăng xuất',
                      style: TextStyle(fontSize: 18, color: Colors.red),)
                    else Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}