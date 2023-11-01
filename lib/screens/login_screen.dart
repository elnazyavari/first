// import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_online_shop/bloc/authentication/auth_event.dart';
import 'package:apple_online_shop/bloc/authentication/auth_state.dart';
import 'package:apple_online_shop/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var usernameTextController = TextEditingController(text: 'Alimmz1');
    var passwordTextController = TextEditingController(text: '12345678');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity, height: 50),
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                    CustomColors.blue, BlendMode.modulate),
                child: Image.asset(
                  width: 144,
                  'assets/images/icon_application.png',
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'ورود به حساب کاربری اپل شاپ',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SB',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: TextField(
                        controller: usernameTextController,
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          labelText: 'نام کاربری',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: CustomColors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 56,
                      child: TextField(
                        controller: passwordTextController,
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: CustomColors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitiateState) {
                            return ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(AuthLoginEvent(
                                  usernameTextController.text,
                                  passwordTextController.text,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              child: const Text(
                                'وارد شوید',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'SB'),
                              ),
                            );
                          } else if (state is AuthLoadingState) {
                            return const CircularProgressIndicator(
                              color: CustomColors.green,
                            );
                          } else if (state is AuthResponseState) {
                            Text? widget;
                            state.response.fold(
                                (l) => {
                                      widget = Text(l),
                                    },
                                (r) =>
                                    {widget = Text(r), Navigator.pop(context)});
                            return Center(child: widget!);
                          }
                          return const Center(
                            child: Text('خطای نامشخص'),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'حساب کاربری ندارید؟ ثبت نام کنید',
                        style: TextStyle(
                          color: CustomColors.blue,
                          fontFamily: 'SB',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
