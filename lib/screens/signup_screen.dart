import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:image_picker/image_picker.dart";
import "package:semicolon_project/resources/auth_methods.dart";
import "package:semicolon_project/responsive/mobile_screen_layout.dart";
import "package:semicolon_project/responsive/responsive_layout_screen.dart";
import "package:semicolon_project/responsive/web_screen_layout.dart";
import "package:semicolon_project/screens/login_screen.dart";
import "package:semicolon_project/utils/colors.dart";
import "package:semicolon_project/utils/utils.dart";
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
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUserUp(
      email: _emailController.text,
      password: _passController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
                height: 44,
              ),
              const SizedBox(height: 2),

              // Widget to accept/show our selected photo
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 54, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 54,
                          backgroundColor: mobileBackgroundColor,
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/6067/6067648.png'),
                        ),
                  Positioned(
                    bottom: 70,
                    left: 75,
                    child: IconButton(
                      onPressed: selectImage,
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
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign Up'),
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
                    child: const Text("Already a semicoloner?"),
                  ),
                  GestureDetector(
                    onTap: navigateToSignIn,
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
