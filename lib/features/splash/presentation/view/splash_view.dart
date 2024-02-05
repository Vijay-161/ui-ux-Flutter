import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      ref.read(splashViewModelProvider.notifier).init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: height * 0.20,
            child: const FittedBox(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/logo.jpg',
                ),
                radius: 70,
              ),
            ),
          ),
        ),
        SizedBox(
            height: height * 0.2,
            child: const Column(
              children: [
                Text(
                  'From',
                  style: TextStyle(fontSize: 23, color: Colors.black),
                ),
                Text(
                  'Vijay Singh',
                  style: TextStyle(fontSize: 25, color: Colors.red),
                )
              ],
            ))
      ],
    ));
  }
}
