const String baseUrl = 'https://story-api.dicoding.dev/v1';
const String endPointRegister = '$baseUrl/register';
const String endPointLogin = '$baseUrl/login';
const String endPointGetStory = '$baseUrl/stories';
String endPointDetailStory(idStories) => '$baseUrl/stories/$idStories';
const String endPointAddStory = '$baseUrl/stories';

//Local Storage Key
const String authData = "oAuthData";
const String loginData = "login";