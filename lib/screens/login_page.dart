import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/widget/auth_input_widget.dart';
import 'package:attendance_app/screens/widget/gradient_button_square.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool keepMeloggedin = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ResizeImage(const AssetImage('assets/images/home_bg.png'),
                  height: MediaQuery.sizeOf(context).height.toInt(),
                  width: MediaQuery.sizeOf(context).width.toInt()),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(style.insets.xl),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fingerprint,
                          size: style.icon.xl - 20,
                          color: AppColors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Login',
                            style: style.text.h1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                    child: Text(
                      'Email ID*',
                      textAlign: TextAlign.start,
                      style: style.text.titleMd,
                    ),
                  ),
                  InputWidget(
                      textCapitalization: TextCapitalization.sentences,
                      isPassword: false,
                      controller: emailController,
                      placeholder: 'Enter Email ID',
                      focusNode: emailFocus,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'please enter a valid email';
                        }
                        return null;
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                    child: Text(
                      'Password*',
                      textAlign: TextAlign.start,
                      style: style.text.titleMd,
                    ),
                  ),
                  InputWidget(
                      textCapitalization: TextCapitalization.none,
                      isPassword: true,
                      controller: passwordController,
                      placeholder: 'Please enter password',
                      focusNode: passwordFocus,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your email';
                        } else if (value.length < 4) {
                          return 'please enter a valid password';
                        }
                        return null;
                      }),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: keepMeloggedin,
                          trackOutlineColor:
                              const WidgetStatePropertyAll(AppColors.grey),
                          trackColor:
                              const WidgetStatePropertyAll(AppColors.white),
                          inactiveThumbColor: AppColors.blue,
                          thumbColor:
                              const WidgetStatePropertyAll(AppColors.blue),
                          onChanged: (value) {
                            setState(() {
                              keepMeloggedin = !keepMeloggedin;
                            });
                          },
                        ),
                      ),
                      // Gap(style.insets.sm),
                      Text(
                        'Keep me logged in',
                        style: style.text.bodyContent,
                      )
                    ],
                  ),
                  Gap(style.insets.lg),
                  GradientButtonSquare(
                      text: 'LOGIN',
                      onClick: () {
                        if (formkey.currentState!.validate()) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'tabs',
                            (route) => false,
                          );
                        }
                      }),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: style.insets.lg),
                      child: Row(
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: style.text.bodyContent
                                .copyWith(color: AppColors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: Text('signup',
                                style: style.text.bodyContent
                                    .copyWith(color: AppColors.blue)),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
