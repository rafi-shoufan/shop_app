import 'package:advanced/app/dependency_injection.dart';
import 'package:advanced/data/data_source/local_data_source.dart';
import 'package:advanced/presentation/resources/assets_manager.dart';
import 'package:advanced/presentation/resources/language_manager.dart';
import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../../../../../app/app_preferences.dart';
import '../../../../resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl()? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowIc),

          ),
          onTap: (){
            _changeLanguage();
    },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          title: Text(
            AppStrings.contactUs.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl()? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowIc),

          ),
          onTap: (){
            _contactUs();
    },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          title: Text(
            AppStrings.inviteYourFriends.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl()? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowIc),
          ),
          onTap: (){
            _inviteFriends();
    },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          title: Text(
            AppStrings.logout.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: (){
            _logout();
          },
        ),
      ],
    );
  }

  void _logout() {

    /// Make sure that app preferences
    _appPreferences.logout();

    /// clear cache
    _localDataSource.clearCache();

    /// navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);

  }

  void _inviteFriends() {}

  void _contactUs() {}

  void _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  bool isRtl(){
    return context.locale == ARABIC_LOCAL; /// يعني اذا عربي رجع true 
  }
}


