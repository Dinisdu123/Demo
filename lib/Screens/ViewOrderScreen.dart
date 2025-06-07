import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../Services/database_helper.dart';
import '../Models/order.dart';

class ViewOrdersScreen extends StatefulWidget {
  const ViewOrdersScreen({super.key});

  @override
  State<ViewOrdersScreen> createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = DatabaseHelper.instance.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            );
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No orders found',
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: ExpansionTile(
                  title: Text(
                    'Order by ${order.name}',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  subtitle: Text(
                    'Total: LKR ${order.total.toStringAsFixed(2)} | ${order.timestamp.toString().substring(0, 16)}',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, color: theme.colorScheme.onSurface),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID: ${order.userId}',
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Phone: ${order.phone}',
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Address: ${order.address}',
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Payment Method: ${order.paymentMethod}',
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Items:',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ...order.items.map((item) => ListTile(
                                dense: true,
                                title: Text(
                                  item.title,
                                  style: GoogleFonts.poppins(fontSize: 12.sp),
                                ),
                                subtitle: Text(
                                  'Qty: ${item.quantity} | ${item.price.replaceAll('\$', 'LKR ')}',
                                  style: GoogleFonts.poppins(fontSize: 10.sp),
                                ),
                              )),
                          if (order.receiptImagePath != null) ...[
                            SizedBox(height: 8.h),
                            Text(
                              'Receipt Image:',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Image.file(
                              File(order.receiptImagePath!),
                              height: 100.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) => Text(
                                'Image not found',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
