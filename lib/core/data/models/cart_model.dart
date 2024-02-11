import 'dart:convert';

//import 'package:empty_project/core/data/models/apis/meal_model.dart';

class CartModel {
  int? count;
  double? totalItem;
  // MealModel? mealModel;

  CartModel({
    this.count,
    this.totalItem,
    //this.mealModel
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalItem = json['totalItem'];
    // mealModel = json['meal_model'] != null
    //     ? new MealModel.fromJson(json['meal_model'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    data['totalItem'] = totalItem;
    // if (this.mealModel != null) {
    //   data['meal_model'] = this.mealModel!.toJson();
    // }
    return data;
  }

  static Map<String, dynamic> toMap(CartModel model) {
    return {
      "count": model.count,
      "totalItem": model.totalItem,
      // "meal_model": model.mealModel,
    };
  }

  static String encode(List<CartModel> list) => json.encode(
        list
            .map<Map<String, dynamic>>((element) => CartModel.toMap(element))
            .toList(),
      );

  static List<CartModel> decode(String strList) =>
      (json.decode(strList) as List<dynamic>)
          .map<CartModel>((item) => CartModel.fromJson(item))
          .toList();
}