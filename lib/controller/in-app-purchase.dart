import 'dart:async';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:matelive/model/credit.dart';

import '/view/utils/snackbar.dart';

class IAPController extends GetxController {
  List<Credit> products = [];
  InAppPurchase iapConnection = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;

  ProductDetailsResponse response;

  @override
  void onInit() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      failureSnackbar(
          "Ürün satın alınırken bir sorun oluştu.\n" + error.toString());
    });
    loadPurchases();

    super.onInit();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        if (purchaseDetails.status == PurchaseStatus.pending) {
          normalSnackbar("Purchase Pending");
        } else {
          if (purchaseDetails.status == PurchaseStatus.error) {
            failureSnackbar(
                "Purchase Error. " + purchaseDetails.error.toString());
          } else if (purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) {
            successSnackbar("Purchase Successful");
          }
          if (purchaseDetails.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
            successSnackbar("Purchase Completed!");
          }
        }
      },
    );
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (available) {
      const ids = <String>{
        "1_baslangic_paketi",
        "2_yeni_gelen_paketi",
        "3_avantaj_paketi",
        "4_super_paketi",
        "5_luks_paketi",
      };

      response = await iapConnection.queryProductDetails(ids);
      products = response.productDetails.map((e) => Credit(e)).toList();
    }
  }

  Future<void> buy(Credit credit) async {
    final purchaseParam = PurchaseParam(productDetails: credit.productDetails);
    await iapConnection.buyConsumable(purchaseParam: purchaseParam);
  }
}
