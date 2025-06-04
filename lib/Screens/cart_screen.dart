import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: cartState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartState.error != null
              ? Center(
                  child: Text(
                    'Error: ${cartState.error}',
                    style: GoogleFonts.roboto(),
                  ),
                )
              : cartState.items.isEmpty
                  ? Center(
                      child: Text(
                        'Your cart is empty',
                        style: GoogleFonts.roboto(),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () =>
                          ref.read(cartProvider.notifier).fetchCartItems(),
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.0.w),
                        itemCount: cartState.items.length,
                        itemBuilder: (context, index) {
                          final item = cartState.items[index];
                          return Card(
                            child: ListTile(
                              leading: item.product.imageUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: item.product.imageUrl!,
                                      width: 50.w,
                                      height: 50.h,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(Icons.image_not_supported),
                              title: Text(
                                item.product.name,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price: \$${item.product.price}',
                                    style: GoogleFonts.roboto(),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            ref
                                                .read(cartProvider.notifier)
                                                .updateCartItem(
                                                  item.id,
                                                  item.quantity - 1,
                                                );
                                          }
                                        },
                                      ),
                                      Text(
                                        'Qty: ${item.quantity}',
                                        style: GoogleFonts.roboto(),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .updateCartItem(
                                                item.id,
                                                item.quantity + 1,
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
                                    .deleteCartItem(item.id),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
