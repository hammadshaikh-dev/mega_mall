import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../utils/price_utils.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final price = parsePrice(product.price);
    final theme = Theme.of(context); // Get the current theme data

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        // ✅ Remove hardcoded color to use global theme settings:
        // backgroundColor: Colors.blueAccent, 
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image
                    Hero(
                      tag: product.name,
                      child: Image.network(
                        product.imageUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle( // Changed from const
                                fontSize: 22, 
                                fontWeight: FontWeight.bold,
                                // ✅ Use dynamic theme color
                                color: theme.textTheme.bodyLarge!.color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatPricePKR(price),
                            style: TextStyle( // Changed from const
                                fontSize: 20,
                                // ✅ Use dynamic theme color (colorScheme.secondary works well)
                                color: theme.colorScheme.secondary, 
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Product Description",
                            style: TextStyle( // Changed from const
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                                // ✅ Use dynamic theme color
                                color: theme.textTheme.bodyLarge!.color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: TextStyle( // Changed from const
                                fontSize: 16, 
                                // ❌ Old: color: Colors.black54, 
                                // ✅ New: Use dynamic theme color with opacity
                               // ✅ Replacement: Use withAlpha() or a standard color reference
                                color: theme.textTheme.bodyMedium!.color?.withAlpha((255 * 0.7).toInt())),

                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            cart.addItem(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${product.name} added to cart!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            // ✅ Use primary color from theme
                              backgroundColor: theme.colorScheme.primary), 
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
