import 'package:flutter/material.dart';


class CompanyInfo extends StatelessWidget {
  const CompanyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Company info',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: const [
        Center(child: Text('Geeksynergy Technologies Pvt Ltd', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
        Text('Sanjayanagar, Bengaluru-56'),
        Text('XXXXXXXXX09'),
        Text('XXXXXX@gmail.com')
      ],),
    );
  }
}
