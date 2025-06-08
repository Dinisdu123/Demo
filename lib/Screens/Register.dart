import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assingment/Screens/Login.dart';
import 'package:assingment/Screens/HomePage.dart';
import '../providers/auth_provider.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
              Image.asset('assets/images/luxury_software.jpg',
                  height: 100.h, fit: BoxFit.contain),
              SizedBox(height: 20.h),
            
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        prefixIcon: const Icon(Icons.person),
                        labelStyle: GoogleFonts.poppins(fontSize: 16.sp),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[100]
                                : Colors.grey[800],
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        prefixIcon: const Icon(Icons.email),
                        labelStyle: GoogleFonts.poppins(fontSize: 16.sp),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[100]
                                : Colors.grey[800],
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your email'
                          : (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)
                              ? 'Please enter a valid email'
                              : null),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        labelStyle: GoogleFonts.poppins(fontSize: 16.sp),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[100]
                                : Colors.grey[800],
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your password'
                          : (value.length < 8
                              ? 'Password must be at least 8 characters'
                              : null),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _passwordConfirmController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () => setState(() =>
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible),
                        ),
                        labelStyle: GoogleFonts.poppins(fontSize: 16.sp),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[100]
                                : Colors.grey[800],
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please confirm your password'
                          : (value != _passwordController.text
                              ? 'Passwords do not match'
                              : null),
                    ),
                    SizedBox(height: 10.h),
                    if (authState.error != null)
                      Text(authState.error!,
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 14.sp),
                          textAlign: TextAlign.center),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref.read(authProvider.notifier).register(
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text,
                              );
                          if (ref.read(authProvider).isAuthenticated) {
                            Navigator.pushReplacement(
                                context, _createRoute(MyHomePage()));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text('Register',
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login())),
                      child: Text('Already have an account? Login Now',
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Theme.of(context).primaryColor)),
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
