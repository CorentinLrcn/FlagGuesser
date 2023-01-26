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
      case "Game over":
        switch (Language) {
          case 'FR':
            return "Fin de la partie";
          case 'US':
            return "Game over";
          case 'ES':
            return "Juego terminado";
          case 'DE':
            return "Spiel ist aus";
          case 'PT':
            return "Game Over";
          case 'BR':
            return "Game Over";
          case 'NL':
            return "Spel is over";
          case 'IT':
            return "Game Over";
          case 'HU':
            return "Játék vége";
          case 'HR':
            return "Igra je gotova";
          default:
            return "Translation not Implemented";
        }
      case "Next":
        switch (Language) {
          case 'FR':
            return "Suivant";
          case 'US':
            return "Next";
          case 'ES':
            return "Próximo";
          case 'DE':
            return "Nächste";
          case 'PT':
            return "Next";
          case 'BR':
            return "Next";
          case 'NL':
            return "De volgende";
          case 'IT':
            return "seguente";
          case 'HU':
            return "következő";
          case 'HR':
            return "Sljedeći";
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
