import 'package:get/get.dart';

import '../modules/addEvent/bindings/add_event_binding.dart';
import '../modules/addEvent/views/add_event_view.dart';
import '../modules/addIndividualEvent/bindings/add_individual_event_binding.dart';
import '../modules/addIndividualEvent/views/add_individual_event_view.dart';
import '../modules/addOrganizationsEvent/bindings/add_organizations_event_binding.dart';
import '../modules/addOrganizationsEvent/views/add_organizations_event_view.dart';
import '../modules/addOrganizationsEvent2/bindings/add_organizations_event2_binding.dart';
import '../modules/addOrganizationsEvent2/views/add_organizations_event2_view.dart';
import '../modules/addProfile/bindings/add_profile_binding.dart';
import '../modules/addProfile/views/add_profile_view.dart';
import '../modules/cityList/bindings/city_list_binding.dart';
import '../modules/cityList/views/city_list_view.dart';
import '../modules/cityWiseParty/bindings/city_wise_party_binding.dart';
import '../modules/cityWiseParty/views/city_wise_party_view.dart';
import '../modules/cust_profile/bindings/cust_profile_binding.dart';
import '../modules/cust_profile/views/cust_profile_view.dart';
import '../modules/dashbord/bindings/dashbord_binding.dart';
import '../modules/dashbord/views/dashbord_view.dart';
import '../modules/drawer/bindings/drawer_binding.dart';
import '../modules/drawer/views/drawer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/organizationProfile/bindings/organization_profile_binding.dart';
import '../modules/organizationProfile/views/organization_profile_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splashscreenThree/bindings/splashscreen_three_binding.dart';
import '../modules/splashscreenThree/views/splashscreen_three_view.dart';
import '../modules/splashscreenTwo/bindings/splashscreen_two_binding.dart';
import '../modules/splashscreenTwo/views/splashscreen_two_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/viewEvent/bindings/view_event_binding.dart';
import '../modules/viewEvent/views/view_event_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN_TWO,
      page: () => SplashscreenTwoView(),
      binding: SplashscreenTwoBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN_THREE,
      page: () => SplashscreenThreeView(),
      binding: SplashscreenThreeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.DASHBORD,
      page: () => DashbordView(),
      binding: DashbordBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EVENT,
      page: () => AddEventView(),
      binding: AddEventBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INDIVIDUAL_EVENT,
      page: () => AddIndividualEventView(),
      binding: AddIndividualEventBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ORGANIZATIONS_EVENT,
      page: () => AddOrganizationsEventView(),
      binding: AddOrganizationsEventBinding(),
    ),
    GetPage(
      name: _Paths.CITY_LIST,
      page: () => CityListView(),
      binding: CityListBinding(),
    ),
    GetPage(
      name: _Paths.ORGANIZATION_PROFILE,
      page: () => OrganizationProfileView(),
      binding: OrganizationProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ORGANIZATIONS_EVENT2,
      page: () => AddOrganizationsEvent2View(),
      binding: AddOrganizationsEvent2Binding(),
    ),
    GetPage(
      name: _Paths.VIEW_EVENT,
      page: () => const ViewEventView(),
      binding: ViewEventBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROFILE,
      page: () => const AddProfileView(),
      binding: AddProfileBinding(),
    ),
    GetPage(
      name: _Paths.CITY_WISE_PARTY,
      page: () => const CityWisePartyView(),
      binding: CityWisePartyBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.DRAWER,
      page: () => const DrawerView(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: _Paths.CUST_PROFILE,
      page: () => const CustProfileView(),
      binding: CustProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
