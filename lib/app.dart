
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/module/notifications/controller/notification_controller.dart';
import 'package:taxi_app/app/module/notifications/view/notification_view.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:taxi_app/app/utils/lang/languages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



class App extends StatelessWidget {
  const App({Key? key, required this.langCode,}) : super(key: key);

  final String langCode;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "DHB",
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Locale(langCode),

      // builder: DevicePreview.appBuilder,

      fallbackLocale: Locale('ar', 'SA'),
        initialRoute: AppPages.INITIAL,
      // initialRoute: Routes.Instructions,
      getPages: AppPages.routes,
      onGenerateRoute: (RouteSettings settings) {
        // Handle deep link for discount coupon
        if (settings.name != null) {
          Uri uri = Uri.parse(settings.name!);
          if (uri.pathSegments.contains('notifications')) {
            var couponCode = uri.queryParameters['code'];
            return GetPageRoute(
              page: () => NotificationView(),
              binding: BindingsBuilder(() {
                Get.put(NotificationController());
              }),
              settings: RouteSettings(
                name:Routes.NOTIFICATIONS,
                arguments: couponCode,
              ),
            );
          }
        }
        return null;
      },
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // color: Colors.white ,
      theme: ThemeData(
        primaryColor: kMainColor,
         scaffoldBackgroundColor: white,
         textTheme: GoogleFonts.akatabTextTheme(
          Theme.of(context).textTheme,
        ),
        cardTheme: CardTheme(
          color: white
        ),
        appBarTheme: AppBarTheme(
            color: white,
        )
      ),
    );
  }
}
