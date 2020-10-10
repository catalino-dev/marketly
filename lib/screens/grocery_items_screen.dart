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
    Hive.openBox<GroceryItems>(cartBoxName);
    cart = Hive.box<GroceryItems>(cartBoxName);
  }

  final List<String> errors = [];

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
  Widget build(BuildContext context) {

    bool isExistingCategory = groceryItems != null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
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
                            groceryItems != null ? PopupMenuButton<String>(
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
                            ) : SizedBox(),
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
                        SizedBox(height: 5.0),
                        isExistingCategory ? HeaderLabel(labelText: groceryItems.category) :
                        Container(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              onSaved: (newValue) => category = newValue,
                              decoration: InputDecoration(
                                hintText: 'Enter category',
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  removeError(error: 'Enter a category');
                                }
                                category = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  addError(error: 'Enter a category');
                                  return "";
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
                ],
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
                    isExistingCategory ?
                    Expanded(
                      child: FutureBuilder<Box<GroceryItems>>(
                          future: Hive.openBox(cartBoxName),
                          builder: (context, snapshot) {
                            return ValueListenableBuilder(
                              valueListenable: cart.listenable(),
                              builder: (context, Box<GroceryItems> cart, _) {
                                GroceryItems grocery = cart.get(groceryIndex);
                                String category = grocery != null ? grocery.category : groceryItems.category;
                                List<Item> items = grocery != null ? grocery.items : groceryItems.items;

                                if (cart.values.length > 0) {
                                  return ListView.builder(
                                      itemCount: items.length,
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      itemBuilder: (context, index) {
                                        Item item = items.toList()[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => ItemScreen(
                                                    groceryIndex: groceryIndex,
                                                    category: category,
                                                    itemIndex: index,
                                                    item: item
                                                ),
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
                                } else {
                                  return Scaffold();
                                }
                              },
                            );
                          }
                      ),
                    ) :
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                'Looks like there\'s nothing here!\nAdd new item',
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  fontSize: 16,
                                  color: kTextColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (hasInvalidFormState()) {
                                    return;
                                  }
                                  navigateToItemScreen(context, category);
                                },
                                child: Icon(
                                  Icons.add_circle_rounded,
                                  size: 80.0,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomBar(
                buttonText: 'Add New Item',
                buttonAction: () {
                  if (hasInvalidFormState()) {
                    return;
                  }
                  navigateToItemScreen(context, groceryItems != null ? groceryItems.category : category);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool hasInvalidFormState() => _formKey.currentState != null && !_formKey.currentState.validate();

  void _triggerContextMenuAction(String choice) {
    if (choice == RemoveCategory) {
      cart.getAt(groceryIndex).delete();
      Navigator.pop(context);
    }
  }

  void navigateToItemScreen(BuildContext context, String category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ItemScreen(
            groceryIndex: groceryIndex,
            category: category,
            itemIndex: null,
            item: null
        ),
      ),
    );
  }
}