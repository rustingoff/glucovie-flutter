import 'package:ecommerce/pages/chartScreen.dart';
import 'package:ecommerce/pages/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  double glucoseValue = 0.0;
  double res = 0.0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              Image.asset(
                'assets/images/FullLogo_Transparent_NoBuffer.png',
                height: 100,
              ),
              const SizedBox(height: 80,),
              Column(
                children: [
                  Text(
                    formattedDate,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.indieFlower(
                      fontSize: 30,
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Valoarea optimala: 70-99 mg/dL, sau 3.9-5.5 mmol/L'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        style: GoogleFonts.archivo(
                          fontSize: 18,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(
                            Icons.health_and_safety,
                            color: Colors.purple,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "mmol/L",
                          labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty && value!.length < 5) {
                            return 'Introduceți o parolă validă';
                            {
                              return null;
                            }
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            if (val == "") {
                              glucoseValue = 0.0;
                            } else {
                              glucoseValue = double.parse(val);
                              res = double.parse((glucoseValue / 18).toStringAsFixed(3));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'mg/dl: $res',
                      style: GoogleFonts.archivo(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 3.3,
                            vertical: 20)
                    ),
                    onPressed: () {},
                    child: const Text("Salveaza datele"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigation(context),
    );
  }


  }

