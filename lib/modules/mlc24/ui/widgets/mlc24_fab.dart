import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import '../add_transaction/add_transaction_page.dart';

class MLC24Fab extends StatelessWidget {
  const MLC24Fab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Cargar pedido'),
      icon: const Icon(UniconsLine.plus),
      onPressed: () {
        Navigator.push(context, AddMLC24Page.route());
      },
    );
  }
}
