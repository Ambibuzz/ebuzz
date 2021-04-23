import 'package:ebuzz/common/colors.dart';
import 'package:flutter/material.dart';

class LinearGradientCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: [
            gradientCard(0xFF5753FF, 0xFF5CBFF1),
            gradientCard(0xFFEA778D, 0xFFF64BA6),
            gradientCard(0xFF4774E2, 0xFF84C7A5),
            gradientCard(0xFFBA92FB, 0xFF5E83F5),
            gradientCard(0xFF5753FF, 0xFFEA778D),
            gradientCard(0xFFF27381, 0xFFFFC785),
            gradientCard(0xFF878BDD, 0xFFA5EFE7),
            gradientCard(0xFF1CD5DA, 0xFF5385E7),
            gradientCard(0xFFF6539A, 0xFFFD707C),
            gradientCard(0xFF39DC97, 0xFF3CB8B2),
            gradientCard(0xFFA3C7FD, 0xFFBCE2FB),
            gradientCard(0xFFF8C76D, 0xFFF7A685),
            gradientCard(0xFF7BDFD5, 0xFFAF91CD),
          ],
        ),
      ),
    );
  }

  Widget gradientCard(int color1, int color2) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(color1),
            Color(color2),
          ],
        ),
      ),
      child: Center(
        child: Text(
          'Quality Inspection',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: whiteColor),
        ),
      ),
    );
  }
}
