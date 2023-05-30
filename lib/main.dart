import 'package:advanced/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';
import 'app/dependency_injection.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
        supportedLocales: const [ARABIC_LOCAL,ENGLISH_LOCAL],
        path: ASSET_PATH_LOCALIZATIONS,
        child: Phoenix(
            child: MyApp()
        ),
    )
  );


}


