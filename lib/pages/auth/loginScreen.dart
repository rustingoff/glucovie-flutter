import 'package:dio/dio.dart';
import 'package:glucovie/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:validators/validators.dart';
import '../../api/apiClient.dart';
import 'signUpScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> userData = {
        "email": _emailEditingController.text,
        "password": _passwordEditingController.text,
      };

      Response res = await _apiClient.login(userData);
      if (res.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushNamed(context, 'main_p');
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${res.data['error']}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
  }

  @override
  void dispose() {
    _emailEditingController.clear();
    _passwordEditingController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                      animate: true,
                      height: 120,
                      width: 600),
                  Text(
                    'Intră în cont',
                    style: screenTitleTS,
                  ),
                  Text(
                    'Vă rugăm să vă autentificați pentru a utiliza aplicația',
                    style: screenSubtitleTS,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: isEmailCorrect ? 280 : 200,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20,),
                            child: TextFormField(
                              controller: _emailEditingController,
                              onChanged: (val) {
                                setState(() {
                                  isEmailCorrect = isEmail(val);
                                });
                              },
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Email",
                                hintText: 'your-email@domain.com',
                                labelStyle: formInputTS,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: _passwordEditingController,
                                obscuringCharacter: '*',
                                obscureText: true,
                                decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.purple,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Parola",
                                  hintText: '*********',
                                  labelStyle: formInputTS,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return 'Introduceți o parolă validă';
                                  }
                                  return null;
                                },
                              ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          isEmailCorrect
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: isEmailCorrect == false
                                          ? Colors.red
                                          : Colors.purple,
                                      padding: const EdgeInsets.symmetric(horizontal: 131, vertical: 20)),
                                  onPressed: _handleLogin,
                                  child: const Text(
                                    'Intră',
                                    style: TextStyle(fontSize: 17),
                                  ))
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nu ai un cont?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push( context,
                            MaterialPageRoute(
                            builder: (BuildContext context) =>
                              const SignUpScreen()));
                        },
                        child: const Text(
                          'Înregistrează-te',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
