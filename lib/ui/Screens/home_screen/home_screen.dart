import 'package:evently_app/ui/Screens/home_screen/add_event/add_event_screen.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/favorite/favorite_tab.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/home/home_tab.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/map/map_tab..dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/user/user_tab.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(0),
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.white,
            type: BottomNavigationBarType.fixed,
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
                  selcIcon: AppAssets.selcHomeIcon,
                  unSelcIcon: AppAssets.unSelcHomeIcon,
                  label: appLocalization.home,
                  index: 0),
              buildBottomNavBarItem(
                  selcIcon: AppAssets.selcLocIcon,
                  unSelcIcon: AppAssets.unSelcLocIcon,
                  label: appLocalization.map,
                  index: 1),
              buildBottomNavBarItem(
                  selcIcon: AppAssets.selcFavIcon,
                  unSelcIcon: AppAssets.unSelcFavIcon,
                  label: appLocalization.favorite,
                  index: 2),
              buildBottomNavBarItem(
                  selcIcon: AppAssets.selcUserIcon,
                  unSelcIcon: AppAssets.unSelcUserIcon,
                  label: appLocalization.user,
                  index: 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEventScreen.routeName);
        },
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
