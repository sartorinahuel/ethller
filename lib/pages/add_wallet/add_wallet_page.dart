import 'package:flutter/material.dart';

class AddWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add wallet'),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Text('Add wallet page')),
      ),
    );
  }
}
