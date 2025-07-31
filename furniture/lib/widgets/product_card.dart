import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/product/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
      child: Card(
        child: Column(
          children: [
            Expanded(child: Image.asset(product.image, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text('${product.price} ETB', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
