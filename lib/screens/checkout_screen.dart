import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/price_utils.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: cart.items.isEmpty
            ? const Center(child: Text('Your cart is empty!'))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (ctx, i) {
                          final item = cart.items.values.toList()[i];
                          final price = parsePrice(item.product.price);

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Image.network(
                                item.product.imageUrl,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item.product.name),
                              subtitle:
                                  Text('${item.quantity} x ${formatPricePKR(price)}'),
                              trailing: Text(
                                formatPricePKR(price * item.quantity),
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement final checkout action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text('Place Order'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
