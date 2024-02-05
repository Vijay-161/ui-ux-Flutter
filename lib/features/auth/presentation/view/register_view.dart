import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoe_store/config/routes/app_route.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:shoe_store/features/auth/presentation/widget/register_widgets.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(authViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var gap = const SizedBox(
    height: 10,
  );
  String? gender;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        height: height * 0.95,
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(children: [
              gap,
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.grey[300],
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _browseImage(ref, ImageSource.camera);
                              Navigator.pop(context);
                              // Upload image it is not null
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _browseImage(ref, ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _img != null
                        ? FileImage(_img!)
                        : const AssetImage('assets/images/camera.png')
                            as ImageProvider,
                  ),
                ),
              ),
              createFormFields(
                  "Full Name", _nameController, false, Icons.person_2_outlined,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Fullname';
                }
                return null;
              }),
              gap,
              createFormFields("Email", _emailController, false, Icons.email,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Email';
                }
                return null;
              }),
              gap,
              createFormFields("Phone", _phoneController, false, Icons.phone,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Fullname';
                }
                return null;
              }),
              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (val) {
                        setState(() {
                          gender = val;
                        });
                      },
                      title: const Text('Male'),
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (val) {
                        setState(() {
                          gender = val;
                        });
                      },
                      title: const Text('Female'),
                    ),
                  ),
                ],
              ),
              gap,
              TextFormField(
                controller: _addressController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: const Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(Icons.location_city_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                  ),
                ),
              ),
              gap,
              createFormFields("Username", _userController, false, Icons.person,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Fullname';
                }
                return null;
              }),
              gap,
              createFormFields("Password", _passwordController, true,
                  Icons.password_outlined, (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Fullname';
                }
                return null;
              }),
              gap,
              SizedBox(
                width: width / 2,
                height: 40,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      var user = UserEntity(
                        fullName: _nameController.text,
                        image: authState.imageName,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        gender: gender!,
                        address: _addressController.text,
                        username: _userController.text,
                        password: _passwordController.text,
                      );

                      ref
                          .read(authViewModelProvider.notifier)
                          .registerUser(user);

                      if (authState.error != null) {
                        showSnackBar(
                          message: authState.error.toString(),
                          context: context,
                          color: Colors.red,
                        );
                      } else {
                        showSnackBar(
                          message: 'Registered successfully',
                          context: context,
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              gap,
              RichText(
                text: TextSpan(
                    text: 'Already Registered!',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                          text: '  Sign in',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, AppRoute.loginRoute);
                            }),
                    ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
