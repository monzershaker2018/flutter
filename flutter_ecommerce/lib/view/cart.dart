// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/custom_button.dart';
import 'package:flutter_ecommerce/component/custom_buttonsheet.dart';
import 'package:flutter_ecommerce/modelview/cart_model_view.dart';
import 'package:flutter_ecommerce/component/custom_text.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButtonSheet(),
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .85,
          child: GetBuilder(
            init: CartModelView(),
            builder: (controller) => ListView.builder(
              itemCount: controller.listCarts.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                            controller.listCarts[index].imageurl!),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: controller.listCarts[index].name!,
                            ),
                            CustomText(
                              text:
                                  controller.listCarts[index].price!.toString(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.grey.shade200,
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomText(
                                      size: 20,
                                      text: '+',
                                    ),
                                    CustomText(
                                      size: 20,
                                      text: '1',
                                    ),
                                    CustomText(
                                      size: 20,
                                      text: '-',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                text: "TOTAL \$1200",
              ),
              CustomButton(
                onPress: () {},
                text: "CHECKOUT",
              ),
            ],
          ),
        )
      ]),
    );
  }
}
