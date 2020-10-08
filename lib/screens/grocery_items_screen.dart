import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marketly/models/item_model.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';

class GroceryItemsScreen extends StatefulWidget {
  final GroceryItems groceryItems;

  GroceryItemsScreen({
    Key key,
    this.groceryItems,
  }) : super(key: key);

  @override
  _GroceryItemsScreenState createState() => _GroceryItemsScreenState(groceryItems: groceryItems);
}

class _GroceryItemsScreenState extends State<GroceryItemsScreen> {
  final String cartBoxName = 'cart';
  final GroceryItems groceryItems;

  Box<GroceryItems> cart;

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  _GroceryItemsScreenState({
    this.groceryItems
  }) : super();

  @override
  void initState() {
    super.initState();
    print('---------category-------------');
    print(groceryItems.category);
    cart = Hive.box<GroceryItems>(cartBoxName);
  }

  @override
  Widget build(BuildContext context) {

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
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 60.0,
                    ),
                    height: 275.0,
                    color: Color(0xFF32A060),
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
                            Icon(
                              Icons.save,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.all(15),
                          color: Colors.grey.withOpacity(0.1),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: 'CATEGORY',
                                labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                                hintText: 'Title',
                                hintStyle: TextStyle(fontSize: 18, color: Colors.white30),
                                border: InputBorder.none
                            ),
                            controller: nameController,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 500.0,
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder<Box<GroceryItems>>(
                          future: Hive.openBox(cartBoxName),
                          builder: (context, snapshot) {
                            return ValueListenableBuilder(
                              valueListenable: cart.listenable(),
                              builder: (context, Box<GroceryItems> cart, _) {
                                return ListView.builder(
                                  itemCount: cart.values.length,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (context, index) {
                                    List<Item> items = cart.getAt(index).items;

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ItemScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * .4,
                                                    child: Text(
                                                      "${items[0].name}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${items[0].description}",
                                                    style: TextStyle(
                                                      color: Colors.black26,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                );
                              },
                            );
                          }
                        ),
                      ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
