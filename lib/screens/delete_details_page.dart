import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';

class DeleteDetails extends StatefulWidget {
  const DeleteDetails(
      {Key key, this.id, this.from, this.filePageId, this.filePageImage})
      : super(key: key);
  final int id;
  final String from;
  final int filePageId;
  final String filePageImage;

  @override
  _DeleteDetailsState createState() =>
      _DeleteDetailsState(id, from, filePageId, filePageImage);
}

class _DeleteDetailsState extends State<DeleteDetails> {
  bool _isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final int id;
  final String from;
  final int filePageId;
  final String filePageImage;
  _DeleteDetailsState(this.id, this.from, this.filePageId, this.filePageImage);
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
                top: MediaQuery.of(context).size.height * 180 / 808),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ցանկանու՞մ եք ջնջել տվյալները",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 67 / 808),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: !_isLoaded
                          ? MiniButtonWidget(
                              onClick: () {
                                if (from == "file") {
                                  PageManager.deleteTaskFail(id, context,
                                          filePageId, filePageImage)
                                      .listen((val) {
                                    setState(() {
                                      _isLoaded = true;
                                    });
                                  });
                                }
                                if (from == "edit") {}
                              },
                              btnText: "Այո",
                            )
                          : CircularProgressIndicator(
                              backgroundColor: kPrimaryColor,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                    Container(
                      child: !_isLoaded
                          ? MiniButtonWidget(
                              onClick: () {
                                Navigator.pop(context);
                              },
                              btnText: "Ոչ",
                            )
                          : CircularProgressIndicator(
                              backgroundColor: kPrimaryColor,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
