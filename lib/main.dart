import 'package:apple_online_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_online_shop/data/Auth/auth_manager.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/screens/app_main.dart';
import 'package:apple_online_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SM'),
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: ValueListenableBuilder(
          valueListenable: AuthManager.authChangeNotifire,
          builder: (context, value, child) {
            var sharedPref =
                locator.get<SharedPreferences>().getString('access_token');
            //CHECK THIS
            if (value == null || value.isEmpty) {
              if (sharedPref == null || sharedPref.isEmpty) {
                return const LoginScreen();
              }
              return const AppMain();
            } else {
              return const AppMain();
            }
            //CHECK THIS
          },
        ),
      ),
    );
  }
}
