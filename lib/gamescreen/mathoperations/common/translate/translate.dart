import 'package:supersetfirebase/gamescreen/mathoperations//common/translate/meta_data.dart';

Map<String, dynamic> getTextLanguageData(String language1, String language2) {
  Map<String, dynamic> result = {};
  List<String> languages = languageData["languages"];
  if (!languages.contains(language1) || !languages.contains(language2)) {
    language1 = language2 = "English";
  }
  result["languages"] = [language1, language2];
  result["ques_heading"] = {
    "pri_lang": languageData["pages"]["TextQuestion"]["ques_heading"]
        [language1],
    "sec_lang": languageData["pages"]["TextQuestion"]["ques_heading"]
        [language2],
  };
  result["pop_up_heading"] = {
    "pri_lang": languageData["pages"]["TextQuestion"]["pop_up_heading"]
        [language1],
    "sec_lang": languageData["pages"]["TextQuestion"]["pop_up_heading"]
        [language2],
  };
  result["hint_text"] = {
    "pri_lang": languageData["pages"]["TextQuestion"]["hint_text"][language1],
    "sec_lang": languageData["pages"]["TextQuestion"]["hint_text"][language2],
  };
  return result;
}

Map<String, dynamic> getMCQLanguageData(String language1, String language2) {
  Map<String, dynamic> result = {};
  List<String> languages = languageData["languages"];
  if (!languages.contains(language1) || !languages.contains(language2)) {
    language1 = language2 = "English";
  }
  result["languages"] = [language1, language2];
  result["ques_heading"] = {
    "pri_lang": languageData["pages"]["MCQ"]["ques_heading"][language1],
    "sec_lang": languageData["pages"]["MCQ"]["ques_heading"][language2],
  };
  return result;
}

Map<String, dynamic> getMcqImgLanguageData(
    String language1, String language2, String sign) {
  Map<String, dynamic> result = {};
  List<String> languages = languageData["languages"];
  if (!languages.contains(language1) || !languages.contains(language2)) {
    language1 = language2 = "English";
  }
  result["languages"] = [language1, language2];
  result["ques_heading"] = {
    "pri_lang": languageData["pages"]["MCQ_IMG"]["ques_heading"][sign]
        [language1],
    "sec_lang": languageData["pages"]["MCQ_IMG"]["ques_heading"][sign]
        [language2],
  };
  result["img_name"] = {
    "pri_lang": languageData["pages"]["MCQ_IMG"]["img_name"][language1],
    "sec_lang": languageData["pages"]["MCQ_IMG"]["img_name"][language2],
  };
  return result;
}

Map<String, dynamic> getFlashCardLanguageData(
    String language1, String language2) {
  Map<String, dynamic> result = {};

  // Extract languages from languageData
  List<String> languages = languageData["languages"];

  // Check if the provided languages are valid
  if (!languages.contains(language1) || !languages.contains(language2)) {
    language1 = language2 = "English";
  }

  // // Extract data for the specified languages
  // result["pages"] = {};
  result["languages"] = [language1, language2];

  Map<String, dynamic> flashcardPage = languageData["pages"]["flashcard"];
  Map<String, dynamic> pageData = {};

  for (var opKey in ["+", "-", "x", '÷']) {
    Map<String, dynamic> opData = flashcardPage[opKey];

    Map<String, dynamic> opName = {
      "pri_lang": opData["op_name"][language1],
      "sec_lang": opData["op_name"][language2]
    };
    Map<String, dynamic> opDef = {
      "pri_lang": opData["op_def"][language1],
      "sec_lang": opData["op_def"][language2]
    };
    pageData[opKey] = {"op_name": opName, "op_def": opDef};
  }
  result = pageData;

  // Add "Guess the Answer" definition
  result["ques_def"] = {
    "pri_lang": languageData["pages"]["flashcard"]["ques_def"][language1],
    "sec_lang": languageData["pages"]["flashcard"]["ques_def"][language2],
  };

  return result;
}

String getNumToWordLangKey(String lang) {
  Map<String, String> languageTranslations = {
    "English": "en",
    "Portuguese": "pt",
    "Spanish": "es",
    "French": "fr",
    "Esperanto": "eo",
    "Vietnamese": "vi",
    "Arabic": "ar",
    "Azerbaijan": "az",
    "Turkish": "tr",
    "Ukrainian": "uk",
    "Indonesian": "id",
    "Russian": "ru",
  };
  return languageTranslations[lang]!;
}

String getSpeakLangKey(String lang) {
  Map<String, String> languageTranslations = {
    "English": 'en-US',
    // "Portuguese": "pt",
    "Spanish": 'es-ES',
    // "French": "fr",
    // "Esperanto": "eo",
    // "Vietnamese": "vi",
    // "Arabic": "ar",
    // "Azerbaijan": "az",
    // "Turkish": "tr",
    // "Ukrainian": "uk",
    // "Indonesian": "id",
    // "Russian": "ru",
  };
  return languageTranslations[lang]!;
}
// list og lang : [ko-KR, mr-IN, ru-RU, zh-TW, hu-HU, sw-KE, th-TH, ur-PK, nb-NO, da-DK, tr-TR, et-EE, pt-PT, vi-VN, en-US, sq-AL, sv-SE, ar, su-ID, bs-BA, bn-BD, gu-IN, kn-IN, el-GR, hi-IN, fi-FI, km-KH, bn-IN, fr-FR, uk-UA, pa-IN, en-AU, lv-LV, nl-NL, fr-CA, sr, pt-BR, ml-IN, si-LK, de-DE, cs-CZ, pl-PL, sk-SK, fil-PH, it-IT, ne-NP, ms-MY, hr, en-NG, nl-BE, zh-CN, es-ES, cy, ta-IN, ja-JP, bg-BG, yue-HK, en-IN, es-US, jv-ID, id-ID, te-IN, ro-RO, ca, en-GB]
