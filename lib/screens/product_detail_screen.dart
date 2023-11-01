import 'dart:ui';

import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/Widgets/cached_image.dart';
import 'package:apple_online_shop/Widgets/screen_app_bar.dart';
import 'package:apple_online_shop/bloc/product/product_bloc.dart';
import 'package:apple_online_shop/bloc/product/product_state.dart';
import 'package:apple_online_shop/data/model/product.dart';
import 'package:apple_online_shop/data/model/product_image.dart';
import 'package:apple_online_shop/data/model/product_variant.dart';
import 'package:apple_online_shop/data/model/variant_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return _getProductDetailScreenContent(state, widget.product);
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getProductDetailScreenContent(ProductState state, Product product) {
  if (state is ProductLoadingState) {
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
  } else if (state is ProductResponseSuccessState) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: 20)),
        state.productCategory.fold(
          (l) {
            return SliverToBoxAdapter(
              child: ScreenAppBar(
                title: l,
                havePop: true,
              ),
            );
          },
          (r) {
            return SliverToBoxAdapter(
              child: ScreenAppBar(
                title: r.title!,
                havePop: true,
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'SB',
              ),
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(bottom: 8),
        ),
        state.productImgage.fold((l) {
          return const SliverToBoxAdapter(
            child: Text('خطای بارگیرری عکس ها'),
          );
        }, (r) {
          return _GalleryWidget(r, product.thumbnail);
        }),
        state.productVariant.fold((l) {
          return SliverToBoxAdapter(
            child: Text(l),
          );
        }, (productVariantList) {
          return VariantContainerGenerator(productVariantList);
        }),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(
                //   width: 1,
                //   color: Colors.black,
                // ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'مشخصات فنی : ',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SB',
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                            color: CustomColors.blue,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Image.asset(
                          'assets/images/icon_left_categroy.png',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(
                //   width: 1,
                //   color: Colors.black,
                // ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'توضیحات محصول : ',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SB',
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                            color: CustomColors.blue,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Image.asset(
                          'assets/images/icon_left_categroy.png',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(
                //   width: 1,
                //   color: Colors.black,
                // ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'نظرات کاربران : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SB',
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CustomColors.green,
                              ),
                            ),
                            Positioned(
                              right: 15,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CustomColors.blue,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 30,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 45,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CustomColors.red,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 60,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CustomColors.grey,
                                ),
                                child: const Center(
                                  child: Text(
                                    '10+',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                            color: CustomColors.blue,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Image.asset(
                          'assets/images/icon_left_categroy.png',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddToBasketButton(),
                PriceTagButton(),
              ],
            ),
          ),
        )
      ],
    );
  } else {
    return const Text('Error');
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;
  const VariantContainerGenerator(
    this.productVariantList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              _VariantContainer(productVariant)
            }
          }
        ],
      ),
    );
  }
}

class _VariantContainer extends StatelessWidget {
  final ProductVariant productVariant;
  const _VariantContainer(this.productVariant);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(productVariant.variantType.title!),
          ),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantContainer(productVariant),
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantContainer(productVariant),
          },
          if (productVariant.variantType.type == VariantTypeEnum.VOLTAGE) ...{
            const Text('Voltage'),
          }
        ],
      ),
    );
  }
}

class ColorVariantContainer extends StatefulWidget {
  final ProductVariant productVariant;
  const ColorVariantContainer(this.productVariant, {super.key});

  @override
  State<ColorVariantContainer> createState() => _ColorVariantContainerState();
}

class _ColorVariantContainerState extends State<ColorVariantContainer> {
  int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.productVariant.variantList.length,
            itemBuilder: (context, index) {
              String variantColor =
                  'ff${widget.productVariant.variantList[index].value}';
              int hexColor = int.parse(variantColor, radix: 16);
              return GestureDetector(
                onTap: () => setState(() => selectedItemIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  width: 28,
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    border: (selectedItemIndex == index)
                        ? Border.all(
                            width: 2,
                            color: CustomColors.blue,
                          )
                        : Border.all(
                            width: 2,
                            color: CustomColors.backgroundColor,
                          ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class StorageVariantContainer extends StatefulWidget {
  final ProductVariant productVariant;
  const StorageVariantContainer(this.productVariant, {super.key});

  @override
  State<StorageVariantContainer> createState() =>
      _StorageVariantContainerState();
}

class _StorageVariantContainerState extends State<StorageVariantContainer> {
  int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productVariant.variantList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => selectedItemIndex = index),
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              width: 84,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: (selectedItemIndex == index)
                    ? Border.all(width: 2, color: CustomColors.blue)
                    : Border.all(width: 2, color: CustomColors.backgroundColor),
              ),
              child: Center(
                child: Text(widget.productVariant.variantList[index].name!),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GalleryWidget extends StatelessWidget {
  final List<Productimage> productImageList;
  final String defaultThumbnailUrl;
  const _GalleryWidget(this.productImageList, this.defaultThumbnailUrl);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 21 / 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CachedNetworkImage(
                imageUrl: (productImageList.isEmpty)
                    ? defaultThumbnailUrl
                    : productImageList[0].imgUrl!,
                width: 150,
              ),
              if (productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 72,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productImageList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(4),
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: CustomColors.blue,
                          ),
                        ),
                        child: CachedImage(
                          radius: 12,
                          imageUrl: productImageList[index].imgUrl!,
                        ),
                      );
                    },
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: const BoxDecoration(
                color: CustomColors.blue,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {},
                child: const SizedBox(
                  height: 53,
                  width: 160,
                  child: Center(
                    child: Text(
                      'افزودن سبد خرید',
                      style: TextStyle(
                          fontFamily: 'sb', fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: const BoxDecoration(
                color: CustomColors.green,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SizedBox(
                height: 53,
                width: 160,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'تومان',
                        style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 10,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '۴۹،۸۰۰،۰۰۰',
                            style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 12,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            '۴۸،۸۰۰،۰۰۰',
                            style: TextStyle(
                              fontFamily: 'sm',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                          child: Text(
                            '٪۳',
                            style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
