class Result{
  // late String
  var st_id,stu_rollno,exam_no, exam, result;
  String? course_name, year;
  var sub1,sub2,sub3,sub4,sub5,sub6,sub7,sub8,sub9,sub10;
  var sub1_name,sub2_name,sub3_name,sub4_name,sub5_name,sub6_name,sub7_name,sub8_name,sub9_name,sub10_name;
  var sub1_grade,sub2_grade,sub3_grade,sub4_grade,sub5_grade,sub6_grade,sub7_grade,sub8_grade,sub9_grade,sub10_grade;
  // late double
  var spi,cpi,cgpa;
  // late int
  var total_backl, curr_backl,sem;

  // Result(exam_no){
  //   this.exam_no = exam_no;
  // }

  Result({
    required this.st_id,
    required this.stu_rollno, required this.sem,
    required this.exam_no, required this.exam, required this.result,
    required this.sub1, required this.sub2, required this.sub3, required this.sub4, required this.sub5,
    required this.sub6, required this.sub7, required this.sub8, required this.sub9, required this.sub10,
    required this.sub1_name, required this.sub2_name, required this.sub3_name, required this.sub4_name, required this.sub5_name,
    required this.sub6_name, required this.sub7_name, required this.sub8_name, required this.sub9_name, required this.sub10_name,
    required this.sub1_grade, required this.sub2_grade, required this.sub3_grade, required this.sub4_grade, required this.sub5_grade,
    required this.sub6_grade, required this.sub7_grade, required this.sub8_grade, required this.sub9_grade, required this.sub10_grade,
    required this.spi,
    required this.cpi,
    required this.cgpa,
    required this.total_backl,
    required this.curr_backl,
    this.year,
  });


}