import 'package:blockchainapp/model/blockchain.dart';

import 'block.dart';

Block mineNewBlock({required Blockchain blockchain, required int difficulty}) {
  Block block = blockchain.newBlock(difficulty);

  while (!block.validPOW()) {
    block.nonce += 1;
    block.hash = block.digest();
  }

  print("Mined block #${block.height}");
  return block;
}
