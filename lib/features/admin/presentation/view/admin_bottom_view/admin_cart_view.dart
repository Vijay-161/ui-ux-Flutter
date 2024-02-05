import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCartView extends ConsumerStatefulWidget {
  const AdminCartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminCartViewState();
}

class _AdminCartViewState extends ConsumerState<AdminCartView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Admin Cart')),
    );
  }
}
