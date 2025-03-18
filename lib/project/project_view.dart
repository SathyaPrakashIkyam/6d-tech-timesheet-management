import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

import '../utils/classes/arguments_classes.dart';
import '../utils/customAppBar.dart';
import '../utils/customDrawer.dart';
import '../utils/static_data/motows_colors.dart';

class ProjectView extends StatefulWidget {
  final ViewProjectsArguments args;
  final Map selectedItem;
  const ProjectView({super.key, required this.args, required this.selectedItem});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {

  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();
  final projectName = TextEditingController();
  final processStatus = TextEditingController();
  final planStart = TextEditingController();
  final planFinish = TextEditingController();
  final projectProfile = TextEditingController();
  final projectId = TextEditingController();
  Map project = {};
  String userId = "";
  List userList = [];
  final List displayListItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    project = widget.args.projectData;
    projectId.text = project["project_id"] ?? "";
    projectName.text = project["project_name"] ?? "";
    processStatus.text = project["status"] ?? "";
    planStart.text = project["start_date"] ?? "";
    planFinish.text = project["end_date"] ?? "";
    projectProfile.text = project["priority"] ?? "";
    userId = project["project_id"] ?? "";
    if(userId == "PRD_00029"){
      userList.length = 3;
      displayListItems.length = 2;
    } else if(userId == "PRD_00030") {
      userList.length = 2;
      displayListItems.length = 3;
    } else if(userId == "PRD_00032") {
      userList.length = 1;
      displayListItems.length = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()
      ),
      drawer: AppBarDrawer(drawerWidth: widget.args.drawerWidth,selectedDestination: 1),
      body: Row(
        children: [
          CustomDrawer(widget.args.drawerWidth,1),
          Expanded(
              child: Scaffold(
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
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10,right: 30,left: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width >1190 ?MediaQuery.of(context).size.width-290:1190,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
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
                                      const SizedBox(height: 18,),
                                       Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:   [
                                            const Text("Project Details : ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                            Text(project["name"] ?? "", style: const TextStyle(color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30,),
                                      const Divider(height: 0.5,color: Colors.grey,thickness: 0.5,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 18, right: 18),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              // width: 300,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:  BorderRadius.circular(5),
                                                    border: Border.all(color: const Color(0xFFE0E0E0),),
                                                    boxShadow: const [BoxShadow(
                                                        color: Colors.black54,
                                                        blurRadius: 3
                                                    )]
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 70,
                                                                child: Text("Project", style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),)
                                                            ),
                                                            Text(": "),
                                                            Text("50000000")
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // width: 300,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:  BorderRadius.circular(5),
                                                    border: Border.all(color: const Color(0xFFE0E0E0),),
                                                    boxShadow: const [BoxShadow(
                                                        color: Colors.black54,
                                                        blurRadius: 3
                                                    )]
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 70,
                                                                child: Text("Allocated", style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),)
                                                            ),
                                                            Text(": "),
                                                            Text("1050000")
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // width: 300,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:  BorderRadius.circular(5),
                                                    border: Border.all(color: const Color(0xFFE0E0E0),),
                                                    boxShadow: const [BoxShadow(
                                                        color: Colors.black54,
                                                        blurRadius: 3
                                                    )]
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 70,
                                                                child: Text("Balance", style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),)
                                                            ),
                                                            Text(": "),
                                                            Text("48950000")
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18, top: 20, bottom: 20),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "Project Name:",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                color: Colors.red, // Set color to red
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: 300,
                                                        child: TextFormField(
                                                          style: const TextStyle(fontSize: 11),
                                                          readOnly: true,
                                                          controller: projectName,
                                                          decoration: customerFieldDecoration(hintText: '',controller: projectName),
                                                          onChanged: (value){

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text("Processing Status:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: 300,
                                                        child: TextFormField(
                                                          style: const TextStyle(fontSize: 11),
                                                          readOnly: true,
                                                          controller: processStatus,
                                                          decoration: customerFieldDecoration(hintText: '',controller: projectName),
                                                          onChanged: (value){

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "Actual Date:",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                color: Colors.red, // Set color to red
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: 300,
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          style: const TextStyle(fontSize: 11),
                                                          controller: planStart,
                                                          decoration: dateFieldDecoration(controller: planStart, hintText: ""),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18, top: 20, bottom: 20),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "Project ID:",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                color: Colors.red, // Set color to red
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: 300,
                                                        child: TextFormField(
                                                          style: const TextStyle(fontSize: 11),
                                                          readOnly: true,
                                                          controller: projectId,
                                                          decoration: customerFieldDecoration(hintText: '',controller: projectId),
                                                          onChanged: (value){

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "Project Profile:",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                color: Colors.red, // Set color to red
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: 300,
                                                        child: TextFormField(
                                                          style: const TextStyle(fontSize: 11),
                                                          readOnly: true,
                                                          controller: projectProfile,
                                                          decoration: customerFieldDecoration(hintText: '',controller: projectProfile),
                                                          onChanged: (value){

                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "End Date:",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: "*",
                                                              style: TextStyle(
                                                                color: Colors.red, // Set color to red
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      SizedBox(
                                                        width: 300,
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          style: const TextStyle(fontSize: 11),
                                                          controller: planFinish,
                                                          decoration: dateFieldDecoration(controller: planFinish, hintText: ""),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  decoration:  const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // const Padding(
                                      //   padding: EdgeInsets.only(left: 18, top: 20, bottom: 20),
                                      //   child: Text("Users", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                      // ),
                                      // Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                      Container(
                                        decoration:  const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: userList.length,
                                          itemBuilder: (context, index) {
                                            double proNum = index+1;
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1
                                                      ),
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 18.0,top: 5,bottom: 5),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text("User $proNum", style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                                        Container(
                                                          color: Colors.grey[100],
                                                          child: IgnorePointer(
                                                            ignoring: true,
                                                            child: MaterialButton(
                                                              onPressed: () {

                                                              },
                                                              hoverColor: Colors.transparent,
                                                              hoverElevation: 0,
                                                              child: const Padding(
                                                                padding: EdgeInsets.only(left: 18, top: 10, bottom: 10),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                                                                    Expanded(child: Text("WBS Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                                                    Expanded(child: Text("Priority", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                                                    Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                                                    Expanded(child: Text("Hours", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        ListView.builder(
                                                          itemCount: displayListItems.length,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context, index) {
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 18, top: 10, bottom: 20),
                                                              child: MaterialButton(
                                                                onPressed: () {

                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(child: Text(displayListItems[index]["project_id"])),
                                                                    Expanded(child: Text(displayListItems[index]["project_name"])),
                                                                    Expanded(child: Text(displayListItems[index]["priority"])),
                                                                    Expanded(child: Text(displayListItems[index]["status"])),
                                                                    Expanded(child: Text(displayListItems[index]["hours"] ?? "")),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // Divider(height: 0.5,color: Colors.grey[500],thickness: 0.5,),
                                              ],
                                            );
                                          },
                                        ),
                                      )
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
              )
          ),
        ],
      ),
    );
  }

  customerFieldDecoration( {required TextEditingController controller, required String hintText, bool? error}) {
    return  InputDecoration(
      constraints: BoxConstraints(maxHeight: error==true ? 50:30),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 11),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.blue)),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
      enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    );
  }
  dateFieldDecoration( {required TextEditingController controller, required String hintText, bool? error}) {
    return  InputDecoration(
        constraints: BoxConstraints(maxHeight: error==true ? 50:30),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 11),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color:  Colors.blue)),
        counterText: '',
        contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
        enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.blue, size: 18,)
    );
  }
}
