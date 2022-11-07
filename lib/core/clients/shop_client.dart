import 'dart:convert';

import 'package:fake_shop/core/clients/base_client.dart';
import 'package:fake_shop/core/constants/action_url.dart';
import 'package:fake_shop/models/product/product.dart';
import 'package:fake_shop/models/response/products_response.dart';

class ShopClient {
  final _baseClient = BaseClient();

  Future<ProductsResponse> getProducts() async {
    final productsResponse = ProductsResponse(productList: <Product>[]);
    final productList = <Product>[];

    final result = await _baseClient.dioGet(
      actionUrl: ActionUrl.getProducts,
    );

    final deserializedProducts =
        jsonDecode(result.responseStr) as List<dynamic>;
    for (final element in deserializedProducts) {
      final product = Product.fromJson(jsonEncode(element));
      productList.add(product);
    }

    productsResponse
      ..productList = result.hasError ? <Product>[] : productList
      ..hasError = result.hasError
      ..errorType = 'Error'
      ..errorMessage = result.errorMessage;

    return productsResponse;
  }
}