import 'dart:isolate';
import 'dart:ui';
import 'package:beon/config/constants.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/get_company_files.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Office extends StatefulWidget {
  const Office({Key key, this.id}) : super(key: key);
  final int id;

  @override
  _OfficeState createState() => _OfficeState(id);
}

class _OfficeState extends State<Office> {
  TextEditingController nameController;
  TextEditingController dateController;
  int progress = 0;
  ReceivePort _receivePort = ReceivePort();
  List<Result> files = [];

  bool isNext = false;

  int offset = 0;
  bool _isData = false;
  void update() {
    files.clear();
    PageManager.getCompanyFiles(
            id, dateController.text, nameController.text, offset)
        .listen((event) {
      for (int i = 0; i < event.results.length; i++) {
        files.add(event.results[i]);
      }
      setState(() {
        _isData = true;
      });
    });
  }

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();

    nameController = new TextEditingController();
    dateController = new TextEditingController();
    final df = new DateFormat.jm('hy');

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });
    });

    FlutterDownloader.registerCallback(downloadingCallback);
    update();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dateController.dispose();
  }

  final int id;
  _OfficeState(this.id);

  @override
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    update();
  }

  void openSnack(Color color, String text) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 30 / 375),
            child: Center(
                child: Text(
              "Իմ գրասենյակ",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            )),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 28 / 808),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 5 / 808),
                  child: TextField(
                    controller: nameController,
                    onChanged: (String value) => {
                      setState(() {
                        _isData = false;
                        update();
                      })
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 32,
                        color: Colors.grey,
                      ),

                      contentPadding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 18 / 375),
                      filled: true,
                      fillColor: kInput,
                      //helperText: validate ? errorText : null,
                      helperStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      //labelText: hint,

                      alignLabelWithHint: true,
                      hintText: "որոնել",
                      labelStyle: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                      //prefixIcon: Icon(icon),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 18 / 808),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).size.width * 18 / 375),
                          filled: true,
                          fillColor: kInput,
                          //helperText: validate ? errorText : null,
                          helperStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),

                          alignLabelWithHint: true,
                          hintText: "Ընտրել ժամանակահատվածը",
                          labelStyle: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 21 / 808),

                        //width: MediaQuery.of(context).size.width * 0.93,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 18 / 808,
                ),
                Visibility(
                  visible: !_isData,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<GetCompanyFiles>(
                    stream: PageManager.getCompanyFiles(
                        id, dateController.text, nameController.text, offset),
                    builder: (context, snapshot) {
                      if (snapshot.data == null && _isData)
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: kPrimaryColor,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        );

                      if (snapshot.data?.count == 0 && files.length == 0) {
                        return Center(
                          child: Text(
                            "Կազմակերպությանը ֆայլեր կցված չեն",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height *
                                            10 /
                                            808),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            files[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Flexible(
                                            flex: 1,
                                            child: Image.asset(
                                                "assets/images/line.png")),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "${DateFormat.yMMMMd('hy').format(files[index].createdAt)} ${DateFormat.jm('hy').format(files[index].createdAt)}",
                                            // snapshot.data.results[index].createdAt
                                            //     .toString()
                                            //     .substring(0, 10),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Flexible(
                                            flex: 1,
                                            child: Image.asset(
                                                "assets/images/line.png")),
                                        GestureDetector(
                                          onTap: () async {
                                            final status = await Permission
                                                .storage
                                                .request();

                                            if (status.isGranted) {
                                              final externalDir =
                                                  await getExternalStorageDirectory();

                                              final taskId =
                                                  await FlutterDownloader
                                                      .enqueue(
                                                url: files[index].file,
                                                savedDir: externalDir.path,
                                                fileName: files[index]
                                                    .file
                                                    .split("/")
                                                    .last,
                                                showNotification: true,
                                                openFileFromNotification: true,
                                              ).then((value) => value.isNotEmpty
                                                      ? openSnack(Colors.green,
                                                          "Ֆայլը ներբեռնվել է")
                                                      : openSnack(Colors.red,
                                                          "Ինչ որ բան այն չէ"));
                                            } else {}
                                          },
                                          child: Icon(
                                            Icons.download_rounded,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        15 /
                                        808,
                                  ),
                                ],
                              );
                            },
                          ),
                          Visibility(
                            visible: snapshot.data?.next != null ? true : false,
                            child: TextButton(
                              onPressed: () {
                                offset += 10;
                                PageManager.getCompanyFiles(
                                        id,
                                        dateController.text,
                                        nameController.text,
                                        offset)
                                    .listen((event) {
                                  for (int i = 0;
                                      i < event.results.length;
                                      i++) {
                                    files.add(event.results[i]);
                                  }
                                  setState(() {
                                    _isData = true;
                                  });
                                });
                              },
                              child: Text("ցույց տալ ավելին"),
                            ),
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
