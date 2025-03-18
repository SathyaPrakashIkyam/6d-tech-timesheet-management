import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/classes/arguments_classes.dart';

import '../utils/api/post_api.dart';
import '../utils/customAppBar.dart';
import '../utils/customDrawer.dart';
import '../utils/custom_popup_dropdown/custom_popup_dropdown.dart';
import '../utils/static_data/motows_colors.dart';

class CreateUsers extends StatefulWidget {
  final CreateUsersArguments args;
  const CreateUsers({super.key, required this.args});

  @override
  State<CreateUsers> createState() => _CreateUsersState();
}

class _CreateUsersState extends State<CreateUsers> {

  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final userRole = TextEditingController();
  final userDepartment = TextEditingController();
  final userEmail = TextEditingController();
  final userType = TextEditingController();
  final userPassword = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  bool showHidePassword=true;
  bool passWordColor = false;
  void passwordHideAndViewFunc(){
    setState(() {
      showHidePassword = !showHidePassword;
    });
  }

  String roleDrop =  "Select Role";
  List<CustomPopupMenuEntry<String>> userRolePopUpList = <CustomPopupMenuEntry<String>>[
    const CustomPopupMenuItem(
      height: 40,
      value: 'Department Head',
      child: Center(child: SizedBox(width: 350,child: Text('Department Head',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
    const CustomPopupMenuItem(
      height: 40,
      value: 'Manager',
      child: Center(child: SizedBox(width: 350,child: Text('Manager',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
    const CustomPopupMenuItem(
      height: 40,
      value: 'User',
      child: Center(child: SizedBox(width: 350,child: Text('User',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
  ];
  String depDrop = "Select Department";
  List<CustomPopupMenuEntry<String>> userDepartmentPopUpList = <CustomPopupMenuEntry<String>>[
    const CustomPopupMenuItem(
      height: 40,
      value: 'M1 Singapore',
      child: Center(child: SizedBox(width: 350,child: Text('M1 Singapore',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
    const CustomPopupMenuItem(
      height: 40,
      value: 'Vodafone Idea Limited',
      child: Center(child: SizedBox(width: 350,child: Text('Vodafone Idea Limited',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
  ];

  Future postUser(Map tempJson) async {
    String url = "https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/usermaster/add-usermaster";
    print(url);
    var response = await postData(url: url,requestBody: tempJson,context: context);

    if (response != null) {
      print(response);
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), 
          child: CustomAppBar()
      ),
      drawer: AppBarDrawer(drawerWidth: widget.args.drawerWidth,selectedDestination: 4),
      body: Row(
        children: [
          CustomDrawer(widget.args.drawerWidth,4),
          Expanded(
              child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: AppBar(
                      title: const Text("Create Users", style: TextStyle(color: Colors.black)),
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10, right: 20),
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () async{
                              Map createUser = {
                                "active": true,
                                "designation": "",
                                "rate_card": 1000,
                                "user_name" : userName.text,
                                "email" : userEmail.text,
                                "roles" : userRole.text,
                                "department": userDepartment.text,
                                "userType" : userType.text,
                                "password" : userPassword.text,
                                "token": "string",
                                "tokenCreationDate": "2025-03-18T08:21:03.860Z",
                              };
                              print('--- user creation ---');
                              print(createUser);
                              await postUser(createUser);
                              // if(_formKey.currentState!.validate()){
                              //
                              // }

                            },
                            child: const Text("Create",style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    )
                ),
                body: AdaptiveScrollbar(
                  controller: _verticalScrollController,
                  underColor: Colors.blueGrey.withOpacity(0.3),
                  sliderDefaultColor: Colors.grey.withOpacity(0.7),
                  sliderActiveColor: Colors.grey,
                  position: ScrollbarPosition.right,
                  child: AdaptiveScrollbar(
                    position: ScrollbarPosition.bottom,
                    underColor: Colors.blueGrey.withOpacity(0.3),
                    sliderDefaultColor: Colors.grey.withOpacity(0.7),
                    sliderActiveColor: Colors.grey,
                    controller: _horizontalScrollController,
                    child: SingleChildScrollView(
                      controller: _verticalScrollController,
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: screenWidth - 300,
                          // height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50,right: 30,left: 30),
                              child: Container(
                                alignment: Alignment.center,
                                width: screenWidth < 975 ? 1000 : screenWidth * 0.5 - 300,
                                decoration:  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  border: Border.all(color: Colors.grey)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:   [
                                          Expanded(
                                            child: Text(
                                              "User Management", style: TextStyle(color: Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 18, top: 15, bottom: 10),
                                                child: Text("User Name:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18, right: 20),
                                                child: TextFormField(
                                                  style: const TextStyle(fontSize: 12),
                                                  controller: userName,
                                                  decoration: customerFieldDecoration(hintText: "User Name", controller: userName),
                                                  onEditingComplete: () {

                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 18, top: 15, bottom: 10),
                                                child: Text("User Email:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18, right: 20),
                                                child: TextFormField(
                                                  style: const TextStyle(fontSize: 12),
                                                  controller: userEmail,
                                                  decoration: customerFieldDecoration(hintText: "User Email", controller: userEmail),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter an email address")));
                                                      return 'Please enter an email address';
                                                    }
                                                    const emailRegex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
                                                    if (!RegExp(emailRegex).hasMatch(value)) {
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter a valid email address")));
                                                      return 'Please enter a valid email address';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 18, top: 15, bottom: 10),
                                                child: Text("User Role:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18, right: 20),
                                                child: SizedBox(
                                                  height: 33,
                                                  child: Focus(
                                                      skipTraversal: true,
                                                      descendantsAreFocusable: true,
                                                      child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return CustomPopupMenuButton(
                                                            decoration: customPopupDecoration(hintText: roleDrop),
                                                            itemBuilder: (BuildContext context) {
                                                              return userRolePopUpList;
                                                            },
                                                            hintText: "",
                                                            childWidth: constraints.maxWidth,
                                                            textController: userRole,
                                                            shape:  const RoundedRectangleBorder(
                                                              side: BorderSide(color: mTextFieldBorder),
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(5),
                                                              ),
                                                            ),
                                                            offset: const Offset(1, 40),
                                                            tooltip: '',textAlign: TextAlign.left,
                                                            onSelected: (value) {
                                                              setState(() {
                                                                userRole.text = value;
                                                                roleDrop = value;
                                                              });
                                                            },
                                                            onCanceled: () {

                                                            },
                                                            child: Container(),
                                                          );
                                                        },
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 18, top: 15, bottom: 10),
                                                child: Text("User Department:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18, right: 20),
                                                child: SizedBox(
                                                  height: 33,
                                                  child: Focus(
                                                      skipTraversal: true,
                                                      descendantsAreFocusable: true,
                                                      child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return CustomPopupMenuButton(
                                                            decoration: customPopupDecoration(hintText: depDrop),
                                                            itemBuilder: (BuildContext context) {
                                                              return userDepartmentPopUpList;
                                                            },
                                                            hintText: "",
                                                            childWidth: constraints.maxWidth,
                                                            textController: userDepartment,
                                                            shape:  const RoundedRectangleBorder(
                                                              side: BorderSide(color: mTextFieldBorder),
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(5),
                                                              ),
                                                            ),
                                                            offset: const Offset(1, 40),
                                                            tooltip: '',textAlign: TextAlign.left,
                                                            onSelected: (value) {
                                                              setState(() {
                                                                userDepartment.text = value;
                                                                depDrop = value;
                                                              });
                                                            },
                                                            onCanceled: () {

                                                            },
                                                            child: Container(),
                                                          );
                                                        },
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 18, top: 15, bottom: 10),
                                                child: Text("User Type:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18, right: 20),
                                                child: TextFormField(
                                                  style: const TextStyle(fontSize: 12),
                                                  controller: userType,
                                                  decoration: customerFieldDecoration(hintText: "User Type", controller: userType),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(left: 18, top: 15, bottom: 10),
                                                child: Text("Password:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18, right: 20, bottom: 20),
                                                child: TextFormField(
                                                  style: const TextStyle(fontSize: 12),
                                                  controller: userPassword,
                                                  obscureText: showHidePassword,
                                                  enableSuggestions: false,
                                                  autocorrect: false,
                                                  decoration: decorationInputPassword("Enter user Password",passWordColor, showHidePassword,passwordHideAndViewFunc),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  customPopupDecoration({required String hintText, bool? error, bool ? isFocused,}) {
    return InputDecoration(
      hoverColor: mHoverColor,
      suffixIcon:  const Icon(Icons.arrow_drop_down_circle_sharp, color: mSaveButton, size: 14),
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      constraints:  BoxConstraints(maxHeight:error==true? 60: 35),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 12, color: Color(0xB2000000)),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isFocused == true ? Colors.blue : error == true ? mErrorColor : mTextFieldBorder)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: error == true ? mErrorColor : mTextFieldBorder)),
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: error == true ? mErrorColor : Colors.blue)),
    );
  }

  customerFieldDecoration( {required TextEditingController controller, required String hintText, bool? error}) {
    return  InputDecoration(
      constraints:  BoxConstraints(maxHeight: error==true ? 50:33),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 11),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
      border: const OutlineInputBorder(borderSide: BorderSide(color:  Colors.blue)),
      enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    );
  }

  decorationInputPassword(String hintString, bool val, bool passWordHind,  passwordHideAndView, ) {
    return InputDecoration(
        constraints: const BoxConstraints(maxHeight: 33),
        // label: Text(
        //   hintString,
        // ),
        suffixIcon: IconButton(
          icon: Icon(
            passWordHind ? Icons.visibility : Icons.visibility_off,size: 20,
          ),
          onPressed: passwordHideAndView,
        ),
        suffixIconColor: val?const Color(0xff00004d):Colors.grey,
        counterText: "",
        contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
        hintText: hintString,
        labelStyle: const TextStyle(fontSize: 11,),
      border: const OutlineInputBorder(borderSide: BorderSide(color:  Colors.blue)),
      enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),

    );
  }
}
