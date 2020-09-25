import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';

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
      appBar: AppTheme.appBarNormal(
        context: context,
        appBarTitle: 'New Sales',
        appBarElevation: 0.0,
        appBarBgColor: AppTheme.appBarColor,
      ),
      body: Container(
        color: Colors.green,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.lstCategory.length,
                            itemBuilder: (context, index){
                              return Container(
                                child: Text(
                                  model.lstCategory[index].categoryName,
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getCategoryWidgets(List<Category> lstCategory) {
    List<Widget> widgets = [];
    lstCategory.forEach((category) {
      widgets.add(
        GestureDetector(
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
      // if (item.categoryName == categoryName)
      widgets.add(
        GestureDetector(
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
        GestureDetector(
          onTap: () {
            setState(() {
              // _key.currentState
              //     .showSnackBar(SnackBar(content: Text('Clicked..')));
            });
          },
          child: ListTile(
            title: Text('item.name'),
          ),
        ),
      );
    });
    return widgets;
  }
}
