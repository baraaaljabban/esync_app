import 'dart:convert';

import 'package:esync_app/core/errors/error_handler.dart';
import 'package:esync_app/core/network/http_client.dart';
import 'package:esync_app/features/products/data/models/product_model.dart';
import 'package:flutter/services.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> loadProducts();

  Future<List<ProductModel>> loadMoreProducts({required int pageNumber});
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource with ErrorHandler {
  HttpClient client;

  ProductsRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<List<ProductModel>> loadProducts() async {
    var string = await rootBundle.loadString('assets/products.json');
    return ProductListModel.fromJson(jsonDecode(string)).products.getRange(0, 7).toList();
    // var path = "Products_ENDPOINT" + "?&pageSize=20";
    // var result = await client.getData(
    //   url: path,
    // );
    // if (result.statusCode != HttpStatus.ok) {
    //   throw getNonSuccessHttpResponseException(result);
    // } else {
    //   var decodedObject = json.decode(utf8.decode(result.bodyBytes));

    //   return ProductsListModel.fromJson(decodedObject).Productss;
    // }
  }

  @override
  Future<List<ProductModel>> loadMoreProducts({required int pageNumber}) async {
    var string = await rootBundle.loadString('assets/products.json');
    return ProductListModel.fromJson(jsonDecode(string)).products.getRange(7, 12).toList();

    // var path = "Products_ENDPOINT" + "?&pageNumber=$pageNumber";
    // var result = await client.getData(
    //   url: path,
    // );
    // if (result.statusCode != HttpStatus.ok) {
    //   throw getNonSuccessHttpResponseException(result);
    // } else {
    //   var decodedObject = json.decode(utf8.decode(result.bodyBytes));
    //   return ProductsListModel.fromJson(decodedObject).Productss;
    // }
  }
}
