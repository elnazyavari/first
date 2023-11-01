import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/bloc/product/product_bloc.dart';
import 'package:apple_online_shop/bloc/product/product_event.dart';
import 'package:apple_online_shop/data/model/product.dart';
import 'package:apple_online_shop/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductHorizontalListItem extends StatelessWidget {
  final List<Product>? productList;
  const ProductHorizontalListItem({super.key, this.productList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ProductItem(
              product: productList![index],
            ),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) {
                var bloc = ProductBloc();
                bloc.add(
                  ProductInitialEvent(
                    productId: product.id,
                    productCategoryId: product.categoryId,
                  ),
                );
                return bloc;
              },
              child: ProductDetailScreen(
                product: product,
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Container(
              width: 160,
              height: 190,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 16,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const SizedBox(width: double.infinity),
                      CachedNetworkImage(
                        imageUrl: product.thumbnail,
                        width: 100,
                      ),
                      Positioned(
                        top: 0,
                        right: 8,
                        child: Image.asset(
                          'assets/images/active_fav_product.png',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 8,
                        child: Container(
                          width: 30,
                          height: 16,
                          decoration: BoxDecoration(
                            color: CustomColors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '%${product.percent?.round().toString()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, right: 10),
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'SB',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 160,
              height: 48,
              decoration: const BoxDecoration(
                color: CustomColors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.blue,
                    blurRadius: 30,
                    spreadRadius: -12,
                    offset: Offset(0.00, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      width: 24,
                      'assets/images/icon_right_arrow_cricle.png',
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.realPrice.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'تومان',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
