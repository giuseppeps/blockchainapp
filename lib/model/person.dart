import 'package:crypto/crypto.dart';
import 'dart:convert';

class Person {
  int time = DateTime.now().millisecondsSinceEpoch;
  String? name;
  String? hash;

  Person(String this.name) {
    hash = sha256.convert(utf8.encode(toJsonNoHash())).toString();
  }

  Map toMap() => {"time": time, "name": name, "hash": hash};

  String toJson() => json.encode(toMap());
  String toJsonNoHash() => json.encode(toMap().remove("hash"));
}
