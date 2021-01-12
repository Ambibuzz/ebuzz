//EmployeeLeave class contains model to store data of Employee Leave api
//All fields are  not been used only limited fields which were useful in app have been used

class EmployeeLeave {
  final String postingDate;
  final String status;
  final String leaveApprover;
  final String description;
  final double totalLeaveDays;
  final String fromDate;
  final String toDate;
  final int halfDay;
  final String halfDayDate;
  final String leaveType;
  final double leaveBalance;
  final String employeeName;
  final String employee;

  EmployeeLeave(
      {this.postingDate,
      this.status,
      this.leaveApprover,
      this.description,
      this.totalLeaveDays,
      this.fromDate,
      this.toDate,
      this.halfDay,
      this.halfDayDate,
      this.leaveType,
      this.leaveBalance,
      this.employeeName,
      this.employee});

  //For fetching json data from leave application api and storing it in employee leave model
  factory EmployeeLeave.fromJson(Map<String, dynamic> json) {
    return EmployeeLeave(
        description: json['description'] ?? '',
        employee: json['employee'] ?? '',
        employeeName: json['employee_name'] ?? '',
        fromDate: json['from_date'] ?? '',
        halfDay: json['half_day'] ?? 0,
        halfDayDate: json['half_day_date'] ?? '',
        leaveApprover: json['leave_approver_name'] ?? '',
        leaveBalance: json['leave_balance'] ?? 0,
        leaveType: json['leave_type'] ?? '',
        postingDate: json['posting_date'] ?? '',
        status: json['status'] ?? '',
        toDate: json['to_date'] ?? '',
        totalLeaveDays: json['total_leave_days'] ?? 0);
  }
}
