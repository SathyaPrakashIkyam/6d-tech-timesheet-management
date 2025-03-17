import 'package:flutter/material.dart';

class RecentWBS extends StatefulWidget {
  const RecentWBS({super.key});

  @override
  State<RecentWBS> createState() => _RecentWBSState();
}

class _RecentWBSState extends State<RecentWBS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder:(context, index) {
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

                                Text("WBS $index"),
                                const SizedBox(height: 20,),
                                Text("testikyam$index@gmail.com"),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: IgnorePointer(
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff0063B2),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 4,
                                    ),

                                    child:  Container(width: 60,alignment: Alignment.center,height: 20,child: Text(index==3?"Medium":'High', style: TextStyle(color: Colors.white, fontSize: 16))),
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
