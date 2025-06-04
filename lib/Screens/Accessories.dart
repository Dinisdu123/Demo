import 'package:assingment/Screens/ProductDetails.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:assingment/Screens/cart_screen.dart'; // Import CartScreen
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class Accessories extends ConsumerWidget {
  const Accessories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider('accessories'));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accessories"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(productProvider('accessories'));
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No accessories available'));
          }

          final jewellery =
              products.where((p) => p.subCategory == 'jewellery').toList();
          final footwear =
              products.where((p) => p.subCategory == 'footwear').toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (jewellery.isNotEmpty)
                  _buildCategorySection(context, 'Jewellery', jewellery),
                if (footwear.isNotEmpty)
                  _buildCategorySection(context, 'Footwear', footwear),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(productProvider('accessories')),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(currentIndex: 1),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, String title, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductCard(context, product);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: product.imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          Text(product.name, textAlign: TextAlign.center),
          Text(product.price),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    imageUrl: product.imageUrl,
                    title: product.name,
                    price: product.price,
                    description: product.description,
                    productId: product.id, // Convert productId to int
                  ),
                ),
              );
            },
            child: const Text("See more ->"),
          ),
        ],
      ),
    );
  }
}