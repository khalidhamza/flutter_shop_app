import 'package:flutter/material.dart';
import 'package:shop_app/modules/auth/login_screen.dart';
import 'package:shop_app/network/local/local_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:shop_app/models/onboarding_model.dart';

import '../../shared/components/navigation.dart';
import '../../shared/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  List<OnboardingModel> onboardingList = [
    OnboardingModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'First Onboarding title',
        body: 'First Onboarding body goes here'
    ),

    OnboardingModel(
        image: 'assets/images/on_boarding_2.png',
        title: 'Second Onboarding title',
        body: 'Second Onboarding body goes here'
    ),

    OnboardingModel(
        image: 'assets/images/on_boarding_3.png',
        title: 'Third Onboarding title',
        body: 'Third Onboarding body goes here'
    ),
  ];

  var onboardingController = PageController();

  bool isLastPage = false;

  void redirectToHome(context)
  {
    LocalStorage.setData(key: 'onboarding_seen', value: true);
    navigateAndFinish(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              redirectToHome(context);
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: primaryColor,
                fontSize: 16
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildPageViewItem(context, onboardingList[index]),
                itemCount: onboardingList.length,
                controller: onboardingController,
                onPageChanged: (int index){
                  setState(() {
                    isLastPage = index == (onboardingList.length -1);
                  });
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: onboardingController,
                    count: onboardingList.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 10,
                      expansionFactor: 4,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: primaryColor,
                    onPressed: () {
                      if(isLastPage){
                        redirectToHome(context);
                      }else{
                        onboardingController.nextPage(
                          duration: const Duration(microseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageViewItem(BuildContext context, OnboardingModel onboardingSlid)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(onboardingSlid.image)),
        const SizedBox(height: 5),
        Text(
          onboardingSlid.title.toUpperCase(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 5),
        Text(
          onboardingSlid.body,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
