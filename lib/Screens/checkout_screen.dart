import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/location_service.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../Models/order.dart';
import '../Services/database_helper.dart';
import 'Login.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isLoadingAddress = false;
  String paymentMethod = 'Cash on Delivery';
  XFile? receiptImage;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    // Pre-fill name from authProvider
    final authState = ref.read(authProvider);
    if (authState.isAuthenticated && authState.user != null) {
      nameController.text = authState.user!.name;
    }
  }

  Future<void> _fetchLocation() async {
    setState(() => isLoadingAddress = true);
    final address = await LocationService.getCurrentAddress();
    setState(() {
      addressController.text = address;
      isLoadingAddress = false;
    });
  }

  double _calculateCartTotal(List items) {
    double total = 0.0;
    for (var item in items) {
      final priceStr = item.price.replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceStr) ?? 0.0;
      total += price * item.quantity;
    }
    return total;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      receiptImage = pickedFile;
    });
  }

  Future<void> _confirmOrder(String userId) async {
    final cartItems = ref.read(cartProvider).value ?? [];
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty')),
      );
      return;
    }

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (paymentMethod == 'Bank Transfer' && receiptImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a receipt image')),
      );
      return;
    }

    final total = _calculateCartTotal(cartItems);
    final orderItems = cartItems
        .map((item) => OrderItem(
              productId: item.productId,
              title: item.title,
              imagePath: item.imagePath,
              price: item.price,
              quantity: item.quantity,
            ))
        .toList();

    final order = Order(
      userId: userId,
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      items: orderItems,
      total: total,
      timestamp: DateTime.now(),
      paymentMethod: paymentMethod,
      receiptImagePath: receiptImage?.path,
    );

    try {
      await DatabaseHelper.instance.insertOrder(order);
      await ref.read(cartProvider.notifier).clearCart();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    if (!authState.isAuthenticated || authState.user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please log in to checkout',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final userId = authState.user!.id;
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                labelStyle: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                labelStyle: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: addressController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Delivery Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                labelStyle: GoogleFonts.poppins(fontSize: 14.sp),
                suffixIcon: isLoadingAddress
                    ? Padding(
                        padding: EdgeInsets.all(8.r),
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.location_on),
                        onPressed: _fetchLocation,
                      ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Payment Method',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            RadioListTile<String>(
              title: Text('Cash on Delivery',
                  style: GoogleFonts.poppins(fontSize: 14.sp)),
              value: 'Cash on Delivery',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                  receiptImage = null;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Bank Transfer',
                  style: GoogleFonts.poppins(fontSize: 14.sp)),
              value: 'Bank Transfer',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
            ),
            SizedBox(height: 12.h),
            // Bank Details (always shown)
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Details',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Account Number: 8016549001',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  Text(
                    'Account Name: NGDS Nilwala',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                  Text(
                    'Bank: Commercial Bank',
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            if (paymentMethod == 'Bank Transfer') ...[
              SizedBox(height: 12.h),
              Text(
                'Upload Receipt',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    child: Text(
                      'Camera',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    child: Text(
                      'Gallery',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              if (receiptImage != null) ...[
                SizedBox(height: 12.h),
                Image.file(
                  File(receiptImage!.path),
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
                TextButton(
                  onPressed: () => setState(() => receiptImage = null),
                  child: Text(
                    'Remove',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
            SizedBox(height: 16.h),
            Text(
              'Order Summary',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            cartAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('No items in cart'));
                }
                final total = _calculateCartTotal(items);
                return Column(
                  children: [
                    ...items.map((item) => ListTile(
                          title: Text(
                            item.title,
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                          subtitle: Text(
                            'Qty: ${item.quantity} | ${item.price.replaceAll('\$', 'LKR ')}',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        )),
                    Divider(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'LKR ${total.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
            SizedBox(height: 16.h),
            Center(
              child: ElevatedButton(
                onPressed: () => _confirmOrder(userId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Confirm Order',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
