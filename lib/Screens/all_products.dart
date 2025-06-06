import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'productDetails.dart';
import 'bottomNav.dart';

class AllProducts extends ConsumerStatefulWidget {
  const AllProducts({super.key});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends ConsumerState<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final categories = ['fragrance', 'leather-goods', 'accessories'];
    final productFutures = categories
        .map((category) => ref.watch(productProvider(category)))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              for (var category in categories) {
                ref.refresh(productProvider(category));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final productsAsync = productFutures[index];

          return productsAsync.when(
            data: (products) {
              if (products.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No ${category.replaceAll('-', ' ')} available',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }

              final subCategories =
                  products.map((p) => p.subCategory).toSet().toList()..sort();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      category.replaceAll('-', ' ').toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...subCategories.map((subCategory) {
                    final subCategoryProducts = products
                        .where((p) => p.subCategory == subCategory)
                        .toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (subCategory != 'unknown')
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              subCategory.replaceAll('-', ' ').toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
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
                          itemCount: subCategoryProducts.length,
                          itemBuilder: (context, index) {
                            final product = subCategoryProducts[index];
                            return _buildProductCard(context, product);
                          },
                        ),
                      ],
                    );
                  }),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Error loading $category: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.refresh(productProvider(category)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const Footer(currentIndex: 1),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildProductImage(product.imagePath),
          const SizedBox(height: 8),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(product.price),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    productId: product.id,
                    imagePath: product.imagePath,
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

  Widget _buildProductImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image(
        image: AssetImage(imagePath),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return Image(
        image: FileImage(File(imagePath)),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }
}
