import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      home: BMI(),
    );
  }
}

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  var htController = TextEditingController();
  var wtController = TextEditingController();
  int? bmi;
  Color bgColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: bgColor,
                  blurRadius: 5,
                  spreadRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "BMI Calculator",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: wtController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.line_weight),
                      hintText: "Weight in kg",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: htController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.height),
                      hintText: "Height in meters",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
                  child: ElevatedButton(
                    onPressed: () {
                      if (wtController.text.isEmpty ||
                          htController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Fill the Details"),
                          ),
                        );
                      } else {
                        double weight =
                            double.tryParse(wtController.text) ?? 0.0;
                        double height =
                            double.tryParse(htController.text) ?? 0.0;
                        double cbmi = weight / (height * height);

                        if (cbmi <= 18.4) {
                          bgColor = Colors.orange;
                        } else if (cbmi > 18.4 && cbmi <= 24.9) {
                          bgColor = Colors.green;
                        } else {
                          bgColor = Colors.red;
                        }

                        setState(() {
                          this.bmi = cbmi.round();
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.blue),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.monitor_weight_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (bmi != null)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Your BMI is : $bmi",
                      style: TextStyle(
                        fontSize: 30,
                        color: bgColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            wtController.clear();
            htController.clear();
            bmi = null;
            bgColor = Colors.grey;
          });
        },
        child: const Icon(
          Icons.clear,
          color: Colors.red,
        ),
      ),
    );
  }
}
