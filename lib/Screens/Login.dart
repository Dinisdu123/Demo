import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assingment/Screens/Register.dart';
import 'package:assingment/Screens/HomePage.dart';
import 'package:assingment/Screens/AdminDashboard.dart';
import '../providers/auth_provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            children: [
              Image.asset('assets/images/luxury_software.jpg', height: 100.h, fit: BoxFit.contain),
              SizedBox(height: 20.h),
              Text(
                'Welcome to Aurora Luxe',
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                        prefixIcon: const Icon(Icons.email),
                        labelStyle: GoogleFonts.poppins(fontSize: 16.sp),
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.light ? Colors.grey[100] : Colors.grey[800],
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your email'
                          : (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
                              ? 'Please enter a valid email'
                              : null),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        labelStyle: GoogleFonts.poppins(fontSize: 16.sp),
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.light ? Colors.grey[100] : Colors.grey[800],
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your password'
                          : (value.length < 8 ? 'Password must be at least 8 characters' : null),
                    ),
                    SizedBox(height: 10.h),
                    if (authState.error != null)
                      Text(
                        authState.error!,
                        style: GoogleFonts.poppins(color: Colors.red, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref.read(authProvider.notifier).login(_emailController.text.trim(), _passwordController.text);
                          final authState = ref.read(authProvider);
                          if (authState.isAuthenticated) {
                            if (authState.user?.role == 'admin') {
                              Navigator.pushReplacement(context, _createRoute(const AdminDashboard()));
                            } else {
                              Navigator.pushReplacement(context, _createRoute(MyHomePage()));
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Register())),
                      child: Text(
                        "Don't have an account? Register",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade700 : Colors.blue.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}