// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/constants_colors.dart';

import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/presentation/auth/forgot_password_screen.dart';
import 'package:penny_places/presentation/auth/sign_up_screen.dart';
import 'package:penny_places/presentation/providers/signInProvider.dart';
import 'package:penny_places/presentation/screens/main_screen.dart';
import 'package:penny_places/presentation/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
      create: (_) => SignInProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.266,
            ),
            const CustomTextWidget(
              text: "Sign in",
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
                        //
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
                    obscureText: _obscureText,
                    style:
                        const TextStyle(color: Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: password,
                    keyboardType: TextInputType.name,
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
                                _toggle();
                              },
                              icon: SvgPicture.asset(
                                _obscureText
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
                        //
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const ForgotPasswordScreen();
                          },
                        ));
                      },
                      child: Text(
                        "Forget Password?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: ConstantsColors.blueColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.066,
            ),

            Consumer<SignInProvider>(
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
                          } else {
                            await provider.signInUser(
                              email.text,
                              password.text,
                            );
                            if (provider.signInModel.status == "success") {
                              print("successful");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const MainScreen();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFFF65734),
                                  content: Text(
                                    provider.signInModel.message.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
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
                                      'Log In',
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




            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushReplacement(context, MaterialPageRoute(
            //       builder: (BuildContext context) {
            //         return const MainScreen();
            //       },
            //     ));
            //   },
            //   // onTap: () async {
            //   //   print("Pressed");
            //   //   if (email.text.isEmpty && password.text.isEmpty) {
            //   //     ScaffoldMessenger.of(context).showSnackBar(
            //   //       const SnackBar(
            //   //         backgroundColor: Color(0xFFF65734),
            //   //         content: Text(
            //   //           'Please Enter Email and Password',
            //   //           style: TextStyle(
            //   //             fontSize: 16,
            //   //             fontWeight: FontWeight.w300,
            //   //             fontFamily: "Satoshi",
            //   //           ),
            //   //         ),
            //   //       ),
            //   //     );
            //   //   } else {
            //   //     setState(() {
            //   //       isLoading = true;
            //   //     });
            //   //     await signinUser();
            //   //     if (loginUserModels.status == "success") {
            //   //       print("successful");

            //   //       prefs = await SharedPreferences.getInstance();
            //   //       // await prefs?.setString('userID',
            //   //       //     "${loginUserModels.data?.passportHolderId}");
            //   //       String userID =
            //   //           loginUserModels.data?.passportHolderId ?? "";
            //   //       await prefs?.setString('userID', userID);

            //   //       print("Sign in userID$userID");
            //   //       Navigator.push(
            //   //         context,
            //   //         MaterialPageRoute(
            //   //           builder: (BuildContext context) {
            //   //             return MainScreen(
            //   //               userId: userID,
            //   //             );
            //   //           },
            //   //         ),
            //   //       );
            //   //     } else if (loginUserModels.status != "success") {
            //   //       ScaffoldMessenger.of(context).showSnackBar(
            //   //         SnackBar(
            //   //           backgroundColor: const Color(0xFFF65734),
            //   //           content: Text(
            //   //             loginUserModels.message.toString(),
            //   //             style: const TextStyle(
            //   //               fontSize: 16,
            //   //               fontWeight: FontWeight.w300,
            //   //               fontFamily: "Satoshi",
            //   //             ),
            //   //           ),
            //   //         ),
            //   //       );
            //   //     }
            //   //   }

            //   //   setState(() {
            //   //     isLoading = false;
            //   //   });
            //   // },
            //   child: Container(
            //     width: 197,
            //     height: 48,
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 43, vertical: 10),
            //     clipBehavior: Clip.antiAlias,
            //     decoration: ShapeDecoration(
            //       color: ConstantsColors.blueColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //     ),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           width: double.infinity,
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Log In',
            //                 style: GoogleFonts.poppins(
            //                   color: Colors.white,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w500,
            //                   height: 0,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.226,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: "Doesn't have an account? ",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5, // Adjusted height for better spacing
                  ),
                  children: [
                    TextSpan(
                      text: "Sign Up",
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
                              return const SignUpScreen();
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
