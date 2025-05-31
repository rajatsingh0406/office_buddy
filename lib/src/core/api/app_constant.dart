class AppConstant {
  // static const baseUrl = 'https://pmg.engineering/apis'; // for production
  static const baseUrl = 'http://192.168.1.222.nip.io:8001/apis'; // SIT // for local
  static const localUrl =
      "http://192.168.1.46:8000/apis"; // pmg.engineering == 192.168.1.222:8001 and https == http
//   static const dynamicLocalUrl = "http://192.168.1.222:8001";
  // static const dynamicBaseUrl = "https://pmg.engineering"; // for production
  static const dynamicBaseUrl = "http://192.168.1.222.nip.io:8001";
  static const apiTimeOutInSecond = 100; // SIT
  static const appVersion = '$baseUrl/appversion/';

  // login
  static const googleLogin = '$baseUrl/google-login/';
  static const appleLogin = '$baseUrl/apple-login/';
  static const signIn = '$dynamicBaseUrl/apis/signin/';
  static const signUp = '$dynamicBaseUrl/apis/signup/';
  static const signOut = '$dynamicBaseUrl/apis/signout/';
  static const forgotPassword = '$dynamicBaseUrl/apis/forgot-password/';
  static const validateOtp = '$dynamicBaseUrl/apis/validate-otp/';
  static const resetPassword = '$dynamicBaseUrl/apis/reset-password/';
  static const verifyToken = '$baseUrl/token/verify/';
  static const refreshToken = '$baseUrl/token/refresh/';

  static const homeDesigAapi = "$baseUrl/StaticContent/?page=home";
  static const storiesApi = "$baseUrl/Stories/";
  static const storiesPlaylistApi = "$baseUrl/StoriesPlaylist";
  static const videoBoxApi = "$baseUrl/StaticContent/?page=homeslider";
  static const metrics = "$baseUrl/Metrics/";
  static const keyClient = "$baseUrl/Customer/?featured=true";
  static const serviceGroup = "$baseUrl/ServiceGroup/";
  static const getServices = "$baseUrl/Product/?Service=True/";
  static const productGroup = "$baseUrl/ProductGroup/";
  static const productsHorizontal = "$baseUrl/Product/?P=True";
  static const technologyGroup = "$baseUrl/TechnologyGroup/";
  static const technologyHorizontal = "$baseUrl/Technology/?P=True";
  static const insights = "$baseUrl/Article/";
  static const newsLetters = "$baseUrl/Newsletter/?limit=10";
  static const newsLettersData = "$baseUrl/Newsletter/";
  static const newsLetterSearch = "$baseUrl/Newsletter/?search=";
  static const digital = "$baseUrl/DigitalGroup/";
  static const faq = "$baseUrl/FAQ/";
  static const about = "$baseUrl/About/";
  static const aboutGroup = "$baseUrl/AboutGroup/";
  static const getGroupCategory = "$baseUrl/About/?group=";
  static const username = "sabitri.behera@pmg.engineering";
  static const password = "Pmg@2015";
  static const expertiseCategory = "$baseUrl/ServiceCategory/?group=";
  static const expertiseGroupData = "$baseUrl/ServiceGroup/";
  static const expertiseCategoryData = "$baseUrl/ServiceCategory/";
  static const project = "$baseUrl/Project/?limit=10&featured=true";
  static const projectDate = "$baseUrl/Project/";
  static const projectSearch = "$baseUrl/Project/?search=";
  static const presentation = "$baseUrl/Presentation/?limit=10";
  static const presentationData = "$baseUrl/Presentation/";
  static const presentationSearch = "$baseUrl/Presentation/?search=";
  static const technographics = "$baseUrl/TechnicalGraphic/?limit=10";
  static const technographicsSearch = "$baseUrl/TechnicalGraphic/?search=";
  static const technographicsData = "$baseUrl/TechnicalGraphic/";
  static const productCategory = "$baseUrl/ProductCategory/?group=";
  static const productCategoryData = "$baseUrl/ProductCategory/";
  static const product = "$baseUrl/Product/?category=";
  static const productData = "$baseUrl/Product/";
  static const technologyCategory = "$baseUrl/TechnologyCategory/?group=";
  static const technologyCategoryData = "$baseUrl/TechnologyCategory/";
  static const technology = "$baseUrl/Technology/?category=";
  static const technologyData = "$baseUrl/Technology/";
  static const expertiseGroup = "$baseUrl/ServiceGroup/";
  static const expertise = "$baseUrl/Service/?category=";
  static const expertiseData = "$baseUrl/Service/";
  static const insightsLimit = "$baseUrl/Article/?limit=6";
  static const insightSearch = "$baseUrl/Article/?search=";
  static const presentationLimit = "$baseUrl/Presentation/?limit=10";
  static const engineeringTemplate = "$baseUrl/EngineeringTemplate/?limit=10";
  static const engineeringTemplateSearch =
      "$baseUrl/EngineeringTemplate/?search=";
  static const engineeringTemplateData = "$baseUrl/EngineeringTemplate/";
  static const infographics = "$baseUrl/NonTechnicalGraphic/?limit=10";
  static const infographicsSearch = "$baseUrl/NonTechnicalGraphic/?search=";
  static const infographicsData = "$baseUrl/NonTechnicalGraphic/";
  static const video = "$baseUrl/Video/?limit=10";
  static const videoSearch = "$baseUrl/Video/?search=";
  static const videoData = "$baseUrl/Video/";
  static const poster = "$baseUrl/Poster/?limit=10";
  static const posterSearch = "$baseUrl/Poster/?search=";
  static const posterData = "$baseUrl/Poster/";
  static const contact = "$baseUrl/Contact/";

  // ask pmg

  static const askQuestion = "$dynamicBaseUrl/AskQuestion/";
  static const askQuestionReply = "$dynamicBaseUrl/AskAnswerQ/?object_id=";
  static const askAnswerReply = "$dynamicBaseUrl/AskAnswerA/?object_id=";
  static const csrfToken = "$dynamicBaseUrl/apis/get-csrf-token/";

  // knowledge

  static const learning = "$dynamicBaseUrl/Learning/";
  static const searchApi = "$dynamicBaseUrl/searchapi/";

  // mySpace

  static const userProject = "$dynamicBaseUrl/apis/UserProject/";
  static const projectUpdates = "$dynamicBaseUrl/updatesapi/";
  static const projectDeliverable = "$dynamicBaseUrl/ProposalItem/?project=";
  static const mySpaceKnowledge = "$dynamicBaseUrl/MySpaceKnowledge/";
  static const todo = "$dynamicBaseUrl/Todo/?project=";
  static const singleTodo = "$dynamicBaseUrl/Todo/";
  static const allToDo = "$dynamicBaseUrl/AllTodo/?project=";
  static const singleAllTodo = "$dynamicBaseUrl/AllTodo/";
  static const projectFiles = "$dynamicBaseUrl/ProjectFiles/?project=";
  static const employeeStatus = "$baseUrl/Employee/";
  static const todoReply = "$dynamicBaseUrl/TodoReplyT/?object_id=";
  static const todoReplyAnswer = "$dynamicBaseUrl/TodoReplyR/?object_id=";

  //career

  static const imageSlider = "$baseUrl/StaticContent/";
  static const career = "$baseUrl/Career/";
  static const careerApplication = "$baseUrl/CareerApplication/";

  //profile
  static const profile = "$baseUrl/Profile/";

  // Digital features

  static const digitalData = "$dynamicBaseUrl/DigitalData/";
  static const digitalTodo = "$dynamicBaseUrl/Todo/?limit=10&page=";
  static const digitalAllTodo = "$dynamicBaseUrl/AllTodo/?limit=10&page=";
  static const logAPiData = "$dynamicBaseUrl/LogApi/?limit=20&page=";
  static const logInsightApi = "$dynamicBaseUrl/loginsightapi/";
  static const logCalendarApi = "$dynamicBaseUrl/logcalendarapi/";
  static const allEmployee = "$dynamicBaseUrl/apis/Employee/";

  // workspace

  static const workspace = "$dynamicBaseUrl/apis/Workspace/";
  static const workspaceNotification = "$dynamicBaseUrl/apis/Notification/";
  static const workspaceInvoice = "$dynamicBaseUrl/apis/Invoice/";

  static const iosVersion = '1.0.7';
  static const androidVersion = '1.0.9+12';
  static const androidAppLink =
      'https://play.google.com/store/apps/details?id=com.pmg&pcampaignid=web_share';
  static const iosAppLink =
      "https://apps.apple.com/in/app/pmg-engineering/id6523418382";
}
