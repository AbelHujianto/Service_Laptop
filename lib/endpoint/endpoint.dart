class Endpoint {
  static const String baseURL =
      "http://10.11.7.76:5000";

  static const String baseURLLive = "https://simobile.singapoly.com";
  static const String serviceRequestcreate = "$baseURL/create_service_request";
  static const String serviceRequestread = "$baseURL/read_service_request";
  static const String serviceRequestreadbyID = "$baseURL/read_service_byID";
  static const String serviceRequestupdate = "$baseURL/update_service_request";
  static const String serviceRequestdelete = "$baseURL/delete_service_request";
  static const String consultationcreate = "$baseURL/create_consultation";
  static const String consultationread = "$baseURL/read_consultation";
  static const String teknisiread = "$baseURL/read_teknisi";
  static const String teknisireadbyID = "$baseURL/read_teknisibyID";
  static const String teknisicreate = "$baseURL/create_teknisi";

 
  static const String datas = "$baseURLLive/api/datas";
  static const String custserv = "$baseURLLive/api/customer-service";
  static const String categories = "$baseURL/categories";
  static const String nimData = "$custserv/2215091005";

  static const String balance = "$baseURLLive/api/balance/2215091005";
  static const String spending = "$baseURLLive/api/spending/2215091005";

  static const String login = "$baseURL/data";
  static const String datalogin = "$baseURL/login";
  static const String logout = "$baseURL/logout";
  static const String register= "$baseURL/register";
}