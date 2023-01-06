class Country {
  String code;
  String name;
  String flag;
  Map<String, dynamic> translations;

  Country(
      {required this.code,
      required this.name,
      required this.flag,
      required this.translations});
}

class Round {
  Country chosenCountry;
  Map<String, dynamic> choices;

  Round({required this.chosenCountry, required this.choices});
}
