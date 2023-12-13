import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:semicolon_project/utils/colors.dart";
import "package:semicolon_project/widgets/text_field_input.dart";

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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
                height: 44,
              ),
              const SizedBox(height: 2),

              // Widget to accept/show our selected photo
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 54,
                    backgroundImage: NetworkImage(
                        'https://temp-number.sfo3.digitaloceanspaces.com/tname/images/male/74/12.jpg'),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 75,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_to_photos_rounded),
                      iconSize: 21.2,
                      color: pinkColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Text field username input
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 10),

              // Text field email input
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'E-mail',
                textInputType: TextInputType.emailAddress,
              ),

              // Text field password input
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _passController,
                hintText: 'Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),

              // Text field bio input
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Bio',
                textInputType: TextInputType.text,
              ),

              // Sign in button
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
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
                  child: const Text('Sign Up'),
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
                    child: const Text("Already a semicoloner?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "  Sign In.",
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
