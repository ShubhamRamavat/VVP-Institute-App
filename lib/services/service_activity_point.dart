class ActivityPoint {
  int student_Activity_Points_Id,
      student_Id,
      semester,
      activity_Point;
  late String event_Date;

  late String main_Heading_Index, sub_Heading_Index, assign_Activity_Index, approval_Status;


    
  ActivityPoint(
      this.student_Activity_Points_Id,
      this.student_Id,
      this.main_Heading_Index,
      this.sub_Heading_Index,
      this.assign_Activity_Index,
      this.approval_Status,
      this.semester,
      this.activity_Point,
      this.event_Date);

      
}
