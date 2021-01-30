import 'package:ethller/widgets/common/buttons/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text('Wallet deleted!', style: TextStyle(fontSize: 22)));

    _launchURL(url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Stack(
        children: [
          Builder(
            builder: (BuildContext context) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  _SettingsItem(
                      title: 'Remove wallet',
                      onTap: () {
                        //TODO clear data
                        Scaffold.of(context).showSnackBar(snackBar);
                      }),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'I made this app just for love for the art. It´s made with Flutter. The code is OpenSource and you can download it from the link below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        wordSpacing: 5,
                        height: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientButton(
                        child: Text(
                          'Link',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height: 60,
                        isButton: true,
                        width: 150,
                        onPressed: () {
                          _launchURL('https://github.com/sartorinahuel/ethller');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _SettingsItem(
                    title: 'Buy me a coffee!',
                    onTap: () => Navigator.pushNamed(context, '/donations'),
                  ),
                  _SettingsItem(
                      title: 'Contact us (is just me)',
                      onTap: () {
                        _launchURL('https://twitter.com/NahuelDev');
                      }),
                  // _SettingsItem(title: 'About this app', onTap: () {}),
                ],
              ),
            ),
          ),
          // _SettingsHeader()
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final Function onTap;

  const _SettingsItem({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 40),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.grey[500],
            )
          ],
        ),
      ),
    );
  }
}
