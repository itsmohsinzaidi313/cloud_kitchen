import 'package:food_app/models/generic_models/dashboard_item.dart';

class DashBoardModel {
  List<DashboardItem> _list;
  set listDashboardButtons(List<DashboardItem> value) => this._list = value;
  get listDashboardButtons => this._list;
}
