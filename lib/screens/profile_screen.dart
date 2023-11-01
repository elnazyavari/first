import 'package:apple_online_shop/Constant/color.dart';
// import 'package:apple_online_shop/Widgets/Home/home_category_list.dart';
import 'package:apple_online_shop/Widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 20),
          ScreenAppBar(title: 'پروفایل کاربری'),
          SizedBox(height: 20),
          Column(
            children: [
              Text(
                'علی محمدزاده منیر',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SB',
                ),
              ),
              Text('5394 523 902 98+'),
            ],
          ),
          SizedBox(height: 40),
          // Wrap(
          //   runSpacing: 10,
          //   spacing: 43,
          //   children: [
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //     CategoryListItem(),
          //   ],
          // ),
          Spacer(),
          Text(
            'اپل آنلاین شاپ',
            style: TextStyle(
              fontSize: 12,
              color: CustomColors.grey,
            ),
          ),
          Text(
            'v1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: CustomColors.grey,
            ),
          ),
          Text(
            'توسعه داده شده توسط Alimmzdev',
            style: TextStyle(
              fontSize: 12,
              color: CustomColors.grey,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
