import 'package:flutter/material.dart';

import 'constants.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Material(
        borderRadius: BorderRadius.circular(11.0),
        elevation: 3.0,
        child: new InkWell(
          borderRadius: BorderRadius.circular(11),
          onTap: () {
            onClick();
          },
          child: new Ink(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 56 / 808,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                btnText,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}

class MiniButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;

  MiniButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Material(
        borderRadius: BorderRadius.circular(11.0),
        elevation: 3.0,
        child: new InkWell(
          borderRadius: BorderRadius.circular(11),
          onTap: () {
            onClick();
          },
          child: new Ink(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
            ),
            width: MediaQuery.of(context).size.width * 111 / 375,
            height: MediaQuery.of(context).size.height * 56 / 808,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                btnText,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
