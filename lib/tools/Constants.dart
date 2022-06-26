class Constants {
  // ** ======================== signing_options_page ======================== ** //
  static const String GOOGLE_LOGIN_TEXT = "التسجيل عن طويق جوجل";
  static const String HAVE_ACCOUNT_TEXT = "لديك حساب ؟";
  static const String LOGIN_TEXT = " تسجيل الدخول";
  static const String LOGIN_WITH_EMAIL_TEXT = "سجل عن طريق البريد الإلكتروني";

  // ** ======================== login_page ======================== ** //
  static const String SKIP_REGISTER_TEXT = "سجل بعدين";
  static const String WELCOME_MESS_TITLE = "سعيد برؤيتك!";
  static const String WELCOME_MESS_DES = "مرحباً بكم، سجل الدخول للاستمرار";
  static const String EMAIL = "عنوان بريد الكتروني";
  static const String PASSWORD = "كلمة السر";
  static const String FORGET_PASSWORD = "نسيت كلمة المرور؟";
  static const String LOGIN_BUTTON = "تسجيل الدخول";
  static const String REGISTER_TEXT = "سجل";

  // ** ======================== forget_password_page ======================== ** //
  static const String FORGET_PASSWORD_TITLE_TEXT = "نسيت كلمة المرور";
  static const String FORGET_PASSWORD_BUTTON_TITLE_TEXT =
      "إعادة تعيين كلمة المرور";
  static const String FORGET_PASSWORD_MESS_TEXT =
      "يرجى إدخال بريدك الإلكتروني أدناه لتلقي تعليمات إعادة تعيين كلمة المرور الخاصة بك.";

  // ** ======================== register_page ======================== ** //
  static const String REGISTER_TITLE_TEXT = "إنشاء حساب";
  static const String REGISTER_MESS_TEXT =
      "الرجاء إدخال بيانات الاعتماد للمتابعة";
  static const String FIRST_NAME_TEXT = "الاسم الاول";
  static const String SECOND_NAME_TEXT = "الاسم الثاني";
  static const String PHONE_TEXT = "رقم الهاتف";
  static const String PASSWORD_CONFORMATION_TEXT = "تأكيد كلمة السر";
  static const String TERMS_AND_CONDITION_TEXT =
      "بإنشاء حساب ، أنت توافق على موقعنا شروط وأحكام";

  // ** ======================== PhoneVerification_page ======================== ** //
  static const String VERIFICATION_TITLE_TEXT = "التحقق من رقم الموبايل";
  static const String RE_SEND_TITLE_TEXT = "إعادة إرسال";
  static const String VERIFY_BUTTON_TEXT = "تحقق";
  static const String VERIFICATION_MESS_TEXT =
      "لقد أرسلنا لك رمزًا للتحقق من صحة  +91 9876543210";

  // ** ======================== add_address_page ======================== ** //
  static const String ADD_ADDRESS_TITLE_TEXT = "اضف عنوان";
  static const String ADD_ADDRESS_MESS_TEXT = "الرجاء إدخال عنوان التسليم";
  static const String ADDRESS_ONE_TEXT = "العنوان 1";
  static const String ADDRESS_TWO_TEXT = "العنوان 2";
  static const String CITY_TEXT = "مدينة";
  static const String STATUS_TEXT = "حالة";
  static const String COUNTRY_TEXT = "بلد";
  static const String SKIP_ADDING_ADDRESS_TEXT = "تخطي في الوقت الراهن";

  // ** ======================== loading_page ======================== ** //
  static const String LOADING_TEXT =
      "أنت على وشك الإنتهاء! نحن بصدد إنشاء ملف التعريف الخاص بك.";

  static const String defaultCurrency = 'SAR';
  static const List<String> SUPPORTED_ISO_CODE_COUNTRY = <String>[
    'SA',
    'YE',
    'SD',
    'AE',
    'TR',
    'TN',
    'SY',
    'SO',
    'QA',
    'EG',
    'DZ',
    'BH',
    'IQ',
    'IR',
    'JO',
    'KW',
    'LB',
    'LY',
    'MA',
    'IL',
    'PS'
  ];
  static const Map<String, String> DEFUlT_HEADER = <String, String>{
    'Accept': 'application/json'
  };
  static const String IMAGE_PLACE_HOLDER_URL =
      'https://i.imgur.com/rNdMwuZ.jpg';
  static const String EG_PHONE_REGEX = r'(010|011|012|015)[0-9]{8}$';
  static const String EMAIL_REGEX =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const double TEXT_FORM_HEIGHT = 51;
  static const double APP_BORDER_RADIUS = 3;
  static const double BOTTOM_SPACE = 30;

  static const String NETWORK_ERROR_MESS = "تأكد من الإتصال بالإنترنت";

  static const String WARNING_TITLE = "تنبيه";
  static const String ERROR_TITLE = "خطا";

  static const String ALL_DATA_REQUIRED = "برجاء إدخال جميع البيانات";
  static const String EMAIL_REQUIRED =
      "برجاء إدخال البريد الإلكتروني صحيح البنية";
  static const String NAME_REQUIRED = "برجاء إدخال الإسم كامل";
  static const String PHONE_REQUIRED = "برجاء إدخال رقم الهاتف بشكل صحيح";
  static const String PASSWORD_REQUIRED =
      "برجاء إدخال كلمة السر لا تقل عن ٧ ارقم او حروف";
  static const String CONFIRMATION_PASSWORD_REQUIRED =
      "برجاء إدخال كلمة السر مره اخري لا تقل عن ٧ ارقم او حروف";
  static const String IDENTICAL_PASSWORD_REQUIRED = "كلمة السر ليست متطابقة";
  static const String POLICIES_REQUIRED =
      "يجب قراءة الشروط والاحكام و الموافقة عليها";
  static const String MAIN_CONFIRMATION = "تأكيد البريد الإلكتروني";
  static const String ACCOUNT_CONFIRMATION = "تأكيد الحساب";
  static const String CODE_CONFIRMATION = "برجاء إدخال الكود بشكل صحيح";
  static const String SUCCESS_REGISTER = "تم التسجيل بنجاح";
  static const String NETWORK_VALIDATION_TITLE = "لا يوجد إتصال بالإنترنت";
  static const String NETWORK_VALIDATION_MESS = "يبدو أنك غير متصل بالإنترنت. يرجى التحقق من إتصالك وحاول مرة أخرى.";

  static const String IMAGE_PLACE_HOLDER = 'https://i.imgur.com/rNdMwuZ.jpg';
  static const String HIGH_LOW_FILTER_KEY = 'high-low';
  static const String LOW_HIGH_FILTER_KEY = 'low-high';

  static const  List<String> addressPageTitle = [
    'عناوين التسليم',
    'عناوين الدفع',
    'عناوين الشحن'
  ];
  static  List<String> orderDetailsTitles = [
    'قيد التنفيذ',
    'التغليف والتعبئة',
    'الشحن',
   // 'تم التوصيل',
     'تم التسليم',
  ];

  static const String paymentMethod = 'cash_on_delivery';

  static const String pendingOrder = 'pending';
  static const String receivedOrder = 'received';
  static const String preparationOrder = 'preparation';
  static const String shippingOrder = 'shipping';
  static const String reachedOrder = 'reached';
  static const String canceledOrder = 'canceled';


}
