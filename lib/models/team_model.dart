// ignore_for_file: non_constant_identifier_names

library com.nds.model;

class TeamMembersModel {
  late String empl_empl_id;
  late String staff_name;

  String getempl_empl_id() {
    return empl_empl_id;
  }

  void setempl_empl_id(String empl_empl_id) {
    this.empl_empl_id = empl_empl_id;
  }

  String getstaff_name() {
    return staff_name;
  }

  void setstaff_name(String staff_name) {
    this.staff_name = staff_name;
  }
}
