import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/Widgets/Home/banner_slider.dart';
import 'package:apple_online_shop/Widgets/Home/home_category_list.dart';
import 'package:apple_online_shop/Widgets/Home/home_product_list.dart';
import 'package:apple_online_shop/bloc/home/home_bloc.dart';
import 'package:apple_online_shop/bloc/home/home_state.dart';
import 'package:apple_online_shop/data/model/banners.dart';
import 'package:apple_online_shop/data/model/category.dart';
import 'package:apple_online_shop/data/model/product.dart';
import 'package:apple_online_shop/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return _getHomeContent(state);
      },
    );
  }
}

Widget _getHomeContent(HomeState state) {
  if (state is HomeLoadingState) {
    return const Center(
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            colors: [CustomColors.blue],
            strokeWidth: 2,
          ),
        ),
      ),
    );
  } else if (state is HomeRequestSuccessState) {
    return CustomScrollView(
      slivers: [
        const _SearchBox(),
        state.bannerList.fold(
          (l) {
            return const SliverToBoxAdapter(child: Text('Ali'));
          },
          (r) {
            return _BannerSlider(r);
          },
        ),
        state.categoryList.fold(
          (l) {
            return const SliverToBoxAdapter(child: Text('Ali'));
          },
          (r) {
            return _CategoryList(r);
          },
        ),
        state.bestSellerProductList.fold(
          (l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          },
          (r) {
            return _ProductList(r, 'پرفروش ترین ها');
          },
        ),
        state.hotestProductList.fold(
          (l) {
            return SliverToBoxAdapter(
              child: Text(l),
            );
          },
          (r) {
            return _ProductList(r, 'پربازدیدترین ها');
          },
        ),
      ],
    );
  } else {
    return const Text('Ali');
  }
}

class _ProductList extends StatelessWidget {
  final List<Product> list;
  final String title;
  const _ProductList(this.list, this.title);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'SB',
                      color: CustomColors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          list: list,
                          appBarTitle: title,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'مشاهده همه',
                          style: TextStyle(
                            fontFamily: 'SB',
                            color: CustomColors.blue,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset('assets/images/icon_left_categroy.png')
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            ProductHorizontalListItem(productList: list)
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _CategoryList extends StatelessWidget {
  _CategoryList(this.categoryList);
  List<Category>? categoryList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'دسته بندی',
              style: TextStyle(
                fontFamily: 'SB',
                color: CustomColors.grey,
              ),
            ),
            CategoryHorizontalListItem(
              categoryList: categoryList,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _BannerSlider extends StatelessWidget {
  List<Banners>? list;
  _BannerSlider(this.list);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BannerSlider(list: list),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Container(
          height: 46.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset('assets/images/icon_search.png'),
                const Expanded(
                  child: Text(
                    'جست و جوی محصولات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomColors.grey,
                    ),
                  ),
                ),
                Image.asset('assets/images/icon_apple_blue.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
