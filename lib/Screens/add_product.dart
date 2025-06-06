import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import '../models/product.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subCategoryController = TextEditingController();
  String _category = 'leather-goods';
  File? _imageFile;
  bool _isLoading = false;

  final List<String> _categories = [
    'leather-goods',
    'fragrance',
    'accessories'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _subCategoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    final permissionStatus = await permission.request();
    if (permissionStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${source == ImageSource.camera ? 'Camera' : 'Gallery'} permission denied')),
      );
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _saveImage() async {
    if (_imageFile == null) return null;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageName = 'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imagePath = '${directory.path}/images/$imageName';
      final imageDir = Directory('${directory.path}/images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }
      await _imageFile!.copy(imagePath);
      // Return asset-like path for JSON
      return 'assets/images/$imageName';
    } catch (e) {
      print('Error saving image: $e');
      return null;
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final imagePath = await _saveImage();
    if (imagePath == null && _imageFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save image')),
      );
      setState(() => _isLoading = false);
      return;
    }

    final product = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      imagePath: imagePath ?? 'assets/images/placeholder.jpg',
      price: 'LKR ${_priceController.text}.00',
      description: _descriptionController.text,
      subCategory: _subCategoryController.text,
    );

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data/$_category.json');
      final fileDir = Directory('${directory.path}/data');
      if (!await fileDir.exists()) {
        await fileDir.create(recursive: true);
      }

      List<Product> existingProducts = [];
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> data = jsonDecode(jsonString);
        existingProducts = data.map((json) => Product.fromJson(json)).toList();
      }

      existingProducts.add(product);
      final jsonString =
          jsonEncode(existingProducts.map((p) => p.toJson()).toList());
      await file.writeAsString(jsonString);

      // Refresh ProductNotifier
      ref.read(productProvider(_category).notifier).fetchProducts();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Product added successfully! Copy ${file.path} to assets/data/$_category.json and image to assets/images/')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error saving product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save product')),
      );
    } finally {
      setState(() => (_isLoading = false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product", style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Details",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Enter product name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter product name" : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: "Price (LKR, without LKR or .00)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter price" : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter description" : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _subCategoryController,
                  decoration: const InputDecoration(
                    labelText: "Sub Category",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter sub category" : null,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.replaceAll('-', ' ')),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Product Image",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 100.h,
                        width: 100.w,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image),
                      ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Camera"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library),
                        label: const Text("Gallery"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _saveProduct,
                        child: Text(
                          "Save Product",
                          style: GoogleFonts.poppins(fontSize: 16.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 0),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
