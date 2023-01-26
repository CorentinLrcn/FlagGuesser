import 'dart:convert';
import 'dart:math';

import 'package:flag_guesser/models.dart';
import 'package:flag_guesser/utils/globals.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

import '../utils/translation.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  Color? ans1BtnColor = Colors.blueGrey[50];
  Color? ans2BtnColor = Colors.blueGrey[50];
  Color? ans3BtnColor = Colors.blueGrey[50];
  Color? ans4BtnColor = Colors.blueGrey[50];
  Color? answer1FontColor = Colors.black;
  Color? answer2FontColor = Colors.black;
  Color? answer3FontColor = Colors.black;
  Color? answer4FontColor = Colors.black;

  List<Country>? countries = [];
  List<Round> game = [];
  int score = 0;

  bool canGoNext = false;
  int gameIndex = 0;

  void initGame() {
    List<Round> tmpGame = [];
    for (int i = 0; i < 10; i++) {
      int countryIndex = Random().nextInt(countries!.length);
      print(countries![countryIndex]);
      int rightAnswerAssigned = Random().nextInt(4);
      Map<String, dynamic> tmpAnswers = {};
      for (int n = 0; n < 4; n++) {
        if (n == rightAnswerAssigned) {
          tmpAnswers.putIfAbsent('answer${n + 1}',
              () => {'name': countries![countryIndex].name, 'value': 'right'});
        } else {
          int fakeAnswerIndex = Random().nextInt(countries!.length);
          while (fakeAnswerIndex == countryIndex) {
            fakeAnswerIndex = Random().nextInt(countries!.length);
          }
          tmpAnswers.putIfAbsent(
              'answer${n + 1}',
              () =>
                  {'name': countries![fakeAnswerIndex].name, 'value': 'right'});
        }
      }
      tmpGame.add(
          Round(chosenCountry: countries![countryIndex], choices: tmpAnswers));
    }
    setState(() {
      game = tmpGame;
    });
  }

  Future<void> getFlagList() async {
    final response = await http
        .get(Uri.parse('$baseUrl/all?fields=name,translations,flags'));
    final jsonCountries = jsonDecode(utf8.decode(response.bodyBytes));
    print(jsonCountries);

    List<Country> tmpCount = [];
    for (var jsonCountry in jsonCountries) {
      tmpCount.add(Country(
        code: '',
        name: jsonCountry['name'],
        flag: jsonCountry['flags']['png'],
        translations: jsonCountry['translations'] as Map<String, dynamic>,
      ));
    }
    setState(() {
      countries = tmpCount;
    });
    initGame();
    print(game);
  }

  void revealAnswer(int userAnswer) {
    setState(() {
      game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer$userAnswer']['name']
          ? score++
          : score;
      ans1BtnColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer1']['name']
          ? Colors.green
          : Colors.red.shade900;
      ans2BtnColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer2']['name']
          ? Colors.green
          : Colors.red.shade900;
      ans3BtnColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer3']['name']
          ? Colors.green
          : Colors.red.shade900;
      ans4BtnColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer4']['name']
          ? Colors.green
          : Colors.red.shade900;
      answer1FontColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer1']['name']
          ? Colors.black
          : Colors.white;
      answer2FontColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer2']['name']
          ? Colors.black
          : Colors.white;
      answer3FontColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer3']['name']
          ? Colors.black
          : Colors.white;
      answer4FontColor = game[gameIndex].chosenCountry.name ==
              game[gameIndex].choices['answer4']['name']
          ? Colors.black
          : Colors.white;
      canGoNext = !canGoNext;
    });
  }

  void hideAnswer() {
    setState(() {
      ans1BtnColor = Colors.blueGrey[50];
      ans2BtnColor = Colors.blueGrey[50];
      ans3BtnColor = Colors.blueGrey[50];
      ans4BtnColor = Colors.blueGrey[50];
      answer1FontColor = Colors.black;
      answer2FontColor = Colors.black;
      answer3FontColor = Colors.black;
      answer4FontColor = Colors.black;
      gameIndex++;
      canGoNext = !canGoNext;
    });
  }

  @override
  void initState() {
    getFlagList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: (game.isNotEmpty)
          ? (gameIndex < game.length)
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: Text(
                          Translation.translate(
                              "To which country this flags belongs ?",
                              selectedLanguage),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 175,
                      child: Neumorphic(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Image.network(game[gameIndex].chosenCountry.flag,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                        '${Translation.translate("Your score :", selectedLanguage)} $score / 10'),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: NeumorphicButton(
                        onPressed: () => {canGoNext ? {} : revealAnswer(1)},
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10.0)),
                          color: ans1BtnColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                            vertical: MediaQuery.of(context).size.width * 0.05),
                        child: Center(
                          child: Text(
                            game[gameIndex].choices['answer1']['name'],
                            style: TextStyle(color: answer1FontColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: NeumorphicButton(
                        onPressed: () => {canGoNext ? {} : revealAnswer(2)},
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10.0)),
                          color: ans2BtnColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                            vertical: MediaQuery.of(context).size.width * 0.05),
                        child: Center(
                          child: Text(
                            game[gameIndex].choices['answer2']['name'],
                            style: TextStyle(color: answer2FontColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: NeumorphicButton(
                        onPressed: () => {canGoNext ? {} : revealAnswer(3)},
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10.0)),
                          color: ans3BtnColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                            vertical: MediaQuery.of(context).size.width * 0.05),
                        child: Center(
                          child: Text(
                            game[gameIndex].choices['answer3']['name'],
                            style: TextStyle(color: answer3FontColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: NeumorphicButton(
                        onPressed: () => {canGoNext ? {} : revealAnswer(4)},
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10.0)),
                          color: ans4BtnColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                            vertical: MediaQuery.of(context).size.width * 0.05),
                        child: Center(
                          child: Text(
                            game[gameIndex].choices['answer4']['name'],
                            style: TextStyle(color: answer4FontColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    (canGoNext)
                        ? Row(children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            NeumorphicButton(
                              onPressed: () => {hideAnswer()},
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10.0)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1,
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Center(
                                child: Text(
                                  Translation.translate(
                                      "Next", selectedLanguage),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ])
                        : const SizedBox()
                  ],
                )
              : Center(
                  child: Column(children: [
                  Text(Translation.translate("Game over", selectedLanguage)),
                  Text(
                      '${Translation.translate("Your score :", selectedLanguage)} $score/10'),
                ]))
          : Center(
              child: Text(
                Translation.translate("Game loading...", selectedLanguage),
              ),
            ),
    );
  }
}
