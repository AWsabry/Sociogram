// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/product.dart';
// import '../../components/product_card.dart';

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     return productProvider.productsSearched.length < 1
//         ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(
//                     Icons.search,
//                     color: Colors.grey,
//                     size: 30,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     "No products Found",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w300,
//                       fontSize: 22,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           )
//         : Container(
//             margin: EdgeInsets.all(10),
//             child: GridView.builder(
//               scrollDirection: Axis.vertical,
//               gridDelegate:
//                   SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//               itemBuilder: (_, index) =>
//                   ProductCard(product: productProvider.productsSearched[index]),
//               itemCount: productProvider.productsSearched.length,
//             ),
//           );
//     //  Column(
//     //   children: [
//     //     ...List.generate(
//     //       productProvider.products.length,
//     //       (index) {
//     //         return Row(children: [ ProductCard(
//     //             product: productProvider.products[index]);],);

//     // return SizedBox
//     // .shrink(); // here by default width and height is 0
//     // },
//     // ),
//     // SizedBox(width: getProportionateScreenWidth(20)),
//     // ],
//     // ),
//   }
// }
