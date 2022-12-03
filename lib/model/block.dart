import 'dart:convert';
import 'package:blockchainapp/model/person.dart';
import 'package:crypto/crypto.dart';

class Block {
  String hash = "";
  String? prevHash;
  int height;
  int nonce = 0;
  Person person = Person("");
  int difficulty;

  Block(this.prevHash, this.height, this.difficulty) {
    hash = digest();
  }

  String digest() {
    return sha256.convert(utf8.encode(toJsonNoHash())).toString();
  }

  Map toMap() {
    Map map = {
      "hash": hash,
      "prev_hash": prevHash,
      "height": height,
      "nonce": nonce,
      "person": person
    };

    return map;
  }

  String toJsonNoHash() {
    Map mapWithoutHash = toMap();
    mapWithoutHash.remove("hash");
    return json.encode(mapWithoutHash);
  }

  bool validPOW() {
    if (hash.startsWith("0" * difficulty)) return true;
    return false;
  }
}
