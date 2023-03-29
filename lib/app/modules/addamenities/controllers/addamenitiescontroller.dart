import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pertypeople/app/modules/addamenities/controllers/GetAmenities.dart';

class AddAmenitiesController extends GetxController {
  //TODO: Implement AddAmenitiesController

  final count = 0.obs;
  RxBool checkbox1 = RxBool(false);
  RxBool checkbox2 = RxBool(true);
  RxBool checkbox3 = RxBool(false);

  GetAmenities? getAmenitiesList;

  List<String> kOptions = <String>[];
  @override
  void onInit() {
    getAmenities();
    update();
    refresh();
    super.onInit();
  }

  void increment() => count.value++;

  getAmenities() async {
    var headers = {
      'x-access-token':
      GetStorage().read("token").toString(),
      'Cookie': 'ci_session=bb484ee68f2155ac47fcb20c35e31310064b7370'
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://manage.partypeople.in/v1/party/organization_amenities'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('the function was called');
    print('Status code : ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 1) {
      // print(await response.stream.bytesToString());
      print('Data found');

      getAmenitiesList =
          GetAmenitiesFromJson(await response.stream.bytesToString());
      print(kOptions);
      kOptions = getAmenitiesList!.data.map((e) => e.name).toList();
      update();
      refresh();
    } else {
      print('no data found');
      // print(response.statusCode);
      // print(_kOptions);
    }
  }
}
