import 'package:flutter/material.dart';
import 'package:itsamistake/Screens/homescree.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool _isloaded = false;
  void startlottie() {
    Timer(const Duration(milliseconds: 1200), () {
      setState(() {
        _isloaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    startlottie();
    return Scaffold(
      body: Stack(
        children: [
          if (_isloaded)
            Center(
              child: Lottie.network(
                  Uri.parse(
                          "https://lottie.host/8db22d0d-3c98-4737-897b-79f855904491/sSyEsEBVVd.json")
                      .toString(),
                  width: MediaQuery.of(context).size.width),
            ),
          Center(
            child: Lottie.network(
                Uri.parse(
                        "https://lottie.host/8ad2a86e-60b9-4041-a3aa-4683c71264db/Bv1isz8Cys.json")
                    .toString(),
                repeat: false),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          child: const Text("Restart"),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          }),
    );
  }
}
