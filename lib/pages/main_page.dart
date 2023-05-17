import 'package:glucovie/pages/navigation/navigation.dart';
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
  int measure = 1;
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
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/FullLogo_Transparent_NoBuffer.png',
                height: 100,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Text(
                    formattedDate,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                        'Valoarea optimală: 70-99 mg/dL, sau 3.9-5.5 mmol/L'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 20,
                                vertical: 10)),
                        onPressed: () {
                          setState(() {
                            glucoseValue = 0.0;
                            res = 0.0;
                            measure = 1;
                          });
                        },
                        child: const Text("mmol/L"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 15,
                                vertical: 10)),
                        onPressed: () {
                          _textEditingController.text = "";
                          setState(() {
                            glucoseValue = 0.0;
                            res = 0.0;
                            measure = 2;
                          });
                        },
                        child: const Text("mg/dl"),
                      ),
                    ],
                  ),
                  measure == 1
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    prefixIcon: Icon(
                                      Icons.health_and_safety,
                                      color: Colors.purple,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: "mmol/L",
                                    labelStyle: TextStyle(
                                        color: Colors.purple, fontSize: 16),
                                  ),
                                  validator: (value) {},
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == "") {
                                        glucoseValue = 0.0;
                                      } else {
                                        glucoseValue = double.parse(val);
                                        res = double.parse((glucoseValue / 18)
                                            .toStringAsFixed(3));
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'mg/dl: $res',
                                style: GoogleFonts.archivo(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    prefixIcon: Icon(
                                      Icons.health_and_safety,
                                      color: Colors.purple,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: "mg/dl",
                                    labelStyle: TextStyle(
                                        color: Colors.purple, fontSize: 16),
                                  ),
                                  validator: (value) {},
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == "") {
                                        glucoseValue = 0.0;
                                      } else {
                                        glucoseValue = double.parse(val);
                                        res = double.parse((glucoseValue * 18)
                                            .toStringAsFixed(3));
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'mmol/L: $res',
                                style: GoogleFonts.archivo(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 3.3,
                            vertical: 20)),
                    onPressed: () {},
                    child: const Text("Salvează datele"),
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
