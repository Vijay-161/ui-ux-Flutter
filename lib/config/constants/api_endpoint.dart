class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3001/api/v1/";
  // static const String baseUrl = "http://192.168.4.4:3001/api/v1/";
  // static const String baseUrl = "http://192.168.11.66:3001/api/v1/";

  // to run in imulator -----http://192.168.56.1:3001/api/v1/
  // static const String baseUrl = "http://192.168.56.1:3001/api/v1/";

  static const String baseUrl = "http://192.168.11.78:3001/api/v1/";

  // static const String baseUrl = "http://192.168.137.1:3001/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllStudent = "auth/getAllStudents";
  static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String uploadImage = "auth/uploadImage";
  static const String checkUser = "auth/checkUser";
  static const String getUser = "auth/getUser";
  static const String imageUrl = "http://10.0.2.2:3001/products/";
  static const String userImageUrl = "http://10.0.2.2:3001/uploads/";

  // ====================== Batch Routes ======================
  static const String createBatch = "batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";

  // ====================== Course Routes ======================
  static const String createCourse = "course/createCourse";
  static const String getAllCourse = "course/getAllCourses";

  //Product
  static const String createProduct = "product/createProduct";
  static const String getAllProduct = "product/getAllProduct";
  static const String uploadProductImage = "product/uploadProductImage";
  static const String getProduct = "product/";
  static const String deleteProduct = "product/";
  static const String editProduct = "product/";
  static const String getByCategory = "product/getByCategory";

  //Cart
  static const String createCart = "cart/createCart";
  static const String getAllCart = "cart/getAllCart";
  static const String getCart = "cart/user";
  static const String deleteCart = "cart/";
  static const String editCart = "cart/";
  static const String getSingleCart = "cart/";

  //Order
  static const String createOrder = "order/createOrder";
  static const String getAllOrder = "order/getAllOrder";
  static const String getOrder = "order/user";
  static const String deleteOrder = "order/";
}
