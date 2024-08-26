import 'dart:ui';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/bloc/signin_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            Navigator.of(context).pushReplacementNamed('/');

            // Handle success, e.g., navigate to another screen
          } else if (state is SigninFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to sign in")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF3F51F3)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text(
                        "ECOM",
                        style: GoogleFonts.caveatBrush(
                          fontSize: 48,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF3F51F3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19),
                      child: Text(
                        "Sign into your account",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24.72,
                            color: const Color(0xFF000000)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 29),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Text(
                              "Email",
                              style: GoogleFonts.poppins(
                                  color: const Color(0XFF6F6F6F),
                                  fontWeight: FontWeight.w400),
                            )),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: SizedBox(
                            width: 288,
                            height: 42,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'ex: jon.smith@gmail.com',
                                hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0XFF888888)),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: const Color(0xFFFAFAFA),
                              ),
                              onChanged: (value) => _email = value,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter your email' : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 19),
                          child: Text(
                            'Password',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6F6F6F),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: SizedBox(
                            width: 288,
                            height: 42,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '........',
                                hintStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0XFF888888)),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: const Color(0xFFFAFAFA),
                              ),
                              onChanged: (value) => _password = value,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter your password' : null,
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(height: 20),
                  BlocBuilder<SigninBloc, SigninState>(
                    builder: (context, state) {
                      if (state is SigninLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SigninBloc>().add(
                                          SigninButtonPressed(
                                            password: _password,
                                            email: _email,
                                          ),
                                        );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: const Color(0xFF3F51F3),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: Text(
                                  'SIGN IN',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 110),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF888888)),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Don't have an account?",
                                    ),
                                    TextSpan(
                                        text: "SIGN UP",
                                        style: TextStyle(
                                            color: const Color(0xFF3F51F3)),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .pushNamed("/signup");
                                          })
                                  ]),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
