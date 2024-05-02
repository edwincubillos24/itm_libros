import 'package:hive/hive.dart';

import 'models/local_book.dart';

class Boxes {
  static Box<LocalBook> getFavoritesBox() => Hive.box<LocalBook>('favorites_book');
}
