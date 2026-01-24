import 'dart:ffi';

class User{
  final String id;
  final String name;
  final String avatar;
  final int age;
  final String city;
  final String  birthdate;


  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.age,
    required this.city,
    required this.birthdate,

});

  factory User.fromJson(Map<String ,dynamic> json){
    return User(
      id : json['id'],
      name: json['name'],
      avatar: json['avatar'],
      city: json['city'],
      birthdate: json['birthdate'],
        age: int.tryParse(json['age']?.toString() ?? '0') ?? 0,
        //\ กันแอปพัง: แปลงค่า age ให้เป็น String ก่อนแล้วค่อย Parse เป็น int ถ้าไม่ได้ให้ใช้ 0
    );
  }

}