import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/presentation/auth/otp_screen.dart';
import 'package:penny_places/presentation/providers/forgetPasswordProvider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgetPasswordProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 258,
                  child: Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              addHeight(6),
              Text(
                'No worries, we’ll send you reset Instructions',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF888888),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              addHeight(19),
              Center(
                child: SvgPicture.asset(
                  'assets/svg/question1.svg',
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                          color: Color(0xFF000000), fontSize: 16),
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
                    width: 15,
                  ),
                ],
              ),
              addHeight(30),
              Consumer<ForgetPasswordProvider>(
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
                            if (email.text.isEmpty) {
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
                              await provider.forgetPasswordUser(
                                email.text,
                              );
                              if (provider.forgetPasswordModel.status ==
                                  "success") {
                                print("successful");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return OtpScreen(
                                          email: email.text,
                                          otp: provider
                                              .forgetPasswordModel.data!.otp
                                              .toString());
                                    },
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xFFF65734),
                                    content: Text(
                                      provider.forgetPasswordModel.message
                                          .toString(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Continue',
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
              //     Navigator.push(context, MaterialPageRoute(
              //       builder: (BuildContext context) {
              //         return const OtpScreen(
              //           email: "widget.email",
              //           //
              //         );
              //       },
              //     ));
              //   },
              //   child: Container(
              //     width: 197,
              //     height: 48,
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
              //                 'Reset Password',
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
              // )
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  TextEditingController email = TextEditingController();
}
