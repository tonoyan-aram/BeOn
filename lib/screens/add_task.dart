import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/get_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class AddTask extends StatefulWidget {
  const AddTask({
    Key key,
    this.id,
    this.image,
  }) : super(key: key);
  final int id;
  final String image;

  @override
  _AddTaskState createState() => _AddTaskState(
        id,
        image,
      );
}

class _AddTaskState extends State<AddTask> {
  final int id;
  final String image;
  _AddTaskState(
    this.id,
    this.image,
  );
  String TaxationUrl;

  TextEditingController accountantController;
  TextEditingController descriptionController;
  TextEditingController nameController;
  TextEditingController dateController;
  TimeOfDay time = new TimeOfDay.now();

  bool _isLoaded = false;

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;

  bool _isAudio;
  bool _isRecord = false;
  bool _isPlay = false;
  int managerCount;
  String accountant;

  StreamSubscription _recorderSubscription;

  void initState() {
    accountantController = new TextEditingController();
    descriptionController = new TextEditingController();
    nameController = new TextEditingController();
    dateController = new TextEditingController();
    _isAudio = false;
    PageManager.getManager(id).listen((event) {
      managerCount = event.accountant.length;
      if (managerCount == 1) {
        accountant = event.accountant[0].url;
        TaxationUrl = event.accountant[0].url;
      }
    });

    super.initState();
    startIt();
  }

  void dispose() {
    if (_myRecorder != null) {
      _myRecorder.closeAudioSession();
      _myRecorder = null;
    }
    super.dispose();
    if (timer != null) timer.cancel();
    accountantController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    _recorderSubscription = null;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        //cancelText: "փակել",
        //confirmText: "լավ",
        //helpText: "ընտրեք ամսաթիվը",
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) _selectTime(context);
    setState(() {
      selectedDate = picked;
      dateController.text = selectedDate.toLocal().toString().split(' ')[0];
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: time,
      cancelText: "փակել",
      confirmText: "լավ",
      helpText: "ընտրեք ժամը",
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        time = picked;
        dateController.text += " " +
            time
                .format(context)
                .toString(); // .toLocal().toString().split(' ')[0];
      });
  }

  List<String> files = [];
  List<File> file = [];

  void uploadFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //_file = File(result.files.single.path);

      files.add(result.files.single.path);
      file.add(File(result.files.single.path));
      setState(() {});
    } else {}
  }

  FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  String filePath;
  bool _play = false;
  String _recorderTxt = '00:00:00';
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  String second;
  String minute;
  String hour;
  var oneSec = Duration(seconds: 1);
  Timer timer;

  void startTimer() {
    _timer = new Timer.periodic(
      oneSec,
      (timer) => setState(
        () {
          if (seconds < 10) second = "0$seconds";
          if (seconds >= 10) second = seconds.toString();
          if (minutes < 10) minute = "0$minutes";
          if (minutes >= 10) minute = minutes.toString();
          if (hours < 10) hour = "0$hours";
          if (hours >= 10) hour = hours.toString();

          _recorderTxt = "$hour:$minute:$second";
          if (seconds < 0) {
            timer.cancel();
          } else {
            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
        },
      ),
    );
  }

  void stopTimer() {
    _timer.cancel();
    timer.cancel();
    oneSec = Duration(seconds: 0);
  }

  void startIt() async {
    filePath = '/sdcard/Download/audio.wav';
    _myRecorder = FlutterSoundRecorder();
    _myRecorder.closeAudioSession();
    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 10));

    _recorderSubscription = _myRecorder.onProgress.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        //_recorderTxt = txt.substring(0, 8);
      });
    });
    _recorderSubscription.resume();
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
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
                "Նոր առաջադրանք",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
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
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 28 / 375,
                right: MediaQuery.of(context).size.width * 28 / 375,
                top: MediaQuery.of(context).size.height * 30 / 808,
                bottom: MediaQuery.of(context).size.height * 30 / 808,
              ),
              child: Column(
                children: [
                  StreamBuilder<ManagerResponse>(
                    stream: PageManager.getManager(id),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return CustomTextInput(
                          controller: accountantController,
                          validate: _validate,
                          hint: "Ընտրել աշխատակից",
                          errorText: "*Պարտադիր դաշտ",
                          isPassword: false,
                          marginTop: 21,
                          inputType: TextInputType.text,
                        );
                      }
                      return Stack(
                        children: [
                          CustomTextInput(
                            ishint: 0,
                            controller: accountantController,
                            validate: _validate,
                            hint: "Ընտրել աշխատակից",
                            errorText: "*Պարտադիր դաշտ",
                            isPassword: false,
                            marginTop: 21,
                            inputType: TextInputType.text,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    21 /
                                    808),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: kInput,
                            ),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width *
                                    18 /
                                    375,
                                right: MediaQuery.of(context).size.width *
                                    10 /
                                    375),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                //iconDisabledColor: Colors.black,

                                iconEnabledColor: kPrimaryColor,
                                iconSize: MediaQuery.of(context).size.width *
                                    30 /
                                    375,
                                hint: Text(
                                  "Ընտրել աշխատակից",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                value: TaxationUrl, // currently selected item
                                isExpanded: true,
                                items: snapshot.data.accountant
                                    .map((item) => DropdownMenuItem(
                                          child: Text(
                                            "${item.user.firstName}" +
                                                " " "${item.user.lastName}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          value: item.url,
                                        ))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  accountantController.text = value;
                                  this.TaxationUrl = value;
                                }),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (accountantController.text != null &&
                                    accountantController.text.isNotEmpty)
                                ? true
                                : false,
                            child: Positioned(
                                top: MediaQuery.of(context).size.width *
                                    12 /
                                    375,
                                left: MediaQuery.of(context).size.width *
                                    19 /
                                    375,
                                child: Text(
                                  "Ընտրել աշխատակից",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8),
                                )),
                          )
                        ],
                      );
                    },
                  ),
                  CustomTextInput(
                    controller: nameController,
                    validate: _validate1,
                    hint: "Առաջադրանքի վերնագիրը",
                    errorText: "*Պարտադիր դաշտ",
                    isPassword: false,
                    marginTop: 21,
                    inputType: TextInputType.text,
                  ),
                  CustomTextInput(
                    controller: descriptionController,
                    validate: _validate2,
                    hint: "Առաջադրանքի բովանդակությունը",
                    errorText: "*Պարտադիր դաշտ",
                    isPassword: false,
                    marginTop: 21,
                    inputType: TextInputType.text,
                  ),
                  Stack(
                    children: [
                      CustomTextInput(
                        controller: dateController,
                        validate: _validate3,
                        hint: "Վերջնաժամկետ",
                        errorText: "*Պարտադիր դաշտ",
                        isPassword: false,
                        marginTop: 21,
                        inputType: TextInputType.text,
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  21 /
                                  808),

                          //width: MediaQuery.of(context).size.width * 0.93,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(_recorderTxt),
                      Stack(
                        children: [
                          Visibility(
                            visible: !_isRecord,
                            child: IconButton(
                                icon: Icon(Icons.mic),
                                onPressed: () {
                                  setState(() {
                                    _isRecord = !_isRecord;
                                  });
                                  record();
                                  startTimer();
                                }),
                          ),
                          Visibility(
                            visible: _isRecord,
                            child: IconButton(
                                icon: Icon(Icons.stop),
                                onPressed: () {
                                  setState(() {
                                    _isRecord = !_isRecord;
                                  });
                                  stopRecord();
                                  stopTimer();
                                }),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Row(
                            children: [
                              Visibility(
                                visible: !_isPlay,
                                child: IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    onPressed: () {
                                      if (_isAudio) {
                                        setState(() {
                                          _isPlay = !_isPlay;
                                        });
                                        startPlaying();
                                      }
                                    }),
                              ),
                              Visibility(
                                visible: _isPlay,
                                child: IconButton(
                                    icon: Icon(Icons.stop_circle),
                                    onPressed: () {
                                      setState(() {
                                        _isPlay = !_isPlay;
                                      });
                                      stopPlaying();
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed: () {
                            uploadFile();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 10 / 375,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          files[index].split("/").last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 80 / 375,
                  ),
                  Center(
                    child: !_isLoaded
                        ? ButtonWidget(
                            onClick: () {
                              if (managerCount == 1 && _isAudio) {
                                setState(() {
                                  _validate1 = false;
                                  _validate2 = false;
                                });
                                accountantController.text = accountant;
                                if (nameController.text?.length == 0) {
                                  nameController.text = "Ձայնային առաջադրանք";
                                }
                                if (descriptionController.text?.length == 0) {
                                  descriptionController.text =
                                      "Ձայնային առաջադրանք";
                                }
                              }
                              setState(() {
                                (accountantController.text.isEmpty &&
                                        managerCount != 1)
                                    ? _validate = true
                                    : _validate = false;
                                (nameController.text.isEmpty)
                                    ? _validate1 = true
                                    : _validate1 = false;
                                (descriptionController.text.isEmpty)
                                    ? _validate2 = true
                                    : _validate2 = false;
                              });

                              if (!_validate && !_validate1 && !_validate2) {
                                setState(() {
                                  _isLoaded = true;
                                });

                                PageManager.addTasks(
                                        id.toString(),
                                        dateController.text,
                                        accountantController.text,
                                        nameController.text,
                                        descriptionController.text,
                                        _isAudio,
                                        files,
                                        file,
                                        context)
                                    .listen((val) {
                                  setState(() {
                                    _isLoaded = false;
                                  });
                                });
                              }
                            },
                            btnText: "Ստեղծել",
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
          )),
    );
  }

  Future<void> record() async {
    startIt();
    Directory dir = Directory(path.dirname(filePath));

    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.closeAudioSession();
    _myRecorder.openAudioSession();
    await _myRecorder
        .startRecorder(
          toFile: filePath,
          codec: Codec.pcm16WAV,
        )
        .then((value) {});

    setState(() {
      _isAudio = true;
    });
    files.add(filePath);
    file.add(File(filePath));
  }

  Future<String> stopRecord() async {
    //stopTimer();
    _recorderSubscription.cancel();

    _myRecorder.closeAudioSession();

    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    Audio file = Audio.file(filePath);

    audioPlayer.open(
      file,
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }
}
