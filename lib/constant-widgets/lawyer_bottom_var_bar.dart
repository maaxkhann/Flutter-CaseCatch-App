import 'package:catch_case/lawyer_panel/dashboard/lawyer_questions_answers_view.dart';
import 'package:catch_case/lawyer_panel/dashboard/profile/lawyer_update_profile_view.dart';
import 'package:catch_case/lawyer_panel/dashboard/show_question_answer_lawyer.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../user_panel/controllers/notification.dart';

class LawyerBottomNavigationBarWidget extends StatefulWidget {
  const LawyerBottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<LawyerBottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends State<LawyerBottomNavigationBarWidget> {
  LocalNotificationService localNotificationService =
      LocalNotificationService();
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
    localNotificationService.requestNotificationPermission();
    localNotificationService.forgroundMessage();
    localNotificationService.firebaseInit(context);
    localNotificationService.setupInteractMessage(context);
    localNotificationService.isTokenRefresh();
    //  LocalNotificationService.storeToken();
  }

  int isSelectedTab = 0;

  List<Widget> pages = [
    const LawyerQuestionAnswer(),
    const ShowQuestionAnswerLawyer(),
    const LawyerUpdateProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSelectedTab != 0) {
          setState(() {
            isSelectedTab = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: pages[isSelectedTab],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                isSelectedTab = index;
              });
            },
            backgroundColor: kWhite,
            currentIndex: isSelectedTab,
            items: [
              BottomNavigationBarItem(
                  icon: DecoratedIcon(
                    icon: Icon(
                      Icons.question_mark,
                      size: 26.r,
                      color: kWhite,
                    ),
                    decoration: IconDecoration(
                        border: IconBorder(color: kGrey, width: 4.w)),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: DecoratedIcon(
                    icon: Icon(
                      Icons.question_answer,
                      size: 26.r,
                      color: kWhite,
                    ),
                    decoration: IconDecoration(
                        border: IconBorder(color: kGrey, width: 4.w)),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: DecoratedIcon(
                    icon: Icon(
                      Icons.person_pin,
                      size: 26.r,
                      color: kWhite,
                    ),
                    decoration: IconDecoration(
                        border: IconBorder(color: kGrey, width: 4.w)),
                  ),
                  label: ''),
              // BottomNavigationBarItem(
              //     icon: DecoratedIcon(
              //       icon: Icon(
              //         Icons.search,
              //         size: 26.r,
              //         color: kWhite,
              //       ),
              //       decoration: IconDecoration(
              //           border: IconBorder(color: kGrey, width: 4.w)),
              //     ),
              //     label: ''),
              // BottomNavigationBarItem(
              //     icon: DecoratedIcon(
              //       icon: Icon(
              //         Icons.person_pin,
              //         size: 26.r,
              //         color: kWhite,
              //       ),
              //       decoration: IconDecoration(
              //           border: IconBorder(color: kGrey, width: 4.w)),
              //     ),
              //     label: '')
            ]),
      ),
    );
  }
}
