import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../config/routes/app_route.dart';
import '../config/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_fc90ea9168a54282848f65387e75298a",
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getApplicationTheme(),
            initialRoute: AppRoute.splashRoute,
            routes: AppRoute.getAppRoutes(),
            navigatorKey: navKey,
            localizationsDelegates: const [KhaltiLocalizations.delegate],
          );
        });
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: AppTheme.getApplicationTheme(),
    //   initialRoute: AppRoute.splashRoute,
    //   routes: AppRoute.getAppRoutes(),
    // );
  }
}
