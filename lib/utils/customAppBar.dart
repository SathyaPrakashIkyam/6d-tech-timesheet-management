import 'dart:html';

import 'package:flutter/material.dart';
import 'package:timesheet_management/utils/static_data/motows_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../bloc/bloc.dart';
import '../main.dart';
import 'custom_popup_dropdown/custom_popup_dropdown.dart';




class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  SharedPreferences? prefs ;
  String companyName='';

  Future getInitialData() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs!.getString("companyName") ?? "";
    });
  }



  customPopupDecoration ({required String hintText, bool? error}){
    return InputDecoration(hoverColor: mHoverColor,
      suffixIcon: const Icon(Icons.add,color: mSaveButton,size: 14),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.blue)),
      constraints:  const BoxConstraints(maxHeight:35),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:error==true? mErrorColor :mTextFieldBorder)),
      focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color:error==true? mErrorColor :Colors.blue)),
    );
  }


  logoutDecoration({required String hintText, bool? error, bool ? isFocused,}) {
    return InputDecoration(
      hoverColor: mHoverColor,
      suffixIcon: const Icon(Icons.account_circle, color:Colors.black),
      // border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      border: InputBorder.none,
      constraints: const BoxConstraints(maxHeight: 35),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xB2000000)),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
    );
  }

  String customerType='Select Customer Type';
  String logoutInitial="";

  List <CustomPopupMenuEntry<String>> customerTypes =<CustomPopupMenuEntry<String>>[

    const CustomPopupMenuItem(height: 40,
      value: 'Business Customer',
      child: Center(child: SizedBox(width: 350,child: Text('Business Customer',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14)))),

    ),
    const CustomPopupMenuItem(height: 40,
      value: 'Individual Customer',
      child: Center(child: SizedBox(width: 350,child: Text('Individual Customer',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14)))),

    ),
    const CustomPopupMenuItem(height: 40,
      value: 'Company Customer',
      child: Center(child: SizedBox(width: 350,child: Text('Company Customer',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14)))),

    )
  ];
  List <CustomPopupMenuEntry<String>> logout =<CustomPopupMenuEntry<String>>[

    const CustomPopupMenuItem(height: 40,
      value: 'Logout',
      child: Center(child: Text('Logout',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14))),

    ),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialData();
  }
  dynamic size,width,height;
  final search2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return AppBar(
      title: Text("${window.sessionStorage["userName"]}",style: TextStyle(color: Colors.black)),

      automaticallyImplyLeading: false,
      leadingWidth: 190,
      leading: Row(
        children: [
          IconButton(
            icon:  Icon(Icons.menu,color: width>800 ?Colors.white:Colors.black),
            onPressed:width>800 ?null: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset("assets/logo/SAP_logo.png",fit: BoxFit.fitHeight),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white
          // gradient: LinearGradient(
          //   colors: [Color(0xff0D47A1), Colors.lightBlueAccent,Colors.blue], // Define gradient colors
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
      ),
     foregroundColor: Colors.white,
     shadowColor: Colors.white,
     surfaceTintColor: Colors.white,
     // backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      centerTitle: true,
      elevation: 2,
      bottomOpacity: 20,
      actions: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // const SizedBox(width: 180,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [

                  const SizedBox(width: 20,),

                  TooltipTheme(
                    data: const TooltipThemeData(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.black,
                      ),
                      tooltip: 'Notifications',
                    ),
                  ),

                  const SizedBox(width: 15,),
                 // _popMenu(),

                  SizedBox(width: 25,
                    height: 25,
                    child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return CustomPopupMenuButton(elevation: 4,
                            decoration: logoutDecoration(hintText:logoutInitial,),
                            hintText: '',
                            childWidth: 150,
                            offset: const Offset(1, 40),
                            tooltip: '',
                            itemBuilder:  (BuildContext context) {
                              return logout;
                            },
                            shape:  const RoundedRectangleBorder(
                              side: BorderSide(color: mTextFieldBorder),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            onSelected: (String value)async{

                                window.sessionStorage.clear();
                                logoutInitial = value;
                                if(logoutInitial=="Logout"){
                                  bloc.setSubRole(false);
                                  bloc.setMangerRole(false);
                                  prefs!.setString('authToken', "");
                                  prefs!.setString('companyName', "");
                                  prefs!.setString('role', "");
                                }

                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyApp()));

                            },
                            onCanceled: () {

                            },
                            child: Container(),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }
}