import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/screens/email_recover.dart';
import 'package:beon/screens/registration.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password;
  TextEditingController email;
  bool _validate = false;
  bool _isLoaded = false;
  String psdError = "*Առնվազն 6 սիմվոլ";
  String emailError = "*Սխալ էլ․ հասցե";
  bool isChecked = false;

  bool showEmailValidationMessage = true;

  @override
  void initState() {
    password = new TextEditingController();
    email = new TextEditingController();
    _isLoaded = false;
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 117 / 808,
                left: MediaQuery.of(context).size.width * 41 / 375,
                right: MediaQuery.of(context).size.width * 41 / 375),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/MainLogo.png",
                    height: MediaQuery.of(context).size.height * 220 / 808,
                  ),
                  CustomEmailInput(
                    controller: email,
                    validate: showEmailValidationMessage,
                    hint: "Էլ․ հասցե",
                    errorText: "*Սխալ էլ հասցե",
                    isPassword: false,
                    marginTop: 21,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomTextInput(
                    controller: password,
                    validate: _validate,
                    hint: "Գաղտնաբառ",
                    errorText: "*Առնվազն 6 սիմվոլ",
                    isPassword: true,
                    marginTop: 21,
                    inputType: TextInputType.text,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailRecover()));
                      },
                      child: Text(
                        "Մոռացե՞լ եք գաղտանաբառը",
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                      Text(
                        "Հիշել գաղտնաբառը",
                        style: TextStyle(
                            fontSize: 10,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 37 / 808),
                  Center(
                    child: !_isLoaded
                        ? ButtonWidget(
                            onClick: () {
                              if (email.text.length > 0 &&
                                  password.text.length > 0) {
                                setState(() {
                                  validateByEmail();

                                  (password.text.length < 6)
                                      ? _validate = true
                                      : _validate = false;
                                });

                                if (!_validate && showEmailValidationMessage) {
                                  setState(() {
                                    _isLoaded = true;
                                  });
                                  PageManager.login(password.text, email.text,
                                          context, isChecked)
                                      .listen((val) {
                                    setState(() {
                                      _isLoaded = false;
                                    });
                                  });
                                }
                              }
                            },
                            btnText: "ՄՈւՏՔ",
                          )
                        : CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 31 / 808),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Ստեղծել ",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration()));
                        },
                        child: Text(
                          "նոր հաշիվ ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return kPrimaryColor;
    }
    return kPrimaryColor;
  }

  validateByEmail() {
    bool valid =
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(email.text) &&
            email.text.trim().isNotEmpty;
    setState(() {
      showEmailValidationMessage = valid;
    });
  }
}
