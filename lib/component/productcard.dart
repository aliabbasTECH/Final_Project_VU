import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  

  
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: (){},
      child: SizedBox(

        width: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network('', fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(" ON SALE ",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.white,
                          backgroundColor: Colors.green)),
                )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
              child: Text('Productbrand',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.caption)),
          SizedBox(
              child: Text('product name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyText2)),
          Row(
            children: [
              Text('price:300 Rs',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
            ],
          ),
          // RatingView(
          //     value: product.reviews?.rating?.toInt() ?? 0,
          //     reviewsCount: product.reviews?.count?.toInt() ?? 0),
        ]),
      ),
    );
  }
}