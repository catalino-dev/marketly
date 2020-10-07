import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/item/item.dart';
import 'package:marketly/widgets/widgets.dart';

const String groceryBoxName = 'grocery';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Box<Item> groceryBox;

  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  void initState() {
    // openBox();
    super.initState();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
          _HomeScreenMobile(scrollController: _trackingScrollController),
        ),
      ),
    );
  }

  // Future openBox() async {
    // final directory = await getApplicationDocumentsDirectory();
    // Hive.init(directory.path);
    // Hive.openBox<Grocery>(groceryBoxName);
  //   return;
  // }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget someOtherSliver = SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text(
        'Grocery list',
        style: const TextStyle(
          color: Palette.primary,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.2,
        ),
      ),
      centerTitle: false,
      floating: true,
    );

    return FutureBuilder<Box<Item>>(
      future: Hive.openBox('grocery'),
      builder: (context, snapshot) {
        print('-----------snapshot--------------');
        print(snapshot.hasData);
        Widget newsListSliver;

        if (snapshot.hasData) {
          newsListSliver = SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final Item grocery = snapshot.data.get(index);
              return GroceryListContainer(item: grocery);
            },
              childCount: snapshot.data.length,
            ),
          );
        } else {
          newsListSliver = SliverToBoxAdapter(child: CircularProgressIndicator(),);
        }

        return CustomScrollView(
          slivers: <Widget>[
            someOtherSliver,
            newsListSliver
          ],
        );
      },
    );
  }
}
