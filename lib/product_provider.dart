import 'package:ecommerce/product_model.dart';
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _prod = [];
  List<ProductModel> _filProd = [];
  List<ProductModel> _userProd = [];
  List<String> _filter = [];
  List<String> get filter => _filter;

  List<ProductModel> get prod => _prod;
  List<ProductModel> get filProd => _filProd;
  List<ProductModel> get userProd => _userProd;

  filterProducts(String cat) {
    _filProd = _prod
        .where((e) =>
            e.pCategory.toString().toLowerCase() ==
            cat.toString().toLowerCase())
        .toList();
    notifyListeners();
  }

  setProducts() {
    products.forEach((element) {
      _prod.add(ProductModel.fromJson(element));
      if (!_filter.contains(element["p_category"].toString())) {
        _filter.add(element["p_category"].toString());
      }
    });

  }

  addProduct(ProductModel pro) {
    if (_userProd.any((element) => element.pId == pro.pId)) {
      var a = _userProd.indexWhere((element) => element.pId == pro.pId);
      _userProd[a].quantity = _userProd[a].quantity! + pro.quantity!;
    } else {
      _userProd.add(pro);
    }
    notifyListeners();
  }

  deleteProduct(ProductModel pro) {
    _userProd.remove(pro);
    notifyListeners();
  }
}
