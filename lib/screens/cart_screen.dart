import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/price_utils.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: cart.items.isEmpty
            ? const Center(child: Text('Your cart is empty!'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
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
                      subtitle: Text('${item.quantity} x ${formatPricePKR(price)}'),
                      trailing: Text(
                        formatPricePKR(price * item.quantity),
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ),
            ),
    );
  }
}
