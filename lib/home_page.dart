import 'package:flutter/material.dart';
import 'package:weather_application_2/constant.dart';
import 'package:weather_application_2/weather_model.dart';
import 'package:weather_application_2/weather_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WeatherModel> getData(String cityName) async {
    return await CallToApi().fetchWeather(cityName);
  }

  TextEditingController textController = TextEditingController(text: "");
  Future<WeatherModel>? _myData;

  @override
  void initState() {
    setState(() {
      _myData = getData("Kathmandu");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If error occured
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error.toString()} occurr',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if data has no errors
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data as WeatherModel;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                  child: Column(
                    children: [
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Enter City',
                          filled: true,
                          fillColor: Color.fromARGB(255, 224, 220, 217),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 26,
                            ),
                            onPressed: () async {
                              print(textController.text);
                              if (textController.text.isEmpty) {
                                print("No city entered");
                              } else {
                                setState(() {
                                  _myData = getData(textController.text);
                                });
                              }

                              FocusScope.of(context).unfocus();
                              textController.clear();
                            },
                          ),
                        ),
                        style: f14RblackLetterSpacing2,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.city,
                              style: f24Rwhitebold,
                            ),
                            height25,
                            Text(
                              data.desc,
                              style: f16PW,
                            ),
                            height25,
                            Text(
                              "${data.temp}°C",
                              style: f42Rwhitebold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text("${snapshot.connectionState} occured"),
            );
          }
          return const Center(
            child: Text("Server timed out!"),
          );
        },
        future: _myData!,
      ),
    );
  }
}
