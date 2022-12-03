import 'package:blockchainapp/model/miner.dart';
import 'package:blockchainapp/model/person.dart';
import 'package:blockchainapp/model/transaction.dart';
import 'package:blockchainapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:blockchainapp/model/block.dart';
import 'package:blockchainapp/model/blockchain.dart';

class EditBlockPage extends StatefulWidget {
  final Block block;
  final Blockchain blockchain;
  final int difficulty;

  const EditBlockPage({
    Key? key,
    required this.blockchain,
    required this.block,
    required this.difficulty,
  }) : super(key: key);

  @override
  State<EditBlockPage> createState() => _EditBlockPageState();
}

class _EditBlockPageState extends State<EditBlockPage> {
  late TextEditingController hashController;
  late TextEditingController nameController;

  @override
  void initState() {
    hashController = TextEditingController(text: widget.block.hash);
    nameController = TextEditingController(text: widget.block.person.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Edit block #${widget.block.height}")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'Hash :',
                ),
              ),
              Expanded(
                flex: 6,
                child: TextFormField(
                    controller: hashController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                  child: Text(
                'Previous Hash :',
              )),
              Expanded(
                flex: 6,
                child: TextFormField(
                    controller:
                        TextEditingController(text: widget.block.prevHash),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                  child: Text(
                'Height :',
              )),
              Expanded(
                flex: 6,
                child: TextFormField(
                    controller: TextEditingController(
                        text: widget.block.height.toString()),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                  child: Text(
                'Nonce :',
              )),
              Expanded(
                flex: 6,
                child: TextFormField(
                    controller: TextEditingController(
                        text: widget.block.nonce.toString()),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                  child: Text(
                'Person name :',
              )),
              Expanded(
                flex: 6,
                child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                    )),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                int index = widget.block.height;
                widget.blockchain.currentTransaction.add(Transaction(
                    sender: "eu",
                    recipient: "recipient",
                    person: Person(nameController.text)));
                widget.blockchain.chain
                  ..removeAt(index)
                  ..insert(
                      index,
                      mineNewBlock(
                          blockchain: widget.blockchain,
                          difficulty: widget.difficulty));
                Navigator.of(context).pop();
              },
              child: const Text("Adicionar"))
        ]),
      ),
    );
  }
}
