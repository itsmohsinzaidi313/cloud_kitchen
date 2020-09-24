import 'package:flutter/material.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';

class NewSale extends StatefulWidget {
  final NewSaleModel model;
  NewSale(this.model);

  @override
  _NewSaleState createState() => _NewSaleState(this.model);
}

class _NewSaleState extends State<NewSale> {
  final NewSaleModel model;
  _NewSaleState(this.model);

  String categoryName = '';

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Expanded(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 5,
                      children: getCategoryWidgets(model.lstCategory),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: getItemsWidgets(model.lstItem, categoryName),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 1,
                      children: getCartItemsWidgets(this.model.order.itemList),
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

  List<Widget> getCategoryWidgets(List<Category> lstCategory) {
    List<Widget> widgets = [];
    lstCategory.forEach((category) {
      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              categoryName = category.categoryName;
            });
          },
          child: Card(
            elevation: 4,
            color: Colors.amberAccent,
            child: Center(
              child: Text(
                category.categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Ubuntu',
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ),
      );
    });
    return widgets;
  }

  List<Widget> getItemsWidgets(List<Item> lstItem, String categoryName) {
    List<Widget> widgets = [];
    lstItem.forEach((item) {
      if (item.categoryName == categoryName)
        widgets.add(
          InkWell(
            onTap: () {
              setState(() {
                this.model.order.addItem(item);
              });
            },
            child: Card(
              elevation: 4,
              color: Colors.amberAccent,
              child: Center(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        );
    });
    return widgets;
  }

  List<Widget> getCartItemsWidgets(List<Item> lstItem) {
    List<Widget> widgets = [];
    lstItem.forEach((item) {
        widgets.add(
          InkWell(
            onTap: () {
              setState(() {
                _key.currentState.showSnackBar(SnackBar(content: Text('Clicked..')));
              });
            },
            child: ListTile(
              title: Text(item.name),
            ),
          ),
        );
    });
    return widgets;
  }

}
