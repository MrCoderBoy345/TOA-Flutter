import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/event-settings.dart';
import '../models/user.dart';

class Cloud {

  static final String baseURL = "https://functions.theorangealliance.org";

  static Future<User> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'data': 'basic'
      };
      Response res = await http.get(baseURL + '/user', headers: headers);
      return User.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<EventSettings> getEventSettings(String eventKey) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'data': eventKey
      };
      Response res = await http.get(baseURL + '/user/getEventSettings', headers: headers);
      return EventSettings.fromResponse(res.body);
    } else {
      return null;
    }
  }

  static Future<bool> updateEventSettings(String eventKey, EventSettings eventSettings) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'data': eventKey
      };
      Response res = await http.post(baseURL + '/user/updateEventSettings', headers: headers, body: jsonEncode(eventSettings.toJson()));
      return res.statusCode == 200;
    } else {
      return false;
    }
  }

  static Future<String> getUID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  static Future<bool> isFavTeam(String teamKey) async {
    String uid = await getUID();
    if (uid == null) {
      return false;
    }
    return false; // TODO
  }

  static setFavTeam(String teamKey, bool fav) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      // TODO: save in myTOA
    }
  }
}