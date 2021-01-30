import 'dart:async';
import 'dart:io';

import 'package:ethller/widgets/common/buttons/gradient_button.dart';
import 'package:ethller/widgets/common/other/custom_imput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class AddWalletPage extends StatefulWidget {
  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  TextEditingController _editingController = new TextEditingController();
  String text = '';

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }

  @override
  Widget build(BuildContext ccc) {
    return Scaffold(
      backgroundColor: Color(0xFF16162f),
      appBar: AppBar(title: Text('Add Wallet')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                if (Platform.isAndroid || Platform.isIOS)
                  Text(
                    'Add your wallet scanning the QR code or pasteing the address',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
                  Text(
                    'Add your wallet pasteing the address',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                SizedBox(height: 40),
                if (Platform.isAndroid || Platform.isIOS)
                  GradientButton(
                    height: 50,
                    width: 130,
                    isButton: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'QR Scan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: _scan,
                  ),
                if (Platform.isAndroid || Platform.isIOS) SizedBox(height: 40),
                CustomInput(
                  icon: Icons.account_balance_wallet,
                  placeholder: 'Paste wallet',
                  textController: _editingController,
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                  child: GradientButton(
                    height: 50,
                    width: 100,
                    isButton: true,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (_editingController.text.isNotEmpty) {
                        text = _editingController.text;
                      }
                      //TODO Add wallet
                      saveAddress(text);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        _editingController.clear();
        text = barcode;
        //TODO Add wallet

        saveAddress(text);
        Navigator.pop(context);
      });
    }
  }
}
