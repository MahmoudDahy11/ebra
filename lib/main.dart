import 'package:ebra/core/routes/app_routes.dart';
import 'package:ebra/core/service/get_it.dart';
import 'package:ebra/features/auth/data/service/local_storage.dart';
import 'package:ebra/firebase_options.dart';
import 'package:ebra/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorageService.init();
  await getItSetup();
  runApp(const Ebra());
}

class Ebra extends StatelessWidget {
  const Ebra({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
    );
  }
}
