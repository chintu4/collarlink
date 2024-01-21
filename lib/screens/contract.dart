import "package:flutter/material.dart";

class ContractScreen extends StatefulWidget {
  final String typeOfPerson;
  const ContractScreen({Key? key, required this.typeOfPerson})
      : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        );
  }
}
