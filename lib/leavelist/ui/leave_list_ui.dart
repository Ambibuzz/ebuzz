import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/leavelist/service/leave_list_api_service.dart';
import 'package:ebuzz/leavelist/model/employee_leave.dart';
import 'package:flutter/material.dart';

//EmployeeLeaveUi class contains ui for displaying leaves list from leave application api
class EmployeeLeaveUi extends StatefulWidget {
  final String name;
  EmployeeLeaveUi({required this.name});
  @override
  _EmployeeLeaveUiState createState() => _EmployeeLeaveUiState();
}

class _EmployeeLeaveUiState extends State<EmployeeLeaveUi> {
  List<String> employeeDuplicteList = [];
  List<String> employeeList = [];
  TextEditingController searchController = TextEditingController();
  bool apicall = false;
  List<EmployeeLeave> employeeLeaveList = [];
  EmployeeApiService _employeeApiService = EmployeeApiService();

  @override
  void initState() {
    super.initState();
    _fetchEmployeeLeaveList();
  }

  _fetchEmployeeLeaveList() async {
    employeeLeaveList =
        await _employeeApiService.fetchEmployeeLeavelist(widget.name, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight( 55),
          child: CustomAppBar(
            title: Text('Leave List', style: TextStyle(color: whiteColor)),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            ),
          )),
      body: employeeLeaveList.isEmpty
          ?
          // CircularProgress()
           Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 20, color: blackColor),
              ),
            )
          : EmployeeLeaveList(
              employeeLeave: employeeLeaveList,
            ),
    );
  }
}

//EmployeeLeaveList is a reusable widget for displaying leaves of employee
class EmployeeLeaveList extends StatelessWidget {
  final List<EmployeeLeave> employeeLeave;
  EmployeeLeaveList({required this.employeeLeave});
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: employeeLeave.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              employeeLeave[index].employeeName!,
                              style: TextStyle(fontSize: 20, color: blackColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'From : ' + employeeLeave[index].fromDate!,
                                  style: TextStyle(
                                      fontSize: 16, color: blackColor),
                                ),
                                Text(
                                  ' To : ' + employeeLeave[index].toDate!,
                                  style: TextStyle(
                                      fontSize: 16, color: blackColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Reason : ' + employeeLeave[index].description!,
                                style:
                                    TextStyle(fontSize: 16, color: blackColor),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Leave Balance : ' +
                                      employeeLeave[index]
                                          .leaveBalance
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: blackColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Half Day : ' +
                                      employeeLeave[index].halfDay.toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: blackColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Total Leave Days : ' +
                                  employeeLeave[index]
                                      .totalLeaveDays
                                      .toString(),
                              style: TextStyle(fontSize: 16, color: blackColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            employeeLeave[index].leaveApprover == null
                                ? Container()
                                : Text(
                                    'Approved by : ' +
                                        employeeLeave[index].leaveApprover!,
                                    style: TextStyle(
                                        fontSize: 16, color: blackColor),
                                  ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: employeeLeave[index].status == 'Approved'
                                ? greenColor
                                : redColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
