import "package:flutter/material.dart";

class ContractScreen extends StatefulWidget {
  final String typeOfPerson;
  const ContractScreen({super.key, required this.typeOfPerson});

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
