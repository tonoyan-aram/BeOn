import 'package:beon/config/constants.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/getMe.dart';
import 'package:beon/screens/change_email.dart';
import 'package:beon/screens/home.dart';
import 'package:flutter/material.dart';
import 'change_password.dart';
import 'edit_page_details.dart';

class PageDetails extends StatefulWidget {
  const PageDetails({Key key, this.id}) : super(key: key);
  final String id;
  @override
  _PageDetailsState createState() => _PageDetailsState(id);
}

class _PageDetailsState extends State<PageDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final String id;
  _PageDetailsState(this.id);

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
          actions: [],
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<GetMe>(
              stream: PageManager.getMe(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                return Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 41 / 375,
                      right: MediaQuery.of(context).size.width * 41 / 375,
                      top: MediaQuery.of(context).size.height * 30 / 808),
                  child: Column(
                    children: [
                      DetailsFieldNew(
                        hint: "Անուն",
                        title: snapshot.data.user.firstName,
                        func: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPageDetails(
                                id: id,
                              ),
                            ),
                          );
                        },
                      ),
                      DetailsFieldNew(
                        hint: "Ազգանուն",
                        title: snapshot.data.user.lastName,
                        func: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPageDetails(
                                id: id,
                              ),
                            ),
                          );
                        },
                      ),
                      DetailsFieldNew(
                        hint: "Հեռախոսահամար",
                        title: snapshot.data.phone,
                        func: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPageDetails(
                                id: id,
                              ),
                            ),
                          );
                        },
                      ),
                      DetailsFieldNew(
                        hint: "Էլեկտրոնային հասցե",
                        title: snapshot.data.user.email,
                        func: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeEmail(
                                email: snapshot.data.user.email,
                              ),
                            ),
                          );
                        },
                      ),
                      DetailsFieldNew(
                        hint: "Գաղտնաբառ",
                        title: "*********",
                        func: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordNew(
                                email: snapshot.data.user.email,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
