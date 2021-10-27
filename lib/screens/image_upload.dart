import 'dart:io';
import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/functional/managment.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({
    Key key,
    this.from,
  }) : super(key: key);
  final String from;
  @override
  _ImageUploadState createState() => _ImageUploadState(from);
}

class _ImageUploadState extends State<ImageUpload> {
  Future<PickedFile> _imageFile;
  ImagePicker _picker = new ImagePicker();
  Function onFilePicked;
  String fileName;
  File _image;

  bool _isLoaded = false;
  bool _hasImage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final String from;
  _ImageUploadState(this.from);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 41 / 375,
                right: MediaQuery.of(context).size.width * 41 / 375,
                top: MediaQuery.of(context).size.height * 120 / 808),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 104 / 375,
                    backgroundImage: (_image != null)
                        ? Image.file(_image).image
                        : Image.asset('assets/images/emptyImage.png').image,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 41 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            if (from == "company") {
                              if (!_hasImage) {
                                _imageFile = _picker.getImage(
                                    source: ImageSource.gallery);
                                _imageFile.then((file) => {
                                      this.setState(() {
                                        _hasImage = true;

                                        _image = File(file.path);
                                        fileName = file.path;
                                      })
                                    });
                              } else
                                Navigator.pop(context, fileName);
                            }
                            if (from == "editProfile") {
                              if (!_hasImage) {
                                _imageFile = _picker.getImage(
                                    source: ImageSource.gallery);
                                _imageFile.then((file) => {
                                      this.setState(() {
                                        _hasImage = true;

                                        _image = File(file.path);
                                        fileName = file.path;
                                      })
                                    });
                              } else
                                Navigator.pop(context, fileName);
                            }
                            if (from == "profile") {
                              if (!_hasImage) {
                                _imageFile = _picker.getImage(
                                    source: ImageSource.gallery);
                                _imageFile.then((file) => {
                                      this.setState(() {
                                        _hasImage = true;

                                        _image = File(file.path);
                                        fileName = file.path;
                                      })
                                    });
                              } else
                                PageManager.addImageProfile(fileName, context)
                                    .listen((val) {
                                  setState(() {
                                    _isLoaded = false;
                                  });
                                });
                            }
                          },
                          btnText: _hasImage ? "Պահպանել" : "Ներբեռնել",
                        )
                      : CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pickPicker(String fileName, Function onFilePicked) {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.white,
        //size: 12,
      ),
      onPressed: () {
        _imageFile = _picker.getImage(source: ImageSource.gallery);
        _imageFile.then((file) => {
              this.setState(() {
                onFilePicked(file);
              })
            });
      },
    );
  }
}
