import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController phoneController;
  bool showEmailValidationMessage = true;
  bool _isLoaded = false;

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
    firstNameController = new TextEditingController();
    lastNameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    phoneController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 41 / 375,
                right: MediaQuery.of(context).size.width * 41 / 375,
                top: MediaQuery.of(context).size.height * 30 / 808),
            child: Column(
              children: [
                CustomTextInput(
                  controller: firstNameController,
                  validate: _validate,
                  hint: "Անուն",
                  errorText: "*Առնվազն 3 սիմվոլ",
                  isPassword: false,
                  marginTop: 0,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: lastNameController,
                  validate: _validate2,
                  hint: "Ազգանուն",
                  errorText: "*Առնվազն 3 սիմվոլ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomEmailInput(
                  controller: emailController,
                  validate: showEmailValidationMessage,
                  hint: "Էլ․ հասցե",
                  errorText: "*Սխալ էլ հասցե",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.emailAddress,
                ),
                // _textInputEmail(
                //   controller: emailController,
                //   hint: "Էլ․ հասցե"
                // ),
                CustomTextInput(
                  isspace: 0,
                  controller: passwordController,
                  validate: _validate1,
                  hint: "Գաղտնաբառ",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  isspace: 0,
                  maxLength: 9,
                  controller: phoneController,
                  validate: _validate3,
                  hint: "Հեռախոսահամար",
                  errorText: "*0xxxxxxxx",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.number,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 111 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {
                              (firstNameController.text.trim().length < 3)
                                  ? _validate = true
                                  : _validate = false;
                              (lastNameController.text.trim().length < 3)
                                  ? _validate2 = true
                                  : _validate2 = false;
                              (passwordController.text.length < 6)
                                  ? _validate1 = true
                                  : _validate1 = false;
                              (phoneController.text.length != 9)
                                  ? _validate3 = true
                                  : _validate3 = false;
                              validateByEmail();
                            });
                            if (!_validate &&
                                !_validate1 &&
                                !_validate2 &&
                                !_validate3 &&
                                showEmailValidationMessage) {
                              setState(() {
                                _isLoaded = true;
                              });
                              // register
                              PageManager.registration(
                                      phoneController.text,
                                      firstNameController.text,
                                      lastNameController.text,
                                      passwordController.text,
                                      emailController.text,
                                      context)
                                  .listen((val) {
                                setState(() {
                                  _isLoaded = false;
                                });
                              });
                            }
                          },
                          btnText: "Գրանցվել",
                        )
                      : CircularProgressIndicator(
                          backgroundColor: Colors.blue,
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
