import 'package:blockchainapp/model/block.dart';
import 'package:blockchainapp/model/transaction.dart';

class Blockchain {
  late List<Block> chain = [];
  late List<Transaction> currentTransaction = [];

  Blockchain() {
    chain.add(genesisBlock);
  }

  Block newBlock(int difficulty) {
    Block block = Block(
      lastBlock.hash,
      lastBlock.height + 1,
      difficulty,
    );

    for (int i = 0; i < currentTransaction.length; i++) {
      block.person = (currentTransaction[i].person);
    }

    return block;
  }

  Block get lastBlock {
    return chain.last;
  }

  Block get previousBlock {
    return chain[chain.length - 1];
  }

  Block get genesisBlock {
    return Block(null, 0, 1);
  }

  void add(Block block) {
    if (isValidBlock(block)) {
      chain.add(block);
      currentTransaction.clear();
    }
  }

  bool isValidBlock(Block block) {
    if (!block.validPOW()) {
      print("Block #${block.height} --> Invalid PoW");
      return false;
    } else if (block.prevHash != previousBlock.hash) {
      print("Block #${block.height} --> Invalid previous hash");
      return false;
    } else if (block.height != previousBlock.height + 1) {
      print("Block #${block.height} --> Invalid index");
      return false;
    } else if (block.digest() != block.hash) {
      print("Block #${block.height} --> Invalid hash");
      return false;
    } else if (currentTransaction
        .any((e) => e.prevHash?.endsWith(block.hash) ?? false)) {
      print("Block #${block.height} --> Invalid: Duplicate block");
      return false;
    }

    return true;
  }
}
