import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  Item({
    @required this.name,
    this.description,
  });
}
