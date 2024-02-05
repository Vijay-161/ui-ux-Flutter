import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoint.dart';
import '../../../../auth/presentation/viewmodel/auth_view_model.dart';
import '../../../../home/presentation/viewmodel/home_view_model.dart';
import '../../../../splash/presentation/viewmodel/splash_view_model.dart';

class AdminProfileView extends ConsumerStatefulWidget {
  const AdminProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminProfileViewState();
}

class _AdminProfileViewState extends ConsumerState<AdminProfileView> {
  final _gap = const SizedBox(
    height: 10,
  );

  double _proximityValue = 0;

  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
      });
    }));
  }

  final GlobalKey _logoutKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var userState = ref.read(authViewModelProvider);
    var splashState = ref.read(splashViewModelProvider);

    bool shouldTapButtonAutomatically = _proximityValue >= 4;

    if (shouldTapButtonAutomatically) {
      // Automatic tap when the condition is met
      Future.delayed(const Duration(milliseconds: 200), () {
        final dynamic button = _logoutKey.currentWidget;
        button.onPressed(); // Simulate tap on the button
      });
      // setState(() {
      //   shouldTapButtonAutomatically = false;
      // });
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gap,
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 150,
                      width: width,
                      color: const Color.fromARGB(255, 182, 134, 134),
                    ),
                    Positioned(
                        bottom: 5,
                        right: 1,
                        child: Column(
                          children: [
                            Text(
                              userState.currentUser != null
                                  ? userState.currentUser!.fullName
                                  : splashState.user.fullName,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userState.currentUser == null
                                  ? splashState.user.email
                                  : userState.currentUser!.email,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                          userState.currentUser == null
                              ? ApiEndpoints.userImageUrl +
                                  splashState.user.image!
                              : ApiEndpoints.userImageUrl +
                                  userState.currentUser!.image!,
                        ),
                      ),
                    ),
                  ],
                ),
                // CircleAvatar(
                //   radius: 80,
                //   backgroundImage: NetworkImage(
                //     userState.currentUser == null
                //         ? ApiEndpoints.userImageUrl + splashState.user.image!
                //         : ApiEndpoints.userImageUrl +
                //             userState.currentUser!.image!,
                //   ),
                // ),

                _gap,
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 237, 217, 35),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(Icons.call),
            ),
            title: Text(
              userState.currentUser == null
                  ? splashState.user.phone
                  : userState.currentUser!.phone,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 21,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(Icons.person),
            ),
            title: Text(
              userState.currentUser == null
                  ? splashState.user.fullName
                  : userState.currentUser!.fullName,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 21,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
              child: const Icon(
                Icons.male_outlined,
              ),
            ),
            title: Text(
              userState.currentUser == null
                  ? splashState.user.gender
                  : userState.currentUser!.gender,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 21,
              ),
            ),
          ),
          _gap,
          InkWell(
            onTap: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey,
                ),
                child: const Icon(
                  Icons.logout,
                ),
              ),
              // title: const Text(
              //   'Logout',
              //   style: TextStyle(
              //     color: Colors.red,
              //     fontSize: 21,
              //   ),
              // ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ElevatedButton(
                    //   key: _buttonKey,
                    //   onPressed: () {
                    //     ref.read(homeViewModelProvider.notifier).logout(context);
                    //   },
                    //   child: const Text('Logout'),
                    // ),
                    TextButton(
                      key: _logoutKey,
                      onPressed: () {
                        ref
                            .read(homeViewModelProvider.notifier)
                            .logout(context);
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
