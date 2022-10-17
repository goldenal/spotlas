import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spotlas/view/feeds/feedsController.dart';
import 'package:spotlas/view/feeds/viewModel.dart';


class Feeds extends StatefulWidget {
  const Feeds({Key key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final feedCtrl = Get.put(FeedsController()); //initialising the controller

  @override
  void initState() {
    //this section is triggered first when the widget is being accessed
    super.initState();
    feedCtrl.firstLoad();//loads first set

    feedCtrl.scrollcontroller.addListener(() {
      feedCtrl.loadMore();  //loads more when you have scrolled to the bottom
    });

  }

  @override
  void dispose() {
    super.dispose();
    feedCtrl.scrollcontroller.removeListener(feedCtrl.loadMore);//removing listener

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding:  EdgeInsets.only(bottom:18.h),
          child: Text('Feed',
              style:TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              )),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        controller: feedCtrl.scrollcontroller,
        child: GetBuilder<FeedsController>(
          init: FeedsController(),
          builder: (value) =>
          feedCtrl.isFirstLoadRunning ?
          Container(
            color: Colors.white,
            height: 812.h,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          ):Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,

                  itemCount: feedCtrl.posts.length,
                  primary: false,
                  itemBuilder:
                      (BuildContext context,
                      int index) {
                    return feedsModel(feedCtrl.posts[index].media,
                        feedCtrl.posts[index].author.photoUrl,
                        feedCtrl.posts[index].author.username,
                        feedCtrl.posts[index].author.fullName,
                        feedCtrl.posts[index].caption.text,
                      feedCtrl.posts[index].spot.name,
                      feedCtrl.posts[index].createdAt,
                      feedCtrl.posts[index].id,
                    );
                  }),
              if (feedCtrl.isLoadMoreRunning == true) //this section shows only when fetching  more items
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 40),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loading more   ",
                        style: TextStyle(
                            color: Colors.red),
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
            ],
          ),

        ),
      ),


    );
  }
}


