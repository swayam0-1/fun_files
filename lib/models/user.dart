import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String name;
  String profilePhoto;
  String email;
  String uid;
  Users({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePhoto,

  });
  Map<String,dynamic> toJson()=>{
    'name':name,
    'email':email,
    'uid':uid,
    'profilePhoto':profilePhoto,
  };
  static Users fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;
    return Users(
        name: snapshot['name'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto']
    );
  }
}
