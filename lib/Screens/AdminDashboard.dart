import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assingment/Screens/Login.dart';
import 'package:assingment/Screens/add_product.dart';
import '../providers/auth_provider.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${authState.user?.name ?? 'Admin'}",
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 20.h),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: Text("Manage Orders",
                    style: GoogleFonts.poppins(fontSize: 18.sp)),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: ListTile(
                leading: const Icon(Icons.inventory),
                title: Text("Add Product",
                    style: GoogleFonts.poppins(fontSize: 18.sp)),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProductScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: ListTile(
                leading: const Icon(Icons.people),
                title: Text("Manage Users",
                    style: GoogleFonts.poppins(fontSize: 18.sp)),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
