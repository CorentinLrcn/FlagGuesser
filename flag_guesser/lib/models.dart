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
