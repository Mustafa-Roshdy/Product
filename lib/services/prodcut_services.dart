
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:product/Model/product_model.dart';
import 'package:product/services/api_client.dart';

class ProdcutServices {


final ApiClient _apiClient =ApiClient();



  Future<List<ProductElement>?> getProductData() async {
    try {
      Response res = await _apiClient.getData("/products", {});
      if (res.statusCode == 200 || res.statusCode == 201) {
        Product product = Product.fromJson(res.data);
        
        return product.products;
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return null;
  }



  Future getCategories() async {
    try {
      Response res = await _apiClient.getData("/products/category-list", {});
      if (res.statusCode == 200 || res.statusCode == 201) {
        // setState(() {
        //   // _cat =res.data;
        //   // res.data.map((item)=>_cat.add(item.toString()));
        //   for (int i = 0; i < res.data.length; i++) {
        //     _cat.add(res.data[i].toString());
        //   }
        // });

        return res.data;
        
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }


   Future<List<ProductElement>?> getProductDataByCategory(String category) async {
    try {
      Response res = await _apiClient.getData("/products/category/$category",{});
      if (res.statusCode == 200 || res.statusCode == 201) {
        Product product = Product.fromJson(res.data);
        if(product.products!=null){
          

          return product.products;
        
      }
      }
    } catch (e) {
      if (kDebugMode) print(e);
      
    }
    return null;
  }

  

}