import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotlas/core/retrofit_client.dart';
import 'package:dio/dio.dart';
import 'package:spotlas/models/feeds.dart';

class FeedsController extends GetxController{
  int page = 0;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List<String> saved = [];
  List<String> liked = [];
  List<FeedsResponse> posts = [];
  ScrollController scrollcontroller = new ScrollController();




  void firstLoad() async {
//this section is meant to load the first set of data to be displayed
      isFirstLoadRunning = true;
      update();
    try {
      final res = await RetrofitClientInstance.getInstance()
          .getDataService()
          .getFeeds( 1, 12);

        posts = res;
      update();

    } catch (e) {
      if (e is DioError) {
        if (e.error != null && e.error is SocketException) {
          // setState(() {
          //   _isBadNetwork = true;
          // });
        }
      }
    }
      isFirstLoadRunning = false;
    update();
  }
  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollcontroller.position.pixels >=
            scrollcontroller.position.maxScrollExtent) {// this is true when you have scrolled to the end of the screen

        isLoadMoreRunning = true;
        update(); // Display a progress indicator at the bottom

      page += 1; // Increase _page by 1
      try {
        final res = await RetrofitClientInstance.getInstance()
            .getDataService()
            .getFeeds( 1, 12);

        final List<FeedsResponse> fetchedPosts = res;
        if (fetchedPosts.length > 0) {
            posts.addAll(fetchedPosts);//adding the newly fetched post to the existing ones
            update();
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
            hasNextPage = false;
            update();

        }
      } catch (err) {
        print('Something went wrong!');
      }
        isLoadMoreRunning = false;
      update();


    }
  }

}