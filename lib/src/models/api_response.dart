// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
    ApiResponse({
        required this.results,
    });

 
    List<Result> results;

    factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.name,
        required this.url,
    });

    String name;
    String url;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
