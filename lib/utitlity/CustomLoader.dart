import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CustomLoader {
  static CustomLoader _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState _overlayState; //= new OverlayState();
  OverlayEntry _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(height: 200.0, width: 200.0, child: buildLoader())
          ],
        );
      },
    );
  }

  Size getScreenSize({@required BuildContext context}) {
    return MediaQuery.of(context).size;
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState.insert(_overlayEntry);
  }

  hideLoader() {
    try {
      print("hide Loader called ");
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print("Exception:: $e");
    }
  }

  buildLoader({isTransparent: false}) {
    return Container(
      child: Center(
        child: Container(
          color: isTransparent ? Colors.transparent : Colors.transparent,
          child: Center(
              child: SpinKitDoubleBounce(
            color: Colors.green,
          )
//            child: CupertinoActivityIndicator(
//              radius: 20,
//            ),
              ), //CircularProgressIndicator(),
        ),
      ),
    );
  }
}
