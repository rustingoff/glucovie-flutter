import 'package:dio/dio.dart';
import 'package:glucovie/api/apiClient.dart';
import 'package:glucovie/pages/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:validators/validators.dart';

import '../../constants/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _genderEditingController = TextEditingController();
  final TextEditingController _ageEditingController = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> userData = {
        "email": _emailEditingController.text,
        "password": _passwordEditingController.text,
        "phone": _phoneEditingController.text,
        "gender": _genderEditingController.text,
        "age": int.parse(_ageEditingController.text),
      };

      Response res = await _apiClient.registerUser(userData);
      if (res.statusCode == 201) {
        if (context.mounted) {
          Navigator.pushNamed(context, 'login_p');
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
                Lottie.asset(
                    'assets/lotties/134399-please-connect-to-see-more.json',
                    animate: true,
                    height: 80,
                    width: 600),
                Text(
                  'Creați un cont nou',
                  style: screenTitleTS,
                ),
                Text(
                  'Vă rugăm să vă înregistrați pentru a continua',
                  style: screenSubtitleTS,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                              left: 20, right: 20, bottom: 10, top: 0),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 0, top: 10),
                          child: TextFormField(
                            controller: _phoneEditingController,
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
                                Icons.phone,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Telefon",
                              hintText: '+373 *** *** ***',
                              labelStyle: formInputTS,
                            ),
                            validator: (val) {
                              RegExp regExp = RegExp("[+373]?[0-9]{11}\$");
                              if (!regExp.hasMatch(val!)) {
                                return 'Numar de telefon invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 0, top: 10),
                          child: TextFormField(
                            controller: _genderEditingController,
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
                                Icons.nature_people_outlined,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Sex",
                              hintText: 'Masculin/Feminin',
                              labelStyle: formInputTS,
                            ),
                            validator: (val) {
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 0, top: 10),
                          child: TextFormField(
                            controller: _ageEditingController,
                            keyboardType: TextInputType.number,
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
                                Icons.date_range_outlined,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Vârsta",
                              labelStyle: formInputTS,
                            ),
                            validator: (val) {
                              if (!isNumeric(val!)) {
                                return 'Introduceți un numar';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 20)),
                            onPressed: _handleRegister,
                            child: const Text(
                              'Înregistrează-te',
                              style: TextStyle(fontSize: 17),
                            ))
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ai deja un cont?',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen()));
                      },
                      child: const Text(
                        'Intră',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.w500),
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
