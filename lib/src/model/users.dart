import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String name;
  final String lastname;
  final String number;
  final int age;
  final String? image;

  MyUser(this.id, this.name, this.lastname, this.number, this.age,
      {this.image});

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastname': lastname,
      'number': number,
      'age': age,
      'image': newImage ?? image,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastname = data['lastname'] as String,
        number = data['number'] as String,
        age = data['age'] as int,
        image = data['image'] as String?;
}
