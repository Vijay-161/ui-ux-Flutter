import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/config/routes/app_route.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:shoe_store/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:shoe_store/features/splash/presentation/viewmodel/splash_view_model.dart';

import '../../../../../config/constants/api_endpoint.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final _gap = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var userState = ref.read(authViewModelProvider);
    var splashState = ref.read(splashViewModelProvider);
    // return Scaffold(
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       _gap,
    //       Container(
    //         alignment: Alignment.center,
    //         child: Column(
    //           children: [
    //             CircleAvatar(
    //               radius: 80,
    //               backgroundImage: NetworkImage(
    //                 userState.currentUser == null
    //                     ? ApiEndpoints.userImageUrl + splashState.user.image!
    //                     : ApiEndpoints.userImageUrl +
    //                         userState.currentUser!.image!,
    //               ),
    //             ),
    //             Text(
    //               userState.currentUser != null
    //                   ? userState.currentUser!.username
    //                   : splashState.user.username,
    //               style: const TextStyle(
    //                 color: Colors.black87,
    //                 fontSize: 30,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             Text(
    //               userState.currentUser == null
    //                   ? splashState.user.email
    //                   : userState.currentUser!.email,
    //               style: const TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 21,
    //                   fontStyle: FontStyle.italic),
    //             ),
    //             _gap,
    //             SizedBox(
    //               width: 200,
    //               child: ElevatedButton(
    //                 onPressed: () {},
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: const Color.fromARGB(255, 237, 217, 35),
    //                 ),
    //                 child: const Text(
    //                   'Edit Profile',
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const Divider(),
    //       ListTile(
    //         leading: Container(
    //           width: 50,
    //           height: 50,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(100),
    //             color: Colors.grey,
    //           ),
    //           child: const Icon(Icons.call),
    //         ),
    //         title: Text(
    //           userState.currentUser == null
    //               ? splashState.user.phone
    //               : userState.currentUser!.phone,
    //           style: const TextStyle(
    //             color: Colors.black87,
    //             fontSize: 21,
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         leading: Container(
    //           width: 50,
    //           height: 50,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(100),
    //             color: Colors.grey,
    //           ),
    //           child: const Icon(Icons.person),
    //         ),
    //         title: Text(
    //           userState.currentUser == null
    //               ? splashState.user.fullName
    //               : userState.currentUser!.fullName,
    //           style: const TextStyle(
    //             color: Colors.black87,
    //             fontSize: 21,
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         leading: Container(
    //           width: 50,
    //           height: 50,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(100),
    //             color: Colors.grey,
    //           ),
    //           child: const Icon(
    //             Icons.male_outlined,
    //           ),
    //         ),
    //         title: Text(
    //           userState.currentUser == null
    //               ? splashState.user.gender
    //               : userState.currentUser!.gender,
    //           style: const TextStyle(
    //             color: Colors.black87,
    //             fontSize: 21,
    //           ),
    //         ),
    //       ),
    //       _gap,
    //       InkWell(
    //         onTap: () {
    //           ref.read(homeViewModelProvider.notifier).logout(context);
    //         },
    //         child: ListTile(
    //           leading: Container(
    //             width: 50,
    //             height: 50,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(100),
    //               color: Colors.grey,
    //             ),
    //             child: const Icon(
    //               Icons.logout,
    //             ),
    //           ),
    //           title: const Text(
    //             'Logout',
    //             style: TextStyle(
    //               color: Colors.red,
    //               fontSize: 21,
    //             ),
    //           ),
    //         ),
    //       ),

    //       // Stack(
    //       //   clipBehavior: Clip.none,
    //       //   children: [
    //       //     Container(
    //       //       height: 150,
    //       //       width: width,
    //       //       color: const Color.fromARGB(255, 182, 134, 134),
    //       //     ),
    //       //     Positioned(
    //       //         bottom: 5,
    //       //         right: 1,
    //       //         child: Column(
    //       //           children: [
    //       //             Text(
    //       //               userState.currentUser != null
    //       //                   ? userState.currentUser!.fullName
    //       //                   : splashState.user.fullName,
    //       //               style: const TextStyle(
    //       //                 color: Colors.black87,
    //       //                 fontSize: 30,
    //       //                 fontWeight: FontWeight.bold,
    //       //               ),
    //       //             ),
    //       // Text(
    //       //   userState.currentUser == null
    //       //       ? splashState.user.email
    //       //       : userState.currentUser!.email,
    //       //   style: const TextStyle(
    //       //       color: Colors.black,
    //       //       fontSize: 20,
    //       //       fontStyle: FontStyle.italic),
    //       // ),
    //       //           ],
    //       //         )),
    //       //     Positioned(
    //       //       bottom: -20,
    //       //       left: 0,
    //       //       child: CircleAvatar(
    //       //         radius: 80,
    //       //         backgroundImage: NetworkImage(
    //       //           userState.currentUser == null
    //       //               ? ApiEndpoints.userImageUrl + splashState.user.image!
    //       //               : ApiEndpoints.userImageUrl +
    //       //                   userState.currentUser!.image!,
    //       //         ),
    //       //       ),
    //       //     ),
    //       //   ],
    //       // ),
    //       // const Text('vijay')
    //     ],
    //   ),
    // );
    return Scaffold(
      // body: Column(
      //   children: [
      //     if (userState.isLoading) ...{
      //       const Expanded(child: Center(child: CircularProgressIndicator())),
      //     } else if (userState.error != null) ...{
      //       Text(userState.error.toString()),
      //     } else ...{
      //       const Expanded(
      //         child: Column(
      //           children: [],
      //         ),
      //       ),
      //     },
      //   ],
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          // const CircleAvatar(
          //   radius: 60,
          //   backgroundImage: AssetImage('assets/images/logo.jpg'),
          // ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  // backgroundImage: AssetImage('assets/images/logo.jpg'),
                  backgroundImage: NetworkImage(
                    userState.currentUser == null
                        ? ApiEndpoints.userImageUrl + splashState.user.image!
                        : ApiEndpoints.userImageUrl +
                            userState.currentUser!.image!,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.cardRoute);
                    },
                    icon: const Icon(Icons.edit),
                    iconSize: 30,
                    color: const Color.fromARGB(255, 10, 5, 131),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            userState.currentUser == null
                ? splashState.user.fullName
                : userState.currentUser!.fullName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            Icons.email,
            'Email',
            userState.currentUser == null
                ? splashState.user.email
                : userState.currentUser!.email,
          ),
          _buildInfoCard(
            Icons.phone,
            'Phone',
            userState.currentUser == null
                ? splashState.user.phone
                : userState.currentUser!.phone,
          ),
          _buildInfoCard(
            Icons.male,
            'Gender',
            userState.currentUser == null
                ? splashState.user.gender
                : userState.currentUser!.gender,
          ),
          // _buildInfoCard(Icons.confirmation_number, 'User Code',
          //     userState.currentUser.userCode!),
          // _buildInfoCard(Icons.swap_horiz, 'Total Transactions',
          //     userState.currentUser.totalTransictions!),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: IconButton(
                onPressed: () {
                  ref.read(homeViewModelProvider.notifier).logout(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromRGBO(81, 78, 182, 2),
                ),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              // subtitle: const Text(
              //   'nothing',
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInfoCard(IconData icon, String title, String value) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10),
    elevation: 3,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        icon,
        color: const Color.fromRGBO(81, 78, 182, 2),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}
