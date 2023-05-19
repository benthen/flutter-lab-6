class UserInfo{

  String uid;

  UserInfo({required this.uid});

  Future<String> getUid() async{
    return uid;
  }

}