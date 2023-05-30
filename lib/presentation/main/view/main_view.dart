
import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../resources/strings_manager.dart';
import '../pages/home/view/home_page.dart';
import '../pages/notifications/view/notifications_page.dart';
import '../pages/search/view/search_page.dart';
import '../pages/settings/view/settings_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];

  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  var title = AppStrings.home.tr();

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey,
              spreadRadius: AppSize.s1
            )
          ]
        ),
        child: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(icon: (Icon(Icons.home_outlined)),label: AppStrings.home.tr()),
            BottomNavigationBarItem(icon: (Icon(Icons.search_outlined)),label: AppStrings.search.tr()),
            BottomNavigationBarItem(icon: (Icon(Icons.notifications_none_outlined)),label: AppStrings.notifications.tr()),
            BottomNavigationBarItem(icon: (Icon(Icons.settings_outlined)),label: AppStrings.settings.tr()),
          ],
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
  onTap(int index){
    setState(() {
      _currentIndex = index;
      title = titles[index];
    });
  }
}
