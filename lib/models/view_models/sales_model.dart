import 'package:food_app/models/objects/category.dart';

class SalesModel {
  List<Category> _list;
  set listCategoryButton(List<Category> value) => this._list = value;
  get listCategoryButton => _list;
}
