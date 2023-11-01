import 'package:apple_online_shop/data/model/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryHorizontalListItem extends StatelessWidget {
  CategoryHorizontalListItem({super.key, required this.categoryList});
  List<Category>? categoryList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
            child: CategoryListItem(
              categoryListitem: categoryList![index],
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryListItem extends StatelessWidget {
  final Category categoryListitem;
  const CategoryListItem({super.key, required this.categoryListitem});

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${categoryListitem.color}';
    int hexColor = int.parse(categoryColor, radix: 16);
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Color(hexColor),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(hexColor),
                blurRadius: 20,
                spreadRadius: -10,
                offset: const Offset(0.00, 10),
              ),
            ],
          ),
          child: Center(
            child: SizedBox(
              width: 26,
              height: 26,
              child: CachedNetworkImage(
                imageUrl: categoryListitem.icon!,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(categoryListitem.title!),
      ],
    );
  }
}
