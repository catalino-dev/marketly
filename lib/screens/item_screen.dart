import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:marketly/item/item_model.dart';

const String cartBoxName = 'cart';

class ItemScreen extends StatefulWidget {
  ItemScreen();

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {

  Box<Item> cart;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cart = Hive.box<Item>(cartBoxName);
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
                    height: 520.0,
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
                              Icons.shopping_cart,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Item Item',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          'NAME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.grey.withOpacity(0.2),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                hintText: "Title",
                                hintStyle: TextStyle(fontSize: 18, color: Colors.white30),
                                border: InputBorder.none
                            ),
                            controller: nameController,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.grey.withOpacity(0.2),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle: TextStyle(fontSize: 18, color: Colors.white30),
                                border: InputBorder.none
                            ),
                            controller: descriptionController,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        RawMaterialButton(
                          padding: EdgeInsets.all(20.0),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.black,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () {
                            final String name = nameController.text;
                            final String description = descriptionController.text;

                            Item item = Item(name: name, description: description);
                            cart.add(item);
                            print('---------------Adding the item');
                            print(item);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 400.0,
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'All to know...',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Item height: 35-45cm',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Nursery pot width: 12cm',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                        ],
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
