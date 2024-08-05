import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penny_places/core/constants/constants_colors.dart';

import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/providers/changePassProvider.dart';
import 'package:penny_places/presentation/screens/main_screen.dart';
import 'package:penny_places/presentation/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  bool isLoading = false;
  bool _obscureText0 = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
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

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordProvider(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Change Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          body: Column(
            children: [
              const Center(
                child: Text(
                  'Must be at least 8 Chracters',
                  style: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              addHeight(50),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: _obscureText0,
                      style: const TextStyle(
                          color: Color(0xFF000000), fontSize: 16),
                      cursorColor: const Color(0xFF000000),
                      controller: oldPassword,
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
                        hintText: "Enter Old Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFEEEEEE)), // change border color
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFF7F8C8D),
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
                    width: 15,
                  ),
                ],
              ),
              addHeight(18),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: _obscureText1,
                      style: const TextStyle(
                          color: Color(0xFF000000), fontSize: 16),
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
                        hintText: "Create New Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFEEEEEE)), // change border color
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFF7F8C8D),
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
                    width: 15,
                  ),
                ],
              ),
              addHeight(18),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: _obscureText2,
                      style: const TextStyle(
                          color: Color(0xFF000000), fontSize: 16),
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
                                  _toggle2();
                                },
                                icon: SvgPicture.asset(
                                  _obscureText2
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
                        hintText: "Create New Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFEEEEEE)), // change border color
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFF7F8C8D),
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
                    width: 15,
                  ),
                ],
              ),
              addHeight(44),
              Consumer<ChangePasswordProvider>(
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
                            if (oldPassword.text.isEmpty &&
                                confirmPassword.text.isEmpty &&
                                password.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xFFF65734),
                                  content: Text(
                                    'Please Put the Passwords',
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
                                    'Confirm Password Mis Matched',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              await provider.changePassword(
                                "$email",
                                oldPassword.text,
                                password.text,
                                confirmPassword.text,
                              );
                              if (provider.changePasswordModel.status ==
                                  "success") {
                                print("successful");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const MainScreen();
                                    },
                                  ),
                                );
                                CustomToast.show(
                                    "Password has been changed successfully",
                                    Colors.green);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xFFF65734),
                                    content: Text(
                                      provider.changePasswordModel.message
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
                            child: const Column(
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
                                        'Change Password',
                                        style: TextStyle(
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
            ],
          )),
    );
  }
}
