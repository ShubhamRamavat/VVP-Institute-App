class PlacementCompany {
  late int company_id;
  late String company_name;
  late String company_detail;
  late String interview_date_time;
  late String venue;
  late String job_title;
  late String job_description;
  late double package_CTC;
  String? job_location;
  String? selection_procedure;
  String? bond_duration;
  late String security_deposite;
  String? eligible_branch;
  String? registration_last_date;
  String? about_company_info;
  String? registration_link;
  String? feedBack;
  String? attachment_filename;

  PlacementCompany({
    required this.company_id,
    required this.company_name,
    required this.company_detail,
    required this.interview_date_time,
    required this.venue,
    required this.job_title,
    required this.job_description,
    required this.package_CTC,
    required this.security_deposite,
    this.job_location,
    this.selection_procedure,
    this.bond_duration,
    this.eligible_branch,
    this.about_company_info,
    this.registration_link,
    this.feedBack,
    this.registration_last_date,
    this.attachment_filename});

}