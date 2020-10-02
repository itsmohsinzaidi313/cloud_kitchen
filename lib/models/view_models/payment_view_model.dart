import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/view_models/order_model.dart';

class PaymentViewModel {
  OrderModel _orderModel;
  Map<String, dynamic> map;
  List<PaymentMethod> _paymentMethodList;
  set ordermodel(OrderModel model) => _orderModel = model;
  OrderModel get orderModel => _orderModel;
  List<PaymentMethod> get paymentMethodList => _paymentMethodList;
  set paymentMethodList(List<PaymentMethod> value) {
    _paymentMethodList = value;
  }
}
