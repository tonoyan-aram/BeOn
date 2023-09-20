import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beon/config/constants.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/task_details_response.dart';
import 'package:beon/screens/file_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:path/path.dart' as path;

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    Key key,
    this.id,
    this.image,
  }) : super(key: key);
  final int id;
  final String image;

  @override
  _TaskDetailsState createState() => _TaskDetailsState(
        id,
        image,
      );
}

String name;
double rating;
bool visible;
bool sms_visible;
String taskAudioFile;
TextEditingController smsController;
int startIndex;
List<dynamic> sms = [];

class _TaskDetailsState extends State<TaskDetails> {
  void initState() {
    PageManager.getTaskDetails(id).listen((event) {
      if (event.isVoice) {
        if (event.taskFile.length > 1) {
          taskAudioFile = event.taskFile.firstWhere((element) {
            String fileExt = element.fileName.split(".").last;
            return fileExt == "wav";
          }).file;
        } else {
          String fileExt = event.taskFile.first.fileName.split(".").last;
          taskAudioFile = fileExt == "wav" ? event.taskFile.first.file : "";
        }
      }
    });

    smsController = new TextEditingController();
    super.initState();
    sms_visible = false;
    visible = false;
    rating = 0.0;

    PageManager.getTaskDetails(id).listen((profil) {
      setState(() {
        name = profil.creatorName;
      });
    });
    startIt();
  }

  void dispose() {
    smsController.dispose();
    super.dispose();
    if (timer != null) timer.cancel();

    if (_myRecorder != null) {
      _myRecorder.closeAudioSession();
      _myRecorder = null;
    }
    _recorderSubscription = null;
  }

  final int id;
  final String image;
  int playingId;
  _TaskDetailsState(this.id, this.image);

  Future<XFile> _imageFile;
  ImagePicker _picker = new ImagePicker();
  Function onFilePicked;
  String fileName;
  File _image;

  bool _isAudio = false;
  bool _isRecord = false;
  bool _isPlay = false;
  bool _isPlayTaskAudio = false;

  StreamSubscription _recorderSubscription;
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
          child: StreamBuilder<TaskDetailsResponse>(
              stream: PageManager.getTaskDetails(id),
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
                if (snapshot.data.ratings.isNotEmpty) {
                  for (int i = 0; i < snapshot.data.ratings.length; i++) {
                    if (snapshot.data.ratings[i].client != null) {
                      rating = snapshot.data.ratings[i].score.toDouble();
                      visible = true;
                    }
                  }
                }

                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 20 / 375,
                      vertical: MediaQuery.of(context).size.height * 20 / 808),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(7, 96, 141, 0.54),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 42 / 808,
                          child: Center(
                              child: Text(
                            snapshot.data.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 8 / 808,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: kInput,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: double.infinity,
                          height:
                              MediaQuery.of(context).size.height * 123 / 808,
                          child: Text(
                            snapshot.data.text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 27 / 808,
                        ),
                        Row(
                          children: [
                            Text(
                              "Ստեղծող - ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              snapshot.data.creatorName,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 10 / 808,
                        ),
                        Visibility(
                          visible: snapshot.data.isVoice,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 2,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Stack(
                              children: [
                                Visibility(
                                  visible: !_isPlayTaskAudio,
                                  child: GestureDetector(
                                      child: Icon(Icons.play_arrow),
                                      onTap: () {
                                        setState(() {
                                          _isPlayTaskAudio = !_isPlayTaskAudio;
                                        });
                                        startPlaying(taskAudioFile);
                                      }),
                                ),
                                Visibility(
                                  visible: _isPlayTaskAudio,
                                  child: GestureDetector(
                                      child: Icon(Icons.stop),
                                      onTap: () {
                                        setState(() {
                                          _isPlayTaskAudio = !_isPlayTaskAudio;
                                          playingId = null;
                                        });
                                        stopPlaying();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 10 / 808,
                        // ),
                        Visibility(
                          visible: snapshot.data.status == "end",
                          child: Container(
                              child: SmoothStarRating(
                            rating: rating,
                            isReadOnly: visible,
                            size: 30,
                            color: kPrimaryColor,
                            borderColor: kPrimaryColor,
                            filledIconData: Icons.star,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: false,
                            spacing: 2.0,
                            onRated: (value) {
                              if (rating > 0) {
                                PageManager.rateTask(value, id).listen((val) {
                                  setState(() {
                                    rating = val.score.toDouble();
                                  });
                                });
                              }
                            },
                          )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 19 / 808,
                        ),
                        Text(
                          "Հաղորդագրություններ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).size.width * 20 / 375),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            15 /
                                            375,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                15 /
                                                375),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.mail_outline,
                                        size: 30,
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: () {
                                        PageManager.seenSms(id);
                                        setState(() {});
                                        startIndex = 0;
                                        sms.clear();
                                        PageManager.getSms(0, id)
                                            .listen((event) {
                                          for (int i = 0;
                                              i < event.length;
                                              i++) {
                                            sms.add(event[i]);
                                          }
                                        });
                                        setState(() {
                                          sms_visible = !sms_visible;
                                        });
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    right: MediaQuery.of(context).size.width *
                                        18 /
                                        375,
                                    top: MediaQuery.of(context).size.width *
                                        16 /
                                        375,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Visibility(
                                          visible:
                                              (snapshot.data.newSmsCount > 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15 /
                                                375,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15 /
                                                375,
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.newSmsCount.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageManager.seenFile(id);
                                      setState(() {});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FilePage(
                                                    id: id,
                                                    image: image,
                                                  )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            15 /
                                            375,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                30 /
                                                375,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/file.svg",
                                        width: 25.0,
                                        height: 25.0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        10 /
                                        375,
                                    top: MediaQuery.of(context).size.width *
                                        7 /
                                        375,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Visibility(
                                          visible:
                                              (snapshot.data.newFileCount > 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15 /
                                                375,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15 /
                                                375,
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.newFileCount.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        28 /
                                        375,
                                    top: MediaQuery.of(context).size.width *
                                        7 /
                                        375,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Visibility(
                                          visible:
                                              (snapshot.data.newSubFileCount >
                                                  0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15 /
                                                375,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15 /
                                                375,
                                            decoration: new BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.newSubFileCount
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: sms_visible,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: kInput,
                                child: Visibility(
                                  visible: sms_visible &&
                                      sms.length >= startIndex + 10,
                                  child: TextButton(
                                    onPressed: () {
                                      startIndex += 10;
                                      PageManager.getSms(startIndex, id)
                                          .listen((event) {
                                        for (int i = 0; i < event.length; i++) {
                                          sms.add(event[i]);
                                          //sms.reversed.toList();
                                        }
                                      });

                                      setState(() {});
                                    },
                                    child: Text(
                                      "ցույց տալ ավելի",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: sms.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 5),
                                    color: kInput,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          sms[index].manager == null
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: sms[index].manager == null
                                          ? [
                                              Column(
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        sms[index].text.length >
                                                            0,
                                                    child: Text(
                                                      sms[index].text,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        sms[index].file != null,
                                                    child: Stack(
                                                      children: [
                                                        Visibility(
                                                          visible: sms[index]
                                                                      .file !=
                                                                  null
                                                              ? sms[index]
                                                                      .fileName
                                                                      .split(
                                                                          ".")
                                                                      .last !=
                                                                  "wav"
                                                              : false,
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(sms[index].file !=
                                                                                null &&
                                                                            sms[index].fileName.split(".").last !=
                                                                                "wav"
                                                                        ? sms[index]
                                                                            .file
                                                                        : ""),
                                                                    fit: BoxFit
                                                                        .fill)),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: sms[index]
                                                                      .file !=
                                                                  null
                                                              ? sms[index]
                                                                      .fileName
                                                                      .split(
                                                                          ".")
                                                                      .last ==
                                                                  "wav"
                                                              : false,
                                                          child: Row(
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Visibility(
                                                                    visible:
                                                                        !_isPlay,
                                                                    child: GestureDetector(
                                                                        child: Icon(Icons.play_arrow),
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            _isPlay =
                                                                                !_isPlay;
                                                                            playingId =
                                                                                sms[index].id;
                                                                          });
                                                                          startPlaying(
                                                                              sms[index].file);
                                                                        }),
                                                                  ),
                                                                  Visibility(
                                                                    visible: _isPlay &&
                                                                        playingId ==
                                                                            sms[index].id,
                                                                    child: GestureDetector(
                                                                        child: Icon(Icons.stop),
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            _isPlay =
                                                                                !_isPlay;
                                                                            playingId =
                                                                                null;
                                                                          });
                                                                          stopPlaying();
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(sms[index]
                                                                          .file !=
                                                                      null
                                                                  ? sms[index]
                                                                      .file
                                                                      .split(
                                                                          "/")
                                                                      .last
                                                                  : ""),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    15 /
                                                    375,
                                                backgroundImage: (sms[index]
                                                            .client
                                                            ?.image !=
                                                        null)
                                                    ? NetworkImage(
                                                        sms[index].client.image)
                                                    : AssetImage(
                                                        'assets/images/companyLogo.png'),
                                              ),
                                            ]
                                          : [
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    15 /
                                                    375,
                                                backgroundImage: (sms[index]
                                                            .client
                                                            ?.image !=
                                                        null)
                                                    ? NetworkImage(
                                                        sms[index].client.image)
                                                    : AssetImage(
                                                        'assets/images/companyLogo.png'),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    sms[index].text,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        sms[index].file != null,
                                                    child: Stack(
                                                      children: [
                                                        Visibility(
                                                          visible: sms[index]
                                                                      .file !=
                                                                  null
                                                              ? sms[index]
                                                                      .fileName
                                                                      .split(
                                                                          ".")
                                                                      .last !=
                                                                  "wav"
                                                              : false,
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(sms[index].file !=
                                                                                null &&
                                                                            sms[index].fileName.split(".").last !=
                                                                                "wav"
                                                                        ? sms[index]
                                                                            .file
                                                                        : ""),
                                                                    fit: BoxFit
                                                                        .fill)),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: sms[index]
                                                                      .file !=
                                                                  null
                                                              ? sms[index]
                                                                      .fileName
                                                                      .split(
                                                                          ".")
                                                                      .last ==
                                                                  "wav"
                                                              : false,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                child: Stack(
                                                                  children: [
                                                                    Visibility(
                                                                      visible:
                                                                          !_isPlay,
                                                                      child: GestureDetector(
                                                                          child: Icon(Icons.play_arrow),
                                                                          onTap: () {
                                                                            setState(() {
                                                                              _isPlay = !_isPlay;
                                                                              playingId = sms[index].id;
                                                                            });
                                                                            startPlaying(sms[index].file);
                                                                          }),
                                                                    ),
                                                                    Visibility(
                                                                      visible: _isPlay &&
                                                                          playingId ==
                                                                              sms[index].id,
                                                                      child: GestureDetector(
                                                                          child: Icon(Icons.stop),
                                                                          onTap: () {
                                                                            setState(() {
                                                                              _isPlay = !_isPlay;
                                                                              playingId = null;
                                                                            });
                                                                            stopPlaying();
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(sms[index]
                                                                          .file !=
                                                                      null
                                                                  ? sms[index]
                                                                      .file
                                                                      .split(
                                                                          "/")
                                                                      .last
                                                                  : ""),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: sms_visible,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor,
                              ),
                              color: kInput,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  //flex: 20,
                                  child: TextField(
                                    controller: smsController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                      //labelText: "Մուտքագրել հաղորդագրություն",
                                      hintText: "Մուտքագրել հաղորդագրություն",
                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                        visible: _isAudio,
                                        child: Text(_recorderTxt)),
                                    // GestureDetector(
                                    //   child: Icon(
                                    //     Icons.mic,
                                    //     color: kPrimaryColor,
                                    //   ),
                                    // ),
                                    Stack(
                                      children: [
                                        Visibility(
                                          visible: !_isRecord,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.mic,
                                                color: kPrimaryColor,
                                              ),
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
                                              icon: Icon(
                                                Icons.stop,
                                                color: kPrimaryColor,
                                              ),
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
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _imageFile = _picker.pickImage(
                                              source: ImageSource.gallery);
                                          _imageFile.then((file) => {
                                                this.setState(() {
                                                  _image = File(file.path);
                                                  fileName = file.path;
                                                })
                                              });
                                        },
                                        child: Icon(
                                          Icons.image_outlined,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 2.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (smsController.text.length > 0 ||
                                              fileName != null ||
                                              _isAudio) {
                                            PageManager.sendSms(
                                                    smsController.text,
                                                    fileName,
                                                    id,
                                                    fileName == null
                                                        ? null
                                                        : File(fileName))
                                                .listen((event) {
                                              PageManager.getOneSms(event.id)
                                                  .listen((event) {
                                                setState(() {
                                                  hours = 0;
                                                  minutes = 0;
                                                  seconds = 0;
                                                  _recorderTxt = "00:00:00";

                                                  sms.insert(0, event);
                                                });
                                              });

                                              setState(() {
                                                smsController.text = "";
                                                fileName = null;
                                              });
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.send_sharp,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
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
    fileName = filePath;
  }

  Future<String> stopRecord() async {
    //stopTimer();
    _recorderSubscription.cancel();

    _myRecorder.closeAudioSession();

    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying(String fileP) async {
    Audio file = Audio.file(fileP);

    audioPlayer.open(
      Audio.network(fileP),
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }
}
