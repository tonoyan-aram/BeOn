import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';

class ChangePasswordNew extends StatefulWidget {
  const ChangePasswordNew({
    Key key,
    this.email,
  }) : super(key: key);

  final String email;
  @override
  _ChangePasswordNewState createState() => _ChangePasswordNewState(email);
}

class _ChangePasswordNewState extends State<ChangePasswordNew> {
  TextEditingController oldpasswordController;
  TextEditingController newpasswordController;
  TextEditingController repetpasswordController;

  bool _isLoaded = false;

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;

    newpasswordController = new TextEditingController();
    repetpasswordController = new TextEditingController();
    oldpasswordController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newpasswordController.dispose();
    repetpasswordController.dispose();
    oldpasswordController.dispose();
  }

  final String email;
  _ChangePasswordNewState(this.email);

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
                top: MediaQuery.of(context).size.height * 124 / 808),
            child: Column(
              children: [
                CustomTextInput(
                  controller: oldpasswordController,
                  validate: _validate,
                  hint: "հին գաղտնաբառ",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: newpasswordController,
                  validate: _validate1,
                  hint: "նոր գաղտնաբառ",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: repetpasswordController,
                  validate: _validate2,
                  hint: "կրկնել գաղտնաբառը",
                  errorText: "*Առնվազն 6 սիմվոլ",
                  isPassword: true,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 98 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {
                              (oldpasswordController.text.length < 6)
                                  ? _validate = true
                                  : _validate = false;
                              (newpasswordController.text.length < 6)
                                  ? _validate1 = true
                                  : _validate1 = false;
                              (repetpasswordController.text.length < 6)
                                  ? _validate2 = true
                                  : _validate2 = false;
                            });
                            if (!_validate && !_validate1 && !_validate2) {
                              setState(() {
                                _isLoaded = true;
                              });

                              PageManager.changePasswordOld(
                                      email,
                                      oldpasswordController.text,
                                      newpasswordController.text,
                                      repetpasswordController.text,
                                      context)
                                  .listen((val) {
                                setState(() {
                                  _isLoaded = false;
                                  oldpasswordController.text = "";
                                  newpasswordController.text = "";
                                  repetpasswordController.text = "";
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
}
