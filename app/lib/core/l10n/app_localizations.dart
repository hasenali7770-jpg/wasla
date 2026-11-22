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

  /// No description provided for @devCodeHint.
  ///
  /// In ar, this message translates to:
  /// **'وضع الاختبار — الرمز: {code}'**
  String devCodeHint(String code);

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

  /// No description provided for @savedMessages.
  ///
  /// In ar, this message translates to:
  /// **'الرسائل المحفوظة'**
  String get savedMessages;

  /// No description provided for @deletedAccount.
  ///
  /// In ar, this message translates to:
  /// **'حساب محذوف'**
  String get deletedAccount;

  /// No description provided for @newChat.
  ///
  /// In ar, this message translates to:
  /// **'محادثة جديدة'**
  String get newChat;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم المستخدم أو رقم الهاتف'**
  String get searchHint;

  /// No description provided for @noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get noResults;

  /// No description provided for @notOnWasla.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرقم غير مسجّل في وصلة'**
  String get notOnWasla;

  /// No description provided for @contactsSection.
  ///
  /// In ar, this message translates to:
  /// **'جهات الاتصال'**
  String get contactsSection;

  /// No description provided for @globalSection.
  ///
  /// In ar, this message translates to:
  /// **'نتائج عامة'**
  String get globalSection;

  /// No description provided for @noChatsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد محادثات بعد. ابدأ محادثة جديدة.'**
  String get noChatsYet;

  /// No description provided for @loadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل المحادثات'**
  String get loadError;

  /// No description provided for @messageHint.
  ///
  /// In ar, this message translates to:
  /// **'رسالة'**
  String get messageHint;

  /// No description provided for @typing.
  ///
  /// In ar, this message translates to:
  /// **'يكتب…'**
  String get typing;

  /// No description provided for @edited.
  ///
  /// In ar, this message translates to:
  /// **'معدّلة'**
  String get edited;

  /// No description provided for @forwardedFrom.
  ///
  /// In ar, this message translates to:
  /// **'معاد توجيهها من {name}'**
  String forwardedFrom(String name);

  /// No description provided for @locationMsg.
  ///
  /// In ar, this message translates to:
  /// **'📍 موقع'**
  String get locationMsg;

  /// No description provided for @contactMsg.
  ///
  /// In ar, this message translates to:
  /// **'👤 جهة اتصال'**
  String get contactMsg;

  /// No description provided for @unsupportedMsg.
  ///
  /// In ar, this message translates to:
  /// **'هذه الرسالة غير مدعومة، يرجى تحديث التطبيق'**
  String get unsupportedMsg;

  /// No description provided for @you.
  ///
  /// In ar, this message translates to:
  /// **'أنت'**
  String get you;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// No description provided for @reply.
  ///
  /// In ar, this message translates to:
  /// **'رد'**
  String get reply;

  /// No description provided for @copy.
  ///
  /// In ar, this message translates to:
  /// **'نسخ'**
  String get copy;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @forward.
  ///
  /// In ar, this message translates to:
  /// **'إعادة توجيه'**
  String get forward;

  /// No description provided for @forwardToSaved.
  ///
  /// In ar, this message translates to:
  /// **'إلى الرسائل المحفوظة'**
  String get forwardToSaved;

  /// No description provided for @chooseChat.
  ///
  /// In ar, this message translates to:
  /// **'اختر محادثة'**
  String get chooseChat;

  /// No description provided for @pin.
  ///
  /// In ar, this message translates to:
  /// **'تثبيت'**
  String get pin;

  /// No description provided for @unpin.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء التثبيت'**
  String get unpin;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @deleteForMe.
  ///
  /// In ar, this message translates to:
  /// **'حذف لديّ فقط'**
  String get deleteForMe;

  /// No description provided for @deleteForEveryone.
  ///
  /// In ar, this message translates to:
  /// **'حذف لدى الجميع'**
  String get deleteForEveryone;

  /// No description provided for @report.
  ///
  /// In ar, this message translates to:
  /// **'إبلاغ'**
  String get report;

  /// No description provided for @block.
  ///
  /// In ar, this message translates to:
  /// **'حظر'**
  String get block;

  /// No description provided for @unblock.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الحظر'**
  String get unblock;

  /// No description provided for @blockConfirm.
  ///
  /// In ar, this message translates to:
  /// **'حظر {name}؟ لن يتمكن أي منكما من مراسلة الآخر.'**
  String blockConfirm(String name);

  /// No description provided for @youBlocked.
  ///
  /// In ar, this message translates to:
  /// **'لقد حظرت هذا المستخدم'**
  String get youBlocked;

  /// No description provided for @copied.
  ///
  /// In ar, this message translates to:
  /// **'تم النسخ'**
  String get copied;

  /// No description provided for @sendFailed.
  ///
  /// In ar, this message translates to:
  /// **'لم تُرسل — اضغط لإعادة المحاولة'**
  String get sendFailed;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @discard.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get discard;

  /// No description provided for @editing.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الرسالة'**
  String get editing;

  /// No description provided for @replyingTo.
  ///
  /// In ar, this message translates to:
  /// **'الرد على {name}'**
  String replyingTo(String name);

  /// No description provided for @pinChat.
  ///
  /// In ar, this message translates to:
  /// **'تثبيت المحادثة'**
  String get pinChat;

  /// No description provided for @unpinChat.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء تثبيت المحادثة'**
  String get unpinChat;

  /// No description provided for @mute.
  ///
  /// In ar, this message translates to:
  /// **'كتم الإشعارات'**
  String get mute;

  /// No description provided for @unmute.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الكتم'**
  String get unmute;

  /// No description provided for @archive.
  ///
  /// In ar, this message translates to:
  /// **'أرشفة'**
  String get archive;

  /// No description provided for @unarchive.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الأرشفة'**
  String get unarchive;

  /// No description provided for @archived.
  ///
  /// In ar, this message translates to:
  /// **'الأرشيف'**
  String get archived;

  /// No description provided for @clearHistory.
  ///
  /// In ar, this message translates to:
  /// **'مسح المحادثة'**
  String get clearHistory;

  /// No description provided for @reportTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ'**
  String get reportTitle;

  /// No description provided for @reportWhy.
  ///
  /// In ar, this message translates to:
  /// **'ما المشكلة؟'**
  String get reportWhy;

  /// No description provided for @reportComment.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل إضافية (اختياري)'**
  String get reportComment;

  /// No description provided for @reportAlsoBlock.
  ///
  /// In ar, this message translates to:
  /// **'حظر هذا المستخدم أيضاً'**
  String get reportAlsoBlock;

  /// No description provided for @reportSend.
  ///
  /// In ar, this message translates to:
  /// **'إرسال البلاغ'**
  String get reportSend;

  /// No description provided for @reportSent.
  ///
  /// In ar, this message translates to:
  /// **'شكراً، وصل بلاغك وسيراجعه فريق الإشراف.'**
  String get reportSent;

  /// No description provided for @reasonSpam.
  ///
  /// In ar, this message translates to:
  /// **'رسائل مزعجة'**
  String get reasonSpam;

  /// No description provided for @reasonScam.
  ///
  /// In ar, this message translates to:
  /// **'احتيال'**
  String get reasonScam;

  /// No description provided for @reasonViolence.
  ///
  /// In ar, this message translates to:
  /// **'عنف'**
  String get reasonViolence;

  /// No description provided for @reasonTerrorism.
  ///
  /// In ar, this message translates to:
  /// **'إرهاب'**
  String get reasonTerrorism;

  /// No description provided for @reasonChildAbuse.
  ///
  /// In ar, this message translates to:
  /// **'إساءة للأطفال'**
  String get reasonChildAbuse;

  /// No description provided for @reasonPornography.
  ///
  /// In ar, this message translates to:
  /// **'محتوى إباحي'**
  String get reasonPornography;

  /// No description provided for @reasonIllegalGoods.
  ///
  /// In ar, this message translates to:
  /// **'بضائع ممنوعة'**
  String get reasonIllegalGoods;

  /// No description provided for @reasonPersonalData.
  ///
  /// In ar, this message translates to:
  /// **'نشر بيانات شخصية'**
  String get reasonPersonalData;

  /// No description provided for @reasonHarassment.
  ///
  /// In ar, this message translates to:
  /// **'تحرّش أو مضايقة'**
  String get reasonHarassment;

  /// No description provided for @reasonFakeAccount.
  ///
  /// In ar, this message translates to:
  /// **'حساب مزيّف'**
  String get reasonFakeAccount;

  /// No description provided for @reasonCopyright.
  ///
  /// In ar, this message translates to:
  /// **'حقوق نشر'**
  String get reasonCopyright;

  /// No description provided for @reasonOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get reasonOther;

  /// No description provided for @errRateLimitedMinutes.
  ///
  /// In ar, this message translates to:
  /// **'محاولات كثيرة. حاول بعد {minutes, plural, =1{دقيقة واحدة} =2{دقيقتين} few{{minutes} دقائق} other{{minutes} دقيقة}}'**
  String errRateLimitedMinutes(int minutes);

  /// No description provided for @photoMsg.
  ///
  /// In ar, this message translates to:
  /// **'📷 صورة'**
  String get photoMsg;

  /// No description provided for @fileMsg.
  ///
  /// In ar, this message translates to:
  /// **'📎 {name}'**
  String fileMsg(String name);

  /// No description provided for @attach.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق'**
  String get attach;

  /// No description provided for @attachGallery.
  ///
  /// In ar, this message translates to:
  /// **'صورة من المعرض'**
  String get attachGallery;

  /// No description provided for @attachCamera.
  ///
  /// In ar, this message translates to:
  /// **'التقاط صورة'**
  String get attachCamera;

  /// No description provided for @attachFile.
  ///
  /// In ar, this message translates to:
  /// **'ملف'**
  String get attachFile;

  /// No description provided for @captionHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف تعليقاً…'**
  String get captionHint;

  /// No description provided for @sendPhoto.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الصورة'**
  String get sendPhoto;

  /// No description provided for @sendFile.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الملف'**
  String get sendFile;

  /// No description provided for @myPhoto.
  ///
  /// In ar, this message translates to:
  /// **'صورتي الشخصية'**
  String get myPhoto;

  /// No description provided for @photoUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث صورتك'**
  String get photoUpdated;

  /// No description provided for @openFailed.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد تطبيق على هاتفك لفتح هذا الملف'**
  String get openFailed;

  /// No description provided for @sizeKb.
  ///
  /// In ar, this message translates to:
  /// **'{n} ك.ب'**
  String sizeKb(String n);

  /// No description provided for @sizeMb.
  ///
  /// In ar, this message translates to:
  /// **'{n} م.ب'**
  String sizeMb(String n);

  /// No description provided for @mediaUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'لم تعد هذه الصورة متاحة'**
  String get mediaUnavailable;

  /// No description provided for @photoTooBig.
  ///
  /// In ar, this message translates to:
  /// **'الملف كبير جداً'**
  String get photoTooBig;
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
