import 'package:apple_online_shop/Constant/color.dart';
import 'package:apple_online_shop/Widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              const SliverPadding(padding: EdgeInsets.only(top: 20)),
              const SliverToBoxAdapter(
                child: ScreenAppBar(title: 'سبد خرید'),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/iphone.png',
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    const Text(
                                      'آیفون 13 پرومکس',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'SB',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'گارانتی 18 ماهه اپل استور',
                                      style: TextStyle(
                                        color: CustomColors.grey,
                                        fontSize: 12,
                                        fontFamily: 'SM',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Text(
                                          '46،000،000 تومان',
                                          style: TextStyle(
                                            color: CustomColors.grey,
                                            fontSize: 12,
                                            fontFamily: 'SM',
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          width: 30,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: CustomColors.red,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '5%',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '46،000،650 تومان',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: 10),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 64),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              height: 53,
              width: MediaQuery.of(context).size.width - 64,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: const Text(
                  'ادامه فرآیند خرید',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'SB'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
