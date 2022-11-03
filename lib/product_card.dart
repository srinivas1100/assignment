import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.detail,
    required this.cost,
    required this.isAvailable,
    required this.addOrDelete,
    required this.qtyFn,
    required this.qty,
    required this.addRe,
  });
  final String imageUrl;
  final String name;
  final String detail;
  final double cost;
  final int isAvailable;
  final int qty;
  final void Function(int) qtyFn;
  final String addRe;

  final void Function() addOrDelete;
  // final void Function() addQuantity;
  // final void Function() deleteQuantity;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int quantity;
  @override
  void initState() {
    quantity = widget.qty;
    super.initState();
  }

  // int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 200,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black12)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
          child: Row(
            children: [
              Image.network(
                widget.imageUrl,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(widget.detail),
                          ],
                        ),
                        Text(
                          widget.cost.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    widget.isAvailable == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity--;
                                          widget.qtyFn(quantity);
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: Colors.black,
                                          )),
                                      child: const Center(
                                          child: Text(
                                        "-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(quantity.toString()),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                        widget.qtyFn(quantity);
                                      });
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: Colors.black,
                                          )),
                                      child: const Center(
                                          child: Text(
                                        "+",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: widget.addOrDelete,
                                  child:  Text(widget.addRe))
                            ],
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Out of stock",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
