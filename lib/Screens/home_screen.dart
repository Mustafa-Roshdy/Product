import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:product/Provider/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // List<ProductElement> _product = [];
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
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.pink),
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
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            Consumer<ProductProvider>(
              builder: (context,productProvider,child) {
                return ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    productProvider.logout();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                );
              }
            ),
          ],
        ),
      ),

      ///---------------------------AppBar------------------------------------
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
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

      body: Column(
        children: [
          Consumer<ProductProvider>(
            builder: (context,productProvider,child) {
              return SizedBox(
                height: 60,
                child:productProvider.cat.isEmpty
                //  _cat.isEmpty
                    ? Center(child: CircularProgressIndicator(color: Colors.pink))
                    : SizedBox(
                        height: 40,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          children: [
                            CustomSlidingSegmentedControl<int>(
                              initialValue: 0,
                              children: {
                                // -1: Text("All"),
                                // for (int i = 0; i < _cat.length; i++)
                                //   i: Text(_cat[i], style: TextStyle(fontSize: 14)),
                                0: Text("All"),
                                for (int i = 0; i < productProvider.cat.length; i++)
                                  i + 1: Text(
                                    productProvider.cat[i],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                // 1:Text("hello"),
                                //  2:Text("hello"),
                                //   3:Text("hello"),
                                //    4:Text("hello"),
                              },
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              thumbDecoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.3),
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                              ),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              onValueChanged: (index) {
                                if(index==0){
                                  productProvider.getProduct();
                                }
                                else{
                                  index=index-1;
                                  productProvider.getProductByCat(productProvider.cat[index]);
                                }
                                
                              },
                            ),
                          ],
                        ),
                      ),
              );
            }
          ),

          Consumer<ProductProvider>(
            builder: (context,productProvider,child) {
              return Expanded(
                child: productProvider.product.isEmpty
                // _product.isEmpty
                    ? Center(child: CircularProgressIndicator(color: Colors.pink))
                    : ListView.builder(
                        itemCount: productProvider.product.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.product[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
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
                                      product.thumbnail ?? "",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title ?? "",
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
                                            "\$${product.price!.toStringAsFixed(2)}",
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
          ),
        ],
      ),
    );
  }
}
