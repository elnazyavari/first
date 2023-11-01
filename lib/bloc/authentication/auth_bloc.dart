import 'package:apple_online_shop/bloc/authentication/auth_event.dart';
import 'package:apple_online_shop/bloc/authentication/auth_state.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoginEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        final response =
            await _repository.login(event.username, event.password);
        emit(AuthResponseState(response));
      },
    );

    on<AuthSignupEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        final response = await _repository.register(
            event.username, event.password, event.confirmPassword);
        emit(AuthResponseState(response));
      },
    );
  }
}
