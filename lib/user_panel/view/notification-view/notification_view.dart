import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/notification-view/widgets/cancelled_notifications.dart';
import 'package:catch_case/user_panel/view/notification-view/widgets/completed_notifications.dart';
import 'package:catch_case/user_panel/view/notification-view/widgets/upcoming_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kButtonColor,
              centerTitle: true,
              title: Text(
                'Notifications',
                style: kBody1White,
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                  labelColor: kDarkBlue,
                  unselectedLabelColor: kMediumBlue,
                  indicatorColor: kDarkBlue,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const Expanded(
                    child: TabBarView(children: [
                  UpcomingNotifications(),
                  CompletedNotifications(),
                  CancelledNotifications()
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
