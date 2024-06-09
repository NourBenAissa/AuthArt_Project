class NormalUser {
  String uid;
  String Name;
  String FName;
  String imagePath;
  String Email;
  List following;
  List favorits;
  NormalUser();

  Map<String, dynamic> toJson() => {
    'uid':uid,'name':Name,'familyName':FName,'imagePath':imagePath,'email':Email,'favorits':favorits,
  };

  NormalUser.fromSnapShot(snapshot) :
        uid = snapshot.data() ['uid'],
        Name = snapshot.data() ['name'],
        FName = snapshot.data() ['familyName'],
        imagePath = snapshot.data() ['imagePath'],
        Email = snapshot.data() ['email'],

        favorits = snapshot.data() ['favorits'];


}
