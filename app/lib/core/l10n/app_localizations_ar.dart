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

  @override
  String get savedMessages => 'الرسائل المحفوظة';

  @override
  String get deletedAccount => 'حساب محذوف';

  @override
  String get newChat => 'محادثة جديدة';

  @override
  String get searchHint => 'ابحث باسم المستخدم أو رقم الهاتف';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get notOnWasla => 'هذا الرقم غير مسجّل في وصلة';

  @override
  String get contactsSection => 'جهات الاتصال';

  @override
  String get globalSection => 'نتائج عامة';

  @override
  String get noChatsYet => 'لا توجد محادثات بعد. ابدأ محادثة جديدة.';

  @override
  String get loadError => 'تعذّر تحميل المحادثات';

  @override
  String get messageHint => 'رسالة';

  @override
  String get typing => 'يكتب…';

  @override
  String get edited => 'معدّلة';

  @override
  String forwardedFrom(String name) {
    return 'معاد توجيهها من $name';
  }

  @override
  String get locationMsg => '📍 موقع';

  @override
  String get contactMsg => '👤 جهة اتصال';

  @override
  String get unsupportedMsg => 'هذه الرسالة غير مدعومة، يرجى تحديث التطبيق';

  @override
  String get you => 'أنت';

  @override
  String get yesterday => 'أمس';

  @override
  String get reply => 'رد';

  @override
  String get copy => 'نسخ';

  @override
  String get edit => 'تعديل';

  @override
  String get forward => 'إعادة توجيه';

  @override
  String get forwardToSaved => 'إلى الرسائل المحفوظة';

  @override
  String get chooseChat => 'اختر محادثة';

  @override
  String get pin => 'تثبيت';

  @override
  String get unpin => 'إلغاء التثبيت';

  @override
  String get delete => 'حذف';

  @override
  String get deleteForMe => 'حذف لديّ فقط';

  @override
  String get deleteForEveryone => 'حذف لدى الجميع';

  @override
  String get report => 'إبلاغ';

  @override
  String get block => 'حظر';

  @override
  String get unblock => 'إلغاء الحظر';

  @override
  String blockConfirm(String name) {
    return 'حظر $name؟ لن يتمكن أي منكما من مراسلة الآخر.';
  }

  @override
  String get youBlocked => 'لقد حظرت هذا المستخدم';

  @override
  String get copied => 'تم النسخ';

  @override
  String get sendFailed => 'لم تُرسل — اضغط لإعادة المحاولة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get discard => 'حذف';

  @override
  String get editing => 'تعديل الرسالة';

  @override
  String replyingTo(String name) {
    return 'الرد على $name';
  }

  @override
  String get pinChat => 'تثبيت المحادثة';

  @override
  String get unpinChat => 'إلغاء تثبيت المحادثة';

  @override
  String get mute => 'كتم الإشعارات';

  @override
  String get unmute => 'إلغاء الكتم';

  @override
  String get archive => 'أرشفة';

  @override
  String get unarchive => 'إلغاء الأرشفة';

  @override
  String get archived => 'الأرشيف';

  @override
  String get clearHistory => 'مسح المحادثة';

  @override
  String get reportTitle => 'الإبلاغ';

  @override
  String get reportWhy => 'ما المشكلة؟';

  @override
  String get reportComment => 'تفاصيل إضافية (اختياري)';

  @override
  String get reportAlsoBlock => 'حظر هذا المستخدم أيضاً';

  @override
  String get reportSend => 'إرسال البلاغ';

  @override
  String get reportSent => 'شكراً، وصل بلاغك وسيراجعه فريق الإشراف.';

  @override
  String get reasonSpam => 'رسائل مزعجة';

  @override
  String get reasonScam => 'احتيال';

  @override
  String get reasonViolence => 'عنف';

  @override
  String get reasonTerrorism => 'إرهاب';

  @override
  String get reasonChildAbuse => 'إساءة للأطفال';

  @override
  String get reasonPornography => 'محتوى إباحي';

  @override
  String get reasonIllegalGoods => 'بضائع ممنوعة';

  @override
  String get reasonPersonalData => 'نشر بيانات شخصية';

  @override
  String get reasonHarassment => 'تحرّش أو مضايقة';

  @override
  String get reasonFakeAccount => 'حساب مزيّف';

  @override
  String get reasonCopyright => 'حقوق نشر';

  @override
  String get reasonOther => 'أخرى';

  @override
  String errRateLimitedMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes دقيقة',
      few: '$minutes دقائق',
      two: 'دقيقتين',
      one: 'دقيقة واحدة',
    );
    return 'محاولات كثيرة. حاول بعد $_temp0';
  }

  @override
  String get photoMsg => '📷 صورة';

  @override
  String fileMsg(String name) {
    return '📎 $name';
  }

  @override
  String get attach => 'إرفاق';

  @override
  String get attachGallery => 'صورة من المعرض';

  @override
  String get attachCamera => 'التقاط صورة';

  @override
  String get attachFile => 'ملف';

  @override
  String get captionHint => 'أضف تعليقاً…';

  @override
  String get sendPhoto => 'إرسال الصورة';

  @override
  String get sendFile => 'إرسال الملف';

  @override
  String get myPhoto => 'صورتي الشخصية';

  @override
  String get photoUpdated => 'تم تحديث صورتك';

  @override
  String get openFailed => 'لا يوجد تطبيق على هاتفك لفتح هذا الملف';

  @override
  String sizeKb(String n) {
    return '$n ك.ب';
  }

  @override
  String sizeMb(String n) {
    return '$n م.ب';
  }

  @override
  String get mediaUnavailable => 'لم تعد هذه الصورة متاحة';

  @override
  String get photoTooBig => 'الملف كبير جداً';

  @override
  String get storageTitle => 'البيانات والتخزين';

  @override
  String get storageUsage => 'الوسائط المحمّلة على هاتفك';

  @override
  String storageUsageValue(int files, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      files,
      locale: localeName,
      other: '$files ملفاً',
      few: '$files ملفات',
      two: 'ملفان',
      one: 'ملف واحد',
      zero: 'لا شيء',
    );
    return '$_temp0 · $size';
  }

  @override
  String get keepMedia => 'الاحتفاظ بالوسائط المحمّلة';

  @override
  String get keepMediaHint =>
      'تُحذف الصور والملفات المحمّلة من هاتفك بعد هذه المدة من آخر فتح لها. تبقى في المحادثة، وتُحمَّل من جديد عند فتحها.';

  @override
  String get keepDays3 => '3 أيام';

  @override
  String get keepDays7 => 'أسبوع';

  @override
  String get keepDays30 => '30 يوماً (الافتراضي)';

  @override
  String get keepForever => 'دائماً';

  @override
  String get clearMedia => 'مسح الوسائط المحمّلة';

  @override
  String get clearMediaConfirm =>
      'حذف كل الصور والملفات المحمّلة من هذا الهاتف؟ لن تُحذف من المحادثات، ويمكن تحميلها من جديد.';

  @override
  String clearMediaDone(String size) {
    return 'تم تحرير $size';
  }

  @override
  String get clear => 'مسح';
}
