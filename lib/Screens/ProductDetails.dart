import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_screen.dart';
import '../Providers/cart_provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;
  final String productId; // Changed to String

  const ProductDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

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
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
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
            ElevatedButton(
              onPressed: () async {
                await ref.read(cartProvider.notifier).addToCart(productId, 1);
                if (cartState.error == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(cartState.error!)),
                  );
                }
              },
              child: Text(
                'Add to Cart',
                style: GoogleFonts.roboto(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}