
const String ON_BOARDING = 'onBoarding';

const String USERS = 'Users';
const String DEFAULT = 'DEFAULT';
const String TOKENS = 'Tokens';
const String BASE_URL = 'https://fcm.googleapis.com/';
const String ServerKey = '';

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";



//Local Database
const String TableName = 'favourite';
const String DB_Name = 'myDB.db';
const String ID = 'id';
const String TITLE = 'title';
const String DESCRIPTION = 'description';
const String IMAGES = 'images';
const String COLOR = 'color';
const String RATING = 'rating';
const String PRICE = 'price';
const String isFavourite = 'isFavourite';
const String isPopular = 'isPopular';
