import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwithfirebase/business_logic/cubit/shop_cubit.dart';
import 'package:flutterwithfirebase/business_logic/helpers/helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback about us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            child: Text('SKIP',
            style: TextStyle(
              color: Colors.white
            ),),
            onPressed: () {
              Helper.sharedPreferences.setBool('onBoarding', true);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLoginScreen()),
                    (route) => false,
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, int index) =>
                  onBoardingPage(boardings[index]),
              controller: onBoardingController,
              onPageChanged: (index) {
                if(index==boardings.length-1)
                {isLast=true;
                setState(() {

                });}
                else{ isLast=false;
                setState(() {
                  
                });
              }},
              itemCount: boardings.length,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: boardings.length,
                  effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      expansionFactor: 2),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Helper.sharedPreferences.setBool('onBoarding', true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeLoginScreen()),
                            (route) => false,
                      );
                    } else {
                      onBoardingController.nextPage(
                        duration: Duration(
                        milliseconds: 750,
                      ), curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


Widget onBoardingPage(OnBoardingModel model) =>
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(model.image,
              width: double.infinity, fit: BoxFit.cover),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
List<OnBoardingModel> boardings = [
  OnBoardingModel(
    image: 'assets/images/onboardin1.png',
    title: 'First page',
    body: 'Hello in our app get enjoying with shopping ',
  ),
  OnBoardingModel(
    image: 'assets/images/onboardin3.png',
    title: 'second page',
    body: 'you can buy a lot of things here without leaving your place ',
  ),
  OnBoardingModel(
    image: 'assets/images/onBoarding_1.webp',
    title: 'last page',
    body: 'you can also get categories by your card ',
  )
];

class OnBoardingModel {
  final String title;
  final String body;
  final String image;

  OnBoardingModel(
      {required this.image, required this.title, required this.body});
}
