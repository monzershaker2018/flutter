// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/custom_button.dart';
import 'package:flutter_ecommerce/component/custom_text.dart';
import 'package:flutter_ecommerce/helper/extension.dart';
import 'package:flutter_ecommerce/helper/cart_provider.dart';
import 'package:flutter_ecommerce/model/product_model.dart';
import 'package:flutter_ecommerce/model/product_provider_model.dart';
import 'package:flutter_ecommerce/modelview/cart_model_view.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget {
  final ProductModel productModel;
  const DetailsView({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Image.network(
                width: MediaQuery.of(context).size.width,
                productModel.imageurl!,
                height: 50,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomText(
              text: productModel.name!,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Size ',
                        ),
                        CustomText(
                          text: productModel.size!,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Color ',
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                              color: HexColor.fromHex(productModel.color!),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CustomText(
              text: 'Description ',
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              text: productModel.description!,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'PRICE  \$${productModel.price!} ',
                      ),
                      GetBuilder(
                          init: CartModelView(),
                          builder: (controller) => CustomButton(
                                onPress: () async {
                                  await CartProvider()
                                      .insertCart(ProductProviderModel(
                                    name: productModel.name!,
                                    imageurl: productModel.imageurl!,
                                    price: int.parse(productModel.price!),
                                    quintity: '1',
                                  ));
                                },
                                text: "ADD",
                              ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
