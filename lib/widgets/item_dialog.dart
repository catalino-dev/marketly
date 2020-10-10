import 'package:flutter/material.dart';
import 'package:marketly/config/constants.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/models/models.dart';

class ItemDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String title, buttonText;
  final Item item;
  final Function buttonAction;
  final Function deleteAction;

  ItemDialog({
    @required this.item,
    @required this.title,
    @required this.buttonText,
    this.buttonAction,
    this.deleteAction,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: item.name);
    final TextEditingController descriptionController = TextEditingController(text: item.description);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: _dialogContent(context, nameController, descriptionController),
    );
  }

  _dialogContent(context, nameController, descriptionController) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: new BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.text,
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
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: deleteAction,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.redAccent,
                    ),
                    child: Text(
                      'Remove',
                      style: kSubtitleTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Item item = Item(name: nameController.text, description: descriptionController.text);
                    buttonAction(item);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Palette.primary,
                    ),
                    child: Text(
                      buttonText,
                      style: kSubtitleTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
