import 'package:flutter/material.dart';
import 'package:food_app/shared/config.dart';

class NewSale extends StatefulWidget {
  @override
  _NewSaleState createState() => _NewSaleState();
}

class _NewSaleState extends State<NewSale> {
  // final categoryDBHelper = TblCategories.categoriesInstance;
  // String _orderType = 'Dine-In', _info = 'Table No. 1', _userName = 'ZiaUddin';
  //
  // List<Categories> catLst = [];
  //
  // Future getCategories() async {
  //   catLst.clear();
  //   var categories = await categoryDBHelper.getCategories();
  //   categories.forEach((element) {
  //     catLst.add(Categories(
  //         id: element['id'],
  //         categoryName: element['category_name'],
  //         description: element['description'],
  //         userId: element['user_id'],
  //         companyId: element['company_id'],
  //         delStatus: element['del_status']));
  //   });
  //   catLst.forEach((element) {
  //     print(element);
  //   });
  //   return catLst;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //#region AppBar
          Container(
            width: Config.getDeviceWidth(context),
            height: 100,
            color: Colors.redAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(8, 10, 0, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(4, 8, 10, 8),
                          child: OutlineButton(
                            child: Text(
                              '_orderType',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Ubuntu',
                                letterSpacing: 2.0,
                              ),
                            ),
                            onPressed: () {},
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 10, 0, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      '_info',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                        fontFamily: 'Ubuntu',
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, right: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                        child: Text(
                          '_userName',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: MediaQuery.of(context).size.height * 0.041,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.04,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //endregion
          Expanded(
            child: Row(
              children: [
                //# region Menu
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            // child: FutureBuilder(
                            //     future: getCategories(),
                            //     builder: (context, snapShot) {
                            //       if (snapShot.connectionState ==
                            //               ConnectionState.none &&
                            //           snapShot.hasData == null) {
                            //         return Center(
                            //             child: CircularProgressIndicator());
                            //       }
                            //       return MaterialApp(
                            //         debugShowCheckedModeBanner: false,
                            //         home: DefaultTabController(
                            //           length: catLst.length,
                            //           child: Scaffold(
                            //             backgroundColor: Colors.white,
                            //             appBar: PreferredSize(
                            //               preferredSize:
                            //                   Size.fromHeight(kToolbarHeight),
                            //               child: Container(
                            //                 height: MediaQuery.of(context)
                            //                         .size
                            //                         .height *
                            //                     0.1,
                            //                 child: TabBar(
                            //                   indicatorColor:
                            //                       Colors.amberAccent,
                            //                   isScrollable: true,
                            //                   tabs: catLst
                            //                       .map<Widget>((Categories c) {
                            //                     return Tab(
                            //                       icon: Icon(
                            //                         Icons.style,
                            //                         color: Colors.amberAccent,
                            //                         size: 15,
                            //                       ),
                            //                       child: Text(
                            //                         c.categoryName
                            //                             .toUpperCase(),
                            //                         style: TextStyle(
                            //                           color: Colors.black,
                            //                           fontWeight:
                            //                               FontWeight.w400,
                            //                         ),
                            //                       ),
                            //                     );
                            //                   }).toList(),
                            //                 ),
                            //               ),
                            //             ),
                            //             body: TabBarView(
                            //               children: catLst.map((Categories c) {
                            //                 return TabBarViewChild(categoryName:c.categoryName);
                            //               }).toList(),
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //endregion
                //# region OrderList
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    // child: Consumer<ProItemMenus>(
                    //   builder: (context, itm, child){
                    //     return ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: itm.item.length,
                    //       itemBuilder: (context, index){
                    //         return CustomRowItem(itm.item[index]);
                    //       },
                    //     );
                    //   },
                    // ),
                  ),
                ),
                //endregion
              ],
            ),
          ),
        ],
      ),
    );
  }
}
