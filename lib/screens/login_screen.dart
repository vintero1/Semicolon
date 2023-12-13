import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:semicolon_project/resources/auth_methods.dart";
import "package:semicolon_project/responsive/mobile_screen_layout.dart";
import "package:semicolon_project/responsive/responsive_layout_screen.dart";
import "package:semicolon_project/responsive/web_screen_layout.dart";
import "package:semicolon_project/screens/signup_screen.dart";
import "package:semicolon_project/utils/colors.dart";
import "package:semicolon_project/utils/utils.dart";
import "package:semicolon_project/widgets/text_field_input.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void signUserIn() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUserIn(
        email: _emailController.text, password: _passController.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              // SVG image
              SvgPicture.asset(
                'assets/semicolon.svg',
                color: primaryColor,
                height: 64,
              ),

              // Text field email input
              const SizedBox(height: 64),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'E-mail',
                textInputType: TextInputType.emailAddress,
              ),

              // Text field password input
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passController,
                hintText: 'Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),

              // Sign in button
              const SizedBox(height: 24),
              InkWell(
                onTap: signUserIn,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Text('Sign In'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: pinkColor),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),

              // Sign up transition
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("New to semicolon?"),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "  Sign Up.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
