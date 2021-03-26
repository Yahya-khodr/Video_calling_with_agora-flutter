import 'package:chatting_with_mentors/provider/user_provider.dart';
import 'package:chatting_with_mentors/screens/callscreens/pickup/pickup_layout.dart';
import 'package:chatting_with_mentors/screens/pageviews/chat_list_screen.dart';
import 'package:chatting_with_mentors/utils/universal_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;

  UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });

    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: PageView(
          children: <Widget>[
            Container(
              child: ChatListScreen(),
            ),
            Center(
              child: Text(
                "Call Logs",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
                child: Text(
              "Contact Screen",
              style: TextStyle(color: Colors.white),
            )),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTabBar(
              backgroundColor: UniversalVariables.blackColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat,
                      color: (_page == 0)
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor),
                  label: "Chats",
                  backgroundColor: (_page == 0)
                      ? UniversalVariables.lightBlueColor
                      : Colors.grey,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.call,
                        color: (_page == 1)
                            ? UniversalVariables.lightBlueColor
                            : UniversalVariables.greyColor),
                    label: "Calls",
                    backgroundColor: (_page == 1)
                        ? UniversalVariables.lightBlueColor
                        : Colors.grey),
                BottomNavigationBarItem(
                    icon: Icon(Icons.contact_phone,
                        color: (_page == 2)
                            ? UniversalVariables.lightBlueColor
                            : UniversalVariables.greyColor),
                    label: "Contacts",
                    backgroundColor: (_page == 2)
                        ? UniversalVariables.lightBlueColor
                        : Colors.grey),
              ],
              onTap: navigationTapped,
              activeColor: UniversalVariables.lightBlueColor,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}
