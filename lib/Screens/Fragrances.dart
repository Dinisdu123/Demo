import 'package:assingment/Screens/ProductDetails.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class Fragrances extends ConsumerWidget {
  const Fragrances({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider('fragrance'));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fragrances"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(productProvider('fragrance'));
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No fragrances available'));
          }

          // Group products by category (mens, ladies)
          final mensFragrances =
              products.where((p) => p.subCategory == 'mens').toList();
          final ladiesFragrances =
              products.where((p) => p.subCategory == 'ladies').toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Men's Section
                if (mensFragrances.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Men's Fragrances",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mensFragrances.length,
                    itemBuilder: (context, index) {
                      final product = mensFragrances[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
                // Ladies' Section
                if (ladiesFragrances.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Ladies' Fragrances",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ladiesFragrances.length,
                    itemBuilder: (context, index) {
                      final product = ladiesFragrances[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
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
                onPressed: () => ref.refresh(productProvider('fragrance')),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(currentIndex: 1),
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
