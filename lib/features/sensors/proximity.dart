// import 'dart:async';

// import 'package:all_sensors2/all_sensors2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../home/presentation/viewmodel/home_view_model.dart';

// class ProximityScreen extends ConsumerStatefulWidget {
//   const ProximityScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _ProximityScreenState();
// }

// class _ProximityScreenState extends ConsumerState<ProximityScreen> {
//   double _proximityValue = 0;

//   final List<StreamSubscription<dynamic>> _streamSubscriptions =
//       <StreamSubscription<dynamic>>[];

//   @override
//   void initState() {
//     super.initState();

//     _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
//       setState(() {
//         _proximityValue = event.proximity;
//       });
//     }));
//   }

//   final GlobalKey _buttonKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     // if (_proximityValue >= 4) {
//     //   // Automatically logout when distance is greater than or equal to 4
//     //   ref.read(homeViewModelProvider.notifier).logout(context);
//     //   // You can add any other necessary actions for logging out here
//     //   return Scaffold(
//     //     appBar: AppBar(
//     //       title: const Text('Proximity'),
//     //     ),
//     //     body: const Center(
//     //       child: Text(
//     //         'Logging out...', // Display a message while logging out
//     //         style: TextStyle(fontSize: 25),
//     //       ),
//     //     ),
//     //   );
//     // } else {
//     //   return Scaffold(
//     //     appBar: AppBar(
//     //       title: const Text('Proximity'),
//     //     ),
//     //     body: const Center(
//     //       child: Text(
//     //         'Obj is near',
//     //         style: TextStyle(fontSize: 25),
//     //       ),
//     //     ),
//     //   );
//     // }

//     bool shouldTapButtonAutomatically = _proximityValue >= 4;

//     if (shouldTapButtonAutomatically) {
//       // Automatic tap when the condition is met
//       Future.delayed(const Duration(milliseconds: 200), () {
//         final dynamic button = _buttonKey.currentWidget;
//         button.onPressed(); // Simulate tap on the button
//       });
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Proximity'),
//       ),
//       // body: Center(
//       //   child: _proximityValue >= 4
//       //       ? ElevatedButton(
//       //           key: _buttonKey,
//       //           onPressed: () {
//       //             ref.read(homeViewModelProvider.notifier).logout(context);
//       //           },
//       //           child: const Text('Logout'))
//       //       : const Text(
//       //           'Obj is near',
//       //           style: TextStyle(fontSize: 25),
//       //         ),
//       // ),
//       body: Column(children: [
//         ElevatedButton(
//             key: _buttonKey,
//             onPressed: () {
//               // ref.read(homeViewModelProvider.notifier).logout(context);
//             },
//             child: const Text('Logout'))
//       ]),
//     );
//   }
// }
