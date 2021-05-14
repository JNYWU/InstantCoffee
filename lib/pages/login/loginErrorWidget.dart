import 'package:flutter/material.dart';
import 'package:readr_app/helpers/dataConstants.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 72),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              '登入失敗',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              '請重新登入，或是聯繫客服',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        InkWell(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Text(
                'E-MAIL: mm-onlineservice@mirrormedia.mg',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
          onTap: () async{
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'mm-onlineservice@mirrormedia.mg',
            );

            if (await canLaunch(emailLaunchUri.toString())) {
              await launch(emailLaunchUri.toString());
            } else {
              throw 'Could not launch mm-onlineservice@mirrormedia.mg';
            }
          }
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              '(02)6633-3966',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              '我們將有專人為您服務',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: _backToHomeButton(context),
        ),
      ],
    );
  }

  Widget _backToHomeButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            '回首頁',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }
}