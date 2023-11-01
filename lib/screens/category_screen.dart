import 'package:apple_online_shop/Widgets/cached_image.dart';
import 'package:apple_online_shop/Widgets/screen_app_bar.dart';
import 'package:apple_online_shop/bloc/category/category_bloc.dart';
import 'package:apple_online_shop/bloc/category/category_event.dart';
import 'package:apple_online_shop/bloc/category/category_state.dart';
import 'package:apple_online_shop/data/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: ScreenAppBar(title: 'دسته بندی')),
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const SliverToBoxAdapter(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryResponseState) {
              return state.response.fold(
                (l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                },
                (r) {
                  return ListCategory(
                    list: r,
                  );
                },
              );
            }
            return const SliverToBoxAdapter(child: Text('error'));
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ListCategory extends StatelessWidget {
  List<Category>? list;
  ListCategory({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CachedImage(imageUrl: list?[index].thumbnail);
          },
          childCount: list?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
