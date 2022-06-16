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
  runApp(const MyConnexion());

}

class MyConnexion extends StatelessWidget {
  const MyConnexion({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepOrange,
      ),
      home: const MyConnexionPage(title: 'Le bon coin'),
    );
  }
}

class MyConnexionPage extends StatefulWidget {
  const MyConnexionPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyConnexionPage> createState() => _MyConnexionPageState();
}

class _MyConnexionPageState extends State<MyConnexionPage> {

  String mail = "";
  String password = "";
  String  prenom = "";
  String nom = "";
  DateTime birthday = DateTime.now();
  bool isregister = true;
  List<bool> selection = [true,false];




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Padding(
          child : bodyPage(),
          padding : const EdgeInsets.all(10),

        )
    );
  }


  Widget bodyPage(){
    //Créer un design de connexion comportant des champs d'entrée et un bouton
    //3 éléments(adresse mail, mot de passe , bouton) + 1 élément de logo
    return SingleChildScrollView(
      child: Column(
        children : [

          const SizedBox(height : 10),
          //Choix pour l'utilisateur
          ToggleButtons(
            children: const [
              Text("Inscription"),
              Text("Connexion")
            ],
            isSelected: selection,
            onPressed: (index){
              if(index == 0){
                setState(() {
                  selection[0] = true;
                  selection[1] = false;
                  isregister = true;
                });

              }
              else
              {
                setState(() {
                  selection[0] = false;
                  selection[1] = true;
                  isregister = false;
                });

              }

            },
          ),

          //Afficher le nom suivant les différents cas
          (isregister) ? TextField(
              decoration : InputDecoration(
                  hintText : "Entrer votre nom",
                  icon : const Icon(Icons.person),
                  border : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
              onChanged : (String value){
                setState((){
                  nom = value;
                });




              }

          ): Container(),

          const SizedBox(height : 10),



          (isregister) ? TextField(
              decoration : InputDecoration(
                  hintText : "Entrer votre prénom",
                  icon : const Icon(Icons.person),
                  border : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
              onChanged : (String value){
                setState((){
                  prenom = value;
                });




              }

          ): Container(),








          //Champs adresse mail
          const SizedBox(height : 10),

          TextField(
              decoration : InputDecoration(
                  hintText : "Entrer votre adresse mail",
                  icon : const Icon(Icons.mail),
                  border : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
              onChanged : (String value){
                setState((){
                  mail = value;
                });




              }

          ),



          //champs mot de passe

          const SizedBox(height : 10),


          TextField(
              obscureText : true,
              decoration : InputDecoration(
                hintText : "Entrer votre mot de passe",
                icon : const Icon(Icons.lock),
                border : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),

              ),
              onChanged : (value){
                setState((){
                  password = value;
                });
              }


          ),



          //Bouton
          const SizedBox(height : 10),

          ElevatedButton(
              onPressed : (){
                if(isregister == true){
                  //fonction pour s'inscrire
                  inscription();
                }
                else{
                  // Fonction pour se connecter
                  connexion();
                }


              },
              child : Text("Validation")

          )

        ],
      ),
    );

  }


  //Fonction
  inscription(){
    FirestoreHelper().createUser(nom, birthday, password, mail, prenom).then((value){
      setState(() {
        GlobalUser = value;
      });

      Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return dashBoard();
          }
      ));


    }).catchError((error){
      //Par exemple une perte de connexion
      print(error);

    });

  }



  connexion(){
    FirestoreHelper().connectUser(mail, password).then((value){
      setState(() {
        GlobalUser = value;



        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return dashBoard();
            }
        ));
      });


    }).catchError((error){
      //Afficher Pop connexion échoué
    });

  }




}