import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/UI/views/list_item_view.dart';
import 'package:kasirku_mobile/bloc/auth/auth_bloc.dart';
import 'package:kasirku_mobile/models/login_form_model.dart';
import 'package:kasirku_mobile/shared/shared_method.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class LoginView extends StatefulWidget {
  static const routeName = "/";
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  final _keyState = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;
  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    this.emailController;
    this.passwordController;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailure) {
            showCustomSnacKbar(context, state.message);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, ListItemView.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return SafeArea(
              child: Container(
            padding: const EdgeInsets.all(24),
            // color: Colors.blue,
            width: double.infinity,
            height: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              width: double.infinity,
                              height: 240,
                              child: Image.asset(
                                "assets/login_image.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 32,
                                    ),
                                  )
                                ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Form(
                                      key: _keyState,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: TextFormField(
                                              controller: emailController,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                return !EmailValidator.validate(
                                                        value.toString())
                                                    ? "Please include '@' in the email address "
                                                    : null;
                                              },
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.email),
                                                  label: Text(
                                                    "Email",
                                                    style: primaryTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .grey.shade500),
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              obscureText: _passwordVisible,
                                              autofocus: false,
                                              controller: passwordController,
                                              validator: (value) {
                                                return value.toString().length <
                                                        4
                                                    ? "Password must at least 4 characters"
                                                    : null;
                                              },
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.lock),
                                                  label: Text("Password",
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _passwordVisible
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _passwordVisible =
                                                            !_passwordVisible;
                                                      });
                                                    },
                                                  )),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                                height: 44,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor: Color(
                                                            0XFF2D31FA)),
                                                    onPressed: (() async {
                                                      if (validate()) {
                                                        context
                                                            .read<AuthBloc>()
                                                            .add(AuthLogin(
                                                                emailController
                                                                    .text,
                                                                passwordController
                                                                    .text));
                                                      } else {
                                                        showCustomSnacKbar(
                                                            context,
                                                            "Semua form harus diisi!");
                                                      }
                                                    }),
                                                    child: Text(
                                                        "Login",
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color:
                                                                    whiteColor,
                                                                fontSize:
                                                                    16)))),
                                            SizedBox(
                                              height: 12,
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              )),
                        ]),
                  )),
                ]),
          ));
        },
      ),
    );
  }
}
