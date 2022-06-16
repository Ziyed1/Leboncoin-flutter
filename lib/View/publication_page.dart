import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:boncoin/Services/FirestoreHelper.dart';
import 'package:boncoin/Services/global.dart';
import 'package:boncoin/View/membre_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:boncoin/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyPublication());
}

class MyPublication extends StatelessWidget {
  const MyPublication({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyPublicationPage(title: 'Le bon coin'),
    );
  }
}

class MyPublicationPage extends StatefulWidget {
  const MyPublicationPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyPublicationPage> createState() => _MyPublicationPageState();
}

class _MyPublicationPageState extends State<MyPublicationPage> {
  String Titre = "";
  String Categorie = "";
  String Prix = "";
  String Description = "";

  CollectionReference annonces =
      FirebaseFirestore.instance.collection("Annonces");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Publier une annonce - Le bon coin"),
        ),
        body: Padding(
          child: bodyPage(),
          padding: const EdgeInsets.all(10),
        ));
  }

  Widget bodyPage() {
    //Design de la page de publication des annonces

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage("assets/add.png"),
          ),
          const SizedBox(height: 30),
          TextField(
              decoration: InputDecoration(
                  hintText: "Titre de l'annonce",
                  icon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (String value) {
                setState(() {
                  Titre = value;
                });
              }),
          const SizedBox(height: 10),
          TextField(
              decoration: InputDecoration(
                  hintText: "Catégorie",
                  icon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (String value) {
                setState(() {
                  Categorie = value;
                });
              }),
          const SizedBox(height: 10),
          TextField(
              decoration: InputDecoration(
                  hintText: "Prix",
                  icon: const Icon(Icons.euro),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (String value) {
                setState(() {
                  Prix = value;
                });
              }),
          const SizedBox(height: 10),
          TextField(
              decoration: InputDecoration(
                  hintText: "Description",
                  icon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (String value) {
                setState(() {
                  Description = value;
                });
              }),
          ElevatedButton(
              onPressed: () async {
                await annonces.add({
                  'Titre': Titre,
                  'Catégorie': Categorie,
                  'Prix': Prix,
                  'Description': Description
                }).then((value) => print('Annonce ajoutée'));
              },
              child: Text("Publier"))
        ],
      ),
    );
  }


}
