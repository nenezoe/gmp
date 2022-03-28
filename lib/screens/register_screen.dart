import 'package:app_google_map/constants/hex_color.dart';
import 'package:app_google_map/model/register_model.dart';
import 'package:app_google_map/screens/home_screen.dart';
import 'package:app_google_map/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final globalFormKey = GlobalKey<FormState>();
  bool isApicalProcess = false;
  bool hidePassword = true;
  String? userName;
  String? password;
  String? email;
  String? confirmPassword;
  late RegisterRequestModel requestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    requestModel = RegisterRequestModel(
        email: "email",
        password: "password",
        userName: "userName",
        confirmPassword: "confirmPassword");
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      key: UniqueKey(),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#283B71'),
      body: SafeArea(
        child: Form(
          key: globalFormKey,
          child: _registerUI(context),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
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
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
              context, const Icon(Icons.person), "userName", "userName",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "username can't be empty";
            }
            return null;
          }, (input) {
            userName = requestModel.userName = input;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FormHelper.inputFieldWidget(
                context, const Icon(Icons.person), "email", "email",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "email can't be empty";
              }
              return null;
            }, (input) {
              email = requestModel.email = input;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10),
          ),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.person),
                "confirmPassword",
                "confirmPassword", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "password must match";
              }
              return null;
            }, (onSavedVal) {
              password = onSavedVal;
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
            child: FormHelper.submitButton("Submit", () {
              // if (validateAndSave()) {
              //   setState(() {
              //     isApiCallProcess = true;
              //   });
              //
              //   APIService apiService = APIService();
              //   apiService.register(requestModel).then((value) {
              //     setState(() {
              //       isApiCallProcess = false;
              //     });

              //   if (value.token.isNotEmpty) {
              //     const snackBar = SnackBar(
              //       content: Text("Registration Successfull"),
              //     );
              //     scaffoldKey.currentState!.showSnackBar(snackBar);
              //   } else {
              //     const snackBar = SnackBar(
              //       content: Text("value.error"),
              //     );
              //     scaffoldKey.currentState!.showSnackBar(snackBar);
              //   }
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const RideScreen()));
              // }).catchError((error) {
              //   setState(() {
              //     isApiCallProcess = false;
              //   });
              //   print(error);
              // });
              print(requestModel.tojson());
            }

                // Navigator.of(context)., "/register");
                // },
                // btnColor: HexColor("#283B71"),
                // borderColor: Colors.white,
                // txtColor: Colors.white,
                // borderRadius: 10,
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
                    const TextSpan(text: "Have an account? "),
                    TextSpan(
                        text: "Sign in",
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          }),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
