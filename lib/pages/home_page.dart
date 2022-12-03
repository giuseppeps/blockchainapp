import 'package:blockchainapp/model/blockchain.dart';
import 'package:blockchainapp/model/miner.dart';
import 'package:blockchainapp/model/person.dart';
import 'package:blockchainapp/model/transaction.dart';
import 'package:blockchainapp/pages/edit_block_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Blockchain blockchain = Blockchain();
  TextEditingController controller = TextEditingController();
  TextEditingController controllerDiff = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BlockChain"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Digite a dificuldade :',
                  ),
                  TextField(controller: controllerDiff),
                  const Text(
                    'Adicione o nome da pessoa :',
                  ),
                  TextField(controller: controller),
                  TextButton(
                      onPressed: () {
                        blockchain.currentTransaction.add(Transaction(
                            sender: "eu",
                            recipient: "recipient",
                            person: Person(controller.text)));
                        blockchain.add(mineNewBlock(
                            blockchain: blockchain,
                            difficulty: int.parse(controllerDiff.text)));
                        setState(() {});
                      },
                      child: const Text("Adicionar"))
                ],
              ),
            ),
            Flexible(
              child: Container(),
            ),
            Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...blockchain.chain.map((element) {
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              EditBlockPage(
                                                block: element,
                                                blockchain: blockchain,
                                                difficulty: int.parse(
                                                    controllerDiff.text),
                                              ))),
                                  child: Card(
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text("Block height : "),
                                                Text(element.height.toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text("nome : "),
                                                Flexible(
                                                  child: Text(
                                                    element.person.name ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text("Block hash : "),
                                                Flexible(
                                                  child: Text(
                                                    element.hash,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text("Nonce : "),
                                                Flexible(
                                                  child: Text(
                                                    element.nonce.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text("Previous hash : "),
                                                Flexible(
                                                  child: Text(
                                                    element.prevHash ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              })
                            ]),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
