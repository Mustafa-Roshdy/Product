import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/Model/product_model.dart';
import 'package:product/services/api_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductElement> _product = [];
  List<String> _cat = [];

  bool isLoading = false;
  final ApiClient _apiClient = ApiClient();

  void getProductData() async {
    try {
      isLoading = true;
      Response res = await _apiClient.getData("/products", {});

      if (res.statusCode == 200 || res.statusCode == 201) {
        Product product = Product.fromJson(res.data);

        setState(() {
          _product = product.products;
        });
        // print(_product);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
    }
  }



  void getProductsByCategory() async {
  try {
    setState(() {
      isLoading = true;
    });

    Response res = await _apiClient.getData("/products/category-list", {});

    if (res.statusCode == 200 || res.statusCode == 201) {
     
      setState(() {
        _cat = res.data;
        print(_cat);
      });
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductData();
    getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: Drawer(
        surfaceTintColor: Colors.pink,
        shadowColor: Colors.pink,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.pink,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Mustafa Roshdy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          ],
        ),
      ),

      ///---------------------------AppBar------------------------------------
      appBar: AppBar(
        
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                // _product;
                // getProductData();
                // print(_product);
              },
              icon: Icon(Icons.menu, color: Colors.pink),
            );
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: Colors.pink,
          ),
        ),
      ),
      body: _product.isEmpty && isLoading == true
          ? Center(child: CircularProgressIndicator(color: Colors.pink,)) 
          : ListView.builder(
              itemCount: _product.length,
              itemBuilder: (context, index) {
                final product = _product[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.pink.shade50, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: Image.network(
                            product.thumbnail,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),


                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "\$${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.pink.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
