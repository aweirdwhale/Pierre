/*
This page is shown only one time : it asks for {manageMediaAccess} perms
*/
import 'package:flutter/material.dart';
import 'package:pierre/handlers/permissionhandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  Future<bool> permissions() async {
    // Accepte les permissions
    PermissionHandler handler = PermissionHandler();
    bool isOk = await handler.requestPerm();

    if (isOk) {
      // Marque l'onboarding comme terminé
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('hasSeenOnboarding', true);

      return true;
    } else {
      return permissions();
      // ask again
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Onboarding")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (await permissions()) {
              // Redirige vers la page principale
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Placeholder()),
              );
            }
          },
          child: Text("Accorder les permissions"),
        ),
      ),
    );
  }
}
