import 'package:flutter/material.dart';

enum Product { dart, flutter, firebase }

extension ProductDetails on Product {
  String get title {
    switch (this) {
      case Product.dart:
        return 'Dart';
      case Product.flutter:
        return 'Flutter';
      case Product.firebase:
        return 'Firebase';
    }
  }

  String get description {
    switch (this) {
      case Product.dart:
        return 'the best object language';
      case Product.flutter:
        return 'th best mobile widget library';
      case Product.firebase:
        return 'the best cloud database';
    }
  }

  String get imagePath {
    switch (this) {
      case Product.dart:
        return 'assets/w4s2/dart.png';
      case Product.flutter:
        return 'assets/w4s2/flutter.png';
      case Product.firebase:
        return 'assets/w4s2/firebase.png';
    }
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imagePath,
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: const TextStyle(
                  fontSize: 50, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 8),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Cards',
      home: Scaffold(
        appBar: AppBar(

          title: const Text('Product Cards'),
        ),

        body: Container(
          color: Colors.blue,

        child: ListView(
          children: [
            ProductCard(product: Product.dart),
            ProductCard(product: Product.flutter),
            ProductCard(product: Product.firebase),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
