class ApiUrls {
  static String BASE_URL_TRUCK = "https://api.truck.deeps.info/api/";
  // static String BASE_URL = "https://makatib.ai/";
  static String CREATE_ACCOUNT = "user/createAccount";
  static String SIGN_IN = "user/loginUser";
  static String CHANGE_PASSWORD = "user/changePassword";
  static String FORGOT_PASSWORD = "user/updateForgotPassword";
  static String SEND_EMAIL_OTP = "user/sendEmailOTP";
  static String GET_VEHICLE_TYPES = "vehicle/getVehicleTypes";
  static String GET_FAIR_BY_ID = "fair/calculateFair";
  static String BOOK_A_RIDE = "booking/book/";
  static String ACCEPT_BID = "booking/acceptBid";
  static String DECLINE_BID = "booking/declineBid";
  static String CANCEL_RIDE = "booking/cancelRide";
  static String CANCEL_REASONS = "booking/reason/getAll";
  static String ADD_CANCEL_REASONS = "booking/reason/add";
  static String GET_CHAT_MESSAGES = 'chat/getChatMessages';
  static String SEND_MESSAGE = "chat/sendMessage";

  /// Ride History
  static String GET_RIDE_HISTORY = "booking/getRideHistory";
  static String GET_LAST_RIDE = "booking/getLastRide";

  /// fav

  static String ADD_TO_FAV = "fav_driver/add";
  static String REMOVE_FROM_FAV = "fav_driver/removeFromFavourite";
  static String GET_ALL_FAV_DRIVERS = "fav_driver/getAllFavourites";

  static String GET_REVIEWS = "rating/getAllReviews";
  static String ADD_REVIEWS = "rating/rate_review";

  static String GET_PLANS = "subscription/getAllPlan";

  static String BUY_PLAN = "subscription/buyPlan";

  static String CREATE_DISPUTE = "dispute/openDispute/";

  static String GET_ALL_DISPUTES = "dispute/getAllDispute/";

  static String GET_DISPUTE_MESSAGES = "dispute/getDisputeMessages/";

  static String SEND_DISPUTE_MESSAGE = "dispute/sendMessage/";

  static var UPDATE_PROFILE = "user/updateUserProfile";

  static String GET_ACTIVATED_PLAN = "subscription/getSubscribedPlanByUser";

  static var GET_RIDE_IN_PROGRESS="booking/inProgressRide";
  ///registration APi

  static String REGISTRATION="Accounts/register";
  static String LOGIN="Accounts/signin";
  ///truck fare
  static String TRUCK_ALL_FARES="Truck/get-truck-fare-details";
  ///booking
 static String BOOKING_REQUEST="Order/book-order";
 ///getAllCities
 static String GET_ALL_CITIES="Cities/get-cities";

 static String GET_DISTANCE="Cities/get-disctance";
 ///getAllOrders

 static String GET_ALL_ORDERS="Order/get-order-by-client";
///uploadPaymentEvidence
 static String UPLOAD_PAYMENT_EVIDENCE="PaymentEvidence/Upload-Payment-Evidence";
  ///getPaymentEvidence

  static String GET_PAYMENT_EVIDENCE="PaymentEvidence/Get-Evidence";
}
