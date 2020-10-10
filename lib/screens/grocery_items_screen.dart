import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marketly/models/item_model.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/widgets.dart';
import 'package:marketly/config/constants.dart';
import 'package:marketly/config/palette.dart';

class GroceryItemsScreen extends StatefulWidget {
  final int groceryIndex;
  final GroceryItems groceryItems;

  GroceryItemsScreen({
    Key key,
    this.groceryIndex,
    this.groceryItems,
  }) : super(key: key);

  @override
  _GroceryItemsScreenState createState() => _GroceryItemsScreenState(
      groceryIndex: groceryIndex, groceryItems: groceryItems);
}

class _GroceryItemsScreenState extends State<GroceryItemsScreen> {
  final String cartBoxName = 'cart';
  final int groceryIndex;
  final GroceryItems groceryItems;

  final _formKey = GlobalKey<FormState>();
  String category = 'Unnamed Category';

  Box<GroceryItems> cart;

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  _GroceryItemsScreenState({
    this.groceryIndex,
    this.groceryItems
  }) : super();

  @override
  void initState() {
    super.initState();
    cart = Hive.box<GroceryItems>(cartBoxName);
  }

  @override
  Widget build(BuildContext context) {

    bool isExistingCategory = groceryItems != null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => HomeScreen()
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        isExistingCategory ? PopupMenuButton<String>(
                          onSelected: _triggerContextMenuAction,
                          icon: Icon(
                            Icons.more_vert,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) {
                            return categoryContextMenu.map((choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ) :
                        GestureDetector(
                          onTap: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _validateAndSaveGroceryItems(null, context);
                          },
                          child: Icon(
                            Icons.save,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'CATEGORY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    isExistingCategory ? HeaderLabel(labelText: groceryItems.category) :
                    Container(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          onSaved: (newValue) => category = newValue,
                          decoration: InputDecoration(
                            hintText: 'Enter category',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                            enabledBorder: outlineInputBorderDark(),
                            focusedBorder: outlineInputBorderDark(),
                            border: outlineInputBorderDark(),
                          ),
                          onChanged: (value) {
                            category = value;
                            if (_formKey.currentState.validate()) {
                              return;
                            }
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a category';
                            } else if (value.isNotEmpty) {
                              return null;
                            }
                            return null;
                          },
                          controller: categoryController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.9,
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text('Items', style: kTitleTextStyle),
                    ),
                    isExistingCategory && groceryItems.items.length > 0 ?
                    Expanded(
                      child: FutureBuilder<Box<GroceryItems>>(
                          future: Hive.openBox(cartBoxName),
                          builder: (context, snapshot) {
                            return ValueListenableBuilder(
                              valueListenable: cart.listenable(),
                              builder: (context, Box<GroceryItems> cart, _) {
                                GroceryItems grocery = cart.getAt(groceryIndex);
                                List<Item> items = grocery != null ? grocery.items : groceryItems.items;

                                return ListView.builder(
                                    itemCount: items.length,
                                    padding: EdgeInsets.symmetric(horizontal: 30),
                                    itemBuilder: (context, index) {
                                      Item item = items.toList()[index];
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) => ItemDialog(
                                              item: item,
                                              title: 'Edit ' + item.name,
                                              buttonText: 'Edit Item',
                                              buttonAction: (Item updatedItem) {
                                                groceryItems.items[index] = updatedItem;
                                                groceryItems.save();
                                                Navigator.pop(context);
                                              },
                                              deleteAction: () {
                                                GroceryItems groceryItems = cart.getAt(groceryIndex);
                                                groceryItems.items.removeAt(index);
                                                groceryItems.save();
                                                Navigator.pop(context);
                                              }
                                            ),
                                          );
                                        },
                                        child: ItemContent(
                                          number: "${index+1}",
                                          name: "${item.name}",
                                          description: "${item.description}"
                                        ),
                                      );
                                    }
                                );
                              },
                            );
                          }
                      ),
                    ) :
                    EmptyState(
                      actionText: 'Looks like there\'s nothing here!\nAdd new item',
                      actionCommand: () {
                        if (hasInvalidFormState()) {
                          return;
                        }
                        _addNewItem(context);
                      }
                    )
                  ],
                ),
              ),
              BottomBar(
                buttonText: 'Add New Item',
                buttonAction: () {
                  if (hasInvalidFormState()) {
                    return;
                  }
                  _addNewItem(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ItemDialog(
        item: Item(),
        title: 'Add new item',
        buttonText: 'Add Item',
        buttonAction: (Item newItem) {
          _validateAndSaveGroceryItems(newItem, context);
        },
      ),
    );
  }

  void _validateAndSaveGroceryItems(Item newItem, BuildContext context) {
    if (groceryIndex != null) {
      GroceryItems groceryItems = cart.getAt(groceryIndex);
      if (newItem != null) groceryItems.items.add(newItem);
      groceryItems.save();
    } else {
      Iterable<GroceryItems> existingGroceryItemsList = cart.values.where((element) => element.category == category);
      if (existingGroceryItemsList.length == 0) {
        GroceryItems groceryItems = GroceryItems(category: category, items: []);
        cart.add(groceryItems);
        if (newItem != null && groceryItems.items.length == 0) {
          groceryItems.items.add(newItem);
        }
        groceryItems.save();
        cart.watch();
        Navigator.pop(context);
      } else {
        GroceryItems groceryItems = existingGroceryItemsList.first;
        if (!groceryItems.isInBox) {
          cart.add(groceryItems);
        }
        groceryItems.save();
      }
    }
    Navigator.maybePop(context);
  }

  void _saveGroceryItems(categoryName) {
    GroceryItems groceryItems = cart.getAt(groceryIndex);
    groceryItems.category = categoryName;
    groceryItems.save();
  }

  bool hasInvalidFormState() => _formKey.currentState != null && !_formKey.currentState.validate();

  void _triggerContextMenuAction(String choice) {
    if (choice == RemoveCategory) {
      cart.getAt(groceryIndex).delete();
      Navigator.pop(context);
    } else if (choice == EditCategoryName) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: 'Edit Category Name',
          buttonText: 'Edit Category',
          buttonAction: (categoryName) {
            _saveGroceryItems(categoryName);
            Navigator.pop(context);
          },
        ),
      );
    }
  }
}
