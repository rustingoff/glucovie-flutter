import 'package:glucovie/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'auth/loginScreen.dart';
import 'auth/signUpScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/FullLogo_Transparent_NoBuffer.png',
                height: 150,
                width: 150,
              ),
              Lottie.asset(
                  'assets/lotties/140905-loading-48.json',
                  height: 200,
                  width: 600,
              ),
              const Text(
                'Bine ați venit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
              ),
              Expanded(
                flex: 0,
                child: Text(
                  'Intră în cont pentru a utiliza la aplicație',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w300,
                      // height: 1.5,
                      fontSize: 15),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3.3,
                          vertical: 20)
                      // padding: EdgeInsets.only(
                      //     left: 120, right: 120, top: 20, bottom: 20),
                      ),
                  onPressed: () {
                    Navigator.push(context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftPop,
                            child: const MainPage(),
                            childCurrent: const WelcomeScreen()
                        )
                    );
                  },
                  child: const Text(
                    'Sună bine!',
                    style: TextStyle(fontSize: 17),
                  )),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignUpScreen()));
                    },
                    child: const Text(
                      'Înregistrează-te',
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
    );
  }
}
