import 'package:cloud_firestore/cloud_firestore.dart';

class Annonce {
  //Attributs
  late String id ;
  late String Titre;
  late String Categorie;
  late String Prix;
  late String description;
  String? photo;

  //Constructeur
  Annonce(DocumentSnapshot snapshot){
    String? provisoire;
    id = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;

    Titre = map["Titre"];
    Categorie = map["Catégorie"];
    Prix = map["Prix"];
    description = map["Description"];
    provisoire = map["Photo"];

    if(provisoire == null){
      // Une image spécifique que je vais luis donner
      photo = "";
    }
    else
    {
      photo = provisoire;
    }


  }

  Annonce.empty(){
    id = "";
    Titre ="";
    Categorie="";
    Prix = "";
    description ="";
    photo ="";

  }


}