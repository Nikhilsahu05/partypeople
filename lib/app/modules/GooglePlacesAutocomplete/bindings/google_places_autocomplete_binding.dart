import 'package:get/get.dart';

import '../controllers/google_places_autocomplete_controller.dart';

class GooglePlacesAutocompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GooglePlacesAutocompleteController>(
      () => GooglePlacesAutocompleteController(),
    );
  }
}
