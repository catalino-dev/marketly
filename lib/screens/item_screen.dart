import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:marketly/config/constants.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/models/item_model.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/widgets.dart';

class ItemScreen extends StatefulWidget {
  final int groceryIndex;
  final String category;
  final int itemIndex;
  final Item item;

  ItemScreen({
    Key key,
    this.groceryIndex,
    this.category,
    this.itemIndex,
    this.item,
  });

  @override
  _ItemScreenState createState() => _ItemScreenState(
      groceryIndex: groceryIndex,
      category: category,
      itemIndex: itemIndex,
      item: item);
}

class _ItemScreenState extends State<ItemScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController descriptionController;

  final String cartBoxName = 'cart';
  final int groceryIndex;
  final String category;
  final int itemIndex;
  final Item item;

  Box<GroceryItems> cart;
  final List<String> errors = [];
  String name;

  _ItemScreenState({
    this.groceryIndex,
    this.category,
    this.itemIndex,
    this.item
  }) : super();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();
    cart = Hive.box<GroceryItems>(cartBoxName);
    nameController = TextEditingController(text: item?.name);
    descriptionController = TextEditingController(text: item?.description);
  }

  @override
  Widget build(BuildContext context) {

    bool isExistingItem = item != null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 60),
                    height: 275.0,
                    color: Palette.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                            isExistingItem ? PopupMenuButton<String>(
                              onSelected: _triggerContextMenuAction,
                              icon: Icon(
                                Icons.more_vert,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              itemBuilder: (BuildContext context){
                                return itemContextMenu.map((String choice){
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ) : SizedBox(),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        HeaderLabel(labelText: isExistingItem ? item.name : 'Add new item'),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.9,
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) => name = newValue,
                          onChanged: (value) {
                            if (_formKey.currentState.validate()) {
                              return;
                            }
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a name';
                            } else if (value.isNotEmpty) {
                              return null;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          controller: nameController,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (newValue) => name = newValue,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter description',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomBar(
                buttonText: isExistingItem ? 'Update Item' : 'Add Item',
                buttonAction: () {
                  final String name = nameController.text;
                  final String description = descriptionController.text;

                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  Item item = Item(name: name, description: description);

                  GroceryItems activeCart;
                  if (groceryIndex != null) {
                    activeCart = cart.getAt(groceryIndex);
                    List<Item> items = activeCart.items;
                    if (itemIndex != null) {
                      items[itemIndex].name = name;
                      items[itemIndex].description = description;
                    } else {
                      activeCart.items.add(item);
                    }

                    activeCart.save();
                    Navigator.pop(context);
                  } else {
                    activeCart = GroceryItems(
                        category: category,
                        items: [Item(name: name, description: description)]
                    );
                    cart.add(activeCart);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GroceryItemsScreen(groceryIndex: groceryIndex, groceryItems: activeCart),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _triggerContextMenuAction(String choice) {
    if (choice == RemoveItem) {
      GroceryItems groceryItems = cart.getAt(groceryIndex);
      groceryItems.items.removeAt(itemIndex);
      groceryItems.save();
      Navigator.pop(context);
    }
  }
}
