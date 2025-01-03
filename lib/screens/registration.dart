import 'package:flutter/material.dart';

class BookRegistrationScreen extends StatelessWidget {
  const BookRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('書籍登録'),
      ),
      body: const Center(
        child: Text('書籍登録画面'),
      ),
    );
  }
}
