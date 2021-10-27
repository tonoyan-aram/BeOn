import 'dart:async';
import 'package:beon/config/constants.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/get_tasks.dart';
import 'package:beon/screens/add_task.dart';
import 'package:beon/screens/task_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Task extends StatefulWidget {
  const Task({
    Key key,
    this.id,
    this.name,
    this.image,
  }) : super(key: key);
  final int id;
  final String name;
  final String image;

  @override
  _TaskState createState() => _TaskState(
        id,
        name,
        image,
      );
}

class _TaskState extends State<Task> {
  final int id;
  final String name;
  final String image;
  bool isdeleted = false;
  _TaskState(
    this.id,
    this.name,
    this.image,
  );
  TextEditingController nameController;
  TextEditingController statusController;
  TextEditingController startDateController;
  TextEditingController endDateController;
  String header = "Նոր ստեղծված";
  String bulbColor = "new";
  bool isNext = false;
  List<Result> tasks = [];
  int offset = 0;
  bool _isData = false;

  void update() {
    setState(() {
      _isData = false;
    });

    PageManager.getTasks(
            id.toString(),
            startDateController.text,
            endDateController.text,
            nameController.text,
            bulbColor,
            true,
            offset)
        .listen((event) {
      tasks.clear();
      if (event.results.isNotEmpty) {
        tasks.addAll(event.results);
      }
      setState(() {
        _isData = true;
      });
    });
  }

  String from;
  void addTask(
    int id1,
    String image1,
  ) async {
    final String _response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTask(
                  id: id1,
                  image: image1,
                )));
    setState(() {
      from = _response;
      if (from == "Շնորհակալություն") update();
    });
  }

  @override
  void initState() {
    super.initState();

    nameController = new TextEditingController();
    statusController = new TextEditingController();
    startDateController = new TextEditingController();
    endDateController = new TextEditingController();
    statusController.text = bulbColor;
    PageManager.getManager(id).listen((profile) {
      setState(() {
        isdeleted = profile.isDeleted;
      });
    });

    update();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    statusController.dispose();
    endDateController.dispose();
    startDateController.dispose();
  }

  DateTime startSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startSelectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != startSelectedDate)
      setState(() {
        startSelectedDate = picked;
        startDateController.text =
            startSelectedDate.toLocal().toString().split(' ')[0];
        _isData = false;
        update();
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endSelectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != endSelectedDate)
      setState(() {
        endSelectedDate = picked;
        endDateController.text =
            endSelectedDate.toLocal().toString().split(' ')[0];
        _isData = false;
        update();
      });
  }

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
          title: Center(
            child: Text(
              this.name ?? "",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
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
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 27 / 375,
                right: MediaQuery.of(context).size.width * 27 / 375,
                top: MediaQuery.of(context).size.width * 5 / 375,
                bottom: MediaQuery.of(context).size.width * 20 / 375),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$header առաջադրանքներ",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 260 / 375,
                        height: MediaQuery.of(context).size.width * 35 / 375,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 5 / 808),
                        child: TextField(
                          controller: nameController,
                          onChanged: (String value) {
                            Timer(Duration(seconds: 1), () {
                              update();
                              // }
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: 25,
                              color: Colors.grey,
                            ),

                            contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 4 / 375,
                            ),
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
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Առաջադրանքներ',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5, // Change as per your requirement
                                    width: MediaQuery.of(context).size.width *
                                        0.8, // Change as per your requirement
                                    child: Column(
                                      children: [
                                        RadioListTile(
                                            title: const Text('Նոր ստեղծված'),
                                            value: "new",
                                            groupValue: bulbColor,
                                            onChanged: (val) {
                                              bulbColor = val;
                                              setState(() {
                                                _isData = false;
                                                statusController.text =
                                                    bulbColor;
                                                header = "Նոր ստեղծված";
                                                update();
                                              });
                                              Navigator.pop(context, 'OK');
                                            }),
                                        RadioListTile(
                                            title: const Text('Հաստատված'),
                                            value: "approved",
                                            groupValue: bulbColor,
                                            onChanged: (val) {
                                              bulbColor = val;
                                              setState(() {
                                                _isData = false;
                                                statusController.text =
                                                    bulbColor;
                                                header = "Հաստատված";
                                                update();
                                              });
                                              Navigator.pop(context, 'OK');
                                            }),
                                        RadioListTile(
                                            title: const Text('Ընթացքի մեջ'),
                                            value: "process",
                                            groupValue: bulbColor,
                                            onChanged: (val) {
                                              bulbColor = val;
                                              setState(() {
                                                _isData = false;
                                                statusController.text =
                                                    bulbColor;
                                                header = "Ընթացքի մեջ";
                                                update();
                                              });
                                              Navigator.pop(context, 'OK');
                                            }),
                                        RadioListTile(
                                            title: const Text('Ավարտված'),
                                            value: "end",
                                            groupValue: bulbColor,
                                            onChanged: (val) {
                                              bulbColor = val;
                                              setState(() {
                                                _isData = false;
                                                statusController.text =
                                                    bulbColor;
                                                header = "Ավարտված";
                                                update();
                                              });
                                              Navigator.pop(context, 'OK');
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ).then((value) => {
                                setState(() {
                                  tasks.clear();
                                  offset = 0;
                                  PageManager.getTasks(
                                          id.toString(),
                                          startDateController.text,
                                          endDateController.text,
                                          nameController.text,
                                          bulbColor,
                                          true,
                                          offset)
                                      .listen((event) {
                                    for (int i = 0;
                                        i < event.results.length;
                                        i++) {
                                      tasks.add(event.results[i]);
                                    }
                                  });
                                })
                              });
                        },
                        child: SvgPicture.asset("assets/icons/groupmenu.svg"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 17 / 375,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height:
                                MediaQuery.of(context).size.width * 35 / 375,
                            child: TextField(
                              controller: startDateController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        18 /
                                        375),
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
                                hintText: "սկիզբ",
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
                              height:
                                  MediaQuery.of(context).size.width * 35 / 375,
                              // margin: EdgeInsets.only(
                              //     top:
                              //         MediaQuery.of(context).size.height *
                              //             21 /
                              //             808),
                              width: MediaQuery.of(context).size.width * 0.4,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height:
                                MediaQuery.of(context).size.width * 35 / 375,
                            child: TextField(
                              controller: endDateController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        18 /
                                        375),
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
                                hintText: "ավարտ",
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
                            onTap: () => _selectEndDate(context),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.width * 35 / 375,
                              width: MediaQuery.of(context).size.width * 0.4,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (!isdeleted)
                        {
                          addTask(id, image),
                        }
                      else
                        {_showAlertDialogRegOk(context)}
                    },
                    child: Image.asset("assets/images/newTask.jpg"),
                  ),
                  Visibility(
                    visible: !_isData,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<TaskResponse>(
                      stream: PageManager.getTasks(
                          id.toString(),
                          startDateController.text,
                          endDateController.text,
                          nameController.text,
                          bulbColor,
                          true,
                          offset),
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

                        return Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskDetails(
                                                  id: tasks[index].id,
                                                  image: image,
                                                ))),
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            15 /
                                            375),
                                    child: Card(
                                      color: kInput,
                                      elevation: 3,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                20 /
                                                375),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Icon(
                                                    Icons.bookmark,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 9,
                                                  child: Text(
                                                    tasks[index].name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.lightGreen,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      4 /
                                                      375),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    tasks[index].companyName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: kPrimaryColor),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            15 /
                                                            375,
                                                  ),
                                                  Text(
                                                    tasks[index].text,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  15 /
                                                  375,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Visibility(
                                                        visible: (tasks[index]
                                                                .newSmsCount >
                                                            0),
                                                        child: Container(
                                                          padding: EdgeInsets.only(
                                                              top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  15 /
                                                                  375,
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  15 /
                                                                  375),
                                                          child: Icon(
                                                            Icons
                                                                .email_outlined,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            18 /
                                                            375,
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            4 /
                                                            375,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  15 /
                                                                  375,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  15 /
                                                                  375,
                                                              decoration:
                                                                  new BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                            Text(
                                                              tasks[index]
                                                                  .newSmsCount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Visibility(
                                                        visible: tasks[index]
                                                                    .newFileCount !=
                                                                0 &&
                                                            tasks[index]
                                                                    .newSubFileCount !=
                                                                0,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          padding: EdgeInsets.only(
                                                              top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  15 /
                                                                  375,
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  15 /
                                                                  375),
                                                          child: Icon(
                                                            Icons.attach_file,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            15 /
                                                            375,
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            4 /
                                                            375,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Visibility(
                                                              visible: (tasks[
                                                                          index]
                                                                      .newFileCount >
                                                                  0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    15 /
                                                                    375,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    15 /
                                                                    375,
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              tasks[index]
                                                                  .newFileCount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            35 /
                                                            375,
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            4 /
                                                            375,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Visibility(
                                                              visible: (tasks[
                                                                          index]
                                                                      .newSubFileCount >
                                                                  0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    15 /
                                                                    375,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    15 /
                                                                    375,
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              tasks[index]
                                                                  .newSubFileCount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  10 /
                                                  375,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              7 /
                                                              375,
                                                    ),
                                                    child: CircleAvatar(
                                                      radius:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              15 /
                                                              375,
                                                      backgroundImage: (tasks[
                                                                      index]
                                                                  .accountantImage !=
                                                              null)
                                                          ? NetworkImage(tasks[
                                                                  index]
                                                              .accountantImage)
                                                          : AssetImage(
                                                              'assets/images/avatar.png'),
                                                      // backgroundImage: AssetImage(
                                                      //     'assets/images/avatar.png'),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 4,
                                                  child: Text(
                                                    "${tasks[index].accountantFirstName == null ? "" : tasks[index].accountantFirstName} ${tasks[index].accountantLastName == null ? "" : tasks[index].accountantLastName}",
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Flexible(
                                                  //flex: 1,
                                                  child: Icon(
                                                    Icons.inventory,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 5,
                                                  child: Text(
                                                    "${DateFormat.yMMMMd('hy').format(tasks[index].createdDate)}",
                                                    // overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                              },
                            ),
                            Visibility(
                              visible:
                                  snapshot.data?.next != null ? true : false,
                              child: TextButton(
                                onPressed: () {
                                  offset += 10;
                                  PageManager.getTasks(
                                          id.toString(),
                                          startDateController.text,
                                          endDateController.text,
                                          nameController.text,
                                          bulbColor,
                                          true,
                                          offset)
                                      .listen((event) {
                                    for (int i = 0;
                                        i < event.results.length;
                                        i++) {
                                      tasks.add(event.results[i]);
                                    }
                                    setState(() {});
                                  });
                                },
                                child: Text("ցույց տալ ավելին"),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showAlertDialogRegOk(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Ուշադրությություն"),
    content: Text("Այս պահին հնարավոր չէ ավելացնել նոր առաջադրանք"),
    actions: [
      TextButton(
        child: Text("Լավ"),
        onPressed: () => Navigator.pop(context, 'OK'),
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
