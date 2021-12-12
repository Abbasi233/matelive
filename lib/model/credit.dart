import 'package:in_app_purchase/in_app_purchase.dart';

class Credit {
  String get id => productDetails.id;
  String get title => productDetails.title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductDetails productDetails;

  Credit(this.productDetails);
}
