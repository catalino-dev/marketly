import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  const Item({
    @required this.name,
    @required this.description,
  });
}
