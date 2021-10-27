import 'package:beon/config/constants.dart';
import 'package:beon/functional/user_secure_storage.dart';
import 'package:beon/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:beon/screens/page_details.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _MainDrawerState createState() => _MainDrawerState(id);
}

class _MainDrawerState extends State<MainDrawer> {
  final String id;
  _MainDrawerState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            title: Text(
              "Գլխավոր էջ",
              style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 10 / 375),
            child: Divider(
              color: kPrimaryColor,
              thickness: 2,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageDetails(id: id)));
            },
            // leading: Icon(
            //   Icons.inbox,
            //   color: Colors.orange,
            // ),
            title: Text(
              "Էջի կարգավորումներ",
              style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 10 / 375),
            child: Divider(
              color: kPrimaryColor,
              thickness: 2,
            ),
          ),
          ListTile(
            onTap: () {
              UserSecureStorage.deletetall();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            title: Text(
              "Դուրս գալ",
              style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
