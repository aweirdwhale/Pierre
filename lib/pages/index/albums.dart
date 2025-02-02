import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  List<Map<String, String>> albums = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Albums'),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: albums.length + 1, // Inclut le bouton "+"
        itemBuilder: (BuildContext context, int i) {
          if (i < albums.length) {
            return GestureDetector(
              onTap: () => _navigateToAlbum(context, i),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    albums[i]["name"] ?? "Album",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => _openCreateAlbumPage(),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(CupertinoIcons.add),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _navigateToAlbum(BuildContext context, int albumIndex) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AlbumDetail(
          name: albums[albumIndex]["name"]!,
          description: albums[albumIndex]["description"]!,
        ),
      ),
    );
  }

  void _openCreateAlbumPage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CreateAlbum(
          onAlbumCreated: (String name, String description) {
            setState(() {
              albums.add({"name": name, "description": description});
            });
          },
        ),
      ),
    );
  }
}

class AlbumDetail extends StatelessWidget {
  final String name;
  final String description;

  AlbumDetail({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(name),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CreateAlbum extends StatefulWidget {
  final Function(String, String) onAlbumCreated;

  CreateAlbum({required this.onAlbumCreated});

  @override
  _CreateAlbumState createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _createAlbum() {
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();

    if (name.isNotEmpty && description.isNotEmpty) {
      widget.onAlbumCreated(name, description);
      Navigator.pop(context);
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Erreur"),
        content: Text("Veuillez remplir tous les champs."),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Créer un album'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _createAlbum,
          child: Text('Créer'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Choisissez une image",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
            CupertinoTextField(
              controller: nameController,
              placeholder: "Nom de l'album",
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}
