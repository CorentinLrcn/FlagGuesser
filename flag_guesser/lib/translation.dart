import 'package:tuple/tuple.dart';

class Translation {
  static String translate(String wordToTranslate, String Language) {
    switch (wordToTranslate) {
      case "Play":
        switch (Language) {
          case 'FR':
            return "Jouer";
          case 'US':
            return "Play";
          case 'ES':
            return "Jugar";
          case 'DE':
            return "Spielen";
          case 'PT':
            return "Jogar";
          case 'BR':
            return "Jogar";
          case 'NL':
            return "Speel";
          case 'IT':
            return "Gioco";
          case 'HU':
            return "Játsszon";
          case 'HR':
            return "Igrač";
          default:
            return "Translation not Implemented";
        }
      case "To which country this flags belongs ?":
        switch (Language) {
          case 'FR':
            return "À quel pays appartient ce drapeau ?";
          case 'US':
            return "To which country does this flags belongs ?";
          case 'ES':
            return "¿A qué país pertenece esta bandera?";
          case 'DE':
            return "Zu welchem Land gehört diese Flagge ?";
          case 'PT':
            return "A que país pertence esta bandeira ?";
          case 'BR':
            return "A que país pertence esta bandeira ?";
          case 'NL':
            return "Van welk land is deze vlag ?";
          case 'IT':
            return "A quale Paese appartiene questa bandiera ?";
          case 'HU':
            return "Melyik országhoz tartozik ez a zászló ?";
          case 'HR':
            return "Kojoj državi pripada ova zastava ?";
          default:
            return "Translation not Implemented";
        }
      default:
        return "Translation not Implemented";
    }
  }
  /*
    ('Play', 'FR'): "Jouer",
    ["Play", "US"]: "Play",
    ["Play", "ES"]: "Jugar",
    ["Play", "DE"]: "Spielen",
    ["Play", "PT"]: "Jogar",
    ["Play", "BR"]: "Jogar",
    ["Play", "NL"]: "Speel",
    ["Play", "IT"]: "Gioco",
    ["Play", "NL"]: "Jugar",
    ["Play", "HU"]: "Játsszon",
  };
  */
}
