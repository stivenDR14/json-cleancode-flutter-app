class LocalizationsClass {
  final Map<String, dynamic> translations;

  LocalizationsClass(this.translations);

  Map<String, dynamic> get getTranslations {
    return translations;
  }

  Map<String, dynamic> general() {
    return {
      'appTitle': translations['appTitle'],
      'event': translations['event'],
    };
  }

  Map<String, dynamic> tabs() {
    return {
      'instructor': translations['instructor'],
      'trainee': translations['trainee'],
      'observer': translations['observer'],
      'administration': translations['administration'],
    };
  }

  Map<String, dynamic> items() {
    return {
      "certificates": translations['certificates'],
      "avsafety_seminar": translations['avsafety_seminar'],
      "flight_instruments": translations['flight_instruments'],
      "flight_simulator": translations['flight_simulator'],
    };
  }

  Map<String, dynamic> messages() {
    return {'not_found': translations['not_found']};
  }
}
