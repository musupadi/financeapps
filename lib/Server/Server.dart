// ini adalah class untuk Server management

String APIBaseURL(){
  return "API Base URL";
}
String BASEURL(){
  return "URL UTAMA";
}
// Header Builder yang bisa digunakan jika nantinya API memiliki Header berbeda beda
var headers = {
  'Content-type': 'application/json',
  "Accept": "application/json",
  "Access-Control-Allow-Origin": APIBaseURL(),
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  "Access-Control-Allow-Headers": " Origin, Content-Type, Accept, Authorization, X-Request-With",
};
Map<String,String> headerBuilder(String token) {
  return headers = {
    'Content-type': 'application/json',
    "Accept": "application/json",
    "Access-Control-Allow-Origin": APIBaseURL(),
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    "Access-Control-Allow-Headers": " Origin, Content-Type, Accept, Authorization, X-Request-With",
    "token": token
  };
}
// Persiapan untuk pembuatan URL
String URLAPI(){
  return "api/URL";
}
