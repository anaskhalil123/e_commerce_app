import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final List<Product> _products = [
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket06.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket01.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket02.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket04.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket05.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket08.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket07.jpeg'),
    Product('jacket', '30', 'Jackets', "jacker desc......",
        'images/juckets/jacket01.jpeg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: .8,
          ),
          itemBuilder: (context, index) => GestureDetector(
                onTapUp: (details) {
                  // position in x axis
                  double dx = details.globalPosition.dx;
                  double dy = details.globalPosition.dy;
                  // distance between the item and the right side of the mobile (المسافة التي يبعد عنها العنصر بالنسبة ليمين الحوال)
                  double dx2 = (MediaQuery.of(context).size.width) - dx;
                  double dy2 = (MediaQuery.of(context).size.height) - dy;

                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [
                        PopupMenuItem(child: Text('Edit')),
                        PopupMenuItem(child: Text('Delete')),
                      ]);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(_products[index].imageLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_products[index].name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('\$ ${_products[index].price}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          itemCount: _products.length),
    );
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() {}
}

class Product {
  late String name;
  late String price;
  late String desc;
  late String category;
  late String imageLocation;

  Product(this.name, this.price, this.category, this.desc, this.imageLocation);
}
