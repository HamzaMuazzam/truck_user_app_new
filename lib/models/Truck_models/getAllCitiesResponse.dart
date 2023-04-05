// To parse this JSON data, do
//
//     final getAllCitiesReponse = getAllCitiesReponseFromJson(jsonString);

import 'dart:convert';

List<GetAllCitiesResponse> getAllCitiesResponseFromJson(String str) =>
    List<GetAllCitiesResponse>.from(json.decode(str).map((x) =>
        GetAllCitiesResponse.fromJson(x)));

String getAllCitiesResponseToJson(List<GetAllCitiesResponse> data) => json
    .encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCitiesResponse {
  GetAllCitiesResponse({
     this.id,
     this.name,
  });

  int? id;
  String? name;

  factory GetAllCitiesResponse.fromJson(Map<String, dynamic> json) =>
      GetAllCitiesResponse(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
