// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/custom_text.dart';
import 'package:flutter_ecommerce/component/custom_buttonsheet.dart';
import 'package:flutter_ecommerce/view/details.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce/modelview/home_model_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeModelView>(
      init:HomeModelView() ,
        builder: (controller) => Scaffold(
              bottomNavigationBar: CustomButtonSheet(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Find Your Product',
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      text: 'Categories',
                    ),
                    Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categoriesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  //  color: Colors.green,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),

                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Image.network(
                                      controller
                                          .categoriesList[index].imageurl!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    )),
                                    CustomText(
                                      alignment: Alignment.center,
                                      text: controller
                                          .categoriesList[index].name!,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Best Selling',
                        ),
                        CustomText(
                          text: 'See All',
                        ),
                      ],
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * .47,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.productsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => DetailsView(
                                        productModel:
                                            controller.productsList[index]));
                                  },
                                  child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            controller
                                                .productsList[index].imageurl!,
                                            fit: BoxFit.fill,
                                            width: 300,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: controller
                                                    .productsList[index].name!,
                                              ),
                                              CustomText(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                text: controller
                                                        .productsList[index]
                                                        .price! +
                                                    " \$ ",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: CustomText(
                                            text: controller.productsList[index]
                                                .description!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        )),
                  ]),
                ),
              ),
            ));
  }
}
