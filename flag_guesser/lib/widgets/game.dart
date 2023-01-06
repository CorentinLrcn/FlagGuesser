import 'dart:convert';
import 'dart:math';

import 'package:flag_guesser/models.dart';
import 'package:flag_guesser/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:http/http.dart' as http;

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  List<Country>? countries = [];
  List<Round>? game = [];
  Country? roundCountry;

  int gameIndex = 0;

  Color? answer1btn = Colors.transparent;
  Color? answer2btn = Colors.transparent;
  Color? answer3btn = Colors.transparent;
  Color? answer4btn = Colors.transparent;

  Color? answer1btnText = Colors.black;
  Color? answer2btnText = Colors.black;
  Color? answer3btnText = Colors.black;
  Color? answer4btnText = Colors.black;

  String answer1 = '';
  String answer2 = '';
  String answer3 = '';
  String answer4 = '';

  bool isRevealed = false;

  void startRound() {
    Country chosenCountry = countries![Random().nextInt(countries!.length)];
    int rightAnswerPos = Random().nextInt(4);
    switch (rightAnswerPos) {
      case 0:
        setState(() {
          roundCountry = chosenCountry;
          answer1 = chosenCountry.name;
          answer2 = countries![Random().nextInt(countries!.length)].name;
          answer3 = countries![Random().nextInt(countries!.length)].name;
          answer4 = countries![Random().nextInt(countries!.length)].name;
        });
        break;
      case 1:
        setState(() {
          roundCountry = chosenCountry;
          answer2 = chosenCountry.name;
          answer1 = countries![Random().nextInt(countries!.length)].name;
          answer3 = countries![Random().nextInt(countries!.length)].name;
          answer4 = countries![Random().nextInt(countries!.length)].name;
        });
        break;
      case 2:
        setState(() {
          roundCountry = chosenCountry;
          answer3 = chosenCountry.name;
          answer2 = countries![Random().nextInt(countries!.length)].name;
          answer1 = countries![Random().nextInt(countries!.length)].name;
          answer4 = countries![Random().nextInt(countries!.length)].name;
        });
        break;
      case 3:
        setState(() {
          roundCountry = chosenCountry;
          answer4 = chosenCountry.name;
          answer2 = countries![Random().nextInt(countries!.length)].name;
          answer3 = countries![Random().nextInt(countries!.length)].name;
          answer1 = countries![Random().nextInt(countries!.length)].name;
        });
        break;
    }
    setState(() {});
  }

  void revealAnswer() {
    setState(() {
      answer1btn =
          (answer1 == roundCountry!.name) ? Colors.green : Colors.red.shade700;
      answer2btn =
          (answer2 == roundCountry!.name) ? Colors.green : Colors.red.shade700;
      answer3btn =
          (answer3 == roundCountry!.name) ? Colors.green : Colors.red.shade700;
      answer4btn =
          (answer4 == roundCountry!.name) ? Colors.green : Colors.red.shade700;
      isRevealed = true;
    });
  }

  void nextRound() {
    startRound();
    setState(() {
      answer1btn = Colors.transparent;
      answer2btn = Colors.transparent;
      answer3btn = Colors.transparent;
      answer4btn = Colors.transparent;
      isRevealed = false;
    });
  }

  Future<void> getAllCountries() async {
    const apiUrl = '$baseUrl/all?fields=name,flags,translations';
    var response = await http.get(Uri.parse(apiUrl));
    List<Country> loadingCountryList = [];
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    for (var pays in json) {
      loadingCountryList.add(Country(
          code: '',
          name: pays['name'],
          flag: pays['flags']["png"],
          translations: pays["translations"] as Map<String, dynamic>));
    }

    setState(() {
      countries = loadingCountryList;
    });
    startRound();
  }

  @override
  void initState() {
    super.initState();
    getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NeumorphicTheme.baseColor(context),
        elevation: 0,
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: (roundCountry == null)
          ? const Center(
              child: Text('Chargement en cours...'),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Center(
                    child: Text(
                      'À quel pays appartient ce drapeau ?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  child: Center(
                    child: Image.network(roundCountry!.flag),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //const Text('Score : /10'),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: answer1btn,
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Text(answer1,
                          style: TextStyle(color: answer1btnText)),
                    ),
                    onPressed: () => revealAnswer(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: answer2btn,
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Text(answer2,
                          style: TextStyle(color: answer2btnText)),
                    ),
                    onPressed: () => revealAnswer(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: answer3btn,
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Text(answer3,
                          style: TextStyle(color: answer3btnText)),
                    ),
                    onPressed: () => revealAnswer(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: answer4btn,
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Text(answer4,
                          style: TextStyle(color: answer4btnText)),
                    ),
                    onPressed: () => revealAnswer(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                (!isRevealed)
                    ? const SizedBox()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 60,
                        child: NeumorphicButton(
                          padding: EdgeInsets.zero,
                          child: const Center(
                            child: Text('Suivant'),
                          ),
                          onPressed: () => nextRound(),
                        ),
                      ),
              ],
            ),
    );
  }
}
