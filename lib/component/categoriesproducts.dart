import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'singleprductpage.dart';

class categoriesproduct extends StatefulWidget {
  final product;
  final cUser;
  final category;

  categoriesproduct({this.product, this.cUser, this.category});

  @override
  State<categoriesproduct> createState() => _categoriesproductState();
}

class _categoriesproductState extends State<categoriesproduct> {
  dynamic products;
  @override
  var pro;
  dynamic catvoislist = [];
  @override
  void initState() {
    super.initState();
    this.getProducts();
  }

  var productUrl =
      "https://daily-groceries-db-default-rtdb.firebaseio.com/database/products/data.json";

  Future getProducts() async {
    final response = await http.get(Uri.parse(productUrl));
    setState(() {
      dynamic resp = jsonDecode(response.body);
      pro = resp;
      pro.asMap().forEach((index, element) {
        var list = pro[index];
        if (list['category'] == widget.category) {
          catvoislist.add(list);
        } 
        products = catvoislist;
      });
      
    });
  }
  // getusers() {
  //   setState(() {
  //     products = widget.product;
  //   });
  // }

  productdetail(e, p) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleProductPage(
                productData: e, cruser: widget.cUser, price: int.parse(p))));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.category)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: products.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return pro == null
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () => productdetail(
                                products[index], products[index]['price']),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    offset: Offset(1, 1), // Shadow position
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              width: 80,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        SizedBox(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: products[index]['image1'] ==
                                                    ''
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : Image.network(
                                                    "${products[index]['image1']}",
                                                    fit: BoxFit.contain)),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                              "${products[index]['tags']}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      backgroundColor:
                                                          Colors.green)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                        child: Text(
                                            '${products[index]['category']}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption)),
                                    SizedBox(
                                        child: Text(
                                            '${products[index]['name']}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2)),
                                    Row(
                                      children: [
                                        Text('${products[index]['price']}',
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            softWrap: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green)),
                                      ],
                                    ),
                                  ]),
                            ),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
