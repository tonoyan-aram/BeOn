import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';

class EmailRecover extends StatefulWidget {
  @override
  _EmailRecoverState createState() => _EmailRecoverState();
}

class _EmailRecoverState extends State<EmailRecover> {
  TextEditingController emailController;
  bool showEmailValidationMessage = true;
  bool _isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
    emailController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
                Text(
                  "Մուտքագրեք ձեր էլեկտրոնային հասցեն",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700),
                ),
                CustomEmailInput(
                  controller: emailController,
                  validate: showEmailValidationMessage,
                  hint: "Էլ․ հասցե",
                  errorText: "*Սխալ էլ հասցե",
                  isPassword: false,
                  marginTop: 28,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 41 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {
                              validateByEmail();
                            });

                            if (showEmailValidationMessage) {
                              setState(() {
                                _isLoaded = true;
                              });

                              PageManager.checkEmail(
                                      emailController.text, context)
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

  validateByEmail() {
    bool valid =
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(emailController.text) &&
            emailController.text.trim().isNotEmpty;
    setState(() {
      showEmailValidationMessage = valid;
    });
  }
}
