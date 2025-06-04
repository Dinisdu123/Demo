import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cartState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartState.error != null
              ? Center(child: Text('Error: ${cartState.error}'))
              : cartState.items.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : RefreshIndicator(
                      onRefresh: () =>
                          ref.read(cartProvider.notifier).fetchCartItems(),
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.0.w),
                        itemCount: cartState.items.length,
                        itemBuilder: (context, index) {
                          final item = cartState.items[index];
                          final product = item['product'];
                          return Card(
                            child: ListTile(
                              leading: product['image_url'] != null
                                  ? CachedNetworkImage(
                                      imageUrl: product['image_url'],
                                      width: 50.w,
                                      height: 50.h,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(Icons.image_not_supported),
                              title: Text(product['name'] ?? 'Unknown Product'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: \$${product['price']}'),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item['quantity'] > 1) {
                                            ref
                                                .read(cartProvider.notifier)
                                                .updateCartItem(
                                                  item['id'].toString(),
                                                  item['quantity'] - 1,
                                                );
                                          }
                                        },
                                      ),
                                      Text('Qty: ${item['quantity']}'),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .updateCartItem(
                                                item['id'].toString(),
                                                item['quantity'] + 1,
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => ref
                                    .read(cartProvider.notifier)
                                    .deleteCartItem(
                                      item['id'].toString(),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
