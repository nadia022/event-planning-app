import 'package:evently_app/ui/tabs/favorite/favorite_tab.dart';
import 'package:evently_app/ui/tabs/home/home_tab.dart';
import 'package:evently_app/ui/tabs/map/map_tab..dart';
import 'package:evently_app/ui/tabs/user/user_tab.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_images.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), UserTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(0),
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: selectIndex,
            onTap: (value) {
              selectIndex = value;
              setState(() {});
            },
            items: [
              buildBottomNavBarItem(
                  selcIcon: AppImages.selcHomeIcon,
                  unSelcIcon: AppImages.unSelcHomeIcon,
                  label: "Home",
                  index: 0),
              buildBottomNavBarItem(
                  selcIcon: AppImages.selcLocIcon,
                  unSelcIcon: AppImages.unSelcLocIcon,
                  label: "Map",
                  index: 1),
              buildBottomNavBarItem(
                  selcIcon: AppImages.selcFavIcon,
                  unSelcIcon: AppImages.unSelcFavIcon,
                  label: "Favorite",
                  index: 2),
              buildBottomNavBarItem(
                  selcIcon: AppImages.selcUserIcon,
                  unSelcIcon: AppImages.unSelcUserIcon,
                  label: "User",
                  index: 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavBarItem(
      {required String selcIcon,
      required String unSelcIcon,
      required String label,
      required int index}) {
    return BottomNavigationBarItem(
        icon: Image.asset(selectIndex == index ? selcIcon : unSelcIcon),
        label: label);
  }
}
