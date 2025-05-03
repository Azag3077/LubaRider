import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoostEarningsPage extends ConsumerWidget {
  const BoostEarningsPage({super.key});

  static const routeName = '/boost-earnings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boost earnings')),
    );
  }
}
