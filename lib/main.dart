import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PermissionTestScreen(),
    );
  }
}

class PermissionTestScreen extends StatefulWidget {
  @override
  PermissionTestScreenState createState() => PermissionTestScreenState();
}

class PermissionTestScreenState extends State<PermissionTestScreen> {
  String permStat = "Vérification des permissions...";

  @override
  void initState() {
    super.initState();
    // add some delay
    Future<void>.delayed(Duration(seconds: 1), () {
      askPermission();
    });
  }

  Future<bool> askPermission() async {
    PermissionStatus mediaAccess =
        await Permission.manageExternalStorage.status;
    if (mediaAccess.isGranted) {
      print("Permissions {manageExternalStorage} accordées");
      permStat = "Accordé.";
      return true;
    } else {
      print("Permissions {manageExternalStorage} accordées ");
      permStat = "Refusé.";

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test de Permissions")),
      body: Center(
        child: ButtonTheme(
          minWidth: 200.0,
          height: 50.0,
          child: Text(permStat),
        ),
      ),
    );
  }
}
