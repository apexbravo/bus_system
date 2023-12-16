import 'dart:convert';

import 'package:bus_system/auth/session_Managers.dart';
import 'package:bus_system/home.dart';
import 'package:bus_system/models/role.dart';
import 'package:bus_system/models/user.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:bus_system/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? loginError;
  bool isLoading = false;
  final GlobalKey<FormState> _form1Key = GlobalKey();
  @override
  void initState() {
    super.initState();
    // SessionManager.clear();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/loginImage.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                form(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _obscureText = false;
  Widget form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100.0,
        bottom: 16,
      ),
      child: Form(
        key: _form1Key,
        child: Column(
          children: <Widget>[
            const Column(
              children: [
                Text(
                  "Bus",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Ticketing",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              width: 400,
              margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      hintText: "Username",
                      fillColor: Colors.white,
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).colorScheme.error
                            : Colors.black;
                        return TextStyle(color: color, letterSpacing: 1.3);
                      }),
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: const Icon(Icons.close),
                    ),
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value == '')
                          ? "Username is required"
                          : null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      hintText: "Password",
                      fillColor: Colors.white,
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).colorScheme.error
                            : Colors.black;
                        return TextStyle(color: color, letterSpacing: 1.3);
                      }),
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value == '')
                          ? "Password is required"
                          : null;
                    },
                    obscureText: !_obscureText,
                  ),
                  const SizedBox(height: 10.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(buttonPrimary),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                      savelogin();
                    },
                    child: isLoading
                        ? const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 12, top: 6, bottom: 6),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              Text(
                                "Signing in... Please wait",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(
                              color: buttonPrimaryTextColor,
                            ),
                          ),
                  ),
                  const SizedBox(height: 15.0),
                  if (loginError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        loginError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> savelogin() async {
    if (_form1Key.currentState!.validate()) {
      setState(() {
        loginError = null;
        isLoading = true;
      });

      User? user = await getUser(usernameController.text);

      if (user == null || !user.isActive) {
        bool isFirstLogin = await checkIfFirstLogin();
        String hashedPassword = hashPassword(passwordController.text);
        if (isFirstLogin) {
          // Create and save the superuser
          User superUser = User(
            name: "Administrator",
            password: hashedPassword,
            initials: "AD",
            email: usernameController.text,
            userRole: adminRole,
            isActive: true,
            tokenExpiryDate: DateTime.now().add(const Duration(hours: 1)),
          );

          // Save the superuser to the "users" collection in Firebase
          await FirebaseDb.collection('users')
              .doc(superUser.id)
              .set(superUser.toJson());

/*           await FirebaseFirestore.instance
              .collection('userRoles')
              .add(adminRole.toJson());
          await FirebaseFirestore.instance
              .collection('userRoles')
              .add(cashierRole.toJson()); */
          AppScaffold.isLoggedIn = true;
          SessionManagers.signIn(superUser);

          await Navigator.pushReplacementNamed(
              context, ModalRoute.of(context)!.settings.name!);
        }

        // Handle error, user not found or inactive
        // For example, show an error message to the user
        setState(() {
          loginError = "User not found or account is inactive";
          isLoading = false;
        });

        return;
      }

      // Hash the entered password for comparison with the stored hashed password
      String hashedPassword = hashPassword(passwordController.text);

      // Compare the hashed password provided by the user with the stored hashed password
      if (hashedPassword == user.password) {
        // Passwords match, grant access and perform necessary actions (e.g., navigate to home screen)
        // For example, you can call a function to handle successful login
        user.tokenExpiryDate = DateTime.now().add(const Duration(hours: 1));

        SessionManagers.signIn(user);

        AppScaffold.isLoggedIn = true;
        await Navigator.pushReplacementNamed(context, '/');
      } else {
        // Passwords don't match, handle incorrect password error
        // For example, show an error message to the user
        setState(() {
          loginError = "Incorrect password";
          isLoading = false;
        });
        return;
      }
    }
    // Check if there are any users in the "users" collection
  }

// Function to check if it's the first login (by checking if any users exist in the "users" collection)
  Future<bool> checkIfFirstLogin() async {
    try {
      // Query the "users" collection in Firebase
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      // Return true if there are no documents in the collection
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      print("Error checking first login: $e");
      return false;
    }
  }

// Function to hash the password using SHA256
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<User?>? getUser(String username) async {
    // Query the database to retrieve user data based on the provided username/email
    // For example, using Firebase Firestore:
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: username)
        .get();

    // If the user exists, create a User object and return it, else return null
    // For example:
    if (querySnapshot.docs.isNotEmpty) {
      var userData = querySnapshot.docs.first.data();
      return User.fromJson(userData);
    } else {
      return null;
      // }
    }
  }
}
