import 'package:attendance_app/res/common_lib.dart';
import 'package:email_validator/email_validator.dart';

import 'widget/auth_input_widget.dart';
import 'widget/gradient_button_square.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  UtilService util = UtilService();

  List usagePreference = [
    {
      'text': 'Office Use',
      'value': 1,
    },
    {
      'text': 'Personal Use',
      'value': 2,
    }
  ];
  int selectedPreference = 1;

  List features = [
    {
      'text': "Time Marking",
      'value': false,
    },
    {
      'text': "Shift Managment",
      'value': false,
    },
    {
      'text': "Custome Holidays",
      'value': false,
    },
    {
      'text': "Leaves",
      'value': false,
    },
  ];

  InputDecoration inputDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.blue,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.red,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.red,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.lightGrey,
        width: 2,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ResizeImage(const AssetImage('assets/images/home_bg.png'),
                  height: MediaQuery.sizeOf(context).height.toInt(),
                  width: MediaQuery.sizeOf(context).width.toInt()),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.all(style.insets.xl),
                child: Column(
                  children: [
                    Icon(
                      Icons.fingerprint,
                      size: style.icon.xl - 20,
                      color: AppColors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Sign Up',
                        style: style.text.h1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                      width: double.infinity,
                      child: Text(
                        'Credentials*',
                        textAlign: TextAlign.start,
                        style: style.text.titleLarge,
                      ),
                    ),
                    //email
                    InputWidget(
                      validator: (value) {
                        if (value == null || value == '') {
                          emailFocus.requestFocus();
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      textCapitalization: TextCapitalization.none,
                      isPassword: false,
                      controller: emailController,
                      placeholder: 'Email Address',
                      focusNode: emailFocus,
                    ),
                    //password
                    InputWidget(
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Please enter a password';
                        }
                        if (value.length < 4) {
                          return 'Please enter a valid password';
                        } else {
                          return null;
                        }
                      },
                      focusNode: passwordFocus,
                      textCapitalization: TextCapitalization.none,
                      isPassword: true,
                      controller: passwordController,
                      placeholder: 'Password',
                    ),
                    DropDownWidget(
                      inputDecoration: inputDecoration,
                      placeholder: 'Select account type',
                      validator: (value) {
                        if (value == null) {
                          return 'please select account type';
                        }
                        return null;
                      },
                      list: const [
                        {'text': "free trail", 'value': 1},
                        {'text': "premium", 'value': 2}
                      ],
                      onChange: (value) {},
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                      width: double.infinity,
                      child: Text(
                        'Selected Features',
                        textAlign: TextAlign.start,
                        style: style.text.titleLarge,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: style.insets.lg,
                          horizontal: style.insets.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.lightGrey,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          features.length,
                          (index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  features[index]['value'] =
                                      !features[index]['value'];
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Checkbox(
                                        activeColor: AppColors.blue,
                                        value: features[index]['value'],
                                        onChanged: (value) {
                                          setState(() {
                                            features[index]['value'] =
                                                !features[index]['value'];
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      features[index]['text'],
                                      style: style.text.title
                                          .copyWith(color: AppColors.blueGrey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: style.insets.lg),
                      width: double.infinity,
                      child: Text(
                        'Usage Preference',
                        textAlign: TextAlign.start,
                        style: style.text.titleLarge,
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          listTileTheme: const ListTileThemeData(
                            horizontalTitleGap: 2,
                          )),
                      child: RadioTheme(
                        data: const RadioThemeData(
                          visualDensity: VisualDensity.comfortable,
                        ),
                        child: Row(
                          children:
                              List.generate(usagePreference.length, (index) {
                            return Expanded(
                              child: RadioListTile(
                                activeColor: AppColors.blue,
                                contentPadding: EdgeInsets.zero,
                                value: usagePreference[index]['value'],
                                groupValue: selectedPreference,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPreference = value!;
                                  });
                                },
                                title: Text(usagePreference[index]['text']),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    const Gap(30),
                    //submit button
                    SizedBox(
                      width: double.infinity,
                      child: GradientButtonSquare(
                        text: "CREATE ACCOUNT",
                        onClick: () {
                          if (formkey.currentState!.validate()) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'login',
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ),
                    const Gap(20),
                    TextButton(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: style.insets.xl,
                              vertical: style.insets.md,
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            Color(0xffe4e6ea),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back to login',
                          style: style.text.bodyTitle
                              .copyWith(color: AppColors.blueGrey),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  final String placeholder;
  final List list;
  final void Function(Object? value) onChange;
  final String? Function(Object?)? validator;
  const DropDownWidget({
    super.key,
    required this.inputDecoration,
    required this.placeholder,
    required this.list,
    required this.onChange,
    this.validator,
  });

  final InputDecoration inputDecoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: style.insets.md),
      child: DropdownButtonFormField(
        dropdownColor: AppColors.white,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        hint: Text(placeholder),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: inputDecoration,
        items: list
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e['text']),
              ),
            )
            .toList(),
        onChanged: onChange,
      ),
    );
  }
}
