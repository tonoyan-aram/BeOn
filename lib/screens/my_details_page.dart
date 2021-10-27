import 'package:beon/config/constants.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/get_manager.dart';
import 'package:beon/screens/delete_details_page.dart';
import 'package:beon/screens/edit_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatefulWidget {
  const Details({Key key, this.id}) : super(key: key);
  final int id;

  @override
  _DetailsState createState() => _DetailsState(id);
}

class _DetailsState extends State<Details> {
  String activity;
  String service;
  String taxation;
  bool isdeleted = false;

  @override
  void initState() {
    PageManager.getManager(id).listen((profile) {
      setState(() {
        isdeleted = !profile.isDeleted;
      });
    });
    // TODO: implement initState
    activity = "";
    service = "";
    super.initState();
  }

  @override
  final int id;
  _DetailsState(this.id);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Visibility(
              visible: isdeleted,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditDetails(
                        id: id,
                        title: service,
                        activity: activity,
                        taxation: taxation,
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: isdeleted,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteDetails(
                        id: id,
                        from: "edit",
                      ),
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 27 / 375),
                    child: SvgPicture.asset("assets/icons/delete.svg")),
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<ManagerResponse>(
              stream: PageManager.getManager(id),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );

                activity = snapshot.data.typeOfActivity
                    .map((e) => e.name)
                    .toList()
                    .join(", ");
                service = snapshot.data.service
                    .map((e) => e.name)
                    .toList()
                    .join(", ");

                taxation = snapshot.data.taxationSystem.name;

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 12 / 375),
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width *
                                    100 /
                                    375),
                            child: Container(
                              padding: EdgeInsets.only(left: 15),
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data.name,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              //padding: EdgeInsets.only(left: ),
                              color: kPrimaryColor,
                              height:
                                  MediaQuery.of(context).size.height * 64 / 808,
                              width:
                                  MediaQuery.of(context).size.width * 300 / 375,
                            ),
                          ),
                          Container(
                            child: CircleAvatar(
                              radius:
                                  MediaQuery.of(context).size.height * 71 / 808,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: MediaQuery.of(context).size.height *
                                    69 /
                                    808,
                                backgroundImage: (snapshot.data.logo == null)
                                    ? AssetImage(
                                        'assets/images/companyLogo.png')
                                    : NetworkImage(snapshot.data.logo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 41 / 375,
                          right: MediaQuery.of(context).size.width * 41 / 375,
                          top: MediaQuery.of(context).size.height * 30 / 808),
                      child: Column(
                        children: [
                          DetailsField(
                            hint: "Անուն",
                            title: snapshot.data.name,
                          ),
                          DetailsField(
                            hint: "Հեռախոսահամար",
                            title: snapshot.data.client.phone,
                          ),
                          DetailsField(
                            hint: "Էլեկտրոնային հասցե",
                            title: snapshot.data.client.user.email,
                          ),
                          DetailsField(
                            hint: "ՀՎՀՀ",
                            title: snapshot.data.hvhh,
                          ),
                          DetailsField(
                            hint: "Տնօրենի անուն, ազգանուն",
                            title: snapshot.data.directorFullName,
                          ),
                          DetailsField(
                            hint: "Կարգավիճակ",
                            title: (snapshot.data.category == 0)
                                ? "Գործող"
                                : "Չգործող",
                          ),
                          DetailsField(
                            hint: "Պայմանագրի սկիզբ",
                            title: snapshot.data.agreementDate
                                .toString()
                                .substring(0, 10),
                          ),
                          DetailsField(
                            hint: "Փաթեթ",
                            title: snapshot.data.packages.name,
                          ),
                          DetailsField(
                            hint: "Գործունեության տեսակ",
                            title: activity,
                          ),
                          DetailsField(
                            hint: "Ծառայության տեսակ",
                            title: service,
                          ),
                          DetailsField(
                            hint: "Հարկման համակարգ",
                            title: snapshot.data.taxationSystem.name,
                          ),
                          DetailsField(
                            hint: "Աշխատակիցների քանակ",
                            title: snapshot.data.countEmployees.toString(),
                          ),
                          DetailsField(
                            hint: "Այլ տվյալներ",
                            title: snapshot.data.changeData,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
