import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/view/chat-view/messages_view.dart';
import 'package:catch_case/user_panel/view/home-view/home_view.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_view.dart';
import 'package:catch_case/user_panel/view/notification-view/notification_view.dart';
import 'package:catch_case/user_panel/view/profile-view/profile_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../lawyer_panel/controllers/data_controller.dart';
import '../controllers/notification.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
   LocalNotificationService localNotificationService=LocalNotificationService();
 @override
  void initState() {
    super.initState();
    Get.put(DataController(), permanent: true);

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
  localNotificationService.requestNotificationPermission();
    localNotificationService.forgroundMessage();
    localNotificationService.firebaseInit(context);
    localNotificationService.setupInteractMessage(context);
    localNotificationService.isTokenRefresh();
    LocalNotificationService.storeToken();
  }

  int isSelectedTab = 0;

  List<Widget> pages = [
    const HomeView(),
    const MessageView(),
    const NotificationView(),
    const AllLawyersView(),
    const ProfileView()
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
                      Icons.home,
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
                      Icons.chat_bubble_outline,
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
                      Icons.notifications,
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
                      Icons.search,
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
                  label: '')
            ]),
      ),
    );
  }
}
