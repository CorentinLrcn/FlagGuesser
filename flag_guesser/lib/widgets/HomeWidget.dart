// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, annotate_overrides, unnecessary_string_interpolations

import 'dart:convert';
import 'package:flag_guesser/utils/translation.dart';
import 'package:flag_guesser/widgets/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flag_guesser/utils/globals.dart';

import '../models.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:http/http.dart' as http;

class HomeWidget extends StatefulWidget {
  HomeWidget({super.key});

  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Country>? countryList;
  List<Country>? languageList;
  SharedPreferences? prefs;
  bool displayLanguage = false;

  @override
  void initState() {
    super.initState();
    loadPreferedLanguage();
    loadCountry();
  }

  Future<void> loadPreferedLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage =
          prefs?.getString(selectedLanguagePreferences) ?? selectedLanguage;
    });
  }

  Future<void> loadCountry() async {
    const apiUrl =
        'https://restcountries.com/v2/all?fields=name,flags,translations,alpha2Code';
    var response = await http.get(Uri.parse("$apiUrl"));
    List<Country> loadingCountryList = [];
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    for (var pays in json) {
      loadingCountryList.add(Country(
          code: pays['alpha2Code'],
          name: pays['name'],
          flag: pays['flags']["png"],
          translations: pays["translations"] as Map<String, dynamic>));
    }

    setState(() {
      countryList = loadingCountryList;
    });
    List<Country> availableLanguages = [
      loadingCountryList.where((element) => element.code == 'US').first
    ];
    for (var element
        in countryList?.first.translations.keys ?? [] as Iterable<String>) {
      if (countryList?.any((pays) => pays.code == element.toUpperCase()) ??
          false) {
        availableLanguages.add(countryList!
            .firstWhere((pays) => pays.code == element.toUpperCase()));
      }
    }
    setState(() {
      languageList = availableLanguages;
    });
  }

  void switchingLanguage() {
    setState(() {
      displayLanguage = !displayLanguage;
    });
  }

  void switchLanguage(Country country) {
    setState(() {
      selectedLanguage = country.code;
      prefs?.setString(selectedLanguagePreferences, country.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.end,
        children: <Widget>[
          for (Country lang in languageList ?? [])
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.1,
              margin: EdgeInsets.all(10),
              child: AnimatedOpacity(
                opacity: displayLanguage ? 1 : 0,
                duration: Duration(
                    milliseconds: 70 *
                        (displayLanguage
                            ? languageList!.length - languageList!.indexOf(lang)
                            : languageList!.indexOf(lang))),
                curve: Curves.easeInBack,
                child: NeumorphicButton(
                  style: NeumorphicStyle(
                    border: NeumorphicBorder(
                        color: selectedLanguage == lang.code
                            ? Colors.blue
                            : Colors.transparent,
                        width: 3),
                  ),
                  padding: EdgeInsets.zero,
                  child: Image.network(lang.flag, fit: BoxFit.fitHeight),
                  onPressed: () {
                    switchLanguage(lang);
                    displayLanguage = false;
                  },
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.15,
            child: NeumorphicButton(
              padding: EdgeInsets.zero,
              onPressed: (() => switchingLanguage()),
              child: Visibility(
                visible: true, //controll to click on your lap button
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  child: Icon(
                    Icons.language,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child:
                      Image.asset('images/Flag_guesser-removebg-preview.png'),
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  children: [
                    Expanded(flex: 1, child: Text('')),
                    Expanded(
                      flex: 4,
                      child: NeumorphicFloatingActionButton(
                        onPressed: () {
                          //TODO
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => GameWidget())));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Translation.translate("Play", selectedLanguage),
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Text('')),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
