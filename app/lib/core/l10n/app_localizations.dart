import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'وصلة'**
  String get appTitle;

  /// No description provided for @connecting.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الاتصال…'**
  String get connecting;

  /// No description provided for @continueButton.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueButton;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @phoneTitle.
  ///
  /// In ar, this message translates to:
  /// **'رقم هاتفك'**
  String get phoneTitle;

  /// No description provided for @phoneSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'سنرسل إليك رمز تحقق في رسالة نصية.'**
  String get phoneSubtitle;

  /// No description provided for @phoneLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneLabel;

  /// No description provided for @codeTitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز'**
  String get codeTitle;

  /// No description provided for @codeSentSms.
  ///
  /// In ar, this message translates to:
  /// **'أرسلنا رمزاً من {length} أرقام إلى {phone}'**
  String codeSentSms(int length, String phone);

  /// No description provided for @codeSentVoice.
  ///
  /// In ar, this message translates to:
  /// **'سنتصل بك على {phone} ونقرأ لك الرمز.'**
  String codeSentVoice(String phone);

  /// No description provided for @codeLabel.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get codeLabel;

  /// No description provided for @resendIn.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الإرسال بعد {seconds, plural, =1{ثانية واحدة} =2{ثانيتين} few{{seconds} ثوانٍ} other{{seconds} ثانية}}'**
  String resendIn(int seconds);

  /// No description provided for @resendByCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصل بي لقراءة الرمز'**
  String get resendByCall;

  /// No description provided for @wrongNumber.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الرقم'**
  String get wrongNumber;

  /// No description provided for @passwordTitle.
  ///
  /// In ar, this message translates to:
  /// **'التحقق بخطوتين'**
  String get passwordTitle;

  /// No description provided for @passwordSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'حسابك محمي بكلمة مرور إضافية.'**
  String get passwordSubtitle;

  /// No description provided for @passwordLabel.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In ar, this message translates to:
  /// **'التلميح: {hint}'**
  String passwordHint(String hint);

  /// No description provided for @signUpTitle.
  ///
  /// In ar, this message translates to:
  /// **'معلوماتك'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك ليتعرّف عليك أصدقاؤك.'**
  String get signUpSubtitle;

  /// No description provided for @firstName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العائلة (اختياري)'**
  String get lastName;

  /// No description provided for @nameRequired.
  ///
  /// In ar, this message translates to:
  /// **'الاسم مطلوب'**
  String get nameRequired;

  /// No description provided for @acceptTerms.
  ///
  /// In ar, this message translates to:
  /// **'أوافق على شروط الاستخدام وسياسة الخصوصية'**
  String get acceptTerms;

  /// No description provided for @chatsTitle.
  ///
  /// In ar, this message translates to:
  /// **'المحادثات'**
  String get chatsTitle;

  /// No description provided for @chatsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'حسابك جاهز! المحادثات قادمة في التحديث القادم.'**
  String get chatsEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsTitle;

  /// No description provided for @activeSessions.
  ///
  /// In ar, this message translates to:
  /// **'الأجهزة المتصلة'**
  String get activeSessions;

  /// No description provided for @thisDevice.
  ///
  /// In ar, this message translates to:
  /// **'هذا الجهاز'**
  String get thisDevice;

  /// No description provided for @endSession.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الجلسة'**
  String get endSession;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل الخروج من هذا الجهاز؟'**
  String get logoutConfirm;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @errPhoneInvalid.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف غير صحيح'**
  String get errPhoneInvalid;

  /// No description provided for @errCodeInvalid.
  ///
  /// In ar, this message translates to:
  /// **'الرمز غير صحيح'**
  String get errCodeInvalid;

  /// No description provided for @errCodeExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت صلاحية الرمز، اطلب رمزاً جديداً'**
  String get errCodeExpired;

  /// No description provided for @errPhoneBanned.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرقم محظور من استخدام وصلة'**
  String get errPhoneBanned;

  /// No description provided for @errPasswordInvalid.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير صحيحة'**
  String get errPasswordInvalid;

  /// No description provided for @errRateLimited.
  ///
  /// In ar, this message translates to:
  /// **'محاولات كثيرة. حاول بعد {seconds, plural, =1{ثانية واحدة} =2{ثانيتين} few{{seconds} ثوانٍ} other{{seconds} ثانية}}'**
  String errRateLimited(int seconds);

  /// No description provided for @errNetwork.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال. تحقّق من الإنترنت وحاول مجدداً'**
  String get errNetwork;

  /// No description provided for @errUpdateRequired.
  ///
  /// In ar, this message translates to:
  /// **'يتوفر إصدار أحدث من وصلة. يرجى التحديث.'**
  String get errUpdateRequired;

  /// No description provided for @errGeneric.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما. حاول مجدداً'**
  String get errGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
