import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_admin/services/global_methods.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/forgetPage';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  // To create forget password method
  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      // To create errorDialog Massage
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email address', context: context);
    } else {
      setState(() {});
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase());
        // To show a toast message on screen
        Fluttertoast.showToast(
          msg: "An email has been sent to your email address",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // To create errorDialog method
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {});
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {});
      } finally {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // To create a forget password screen UI
    return Scaffold(
      body: Stack(
        children: [
          // To control with autoplay images background

          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Forget password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _emailTextController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Email address',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white30, // background (button) color
                    ),
                    onPressed: () {
                      _forgetPassFCT();
                    },
                    child: const Text('Reset now',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
