// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:pertypeople/app/modules/individualDrawer/bindings/individual_drawer_binding.dart';
import 'package:pertypeople/app/modules/individualDrawer/views/individual_drawer_view.dart';
import 'package:pertypeople/app/modules/individualLogin/bindings/individual_login_binding.dart';
import 'package:pertypeople/app/modules/individualLogin/views/individual_login_view.dart';
import 'package:pertypeople/app/modules/individualOTP/bindings/individual_otp_binding.dart';
import 'package:pertypeople/app/modules/individualOTP/views/individual_otp_view.dart';
import 'package:pertypeople/app/modules/organizationProfile/bindings/organization_profile_binding.dart';
import 'package:pertypeople/app/modules/organizationProfile/views/organization_profile_view.dart';
import 'package:pertypeople/app/modules/userTypeSelection/bindings/user_type_selection_binding.dart';
import 'package:pertypeople/app/modules/userTypeSelection/views/user_type_selection_view.dart';
import 'package:pertypeople/app/modules/visitInfo/views/visit_info_view.dart';
import 'package:pertypeople/app/splash_main.dart';

import '../modules/addIndividualEvent/bindings/add_individual_event_binding.dart';
import '../modules/addIndividualEvent/views/add_individual_event_view.dart';
import '../modules/addOrganizationsEvent/bindings/add_organizations_event_binding.dart';
import '../modules/addOrganizationsEvent/views/add_organizations_event_view.dart';
import '../modules/addOrganizationsEvent2/bindings/add_organizations_event2_binding.dart';
import '../modules/addOrganizationsEvent2/views/add_organizations_event2_view.dart';
import '../modules/addProfile/bindings/add_profile_binding.dart';
import '../modules/addProfile/views/add_profile_view.dart';
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
import '../modules/organizationProfileNew/bindings/organization_profile_new_binding.dart';
import '../modules/organizationProfileNew/views/organization_profile_new_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/individualDashboard/bindings/individual_dashboard_binding.dart';
import '../modules/individualDashboard/views/individual_dashboard_view.dart';
import '../modules/chatScreen/bindings/chat_screen_binding.dart';
import '../modules/chatScreen/views/chat_screen_view.dart';
import '../modules/visitInfo/bindings/visit_info_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PARTYPEOPLE;

  static final routes = [
    GetPage(
      name: _Paths.PARTYPEOPLE,
      page: () => SplashScreenMain(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OTPView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.DASHBORD,
      page: () => DashbordView(),
      binding: DashbordBinding(),
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
      name: _Paths.ADD_ORGANIZATIONS_EVENT2,
      page: () => AddOrganizationsEvent2View(isPopular: false),
      binding: AddOrganizationsEvent2Binding(),
    ),
    GetPage(
      name: _Paths.ADD_PROFILE,
      page: () => const AddProfileView(),
      binding: AddProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => SubscriptionView(
        id: '',
        data: {},
      ),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.DRAWER,
      page: () => DrawerView(
          likes: '', views: '', profileImageView: '', timeLineImage: ''),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: _Paths.CUST_PROFILE,
      page: () => CustProfileView(
        phoneNumber: '',
        organizationData: {},
      ),
      binding: CustProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORGANIZATION_PROFILE_NEW,
      page: () => const OrganizationProfileNewView(),
      binding: OrganizationProfileNewBinding(),
    ),
    GetPage(
      name: _Paths.ORGANIZATION_PROFILE,
      page: () => OrganizationProfileView(),
      binding: OrganizationProfileBinding(),
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_DASHBOARD,
      page: () => IndividualDashboardView(),
      binding: IndividualDashboardBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: _Paths.VISIT_INFO,
      page: () => VisitInfoView(),
      binding: VisitInfoBinding(),
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_OTP,
      page: () => IndividualOtpView(),
      binding: IndividualOtpBinding(),
    ),
    GetPage(
      name: _Paths.USER_TYPE_SELECTION,
      page: () => UserTypeSelectionView(),
      binding: UserTypeSelectionBinding(),
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_LOGIN,
      page: () => IndividualLoginView(),
      binding: IndividualLoginBinding(),
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_DRAWER,
      page: () => IndividualDrawerView(),
      binding: IndividualDrawerBinding(),
    ),
  ];
}
