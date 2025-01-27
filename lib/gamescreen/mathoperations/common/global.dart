import 'package:supersetfirebase/gamescreen/mathoperations/common/level/level_info.dart';
import 'package:flutter/foundation.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/util/log.dart';


class GlobalVariables {
  static String priLang = "English"; // Private static variable
  static String secLang = "Spanish"; // Private static variable
  static String userName = "User XYZ"; // Private static variable
  static String userID = "12121"; // Private static variable
  static ValueNotifier<int> totalScore = ValueNotifier<int>(0);
  static List<LevelInfo> levels = initLevelData();

  static void setUserData(){
    // http get user info
    //

          Map<dynamic, dynamic> data = {
            "name" : "kjhsa"
          };

    priLang  = data.containsKey("primary_lang") ? data["primary_lang"]! : "English"; // Private static variable
    secLang  = data.containsKey("primary_lang") ? data["primary_lang"]! : "Spanish"; // Private static variable
    userName = data.containsKey("primary_lang") ? data["primary_lang"]! : "Guest"; // Private static variable
    userID   = data.containsKey("primary_lang") ? data["primary_lang"]! : "999999"; // Private static variable
  }

  static void setLevelData(){
    // http get level info
    // below code repl http resp - data
    // TASK - replace this with api code
              List<LevelInfo> tempLevels = testLevelData();
              List<Map<String, dynamic>> data = [];
              for (int i = 0; i <= 13; i++) {
                data.add(tempLevels[i].toMap());
              }

    // conversion
    List<LevelInfo> out =[];
    for (int i = 0; i <= 13; i++) {
      out.add(LevelInfo.fromMap(data[i]));
    }
    // if no info present
    // use init levelinfo as is
    if (out.isEmpty ) {
      //TASK ---- push this init level info to server
      List<Map<String, dynamic>> data = [];
      for (int i = 0; i <= 13; i++) {
        data.add(tempLevels[i].toMap());
      }
      // ie post(data)
      return;
    }
    levels = out;
  }

  static void postLevelData(){
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i <= 13; i++) {
      data.add(levels[i].toMap());
    }

    // http post  (data)

  }
  void test(){
    List<LevelInfo> levels = testLevelData();
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i <= 13; i++) {
      data.add(levels[i].toMap());
    }
  }
}
