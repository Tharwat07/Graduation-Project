import 'package:union/other_config.dart';
import 'package:union/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:union/my_theme.dart';
import 'package:shared_value/shared_value.dart';
import 'dart:async';
import 'app_config.dart';
import 'package:union/services/push_notification_service.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:union/providers/locale_provider.dart';
import 'lang_config.dart';
import 'package:firebase_core/firebase_core.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) async{

      Firebase.initializeApp().then((value){
        if (OtherConfig.USE_PUSH_NOTIFICATION) {
          Future.delayed(Duration(milliseconds: 10), () async {
            PushNotificationService().initialise();
          });
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
            builder: OneContext().builder,
            navigatorKey: OneContext().navigator.key,
            title: AppConfig.app_name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: MyTheme.white,
              scaffoldBackgroundColor: MyTheme.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.publicSansTextTheme(textTheme).copyWith(
                bodyLarge:
                    GoogleFonts.publicSans(textStyle: textTheme.bodyLarge),
                bodyMedium: GoogleFonts.publicSans(
                    textStyle: textTheme.bodyMedium, fontSize: 12),
              ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MyTheme.accent_color),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: provider.locale,
            supportedLocales: LangConfig().supportedLocales(),
            home: SplashScreen(),
            // home: Splash(),
          );
        }));
  }
}
