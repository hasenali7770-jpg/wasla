// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'وصلة';

  @override
  String get connecting => 'جارٍ الاتصال…';

  @override
  String get continueButton => 'متابعة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get phoneTitle => 'رقم هاتفك';

  @override
  String get phoneSubtitle => 'سنرسل إليك رمز تحقق في رسالة نصية.';

  @override
  String get phoneLabel => 'رقم الهاتف';

  @override
  String get codeTitle => 'أدخل الرمز';

  @override
  String codeSentSms(int length, String phone) {
    return 'أرسلنا رمزاً من $length أرقام إلى $phone';
  }

  @override
  String codeSentVoice(String phone) {
    return 'سنتصل بك على $phone ونقرأ لك الرمز.';
  }

  @override
  String get codeLabel => 'رمز التحقق';

  @override
  String resendIn(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds ثانية',
      few: '$seconds ثوانٍ',
      two: 'ثانيتين',
      one: 'ثانية واحدة',
    );
    return 'إعادة الإرسال بعد $_temp0';
  }

  @override
  String get resendByCall => 'اتصل بي لقراءة الرمز';

  @override
  String devCodeHint(String code) {
    return 'وضع الاختبار — الرمز: $code';
  }

  @override
  String get wrongNumber => 'تعديل الرقم';

  @override
  String get passwordTitle => 'التحقق بخطوتين';

  @override
  String get passwordSubtitle => 'حسابك محمي بكلمة مرور إضافية.';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String passwordHint(String hint) {
    return 'التلميح: $hint';
  }

  @override
  String get signUpTitle => 'معلوماتك';

  @override
  String get signUpSubtitle => 'أدخل اسمك ليتعرّف عليك أصدقاؤك.';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة (اختياري)';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get acceptTerms => 'أوافق على شروط الاستخدام وسياسة الخصوصية';

  @override
  String get chatsTitle => 'المحادثات';

  @override
  String get chatsEmpty => 'حسابك جاهز! المحادثات قادمة في التحديث القادم.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get activeSessions => 'الأجهزة المتصلة';

  @override
  String get thisDevice => 'هذا الجهاز';

  @override
  String get endSession => 'إنهاء الجلسة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirm => 'هل تريد تسجيل الخروج من هذا الجهاز؟';

  @override
  String get language => 'اللغة';

  @override
  String get errPhoneInvalid => 'رقم الهاتف غير صحيح';

  @override
  String get errCodeInvalid => 'الرمز غير صحيح';

  @override
  String get errCodeExpired => 'انتهت صلاحية الرمز، اطلب رمزاً جديداً';

  @override
  String get errPhoneBanned => 'هذا الرقم محظور من استخدام وصلة';

  @override
  String get errPasswordInvalid => 'كلمة المرور غير صحيحة';

  @override
  String errRateLimited(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds ثانية',
      few: '$seconds ثوانٍ',
      two: 'ثانيتين',
      one: 'ثانية واحدة',
    );
    return 'محاولات كثيرة. حاول بعد $_temp0';
  }

  @override
  String get errNetwork => 'لا يوجد اتصال. تحقّق من الإنترنت وحاول مجدداً';

  @override
  String get errUpdateRequired => 'يتوفر إصدار أحدث من وصلة. يرجى التحديث.';

  @override
  String get errGeneric => 'حدث خطأ ما. حاول مجدداً';
}
