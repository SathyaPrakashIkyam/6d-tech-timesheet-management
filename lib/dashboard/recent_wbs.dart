import 'package:flutter/material.dart';

class RecentWBS extends StatefulWidget {
  final List wbsList;
  const RecentWBS({super.key, required this.wbsList});

  @override
  State<RecentWBS> createState() => _RecentWBSState();
}

class _RecentWBSState extends State<RecentWBS> {

  List wbsDisplayList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wbsDisplayList = widget.wbsList;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: wbsDisplayList.length,
          itemBuilder:(context, index) {
            Color priHigh = Colors.green;
            Color priMedium = Colors.orange;
            Color priLow = Colors.red;
            String priority = wbsDisplayList[index]['priority'];
            return SizedBox(height: 120,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners for the entire Card
                  ),
                  child: Stack(
                    children: [
                      // Left Border with Rounded Corners
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 12.0,
                          decoration: const BoxDecoration(
                            color: Color(0xff0063B2), // Border color
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                          ),
                        ),
                      ),

                      // Main Content
                      Padding(
                        padding: const EdgeInsets.only(left: 28,top: 12,right: 28),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("${wbsDisplayList[index]["wbs_id"]}"),
                                const SizedBox(height: 20,),
                                Text("${wbsDisplayList[index]["project_name"]}"),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: IgnorePointer(
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: priority == "High" ? priHigh : priority == "Medium" ? priMedium : priLow,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 4,
                                    ),

                                    child:  Container(
                                        width: 60,
                                        alignment: Alignment.center,
                                        height: 20,
                                        child: Text(
                                            "${wbsDisplayList[index]["priority"]}",
                                            style: const TextStyle(color: Colors.white, fontSize: 16)
                                        )
                                    ),
                                  ),
                                )



                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                )

              ),
            );
          },),
      ],
    );
  }
}
