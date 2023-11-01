import 'package:flutter/material.dart';
import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_online_shop/bloc/authentication/auth_event.dart';
import 'package:apple_online_shop/bloc/authentication/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var usernameTextController = TextEditingController(text: 'Alimmztesttest1');
    var passwordTextController = TextEditingController(text: '12345678');
    var confirmPasswordTextController = TextEditingController(text: '12345678');
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Directionality(
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
                  'ثبت نام حساب کاربری اپل شاپ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SB',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 280,
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
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 56,
                        child: TextField(
                          controller: confirmPasswordTextController,
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          decoration: InputDecoration(
                            labelText: 'تکرار رمز عبور',
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
                      const Spacer(),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthInitiateState) {
                                return ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      AuthSignupEvent(
                                        usernameTextController.text,
                                        passwordTextController.text,
                                        confirmPasswordTextController.text,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomColors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  child: const Text(
                                    'ثبت نام کنید',
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
                                    (r) => {
                                          widget = Text(r),
                                          Future.delayed(
                                            const Duration(seconds: 1),
                                            () => Navigator.pop(context),
                                          ),
                                        });
                                return Center(child: widget!);
                              }
                              return const Center(
                                child: Text('خطای نامشخص'),
                              );
                            },
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
