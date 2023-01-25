import 'package:flutter/material.dart';

import 'singleprductpage.dart';

class categoriesproduct extends StatefulWidget {
  final product;
  final cUser;

  categoriesproduct({this.product,this.cUser});

  @override
  State<categoriesproduct> createState() => _categoriesproductState();
}

class _categoriesproductState extends State<categoriesproduct> {
  
  dynamic products;
  @override
  void initState() {
    super.initState();
    this.getusers();
  }

  getusers() {
    setState(() {
      products = widget.product;
    });
  }


  productdetail(e,p) {
   Navigator.push( context, MaterialPageRoute(builder: (context) => SingleProductPage(productData:e,cruser:widget.cUser,price:int.parse(p))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          centerTitle: true,
          title:Text("")),
        body: Column(
        children: [ 
          Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  
                ),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return products[index]['image1'] == ''? 
                                   Center()
                                    :GestureDetector(
                    onTap: () => productdetail(products[index],products[index]['price']),
                    child: Container(
                           decoration:  BoxDecoration(
                            color: Colors.white,
                                   borderRadius:  BorderRadius.circular(5),
                                   boxShadow: [ BoxShadow(
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
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                SizedBox(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child:  products[index]['image1'] == ''? 
                                   Center(child: CircularProgressIndicator()):
                                    Image.network(
                                        "${products[index]['image1']}",
                                        fit: BoxFit.contain)),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("${products[index]['tags']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                              color: Colors.white,
                                              backgroundColor: Colors.green)),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                                child: Text('${products[index]['category']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: Theme.of(context).textTheme.caption)),
                            SizedBox(
                                child: Text('${products[index]['name']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.bodyText2)),
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
    );
  }
}