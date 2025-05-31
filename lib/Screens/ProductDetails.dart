import 'package:flutter/material.dart';
  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  class ProductDetailsScreen extends StatelessWidget {
    final String imageUrl;
    final String title;
    final String price;
    final String description;

    const ProductDetailsScreen({
      super.key,
      required this.imageUrl,
      required this.title,
      required this.price,
      required this.description,
    });

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
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
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                price,
                style: TextStyle(fontSize: 20.sp, color: Colors.green),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      );
    }
  }