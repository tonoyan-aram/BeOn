import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beon/config/constants.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/task_details_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'delete_details_page.dart';

class FilePage extends StatefulWidget {
  const FilePage({
    Key key,
    this.id,
    this.image,
  }) : super(key: key);
  final int id;
  final String image;

  @override
  _FilePageState createState() => _FilePageState(
        id,
        image,
      );
}

class _FilePageState extends State<FilePage> {
  int id;
  String image;
  bool _isPlay = false;
  int playingId;

  final audioPlayer = AssetsAudioPlayer();
  _FilePageState(this.id, this.image);
  File _file;

  void uploadFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _file = File(result.files.single.path);
      PageManager.addFile(result.files.single.path, id).listen((event) {
        setState(() {});
      });
    } else {}
  }

  void update(int newid) async {
    final List<String> _response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeleteDetails(
          id: newid,
          from: "file",
          filePageId: id,
          filePageImage: image,
        ),
      ),
    );
    setState(() {
      id = int.parse(_response[0]);
      image = _response[1];
    });
  }

  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 20 / 375,
              vertical: MediaQuery.of(context).size.height * 20 / 808),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: uploadFile,
                  child: Container(
                    //margin: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(7, 96, 141, 0.54),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 42 / 808,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ավելացնել ֆայլ",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ],
                    )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 15 / 808,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 6 / 375),
                  child: StreamBuilder<TaskDetailsResponse>(
                      stream: PageManager.getTaskDetails(id),
                      builder: (context, snapshot) {
                        if (snapshot.data == null)
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

                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.taskFile?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 9,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 3),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                //                   <--- left side
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                              top: BorderSide(
                                                //                    <--- top side
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Visibility(
                                                visible: snapshot
                                                        .data
                                                        .taskFile[index]
                                                        .fileName
                                                        .split(".")
                                                        .last ==
                                                    "wav",
                                                child: Stack(
                                                  children: [
                                                    Visibility(
                                                      visible: !_isPlay,
                                                      child: GestureDetector(
                                                          child: Icon(
                                                              Icons.play_arrow),
                                                          onTap: () {
                                                            setState(() {
                                                              _isPlay =
                                                                  !_isPlay;
                                                              playingId =
                                                                  snapshot
                                                                      .data
                                                                      .taskFile[
                                                                          index]
                                                                      .id;
                                                            });
                                                            startPlaying(
                                                                snapshot
                                                                    .data
                                                                    .taskFile[
                                                                        index]
                                                                    .file);
                                                          }),
                                                    ),
                                                    Visibility(
                                                      visible: _isPlay &&
                                                          playingId ==
                                                              snapshot
                                                                  .data
                                                                  .taskFile[
                                                                      index]
                                                                  .id,
                                                      child: GestureDetector(
                                                          child:
                                                              Icon(Icons.stop),
                                                          onTap: () {
                                                            setState(() {
                                                              _isPlay =
                                                                  !_isPlay;
                                                              playingId = null;
                                                            });
                                                            stopPlaying();
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 8,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    final status =
                                                        await Permission.storage
                                                            .request();

                                                    if (status.isGranted) {
                                                      final externalDir =
                                                          await getExternalStorageDirectory();

                                                      final taskId =
                                                          await FlutterDownloader
                                                              .enqueue(
                                                        url: snapshot
                                                            .data
                                                            .taskFile[index]
                                                            .file,
                                                        savedDir:
                                                            externalDir.path,
                                                        fileName: snapshot
                                                            .data
                                                            .taskFile[index]
                                                            .fileName,
                                                        showNotification: true,
                                                        openFileFromNotification:
                                                            true,
                                                      ).then((value) => value
                                                                  .isNotEmpty
                                                              ? openSnack(
                                                                  Colors.green,
                                                                  "Ֆայլը ներբեռնվել է")
                                                              : openSnack(
                                                                  Colors.red,
                                                                  "Ինչ որ բան այն չէ"));
                                                    } else {}
                                                  },
                                                  child: Text(
                                                    snapshot
                                                        .data
                                                        .taskFile[index]
                                                        .fileName,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Text(
                                                  "${DateFormat.yMMMMd('hy').format(snapshot.data.taskFile[index].createdDate)} ${DateFormat.jm('hy').format(snapshot.data.taskFile[index].createdDate)}",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                          flex: 1,
                                          child: GestureDetector(
                                              onTap: () {
                                                update(snapshot
                                                    .data.taskFile[index].id);
                                              },
                                              child: SvgPicture.asset(
                                                  "assets/icons/delete.svg")))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
