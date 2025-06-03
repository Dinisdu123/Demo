import 'package:assingment/Screens/ProductDetails.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class LeatherGoods extends ConsumerWidget {
  const LeatherGoods({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider('leather-goods'));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leather Goods"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(productProvider('leather-goods'));
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
            return const Center(child: Text('No leather goods available'));
          }

          final shoulderBags =
              products.where((p) => p.subCategory == 'shoulder bags').toList();
          final miniBags =
              products.where((p) => p.subCategory == 'minibags').toList();
          final backpacks =
              products.where((p) => p.subCategory == 'backpacks').toList();
          final wallets =
              products.where((p) => p.subCategory == 'wallets').toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (shoulderBags.isNotEmpty)
                  _buildCategorySection(context, 'Shoulder Bags', shoulderBags),
                if (miniBags.isNotEmpty)
                  _buildCategorySection(context, 'Mini Bags', miniBags),
                if (backpacks.isNotEmpty)
                  _buildCategorySection(context, 'Backpacks', backpacks),
                if (wallets.isNotEmpty)
                  _buildCategorySection(context, 'Wallets', wallets),
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
                onPressed: () => ref.refresh(productProvider('leather-goods')),
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
        ListView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Disable inner scroll to let parent SingleChildScrollView handle scrolling
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: product.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(product.name),
          subtitle: Text(product.price),
          trailing: TextButton(
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
            child: const Text("See more"),
          ),
        ),
      ),
    );
  }
}
