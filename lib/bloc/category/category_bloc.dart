import 'package:apple_online_shop/bloc/category/category_event.dart';
import 'package:apple_online_shop/bloc/category/category_state.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/repository/category_repository.dart';
import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        final response = await _repository.getCategories();
        emit(CategoryResponseState(response));
      },
    );
  }
}
