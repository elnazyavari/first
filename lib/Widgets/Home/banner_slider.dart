import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/Widgets/cached_image.dart';
// import 'package:apple_online_shop/bloc/home/home_bloc.dart';
import 'package:apple_online_shop/data/model/banners.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class BannerSlider extends StatelessWidget {
  BannerSlider({super.key, required this.list});
  List<Banners>? list;

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.8, initialPage: 1);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: controller,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: CachedImage(imageUrl: list?[index].thumbnail ?? ''),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            axisDirection: Axis.horizontal,
            effect: const ExpandingDotsEffect(
              activeDotColor: CustomColors.blue,
              expansionFactor: 4,
              dotHeight: 10,
              dotWidth: 10,
              dotColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
