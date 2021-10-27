import 'dart:io';

import 'package:beon/config/constants.dart';
import 'package:beon/config/costum_botton.dart';
import 'package:beon/config/text_inputs.dart';
import 'package:beon/functional/managment.dart';
import 'package:beon/models/get_activirty.dart';
import 'package:beon/models/get_package_type.dart';
import 'package:beon/models/get_service_type.dart';
import 'package:beon/models/get_taxation_system.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'image_upload.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({
    Key key,
    this.fileName1,
    this.fileNameString,
  }) : super(key: key);

  final File fileName1;
  final String fileNameString;
  @override
  _AddCompanyState createState() => _AddCompanyState(fileName1, fileNameString);
}

class _AddCompanyState extends State<AddCompany> {
  TextEditingController companyNameController;
  TextEditingController hvhhController;
  TextEditingController addressController;
  TextEditingController registerNumberController;
  TextEditingController employerCountController;
  TextEditingController directorController;
  TextEditingController otherController;
  TextEditingController dateController;
  TextEditingController activityController;
  TextEditingController serviceTypeController;
  TextEditingController taxationController;
  TextEditingController packageController;
  TextEditingController statusController;

  final File fileName1;
  final String fileNameString;
  _AddCompanyState(this.fileName1, this.fileNameString);

  Future<PickedFile> _imageFile;
  ImagePicker _picker = new ImagePicker();
  Function onFilePicked;
  String fileName;
  //File _image;

  FilePicker _newFile;

  List _myActivities;

  bool showEmailValidationMessage = true;
  bool _isLoaded = false;
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;
  bool _validate8 = false;
  bool _validate9 = false;
  bool _validate10 = false;
  bool _validate11 = false;

  @override
  void initState() {
    super.initState();
    //_isLoaded = false;
    _myActivities = [];
    companyNameController = new TextEditingController();
    hvhhController = new TextEditingController();
    addressController = new TextEditingController();
    registerNumberController = new TextEditingController();
    employerCountController = new TextEditingController();
    directorController = new TextEditingController();
    otherController = new TextEditingController();
    dateController = new TextEditingController();
    activityController = new TextEditingController();
    serviceTypeController = new TextEditingController();
    taxationController = new TextEditingController();
    packageController = new TextEditingController();
    statusController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    companyNameController.dispose();
    hvhhController.dispose();
    addressController.dispose();
    registerNumberController.dispose();
    employerCountController.dispose();
    directorController.dispose();
    otherController.dispose();
    dateController.dispose();
    activityController.dispose();
    serviceTypeController.dispose();
    taxationController.dispose();
    packageController.dispose();
    statusController.dispose();
  }

  File newFile;
  String newFileString;

  @override
  String TaxationUrl;
  String PackageUrl;
  //String StatusName;
  //int PackageId;
  int StatusId;
  List<String> selectedActivityCategories = [];
  void _onCategorySelected(bool selected, categoryUrl) {
    if (selected == true) {
      setState(() {
        selectedActivityCategories.add(categoryUrl);
      });
    } else {
      setState(() {
        selectedActivityCategories.remove(categoryUrl);
      });
    }
  }

  List<String> selectedActivityCategoriesName = [];
  void _onCategoryNameSelected(bool selected, categoryName) {
    if (selected == true) {
      setState(() {
        selectedActivityCategoriesName.add(categoryName);
      });
    } else {
      setState(() {
        selectedActivityCategoriesName.remove(categoryName);
      });
    }
  }

  List<String> selectedServiceCategories = [];
  void _onServiceSelected(bool selected, categoryUrl) {
    if (selected == true) {
      setState(() {
        selectedServiceCategories.add(categoryUrl);
      });
    } else {
      setState(() {
        selectedServiceCategories.remove(categoryUrl);
      });
    }
  }

  List<String> selectedServiceCategoriesName = [];
  void _onServiceNameSelected(bool selected, categoryName) {
    if (selected == true) {
      setState(() {
        selectedServiceCategoriesName.add(categoryName);
      });
    } else {
      setState(() {
        selectedServiceCategoriesName.remove(categoryName);
      });
    }
  }

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
          title: Center(
              child: Text(
            "Ավելացնել նոր կազմակերպություն",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          )),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 41 / 375,
                right: MediaQuery.of(context).size.width * 41 / 375,
                top: MediaQuery.of(context).size.height * 20 / 808,
                bottom: MediaQuery.of(context).size.height * 85 / 808),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    moveToSecondPage();
                  },
                  child: Stack(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 100 / 808,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius:
                                MediaQuery.of(context).size.width * 80 / 808,
                            // child: ClipOval(
                            //   child: (_image != null)
                            //       ? Image.file(_image)
                            //       : Image.asset('assets/images/emptyImage.png'),
                            // ),
                            backgroundImage: (newFile != null)
                                ? Image.file(newFile).image
                                : Image.asset('assets/images/emptyImage.png')
                                    .image,
                          ),
                        ),
                      ),
                      Positioned(
                        right: MediaQuery.of(context).size.width * 5 / 375,
                        top: MediaQuery.of(context).size.width * 5 / 375,
                        child: GestureDetector(
                          onTap: () {
                            moveToSecondPage();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ImageUpload()));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    23 /
                                    375,
                                height: MediaQuery.of(context).size.width *
                                    23 /
                                    375,
                                decoration: new BoxDecoration(
                                  color: kPhotoAdd,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Icon(Icons.add, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextInput(
                  controller: companyNameController,
                  validate: _validate,
                  hint: "Կազմակերպության անունը",
                  errorText: "*Պարտադիր դաշտ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: hvhhController,
                  validate: _validate1,
                  hint: "ՀՎՀՀ",
                  errorText: "*Պարտադիր դաշտ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: addressController,
                  validate: _validate2,
                  hint: "Հասցե",
                  errorText: "*Պարտադիր դաշտ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                CustomTextInput(
                  controller: registerNumberController,
                  validate: _validate3,
                  hint: "Գրանցման համար",
                  errorText: "*Պարտադիր դաշտ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.number,
                ),
                CustomTextInput(
                  controller: employerCountController,
                  validate: _validate4,
                  hint: "Աշխատակիցների քանակ",
                  errorText: "*Պարտադիր դաշտ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.number,
                ),
                CustomTextInput(
                  controller: directorController,
                  validate: _validate5,
                  hint: "Տնօրենի անուն ազգանուն",
                  errorText: "*Պարտադիր դաշտ",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                StreamBuilder<GetActivity>(
                    stream: PageManager.getActivity(),
                    builder: (context, snapshot) {
                      return Stack(
                        children: [
                          CustomTextInputMulti(
                            controller: activityController,
                            validate: _validate6,
                            hint: "Գործունեության տեսակ",
                            errorText: "*Պարտադիր դաշտ",
                            isPassword: false,
                            marginTop: 21,
                            inputType: TextInputType.text,
                          ),
                          GestureDetector(
                              onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            title: Text('Գործունեության տեսակ'),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Հաստատել",
                                                  style: TextStyle(
                                                      color: kPrimaryColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                              )
                                            ],
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5, // Change as per your requirement
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8, // Change as per your requirement
                                              child: Container(
                                                child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data.results.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return CheckboxListTile(
                                                        activeColor:
                                                            kPrimaryColor,
                                                        checkColor:
                                                            kPrimaryColor,
                                                        value:
                                                            selectedActivityCategories
                                                                .contains(snapshot
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .url),
                                                        onChanged: (selected) {
                                                          setState(() {
                                                            _onCategoryNameSelected(
                                                                selected,
                                                                snapshot
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .name);
                                                            _onCategorySelected(
                                                                selected,
                                                                snapshot
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .url);
                                                          });
                                                        },
                                                        title: Text(
                                                          snapshot
                                                              .data
                                                              .results[index]
                                                              .name,
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          );
                                        });
                                      }).then((val) {
                                    activityController.text = "";
                                    if (selectedActivityCategoriesName
                                        .isNotEmpty) {
                                      for (int i = 0;
                                          i <
                                              selectedActivityCategoriesName
                                                  .length;
                                          i++) {
                                        activityController.text += i ==
                                                selectedActivityCategoriesName
                                                        .length -
                                                    1
                                            ? selectedActivityCategoriesName[i]
                                                    .toString() +
                                                ""
                                            : selectedActivityCategoriesName[i]
                                                    .toString() +
                                                ", ";
                                      }
                                    }
                                  }),
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        21 /
                                        808),

                                //width: MediaQuery.of(context).size.width * 0.93,
                                color: Colors.transparent,
                              )),
                        ],
                      );
                    }),
                StreamBuilder<GetServiceType>(
                    stream: PageManager.getServiceType(),
                    builder: (context, snapshot) {
                      return Stack(
                        children: [
                          CustomTextInputMulti(
                            controller: serviceTypeController,
                            validate: _validate7,
                            hint: "Ծառայության տեսակ",
                            errorText: "*Պարտադիր դաշտ",
                            isPassword: false,
                            marginTop: 21,
                            inputType: TextInputType.text,
                          ),
                          GestureDetector(
                              onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            title: Text('Ծառայության տեսակ'),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Հաստատել",
                                                  style: TextStyle(
                                                      color: kPrimaryColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                              )
                                            ],
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5, // Change as per your requirement
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8, // Change as per your requirement
                                              child: Container(
                                                child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data.results.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return CheckboxListTile(
                                                        activeColor:
                                                            kPrimaryColor,
                                                        checkColor:
                                                            kPrimaryColor,
                                                        value:
                                                            selectedServiceCategories
                                                                .contains(snapshot
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .url),
                                                        onChanged: (selected) {
                                                          setState(() {
                                                            _onServiceNameSelected(
                                                                selected,
                                                                snapshot
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .name);
                                                            _onServiceSelected(
                                                                selected,
                                                                snapshot
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .url);
                                                          });
                                                        },
                                                        title: Text(
                                                          snapshot
                                                              .data
                                                              .results[index]
                                                              .name,
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          );
                                        });
                                      }).then((val) {
                                    serviceTypeController.text = "";
                                    if (selectedServiceCategoriesName
                                        .isNotEmpty) {
                                      for (int i = 0;
                                          i <
                                              selectedServiceCategoriesName
                                                  .length;
                                          i++) {
                                        serviceTypeController.text += i ==
                                                selectedServiceCategoriesName
                                                        .length -
                                                    1
                                            ? selectedServiceCategoriesName[i]
                                                    .toString() +
                                                ""
                                            : selectedServiceCategoriesName[i]
                                                    .toString() +
                                                ", ";
                                      }
                                    }
                                  }),
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        21 /
                                        808),

                                //width: MediaQuery.of(context).size.width * 0.93,
                                color: Colors.transparent,
                              )),
                        ],
                      );
                    }),
                StreamBuilder<GetTaxationSystem>(
                    stream: PageManager.getTaxationSystem(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return CustomTextInput(
                          controller: taxationController,
                          validate: _validate8,
                          hint: "Հարկման համակարգ",
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
                            controller: taxationController,
                            validate: _validate8,
                            hint: "Հարկման համակարգ",
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
                                  "Հարկման համակարգ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                value: TaxationUrl, // currently selected item
                                isExpanded: true,
                                items: snapshot.data.results
                                    .map((item) => DropdownMenuItem(
                                          child: Text(
                                            item.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          value: item.url,
                                        ))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  taxationController.text = value;
                                  this.TaxationUrl = value;
                                }),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: taxationController.text.isNotEmpty,
                            child: Positioned(
                                top: MediaQuery.of(context).size.width *
                                    12 /
                                    375,
                                left: MediaQuery.of(context).size.width *
                                    19 /
                                    375,
                                child: Text(
                                  "Հարկման համակարգ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8),
                                )),
                          )
                        ],
                      );
                    }),
                StreamBuilder<GetPackageType>(
                    stream: PageManager.getPackageType(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return CustomTextInput(
                          ishint: 0,
                          controller: packageController,
                          validate: _validate9,
                          hint: "Ընտրել փաթեթ",
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
                            controller: packageController,
                            validate: _validate9,
                            hint: "Ընտրել փաթեթ",
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
                                  "Ընտրել փաթեթ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                value: PackageUrl, // currently selected item
                                isExpanded: true,
                                items: snapshot.data.results
                                    .map((item) => DropdownMenuItem(
                                          child: Text(
                                            item.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          value: item.url,
                                        ))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  packageController.text = value;
                                  this.PackageUrl = value;
                                }),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: packageController.text.isNotEmpty,
                            child: Positioned(
                                top: MediaQuery.of(context).size.width *
                                    12 /
                                    375,
                                left: MediaQuery.of(context).size.width *
                                    19 /
                                    375,
                                child: Text(
                                  "Ընտրել փաթեթ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8),
                                )),
                          )
                        ],
                      );
                    }),
                Stack(
                  children: [
                    CustomTextInput(
                      ishint: 0,
                      controller: statusController,
                      validate: _validate10,
                      hint: "Կարգավիճակ՝ գործող կամ դադար",
                      errorText: "*Պարտադիր դաշտ",
                      isPassword: false,
                      marginTop: 21,
                      inputType: TextInputType.text,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 21 / 808),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: kInput,
                      ),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 18 / 375,
                          right: MediaQuery.of(context).size.width * 10 / 375),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          //iconDisabledColor: Colors.black,

                          iconEnabledColor: kPrimaryColor,
                          iconSize:
                              MediaQuery.of(context).size.width * 30 / 375,
                          hint: Text(
                            "Կարգավիճակ՝ գործող կամ դադար",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          value: StatusId, // currently selected item
                          isExpanded: true,
                          items: <String>['Գործող', 'Չգործող']
                              .map((item) => DropdownMenuItem(
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: item == "Գործող" ? 0 : 1,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            statusController.text =
                                value == 0 ? "Գործող" : "Չգործող";
                            this.StatusId = value;
                          }),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: statusController.text.isNotEmpty,
                      child: Positioned(
                          top: MediaQuery.of(context).size.width * 12 / 375,
                          left: MediaQuery.of(context).size.width * 19 / 375,
                          child: Text(
                            "Կարգավիճակ՝ գործող կամ դադար",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 8),
                          )),
                    )
                  ],
                ),
                Stack(
                  children: [
                    CustomTextInput(
                      controller: dateController,
                      validate: _validate11,
                      hint: "Պայմանագրի սկիզբ",
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
                            top: MediaQuery.of(context).size.height * 21 / 808),

                        //width: MediaQuery.of(context).size.width * 0.93,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                CustomTextInput(
                  controller: otherController,
                  validate: false,
                  hint: "Այլ տվյալներ",
                  errorText: "",
                  isPassword: false,
                  marginTop: 21,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 21 / 808),
                Center(
                  child: !_isLoaded
                      ? ButtonWidget(
                          onClick: () {
                            setState(() {
                              (companyNameController.text.isEmpty)
                                  ? _validate = true
                                  : _validate = false;
                              (hvhhController.text.isEmpty)
                                  ? _validate1 = true
                                  : _validate1 = false;
                              (addressController.text.isEmpty)
                                  ? _validate2 = true
                                  : _validate2 = false;
                              (registerNumberController.text.isEmpty)
                                  ? _validate3 = true
                                  : _validate3 = false;
                              (employerCountController.text.isEmpty)
                                  ? _validate4 = true
                                  : _validate4 = false;
                              (directorController.text.isEmpty)
                                  ? _validate5 = true
                                  : _validate5 = false;
                              (selectedActivityCategories.isEmpty)
                                  ? _validate6 = true
                                  : _validate6 = false;
                              (selectedServiceCategories.isEmpty)
                                  ? _validate7 = true
                                  : _validate7 = false;
                              (taxationController.text.isEmpty)
                                  ? _validate8 = true
                                  : _validate8 = false;
                              (packageController.text.isEmpty)
                                  ? _validate9 = true
                                  : _validate9 = false;
                              (statusController.text.isEmpty)
                                  ? _validate10 = true
                                  : _validate10 = false;
                              (dateController.text.isEmpty)
                                  ? _validate11 = true
                                  : _validate11 = false;
                            });

                            if (!_validate &&
                                !_validate1 &&
                                !_validate2 &&
                                !_validate3 &&
                                !_validate4 &&
                                !_validate5 &&
                                !_validate6 &&
                                !_validate7 &&
                                !_validate8 &&
                                !_validate9 &&
                                !_validate10 &&
                                !_validate11) {
                              setState(() {
                                _isLoaded = true;
                              });

                              PageManager.addCompany(
                                      companyNameController.text,
                                      hvhhController.text,
                                      addressController.text,
                                      registerNumberController.text.toString(),
                                      employerCountController.text.toString(),
                                      directorController.text,
                                      selectedActivityCategories,
                                      selectedServiceCategories,
                                      taxationController.text,
                                      packageController.text,
                                      StatusId.toString(),
                                      dateController.text,
                                      otherController.text,
                                      newFileString,
                                      context)
                                  .listen((event) {
                                setState(() {
                                  _isLoaded = false;
                                });
                              });
                            }
                          },
                          btnText: "Հաստատել",
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
        ),
      ),
    );
  }

  // String _information = 'No Information Yet';

  void updateInformation(String information) {
    setState(() {
      newFile = File(information);
      newFileString = information.toString();
    });
  }

  void moveToSecondPage() async {
    final String information = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageUpload(
                from: "company",
              )),
    );
    if (information != null) {
      updateInformation(information);
    }
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
