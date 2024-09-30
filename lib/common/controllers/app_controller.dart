import 'package:get/get.dart';
import 'package:award_ticket/index.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  static final AppController _instance = Get.find<AppController>();
  static AppController get instance => _instance;

  final List<LanguageModel> _languages = <LanguageModel>[
    const LanguageModel(image: Assets.flagsUs, language: "English - US"),
    const LanguageModel(image: Assets.flagsGb, language: "English - GB"),
    const LanguageModel(image: Assets.flagsGh, language: "English - GH"),
  ];
  final _appVersion = "1.0.0".obs;
  final _activeLanguage = Rxn<LanguageModel>();

  updateVersion() async {
    initLanguage();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    _appVersion.value = version;
  }

  initLanguage() {
    _activeLanguage.value = _languages.last;
  }

  updateActiveLanguage({required LanguageModel language}) {
    _activeLanguage.value = language;
  }

  String get appVersion => _appVersion.value;
  List<LanguageModel> get languages => _languages;
  LanguageModel get activeLanguage => _activeLanguage.value!;
}
