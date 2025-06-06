import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assingment/Screens/AboutUs.dart';
import 'package:assingment/Screens/Login.dart';
import 'package:assingment/Screens/bottomNav.dart';
import 'package:assingment/Screens/HomePage.dart';
import '../providers/auth_provider.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aurora Luxe"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: authState.isAuthenticated && authState.user != null
                ? Column(
                    children: [
                      Text(
                        authState.user!.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (authState.error != null)
                        Text(
                          authState.error!,
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () async {
                          await ref.read(authProvider.notifier).logout();
                          final newAuthState = ref.read(authProvider);
                          if (!newAuthState.isAuthenticated) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                              (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "LOG OUT",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200.w, 40.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "SIGN IN OR REGISTER",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          const Expanded(child: _AccountCateg()),
        ],
      ),
      bottomNavigationBar: const Footer(currentIndex: 3),
    );
  }
}

class _AccountCateg extends StatelessWidget {
  const _AccountCateg();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              const Icon(Icons.shopping_bag_outlined),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  "Orders",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24.sp,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              const Icon(Icons.help_outline),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  "Help",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24.sp,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  "About Us",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Aboutus()),
                  );
                },
                icon: const Icon(Icons.arrow_forward_outlined),
                color: Theme.of(context).iconTheme.color,
                iconSize: 24.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
