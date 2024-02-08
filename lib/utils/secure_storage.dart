import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  final storage = const FlutterSecureStorage();

  Future setStaffId(var staffId) async {
    await storage.write(key: "staffId", value: "$staffId");
  }

  Future setuser(var user) async {
    await storage.write(key: "user", value: "$user");
  }

  Future setdate(var date) async {
    await storage.write(key: "date", value: "$date");
  }

  Future setbaseurl(var url) async {
    await storage.write(key: "domain_url", value: "$url");
  }

  Future getbaseurl() async {
    var domainurl = await storage.read(key: "domain_url");
    return domainurl;
  }

  Future settcode(var url) async {
    await storage.write(key: "t_code", value: "$url");
  }

  Future gettcode() async {
    var tcode = await storage.read(key: "t_code");
    return tcode;
  }

  Future getdate() async {
    var date = await storage.read(key: "date");
    return date;
  }

  Future getuser() async {
    var user = await storage.read(key: "user");
    return user;
  }

  Future getStaffId() async {
    var staffId = await storage.read(key: "staffId");
    return staffId;
  }

  Future setcheckinattendance(var message) async {
    await storage.write(key: "checkinmsg", value: "$message");
  }

  Future getattendancemsg() async {
    var empName = await storage.read(key: "checkinmsg");
    return empName;
  }

  Future setEmpName(var empName) async {
    await storage.write(key: "empName", value: "$empName");
  }

  Future getEmpName() async {
    var empName = await storage.read(key: "empName");
    return empName;
  }

  Future setBodyHeader(var bodyHeader) async {
    await storage.write(key: "bodyHeader", value: "$bodyHeader");
  }

  Future getBodyHeader() async {
    var bodyHeader = await storage.read(key: "bodyHeader");
    return bodyHeader;
  }

  Future setData(var data) async {
    await storage.write(key: "data", value: "$data");
  }

  Future getData() async {
    var data = await storage.read(key: "data");
    return data;
  }

  Future setDailyCalls(var dailyCalls) async {
    await storage.write(key: "dailyCalls", value: "$dailyCalls");
  }

  Future getDailyCalls() async {
    var dailyCalls = await storage.read(key: "dailyCalls");
    return dailyCalls;
  }

  Future setfdfmcreate(var setfdfm) async {
    await storage.write(key: "fdfm", value: "$setfdfm");
  }

  Future getfdfmcreate() async {
    var fdfm = await storage.read(key: "fdfm");
    return fdfm;
  }

  Future setfdfmname(var setfdfmname) async {
    await storage.write(key: "setfdfmname", value: "$setfdfmname");
  }

  Future getfdfmname() async {
    var getfdfmname = await storage.read(key: "setfdfmname");
    return getfdfmname;
  }

  Future setbool(var value) async {
    await storage.write(key: "bool", value: "$value");
  }

  Future getbool() async {
    var getbool = await storage.read(key: "bool");
    return getbool;
  }

  //order in daily report

  Future setClient(var value) async {
    await storage.write(key: "name", value: "$value");
  }

  Future getClient() async {
    var getname = await storage.read(key: "name");
    return getname;
  }

  Future setItem(var value) async {
    await storage.write(key: "item", value: "$value");
  }

  Future getItem() async {
    var getItem = await storage.read(key: "item");
    return getItem;
  }

  Future setDes(var value) async {
    await storage.write(key: "des", value: "$value");
  }

  Future getDes() async {
    var getDes = await storage.read(key: "des");
    return getDes;
  }

  ///Visit Location var

  Future setCheckInvisitLocation(var value) async {
    await storage.write(key: "CheckIn", value: "$value");
  }

  Future getsetCheckInvisitLocation() async {
    var getDes = await storage.read(key: "CheckIn");
    return getDes;
  }

  Future setCheckOutvisitLocation(var value) async {
    await storage.write(key: "CheckOut", value: "$value");
  }

  Future getsetCheckOutvisitLocation() async {
    var getDes = await storage.read(key: "CheckOut");
    return getDes;
  }
}
