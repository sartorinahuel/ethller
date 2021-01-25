import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Text('Settings page')),
      ),
    );
  }
}
