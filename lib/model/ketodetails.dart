// To parse this JSON data, do
//
//     final ketodetails = ketodetailsFromJson(jsonString);

import 'dart:convert';

List<Ketodetails> ketodetailsFromJson(String str) => List<Ketodetails>.from(json.decode(str).map((x) => Ketodetails.fromJson(x)));



class Ketodetails {
    Ketodetails({
        required this.id,
        required this.img,
        required this.description,
        required this.blogUrl,
        required this.title,
    });

    String id;
    List<String> img;
    String description;
    String blogUrl;
    String title;

    factory Ketodetails.fromJson(Map<String, dynamic> json) => Ketodetails(
        id: json["id"],
        img: List<String>.from(json["img"].map((x) => x)),
        description: json["description"],
        blogUrl: json["blogURL"],
        title: json["Title"],
    );

  
}
