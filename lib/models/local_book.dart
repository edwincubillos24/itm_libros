import 'package:hive/hive.dart';

part 'local_book.g.dart';

@HiveType(typeId: 0)
class LocalBook extends HiveObject{

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? author;

  @HiveField(2)
  String? bookImage;

  @HiveField(3)
  String? publisher;

  @HiveField(4)
  String? description;

}