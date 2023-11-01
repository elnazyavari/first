import 'dart:ui';
import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/bloc/category/category_bloc.dart';
import 'package:apple_online_shop/bloc/home/home_bloc.dart';
import 'package:apple_online_shop/bloc/home/home_event.dart';
import 'package:apple_online_shop/screens/basket_screen.dart';
import 'package:apple_online_shop/screens/category_screen.dart';
import 'package:apple_online_shop/screens/home_screen.dart';
import 'package:apple_online_shop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  var selectedBottomNavigationBarIndex = 0;

  List<Widget> getScreens() {
    return [
      BlocProvider(
        create: (context) {
          var bloc = HomeBloc();
          bloc.add(HomeGetInitializedDataEvent());
          return bloc;
        },
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      const BasketScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: IndexedStack(
            index: selectedBottomNavigationBarIndex,
            children: getScreens(),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedBottomNavigationBarIndex = index;
                });
              },
              currentIndex: selectedBottomNavigationBarIndex,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(
                color: CustomColors.blue,
                fontFamily: 'SB',
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                color: CustomColors.grey,
                fontFamily: 'SB',
                fontSize: 12,
              ),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_home.png'),
                    activeIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ]),
                        child:
                            Image.asset('assets/images/icon_home_active.png'),
                      ),
                    ),
                    label: 'خانه'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_category.png'),
                    activeIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ]),
                        child: Image.asset(
                            'assets/images/icon_category_active.png'),
                      ),
                    ),
                    label: 'دسته بندی'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_basket.png'),
                    activeIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ]),
                        child:
                            Image.asset('assets/images/icon_basket_active.png'),
                      ),
                    ),
                    label: 'سبد خرید'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_profile.png'),
                    activeIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13))
                        ]),
                        child: Image.asset(
                            'assets/images/icon_profile_active.png'),
                      ),
                    ),
                    label: 'حساب کاربری'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
