import 'package:blockchainapp/model/person.dart';

class Transaction {
  String sender;
  String recipient;
  Person person;
  int? proof;
  String? prevHash;

  Transaction({
    required this.sender,
    required this.recipient,
    required this.person,
    this.proof,
    this.prevHash,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "sender": sender,
      "recipient": recipient,
      "person": person,
      "proof": proof,
      "prevHash": prevHash,
    };
  }
}
