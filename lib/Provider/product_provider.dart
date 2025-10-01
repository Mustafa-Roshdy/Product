import 'package:flutter/widgets.dart';
import 'package:product/Model/product_model.dart';
import 'package:product/services/prodcut_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {
  List<ProductElement> product = [];

  ProdcutServices _prodcutServices = ProdcutServices();

   List<String> cat = [];


   String title="";

  ProductProvider() {
    getProduct();
    getCat();
    getProductByCat(title) ;
  }

  void getProduct() async {
    var pro = await _prodcutServices.getProductData();
    if (pro != null) {
      product = pro;
      notifyListeners();
    }
  }

  void getCat() async {

    var c= await _prodcutServices.getCategories();
          for (int i = 0; i < c.length; i++) {
            cat.add(c[i].toString());
          }
          notifyListeners();
  }

  void getProductByCat(title) async{

    var pro = await  _prodcutServices.getProductDataByCategory(title);

    if(pro != null){
      product = pro;
      notifyListeners();
    }
    
  }



  void logout ()async{

    final SharedPreferences preferences=await SharedPreferences.getInstance();

    preferences.remove("userData");
  }
}
