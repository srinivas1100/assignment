import 'package:ecommerce/product_card.dart';
import 'package:ecommerce/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCartItems extends StatelessWidget {
  const UserCartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Consumer<ProductProvider>(builder: (context, provider, _) {
        return provider.userProd.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.userProd.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            addRe: "Remove",
                            qty: provider.userProd[index].quantity!,
                            // addQuantity: () {},
                            // deleteQuantity: () {},
                            addOrDelete: () {
                              provider.deleteProduct(provider.userProd[index]);
                            },
                            imageUrl:
                                provider.userProd[index].pImage.toString(),
                            name: provider.userProd[index].pName.toString(),
                            detail:
                                provider.userProd[index].pDetails.toString(),
                            isAvailable: int.parse(provider
                                .userProd[index].pAvailability
                                .toString()),
                            cost: double.parse(
                                provider.userProd[index].pCost.toString()),
                            qtyFn: (int) {},
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              List<String> data = [];
                              provider.userProd.forEach(
                                  (ele) => data.add(ele.pName.toString()));
                              return Dialog(
                                child: Container(
                                  height: 200,
                                  child: Center(
                                    child: Text(data.join(", ")),
                                  ),
                                ),
                              );
                            });
                      },
                      child: const Text("Order Now"))
                ],
              )
            : Center(
                child: Text("No Products"),
              );
      }),
    );
  }
}
