
class Strings {
  static const String url = "http://192.168.85.9:8080/Project_Schoolbus";
  //static const String url = "http://10.1.2.183:8080/Project_Schoolbus";
  //static const String url = "http://192.168.137.9:8080/Project_Schoolbus";

  //*************************** Parent ******************************//

  static const String list_parent = "/parent/list";
  static const String RegisterParent = "/parent/add";
  static const String editParent = "/parent/edit";

  static const String getlistSchool = "/school/list";
  static const String getListSearch = "/route/listSearch";

  static const String getListApproved =  "/contract/listApproved";
  static const String getListUnApproved =  "/contract/listUnApproved";
  static const String getContractDetails =  "/contract/getDetails";
  static const String deleteContract =  "/contract/delete";
  static const String requestCancel =  "/request/add";
  static const String getListOther =  "/contract/listOther";
  static const String getSchool =  "/school/getSchool";

  //*************************** Children ******************************//

  static const String list_childrenbyParentId = "/children/listByParentId";
  static const String addChildren = "/children/add";
  static const String getProfileChildren = "/children/profilebyid";
  static const String editChildren = "/children/edit";
  static const String deletechildrenbyId = "/children/delete";
  static const String list_childrenApply = "/children/listApply";
  static const String getContractDetailsbychildrenid = "/contract/getDetailsbychildrenid";

  //*************************** Driver ******************************//

  static const String RegisterDriver ="/driver/add";
  static const String getBusdetailsByDriverId ="/bus/detailsByDriverId";
  static const String calDetails = "/driver/calDetails";
  static const String calChildrensInCar = "/driver/calChildrensInCar";
  static const String editProfileDriver = '/driver/editProfile';
  static const String getProfileDriver ="/driver/getProfileDriver";
  static const String updateService = "/driver/UpdateService";

  static const String driver_listUnApproved =  "/contractDriver/listUnApproved";
  static const String driver_requestCancel =  "/requestCancel/listbyId";

  static const String driver_getRequestCancel =  "/requestCancel/getDetails";
  static const String driver_ApproveRequestCancel =  "/requestCancel/approved";
  static const String driver_ApproveApplication =  "/application/approved";

  static const String Busupdatelocation =  "/bus/updatelocation";
  static const String driver_listChildren =  "/driver/listChildren";
  static const String driver_listChildren1 =  "/driver/listChildren1";
  static const String driver_listChildren2 =  "/driver/listChildren2";
  //*************************** Login *******************************//

  static const String verifyLogin = "/login/verify";
  static const String getProfileByUsername = "/user/profile";

  //*************************** Contract *******************************//
  static const String add_Route = "/route/add";
  static const String list_Route = "/route/list";
  static const String getschoolbusdetails = "/schoolbus/SchoolBusDetails";
  static const String getRouteBySchoolID = "/schoolbus/routebySchool";
  static const String getRouteBySchoolName = "/schoolbus/routebySchoolName";
  static const String requestContract = "/contract/add";

  //*************************** Activity *******************************//
  static const String add_activity = "/activity/add";
  static const String listActivitytime1 = "/activity/list1";
  static const String listActivitytime2 = "/activity/list2";
  static const String updateactivity = "/activity/update";
  static const String activitylistday = "/activity/listday";
  static const String activitylistById = "/activity/listbyid";
}
