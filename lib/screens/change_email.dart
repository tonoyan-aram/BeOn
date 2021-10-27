import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/screens/page_details.dart';
import 'package:flutter/material.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({
    Key key,
    this.email,
  }) : super(key: key);

  final String email;
  @override
  _ChangeEmailState createState() => _ChangeEmailState(email);
}

class _ChangeEmailState extends State<ChangeEmail> {
  TextEditingController emailController;
  TextEditingController passwordController;

  bool showEmailValidationMessage = true;
  bool _isLoaded = false;

  bool _validate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  final String email;
  _ChangeEmailState(this.email);

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
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageDetails(),
              ),
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 41 / 375,
                right: MediaQuery.of(context).size.width * 41 / 375,
                top: MediaQuery.of(context).size.height * 124 / 808),
            child: Column(
              children: [
                CustomEmailInput(
                  controller: emailController,
                  validate: showEmailValidationMessage,
                  hint: "Էլ․ հասցե",
                  errorText: "*Սխալ էլ հասցե",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.emailAddress,
                ),
                CustomTextInput(
                  controller: passwordController,
                  validate: _validate,
                  hint: "Գաղտնաբառ",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 174 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {
                              (passwordController.text.length < 6)
                                  ? _validate = true
                                  : _validate = false;

                              validateByEmail();
                            });
                            if (!_validate && showEmailValidationMessage) {
                              setState(() {
                                _isLoaded = true;
                              });

                              PageManager.changeEmail(emailController.text,
                                      email, passwordController.text, context)
                                  .listen((val) {
                                setState(() {
                                  _isLoaded = false;
                                });
                              });
                            }
                          },
                          btnText: "Հաստատել",
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
