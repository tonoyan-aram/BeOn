import 'package:beon/config/constants.dart';
import 'package:beon/screens/consultant_page.dart';
import 'package:beon/screens/my_details_page.dart';
import 'package:beon/screens/office_page.dart';
import 'package:beon/screens/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({
    Key key,
    this.id,
    this.name,
    this.image,
  }) : super(key: key);
  final int id;
  final String name;
  final String image;
  @override
  _CompanyPageState createState() => _CompanyPageState(id, name, image);
}

class _CompanyPageState extends State<CompanyPage>
    with SingleTickerProviderStateMixin {
  final int id;
  final String name;
  final String image;
  TabController _controller;
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  _CompanyPageState(this.id, this.name, this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TabBar(
          unselectedLabelColor: Colors.lightBlue[100],
          labelColor: const Color(0xFF3baee7),
          indicatorWeight: 2,
          indicatorColor: Colors.blue[100],
          controller: _controller,
          tabs: [
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/images/tab1.svg"),
                    Center(
                      child: Text(
                        "Առաջադրանքներ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/images/tab2.svg"),
                    Text(
                      "Իմ գրասենյակը",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/images/tab3.svg"),
                    Text(
                      "Իմ տվյալները",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/images/tab4.svg"),
                    Text(
                      "Խորհրդատու",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Task(
            id: id,
            name: name,
            image: image,
          ),
          Office(id: id),
          Details(id: id),
          Consultant(
            id: id,
            image: image,
          ),
        ],
      ),
    );
  }
}
