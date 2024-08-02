import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/presentation/auth/reset_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String? otp;
  final String? email;
  const OtpScreen({super.key, this.otp, this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otp = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  // @override
  // void dispose() {
  //   errorController?.close();
  //   _otp.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: 258,
              child: Text(
                'Password Reset',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            addHeight(6),
            SizedBox(
              width: 245,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'A code is forwarded to ',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF888888),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Developers@pennyPlaces.com',
                      style: GoogleFonts.poppins(
                        color: ConstantsColors.blueColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              width: 330,
              child: Opacity(
                opacity: 0.50,
                child: Text(
                  'Please enter 4-digit OTP code here, after confirmation you can create new password.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    height: 1.50,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 45),
                child: PinCodeTextField(
                  textStyle: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                  ),
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: '*',

                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    disabledColor: Colors.white,
                    inactiveColor: const Color(0xFFF3F3F3),
                    selectedColor: const Color(0xFF7A3027).withOpacity(0.5),
                    // inactiveFillColor: Color(0xFFF3F3F3),
                    //inactiveFillColor: Colors.white,
                    activeColor: const Color(0xFFF3F3F3),
                    shape: PinCodeFieldShape.box,

                    borderWidth: 1,
                    // activeFillColor: Colors.green.shade600,

                    //activeColor: Colors.green.shade600,

                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 52,
                    fieldWidth: 52,
                  ),

                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),

                  errorAnimationController: errorController,
                  controller: _otp,
                  keyboardType: TextInputType.number,

                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");

                    return true;
                  },
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

            GestureDetector(
              onTap: () {
                if (_otp.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please enter OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Satoshi",
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                } else if (_otp.text != widget.otp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please enter correct OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Satoshi",
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "OTP verified",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Satoshi",
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ResetPassword(
                        email: widget.email,
                        //                              emailId: _emailController.text ?? "",
                      );
                    },
                  ));
                }
              },
              child: Container(
                width: 197,
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 43, vertical: 10),
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
            ),
            addHeight(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Don’t Received Email? ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  children: [
                    TextSpan(
                      text: "Resend",
                      style: GoogleFonts.poppins(
                        color: ConstantsColors.blueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(
                          //   builder: (BuildContext context) {
                          //     return const SignUpScreen();
                          //   },
                          // ));
                        },
                    ),
                  ],
                ),
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         onTap: () async {
            //           if (_otp.text.isEmpty) {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                 content: Text(
            //                   "Please enter OTP",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontFamily: "Satoshi",
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //             );
            //           } else if (_otp.text != widget.otp) {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                 content: Text(
            //                   "Please enter correct OTP",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontFamily: "Satoshi",
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //             );
            //           } else {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                 content: Text(
            //                   "OTP verified",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontFamily: "Satoshi",
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //             );
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (BuildContext context) {
            //     return CreatePassword(
            //       otp: widget.otp,
            //       email: widget.email,
            //       //                              emailId: _emailController.text ?? "",
            //     );
            //   },
            // ));
            //           }
            //         },
            //         child: Container(
            //           height: 48,
            //           width: MediaQuery.of(context).size.width * 0.93,
            //           decoration: BoxDecoration(
            //             gradient: const LinearGradient(
            //               colors: [Color(0xFFF65734), Color(0xFFFF8D74)],
            //               begin: Alignment.bottomCenter,
            //               end: Alignment.topCenter,
            //             ),
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //           child: const Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 "Confirm",
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
