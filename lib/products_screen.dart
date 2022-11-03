import 'package:ecommerce/cart_screen.dart';
import 'package:ecommerce/product_card.dart';
import 'package:ecommerce/product_model.dart';
import 'package:ecommerce/product_provider.dart';
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductProvider productProvider;
  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.setProducts();
    super.initState();
  }

  String filter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fruits"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserCartItems()));
              },
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            child: Center(
              child: ListView.builder(
                  itemCount: productProvider.filter.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (filter.toString().toLowerCase() ==
                                  productProvider.filter[index]
                                      .toString()
                                      .toLowerCase()) {
                                filter = "";
                              } else {
                                filter = productProvider.filter[index];
                                productProvider.filterProducts(
                                    productProvider.filter[index]);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: filter == productProvider.filter[index]
                                    ? Colors.greenAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.black,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(productProvider.filter[index]),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filter == ""
                    ? productProvider.prod.length
                    : productProvider.filProd.length,
                itemBuilder: (BuildContext context, int index) {
                  var pr = filter == ""
                      ? productProvider.prod[index]
                      : productProvider.filProd[index];

                  int quantity = 1;

                  return ProductCard(
                    qty: 1,
                    addRe: "Add",
                    // addQuantity: () {
                    //   setState(() {
                    //     quantity++;
                    //   });
                    // },
                    // deleteQuantity: () {
                    //   setState(() {
                    //     if (quantity > 1) {
                    //       quantity--;
                    //     }
                    //   });
                    // },
                    addOrDelete: () {
                      productProvider.addProduct(ProductModel(
                          pId: pr.pId,
                          pAvailability: pr.pAvailability,
                          pName: pr.pName.toString(),
                          pCategory: pr.pCategory,
                          pCost: int.parse(pr.pCost.toString()),
                          pDetails: pr.pCategory.toString(),
                          pImage: pr.pImage.toString(),
                          quantity: quantity));
                    },
                    imageUrl: pr.pImage.toString(),
                    name: pr.pName.toString(),
                    detail: pr.pCategory.toString(),
                    isAvailable: int.parse(pr.pAvailability.toString()),
                    cost: double.parse(pr.pCost.toString()),
                    qtyFn: (int a) {
                      quantity = a;
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
