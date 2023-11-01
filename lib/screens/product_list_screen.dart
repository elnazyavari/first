import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/Widgets/Home/home_product_list.dart';
import 'package:apple_online_shop/Widgets/screen_app_bar.dart';
import 'package:apple_online_shop/data/model/product.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> list;
  final String appBarTitle;
  const ProductListScreen({super.key, required this.list , required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: ScreenAppBar(
                    title: appBarTitle,
                    havePop: true,
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductItem(
                        product: list[index],
                      );
                    },
                    childCount: list.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 2 / 3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
