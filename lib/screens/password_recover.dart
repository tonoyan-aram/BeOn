import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key key,
    this.email,
    this.code,
  }) : super(key: key);

  final String email;
  final String code;

  @override
  _ChangePasswordState createState() => _ChangePasswordState(email, code);
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  bool _validate = false;
  bool _validate1 = false;
  bool _isLoaded = false;

  final String email;
  final String code;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
    passwordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  _ChangePasswordState(this.email, this.code);

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
                CustomTextInput(
                  controller: passwordController,
                  validate: _validate,
                  hint: "նոր գաղտնաբառ",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 0,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: confirmPasswordController,
                  validate: _validate1,
                  hint: "կրկնել գաղտնաբառը",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 41 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {
                              (passwordController.text.length < 5)
                                  ? _validate = true
                                  : _validate = false;

                              (confirmPasswordController.text.length < 5)
                                  ? _validate1 = true
                                  : _validate1 = false;
                            });

                            if (!_validate &&
                                !_validate1 &&
                                passwordController.text !=
                                    confirmPasswordController.text) {
                              _showAlertDialogRegOk(context);
                            }

                            if (!_validate &&
                                !_validate1 &&
                                passwordController.text ==
                                    confirmPasswordController.text) {
                              setState(() {
                                _isLoaded = true;
                              });

                              PageManager.changePassword(
                                      email,
                                      code,
                                      passwordController.text,
                                      confirmPasswordController.text,
                                      context)
                                  .listen((val) {
                                setState(() {
                                  _isLoaded = false;
                                });
                              });
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

void _showAlertDialogRegOk(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Ուշադրություն"),
    content: Text("Մուտքագրված գաղտնաբառերը չեն համընկնում"),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
