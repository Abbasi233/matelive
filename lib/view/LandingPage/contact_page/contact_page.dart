import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/constant.dart';
import '/controller/api.dart';
import '/view/utils/appBar.dart';
import '/view/utils/footer.dart';
import '/view/utils/snackbar.dart';
import '/view/utils/primaryButton.dart';
import '/view/utils/auto_size_text.dart';
import '/view/auth/utils/text_input.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _controller = Completer<GoogleMapController>();

  final _adSoyadController = TextEditingController();
  final _eMailController = TextEditingController();
  final _telefonController = TextEditingController();
  final _mesajController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "İletişim",
          style: styleH3(),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              autoSize(
                text: "İletişim Bilgilerimiz",
                style: styleH1(),
                paddingVertical: 20,
              ),
              autoSize(
                textSpan: TextSpan(
                  text: "E-Posta: ",
                  style: styleH4(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "site@matelive.net",
                      style: styleH5(),
                    )
                  ],
                ),
              ),
              autoSize(
                  textSpan: TextSpan(
                    text: "Adres: ",
                    style: styleH4(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text:
                            "İnönü Mahallesi 410 Sokak No:16 Daire:2 Bağcılar / İstanbul",
                        style: styleH5(),
                      )
                    ],
                  ),
                  maxLines: 2,
                  paddingRight: 0),
              Container(
                height: 300,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(41.04275, 28.83625),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: {
                    Marker(
                      markerId: MarkerId("Center"),
                      position: LatLng(41.04275, 28.83625),
                    )
                  },
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: textInput(
                        hintText: "Adınız-Soyadınız *",
                        controller: _adSoyadController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: textInput(
                        hintText: "E-Posta Adresiniz *",
                        controller: _eMailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: textInput(
                        hintText: "Telefon Numaranız",
                        controller: _telefonController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: textInput(
                        hintText: "Mesajınız",
                        controller: _mesajController,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: primaryButton(
                  text: Center(
                    child: autoSize(
                      text: 'Mesajı Gönder',
                      paddingRight: 0,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var body = {
                        "name": _adSoyadController.text,
                        "email": _eMailController.text,
                        "phone": _telefonController.text,
                        "message": _mesajController.text,
                      };

                      var result = await API().contactSend(body);

                      if (result.keys.first) {
                        successSnackbar(result.values.first);
                      } else {
                        failureSnackbar(result.values.first[0]);
                      }
                    }
                  },
                ),
              ),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
