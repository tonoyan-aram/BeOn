import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  const Verification(
      {Key key,
      this.email,
      this.from,
      this.oldEmail,
      this.newEmail,
      this.password})
      : super(key: key);

  final String email;
  final String from;
  final String oldEmail;
  final String newEmail;
  final String password;

  @override
  _VerificationState createState() =>
      _VerificationState(email, from, oldEmail, newEmail, password);
}

class _VerificationState extends State<Verification> {
  TextEditingController codeController;
  bool _validate = false;
  bool _isLoaded = false;

  final String email;
  final String from;
  final String oldEmail;
  final String newEmail;
  final String password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
    codeController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    codeController.dispose();
  }

  _VerificationState(
      this.email, this.from, this.oldEmail, this.newEmail, this.password);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 41 / 375,
                right: MediaQuery.of(context).size.width * 41 / 375,
                top: MediaQuery.of(context).size.height * 120 / 808),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Մուտքագրեք կոդը, որն ուղարկվել է ',
                    style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                          text: email != null
                              ? email
                              : newEmail != null
                                  ? newEmail
                                  : "test@gmail.com",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700)),
                      TextSpan(
                        text: ' էլեկտրոնային հասցեին',
                        style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                CustomCodeInput(
                  controller: codeController,
                  validate: _validate,
                  hint: "",
                  errorText: "*Պետք է լինի 6 նիշ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 41 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {});

                            if (true) {
                              setState(() {
                                _isLoaded = true;
                              });

                              if (from == "password") {
                                PageManager.checkEmailCode(
                                        email, codeController.text, context)
                                    .listen((val) {
                                  setState(() {
                                    codeController.text = "";
                                    _isLoaded = false;
                                  });
                                });
                              }
                              if (from == "email") {
                                PageManager.changeEmailCode(newEmail, oldEmail,
                                        password, codeController.text, context)
                                    .listen((val) {
                                  setState(() {
                                    codeController.text = "";
                                    _isLoaded = false;
                                  });
                                });
                              }
                            }
                          },
                          btnText: "Ուղարկել",
                        )
                      : CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
