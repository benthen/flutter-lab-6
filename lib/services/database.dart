import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  // String sugars = '';
  // String name = '';
  // int strength = 0;

  // Database({required this.sugars, required String name, required int strength});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  // Future add(String sugars, String name, int strength) async {
  //   return await brewCollection.add({
  //     'sugars': sugars,
  //     'name': name,
  //     'strength': strength,
  //   });
  // }

  Future update(String sugars, String name, int strength) async {
    print(sugars);
    print(strength);
    print(name);
    return await brewCollection.doc().set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Future getDocs() async {
    List list = [];
    try {
      await brewCollection.get().then((value) => value.docs.forEach((element) {
            list.add(element.data());
          }));
        return list;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
