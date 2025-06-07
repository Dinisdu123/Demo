import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/cart_provider.dart';
import '../Screens/ProductDetails.dart';
import 'bottomNav.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  // Helper function to calculate the total cart value
  double _calculateCartTotal(List items) {
    double total = 0.0;
    for (var item in items) {
      // Remove any non-numeric characters (e.g., '$') and parse the price
      final priceStr = item.price.replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceStr) ?? 0.0;
      total += price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_sweep,
              color: theme.colorScheme.error, // Theme-aware error color
            ),
            onPressed: () async {
              await ref.read(cartProvider.notifier).clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Cart cleared',
                    style: TextStyle(color: theme.colorScheme.onSurface),
                  ),
                  backgroundColor: theme.colorScheme.surface,
                ),
              );
            },
          ),
        ],
      ),
      body: cartAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty',
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                color: theme.colorScheme.surface, // Theme-aware card color
                child: ListTile(
                  leading: _buildCartImage(item.imagePath),
                  title: Text(
                    item.title,
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.price
                            .replaceAll('\$', 'LKR '), // Replace $ with LKR
                        style: GoogleFonts.roboto(
                          color: theme.colorScheme.primary, // Theme-aware color
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            color: theme.colorScheme.onSurface,
                            onPressed: () async {
                              await ref
                                  .read(cartProvider.notifier)
                                  .updateQuantity(
                                      item.productId, item.quantity - 1);
                            },
                          ),
                          Text(
                            item.quantity.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: theme.colorScheme.onSurface,
                            onPressed: () async {
                              await ref
                                  .read(cartProvider.notifier)
                                  .updateQuantity(
                                      item.productId, item.quantity + 1);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: theme.colorScheme.error, // Theme-aware error color
                    ),
                    onPressed: () async {
                      await ref
                          .read(cartProvider.notifier)
                          .removeFromCart(item.productId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Removed from Cart',
                            style:
                                TextStyle(color: theme.colorScheme.onSurface),
                          ),
                          backgroundColor: theme.colorScheme.surface,
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          productId: item.productId,
                          imagePath: item.imagePath,
                          title: item.title,
                          price: item.price,
                          description: item.description,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error: $error',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display cart total and checkout button
          cartAsync.when(
            data: (items) {
              final total = _calculateCartTotal(items);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                color: theme
                    .colorScheme.surfaceContainer, // Theme-aware background
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'LKR ${total.toStringAsFixed(2)}',
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        ElevatedButton(
                          onPressed: items.isEmpty
                              ? null
                              : () {
                                  // Placeholder checkout action
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Proceeding to checkout...',
                                        style: TextStyle(
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      backgroundColor:
                                          theme.colorScheme.surface,
                                    ),
                                  );
                                  // TODO: Add actual checkout logic (e.g., navigate to checkout screen)
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          child: Text(
                            'Checkout',
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
          // Existing Footer
          const Footer(currentIndex: 2),
        ],
      ),
    );
  }

  Widget _buildCartImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        height: 50.h,
        width: 50.w,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        height: 50.h,
        width: 50.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return Image.file(
        File(imagePath),
        height: 50.h,
        width: 50.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }
}
