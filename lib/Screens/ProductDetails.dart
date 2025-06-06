import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(imagePath),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              price,
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              style: GoogleFonts.roboto(fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            FutureBuilder<bool>(
              future: ref.read(cartProvider.notifier).isInCart(productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final isInCart = snapshot.data ?? false;
                return ElevatedButton.icon(
                  onPressed: () async {
                    if (isInCart) {
                      await ref
                          .read(cartProvider.notifier)
                          .removeFromCart(productId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Removed from Cart')),
                      );
                    } else {
                      await ref.read(cartProvider.notifier).addToCart(
                            productId: productId,
                            title: title,
                            imagePath: imagePath,
                            price: price,
                            description: description,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to Cart'),
                        ),
                      );
                    }
                  },
                  icon: Icon(isInCart
                      ? Icons.remove_shopping_cart
                      : Icons.add_shopping_cart),
                  label: Text(
                    isInCart ? 'Remove from Cart' : 'Add to Cart',
                    style: GoogleFonts.roboto(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isInCart ? Colors.grey : Theme.of(context).primaryColor,
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image(
        image: AssetImage(imagePath),
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return Image(
        image: FileImage(File(imagePath)),
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }
}
