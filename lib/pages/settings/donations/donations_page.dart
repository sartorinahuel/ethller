import 'package:ethller/widgets/common/buttons/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class DonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Donations',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      //ShowSnackBar method need this Builder to work
      body: Builder(
        builder: (BuildContext context) => Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Text(
                'if you like it, also you can donate with what you think es fair.\n\nThanks and good mining!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CoinWalletButton(
                    title: 'Ether Wallet',
                    address: '0xF02bB51E0aEbCE3FeDd890555A19582FEBa1Eb3a',
                  ),
                  SizedBox(width: 20),
                  _CoinWalletButton(
                    title: 'Bitcon Wallet',
                    address: '1BrWnbsMR9fzPAvzcvmy6h15iMZGPtpsD3',
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

class _CoinWalletButton extends StatelessWidget {
  final String title;
  final String address;

  const _CoinWalletButton({
    Key key,
    @required this.title,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      child: Text(
        title,
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
        FlutterClipboard.copy(address)
            .then((value) => Scaffold.of(context).showSnackBar(_snackBar));
      },
    );
  }
}

//Snackbar that is shown when either Bitcoin or Ethereum wallet button is pressed
final _snackBar = SnackBar(
    content: Text('Copied to clipboard!', style: TextStyle(fontSize: 22)));
