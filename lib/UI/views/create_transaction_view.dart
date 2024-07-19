import 'package:flutter/material.dart';

class CreateTransactionView extends StatefulWidget {
  static const routeName = '/create-transaction';
  const CreateTransactionView({super.key});

  @override
  State<CreateTransactionView> createState() => _CreateTransactionViewState();
}

class _CreateTransactionViewState extends State<CreateTransactionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Transaction'),
      ),
      body: const Center(
        child: Text('Create Transaction'),
      ),
    );
  }
}