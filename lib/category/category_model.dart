import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
class Category {

  @HiveField(0)
  final String name;

  const Category({
    @required this.name
  });
}
