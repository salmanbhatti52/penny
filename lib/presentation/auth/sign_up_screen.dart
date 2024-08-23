// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/presentation/auth/sign_in_screen.dart';
import 'package:penny_places/presentation/providers/signUpProvider.dart';
import 'package:penny_places/presentation/widgets/custom_text_widget.dart';
import 'package:penny_places/presentation/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  bool isLoading = false;
  bool _obscureText0 = true;
  bool _obscureText1 = true;
  void _toggle0() {
    setState(() {
      _obscureText0 = !_obscureText0;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(_onFocusChange);
    _focusNode2.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode1.removeListener(_onFocusChange);
    _focusNode1.dispose();
    _focusNode2.removeListener(_onFocusChange);
    _focusNode2.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.169,
            ),
            const CustomTextWidget(
              text: "Sign Up",
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.038,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true, // Add this line
                      fillColor: const Color(0xFFF4F4F4),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/svg/user.svg',
                          width: 23,
                          height: 23,
                          color: const Color(0xFF7F8C8D),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFFEEEEEE)), // change border color
                      ),

                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onSaved: (value) {
                      email = value!.trim() as TextEditingController;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            addHeight(18),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: email,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true, // Add this line
                      fillColor: const Color(0xFFF4F4F4),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/svg/sms.svg',
                          width: 23,
                          height: 23,
                          color: const Color(0xFF7F8C8D),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFFEEEEEE)), // change border color
                      ),

                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your email address';
                      } else if (isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!.trim() as TextEditingController;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            addHeight(18),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: _obscureText0,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      filled: true, // Add this line
                      fillColor: const Color(0xFFF4F4F4),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/svg/lock.svg',
                          width: 23,
                          height: 23,
                          color: const Color(0xFF7F8C8D),
                        ),
                      ),
                      suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _toggle0();
                              },
                              icon: SvgPicture.asset(
                                _obscureText0
                                    ? 'assets/svg/eye1.svg'
                                    : 'assets/svg/eye0.svg',
                                width: 24,
                                height: 24,
                              ),
                            )
                          ]),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFFEEEEEE)), // change border color
                      ),
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            addHeight(18),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: _obscureText1,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      filled: true, // Add this line
                      fillColor: const Color(0xFFF4F4F4),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/svg/lock.svg',
                          width: 23,
                          height: 23,
                          color: const Color(0xFF7F8C8D),
                        ),
                      ),
                      suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _toggle1();
                              },
                              icon: SvgPicture.asset(
                                _obscureText1
                                    ? 'assets/svg/eye1.svg'
                                    : 'assets/svg/eye0.svg',
                                width: 24,
                                height: 24,
                              ),
                            )
                          ]),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // labelText: 'Email',
                      hintText: "Confirm Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFFEEEEEE)), // change border color
                      ),
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.048,
            ),
            Consumer<SignUpProvider>(
              builder: (context, provider, child) {
                return provider.isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ConstantsColors.blueColor),
                      )
                    : GestureDetector(
                        onTap: () async {
                          print("Pressed");
                          if (email.text.isEmpty && password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFFF65734),
                                content: Text(
                                  'Please Enter Email and Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            );
                          } else if (confirmPassword.text != password.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFFF65734),
                                content: Text(
                                  'Confirm Password Mic Match',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            await provider.signUpUser(
                              email.text,
                              password.text,
                              name.text,
                            );
                            if (provider.signUpModel.status == "success") {
                              print("successful");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const SignInScreen();
                                  },
                                ),
                              );
                              CustomToast.show(
                                  "Your account created successfully",
                                  Colors.green);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFFF65734),
                                  content: Text(
                                    provider.signUpModel.message.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Satoshi",
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: 197,
                          height: 48,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: ConstantsColors.blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Create Account',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.249,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5, // Adjusted height for better spacing
                  ),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: GoogleFonts.poppins(
                        color: ConstantsColors.blueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5, // Adjusted height for better spacing
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const SignInScreen();
                            },
                          ));
                        },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ]),
        ),
      ),
    );
  }
}
