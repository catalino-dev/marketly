import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  Item({
    this.name,
    this.description,
  });
}
