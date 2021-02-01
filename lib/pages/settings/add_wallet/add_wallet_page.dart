import 'dart:io';

import "package:ethereum_address/ethereum_address.dart";

import 'package:ethller/pages/home/home_subpages/wallet/bloc/wallet_bloc.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/buttons/gradient_button.dart';
import 'package:ethller/widgets/common/other/custom_imput.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddWalletPage extends StatefulWidget {
  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  //Snackbar that is shown when [Remove wallet] is pressed
  final snackBar = SnackBar(
      content: Text('invalid Wallet!', style: TextStyle(fontSize: 22)));

  TextEditingController _editingController = new TextEditingController();
  String text = '';

  //=====QR Code Scanner tools========================
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  //=====QR Code Scanner tools========================

  @override
  void dispose() {
    _editingController?.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ccc) {
    return Scaffold(
      backgroundColor: Color(0xFF16162f),
      appBar: AppBar(
        title: Text(
          'Add Wallet',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                if (Platform.isWindows || Platform.isLinux || Platform.isMacOS || kIsWeb)
                  Text(
                    'Add your wallet pasteing the address',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                SizedBox(height: 40),
                if (Platform.isAndroid || Platform.isIOS)
                  Container(
                    height: 300,
                    width: 300,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: QRView(
                      key: qrKey,
                      cameraFacing: CameraFacing.back,
                      onQRViewCreated: (QRViewController controller) =>
                          _onQRViewCreated(
                        controller,
                        _editingController,
                      ),
                      formatsAllowed: [BarcodeFormat.qrcode],
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 270,
                      ),
                    ),
                  ),
                if (Platform.isAndroid || Platform.isIOS) SizedBox(height: 40),
                CustomInput(
                  icon: Icons.account_balance_wallet,
                  placeholder: 'Paste wallet',
                  textController: _editingController,
                ),
                SizedBox(height: 30),
                Builder(
                  builder: (BuildContext context) => Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom),
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
                          if (isValidEthereumAddress(text)) {
                            BlocProvider.of<WalletBloc>(context)
                                .add(WalletInitEvent(text));
                            BlocProvider.of<MinersBloc>(context)
                                .add(MinersInitEvent(text));
                            Navigator.pop(context);
                          } else {
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(
      QRViewController controller, TextEditingController _editingController) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _editingController.text = result.code
            .substring(
                result.code.indexOf('0x'), result.code.indexOf('0x') + 42)
            .toLowerCase();
        print(result.code.substring(
            result.code.indexOf('0x'), result.code.indexOf('0x') + 42));
      });
    });
  }
}
