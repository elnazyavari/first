import 'package:apple_online_shop/Constant/color.dart';
import 'package:flutter/material.dart';

class ScreenAppBar extends StatelessWidget {
  const ScreenAppBar({super.key, required this.title, this.havePop = false});

  final String title;
  final bool havePop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Visibility(
              visible: havePop,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/images/icon_back.png'),
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: CustomColors.blue,
                ),
              ),
            ),
            Image.asset('assets/images/icon_apple_blue.png'),
          ],
        ),
      ),
    );
  }
}
