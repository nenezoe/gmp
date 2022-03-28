import 'package:app_google_map/constants/hex_color.dart';
import 'package:app_google_map/model/login_model.dart';
import 'package:app_google_map/screens/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isApicalProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? email;
  String? password;
  late LoginRequestModel requestModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestModel = LoginRequestModel('email!', 'password');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isApicalProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/note_pad.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text('Note pad'),
                ]),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
              context, const Icon(Icons.person), "email", "email",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "email can't be empty";
            }
            return null;
          }, (input) {},
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
                context, const Icon(Icons.person), "password", "password",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "password can't be empty";
              }
              return null;
            }, (input) {
              password = requestModel.password = input;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(0.7),
                    icon: Icon(hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Forget Password ?",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = (){
                        //   print()
                        //   }
                      ),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {},
              btnColor: HexColor("#283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Don't have an account? "),
                    TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                          }),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
