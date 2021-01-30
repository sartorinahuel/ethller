import 'package:ethller/widgets/common/buttons/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class DonationsPage extends StatelessWidget {
  final snackBar = SnackBar(content: Text('Copied to clipboard!', style: TextStyle(fontSize: 22)));
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF16162f),
        appBar: AppBar(
          backgroundColor: Color(0xFF16162f),
          elevation: 0,
          title: Text(
            'Donations',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Text(
                'if you like it, also you can donate with what you think es fair.\n\nThanks and good mining!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  wordSpacing: 5,
                  height: 2,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientButton(
                    child: Text(
                      'Ether Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    height: 60,
                    isButton: true,
                    width: 150,
                    onPressed: () {
                      FlutterClipboard.copy('0xF02bB51E0aEbCE3FeDd890555A19582FEBa1Eb3a')
                          .then((value) => Scaffold.of(context).showSnackBar(snackBar));
                    },
                  ),
                  SizedBox(width: 20),
                  GradientButton(
                    child: Text(
                      'Bitcon Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    height: 60,
                    isButton: true,
                    width: 150,
                    onPressed: () {
                      FlutterClipboard.copy('1BrWnbsMR9fzPAvzcvmy6h15iMZGPtpsD3')
                          .then((value) => Scaffold.of(context).showSnackBar(snackBar));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// if you like it, also you can donate with what you think es fair. Thanks and good mining!
