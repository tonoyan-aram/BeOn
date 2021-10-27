import 'package:beon/config/constants.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/getMe.dart';
import 'package:beon/screens/add_company.dart';
import 'package:beon/screens/company_page.dart';
import 'package:beon/screens/image_upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String name;
  String image;
  String id;
  @override
  void initState() {
    super.initState();
    PageManager.getMe().listen((profile) {
      setState(() {
        name = "${profile.user.firstName} ${profile.user.lastName}";
        image = profile.image;
        id = profile.id.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            name ?? "",
            style: TextStyle(color: kPrimaryColor, fontSize: 16),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageUpload(
                            from: "profile",
                          )));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 7 / 375,
                      top: MediaQuery.of(context).size.width * 7 / 375),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 21 / 375,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.width * 19 / 375,
                      backgroundImage: (image != null)
                          ? NetworkImage(image)
                          : AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 7 / 375,
                  top: MediaQuery.of(context).size.width * 7 / 375,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 11 / 375,
                        height: MediaQuery.of(context).size.width * 11 / 375,
                        decoration: new BoxDecoration(
                          color: kPhotoAdd,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 7 / 375,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                height: MediaQuery.of(context).size.width * 21 / 375,
              ),
              color: kPrimaryColor,
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      endDrawer: Drawer(
        child: MainDrawer(id: id),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 20 / 375,
              vertical: MediaQuery.of(context).size.height * 20 / 808),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Center(
                    child: Text(
                      "Կազմակերպություններ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
                  height: MediaQuery.of(context).size.height * 31 / 808,
                  width: MediaQuery.of(context).size.width * 226 / 375,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 40 / 375,
              ),
              StreamBuilder<GetMe>(
                  stream: PageManager.getMe(),
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
                        itemCount: snapshot.data.clientCompany?.length,
                        itemBuilder: (context, index) {
                          int id = snapshot.data.clientCompany[index].id;
                          return Visibility(
                            visible: !snapshot
                                .data.clientCompany[index].isDeletedByManager,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CompanyPage(
                                              id: id,
                                              name: snapshot.data
                                                  .clientCompany[index].name,
                                              image: snapshot.data
                                                  .clientCompany[index].logo,
                                            )));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                20 /
                                                808),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/fr1.png'),
                                          width: double.infinity,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  85 /
                                                  375,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  35 /
                                                  375),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapshot.data
                                                    .clientCompany[index].name,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    5 /
                                                    375,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/images/gic.svg'),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    5 /
                                                    375,
                                              ),
                                              Text(
                                                "ՀՎՀՀ",
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    5 /
                                                    375,
                                              ),
                                              Text(
                                                snapshot.data
                                                    .clientCompany[index].hvhh,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Icon(
                                                Icons.mail_outline,
                                                color: kPrimaryColor,
                                              ),
                                              Text(
                                                "info@beon.am",
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: -MediaQuery.of(context).size.width *
                                        10 /
                                        375,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/beon.png'),
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                33 /
                                                375,
                                            backgroundImage: (snapshot
                                                        .data
                                                        .clientCompany[index]
                                                        .logo !=
                                                    null)
                                                ? NetworkImage(snapshot.data
                                                    .clientCompany[index].logo)
                                                : Image.asset(
                                                        'assets/images/companyLogo.png')
                                                    .image,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCompany()));
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 35 / 808),

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/border.png'),
                            //height: MediaQuery.of(context).size.height * 140 / 808,
                            width: double.infinity,
                          ),
                          Text(
                            "Ավելացնել կազմակերպություն",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),

                      //height: MediaQuery.of(context).size.height * 140 / 808,
                      //width: double.infinity,
                    ),
                    Positioned(
                      left: -MediaQuery.of(context).size.width * 10 / 375,
                      top: -MediaQuery.of(context).size.width * 6 / 375,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCompany()));
                        },
                        child: Container(
                          child: Image(
                            image: AssetImage('assets/images/Frame1.png'),
                            //height: MediaQuery.of(context).size.height * 140 / 808,
                            //width: 100,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
