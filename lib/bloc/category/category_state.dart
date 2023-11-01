import 'package:apple_online_shop/data/model/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryState{}

class CategoryInitialState extends CategoryState{}

class CategoryLoadingState extends CategoryState{}

class CategoryResponseState extends CategoryState{
  Either<String, List<Category>> response;
  CategoryResponseState(this.response);
}