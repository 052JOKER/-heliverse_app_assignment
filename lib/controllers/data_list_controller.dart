import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:heliverse_app_assignment/models/data_list_model.dart';

class HomePageProvider extends ChangeNotifier {
  MyData? data;

  Future getData(context) async {
    try {
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/heliverse_mock_data.json');
      Map<String, dynamic> myJson = json.decode(response);
      data = MyData.fromJson(myJson);
      notifyListeners();
    } catch (e) {
      print("error is:"+e.toString());
    }
  }
}
