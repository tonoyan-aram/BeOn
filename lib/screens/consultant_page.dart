import 'package:beon/config/constants.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/get_manager.dart';
import 'package:flutter/material.dart';

class Consultant extends StatefulWidget {
  const Consultant({
    Key key,
    this.id,
    this.image,
  }) : super(key: key);
  final int id;
  final String image;

  @override
  _ConsultantState createState() => _ConsultantState(
        id,
        image,
      );
}

class _ConsultantState extends State<Consultant> {
  void initState() {
    super.initState();
  }

  final int id;
  final String image;
  _ConsultantState(this.id, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Մասնագետ-խորհրդատու",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 27 / 375,
                top: MediaQuery.of(context).size.width * 7 / 375),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 21 / 375,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.of(context).size.width * 19 / 375,
                backgroundImage: (image != null)
                    ? NetworkImage(image)
                    : AssetImage('assets/images/companyLogo.png'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 20 / 375,
              vertical: MediaQuery.of(context).size.height * 20 / 808),
          child: StreamBuilder<ManagerResponse>(
              stream: PageManager.getManager(id),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: kPrimaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ));
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.accountant.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            //height: 200,
                            //color: Colors.red,
                            padding: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.height * 20 / 808,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/fr1.png'),
                                  //height: MediaQuery.of(context).size.height * 140 / 808,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          100 /
                                          375,
                                      right: MediaQuery.of(context).size.width *
                                          35 /
                                          375),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: kPrimaryColor,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              snapshot.data.accountant[index]
                                                      .user.firstName +
                                                  " " +
                                                  snapshot
                                                      .data
                                                      .accountant[index]
                                                      .user
                                                      .lastName,
                                              // "aaaaaaaaaaaa sssssss",
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                5 /
                                                375,
                                      ),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business_center_outlined,
                                            color: kPrimaryColor,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Հաշվապահ",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                5 /
                                                375,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_phone_sharp,
                                            color: kPrimaryColor,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            snapshot
                                                .data.accountant[index].phone,
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      //SizedBox(height: MediaQuery.of(context).size.height * 11 / 808,),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                5 /
                                                375,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.mail_outline,
                                            color: kPrimaryColor,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              snapshot.data.accountant[index]
                                                  .user.email,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: -MediaQuery.of(context).size.width * 10 / 375,
                            // top: -MediaQuery.of(context)
                            //         .size
                            //         .width *
                            //     1 /
                            //     375,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/beon.png'),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: MediaQuery.of(context).size.width *
                                        33 /
                                        375,
                                    backgroundImage: (snapshot
                                                .data.accountant[index].image !=
                                            null)
                                        ? NetworkImage(snapshot
                                            .data.accountant[index].image)
                                        : Image.asset(
                                                'assets/images/companyLogo.png')
                                            .image,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }
}
