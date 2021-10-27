import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/screens/page_details.dart';
import 'package:flutter/material.dart';

class EditPageDetails extends StatefulWidget {
  const EditPageDetails({Key key, this.id}) : super(key: key);
  final String id;
  @override
  _EditPageDetailsState createState() => _EditPageDetailsState(id);
}

class _EditPageDetailsState extends State<EditPageDetails> {
  TextEditingController firstNameController;
  TextEditingController lastNameController;

  TextEditingController phoneController;

  bool _isLoaded = false;
  bool _isData = false;

  bool _validate = false;

  bool _validate2 = false;
  bool _validate3 = false;

  @override
  void initState() {
    super.initState();
    _isLoaded = false;
    _isData = false;

    firstNameController = new TextEditingController();
    lastNameController = new TextEditingController();

    phoneController = new TextEditingController();

    PageManager.getMe().listen((profil) {
      setState(() {
        firstNameController.text = profil.user.firstName;
        lastNameController.text = profil.user.lastName;
        phoneController.text = profil.phone;
        _isData = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
  }

  final String id;
  _EditPageDetailsState(this.id);

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
                top: MediaQuery.of(context).size.height * 30 / 808),
            child: !_isData
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Column(
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
                      CustomTextInput(
                        controller: phoneController,
                        validate: _validate3,
                        hint: "Հեռախոսահամար",
                        errorText: "*0xxxxxxxx",
                        isPassword: false,
                        marginTop: 21,
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 41 / 808),
                      Center(
                        child: !_isLoaded
                            ? ButtonWidget(
                                onClick: () {
                                  setState(() {
                                    (firstNameController.text.length < 3)
                                        ? _validate = true
                                        : _validate = false;
                                    (lastNameController.text.length < 3)
                                        ? _validate2 = true
                                        : _validate2 = false;

                                    (phoneController.text.length != 9)
                                        ? _validate3 = true
                                        : _validate3 = false;
                                  });
                                  if (!_validate &&
                                      !_validate2 &&
                                      !_validate3) {
                                    setState(() {
                                      _isLoaded = true;
                                    });

                                    PageManager.changePersonalInfo(
                                            firstNameController.text,
                                            lastNameController.text,
                                            phoneController.text,
                                            context)
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
}
