import '../models/product_model.dart';

class ProductService {
  static List<Product> getProducts() {
    return [
      Product(id: '1', name: 'Wooden Chair', image: 'assets/images/f.jpeg', price: 1200),
      Product(id: '2', name: 'Sofa Set', image: 'assets/images/f1.jpeg', price: 4500),
    ];
  }
}
