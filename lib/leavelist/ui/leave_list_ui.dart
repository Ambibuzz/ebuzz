import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/leavelist/service/leave_list_api_service.dart';
import 'package:ebuzz/leavelist/model/employee_leave.dart';
import 'package:flutter/material.dart';

//EmployeeLeaveUi class contains ui for displaying leaves list from leave application api
class EmployeeLeaveUi extends StatefulWidget {
  final String name;
  EmployeeLeaveUi({this.name});
  @override
  _EmployeeLeaveUiState createState() => _EmployeeLeaveUiState();
}

class _EmployeeLeaveUiState extends State<EmployeeLeaveUi> {
  List<String> employeeDuplicteList = [];
  List<String> employeeList = [];
  TextEditingController searchController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  bool apicall = false;
  List<EmployeeLeave> employeeLeaveList;
  EmployeeApiService _employeeApiService = EmployeeApiService();

  @override
  void initState() {
    super.initState();
    _fetchEmployeeLeaveList();
  }

  _fetchEmployeeLeaveList() async {
    employeeLeaveList =
        await _employeeApiService.fetchEmployeeLeavelist(widget.name);
    setState(() {});
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Leave List',
          )),
      body: employeeLeaveList == null
          ? CircularProgress()
          : EmployeeLeaveList(
              employeeLeave: employeeLeaveList,
            ),
    );
  }
}

//EmployeeLeaveList is a reusable widget for displaying leaves of employee
class EmployeeLeaveList extends StatelessWidget {
  final List<EmployeeLeave> employeeLeave;
  EmployeeLeaveList({this.employeeLeave});
  @override
  Widget build(BuildContext context) {
    return employeeLeave.length == 0
        ? Center(
            child: Text(
              'No Data',
              style: displayWidth(context) > 600
                  ? TextStyle(
                      fontSize: 28,
                    )
                  : TextStyles.t20Black,
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: employeeLeave.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) > 600 ? 16 : 8,
                    vertical: displayWidth(context) > 600 ? 6 : 2),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: displayWidth(context) > 600 ? 14 : 8,
                        horizontal: displayWidth(context) > 600 ? 18 : 12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              employeeLeave[index].employeeName,
                              style: displayWidth(context) > 600
                                  ? TextStyle(
                                      fontSize: 28, fontWeight: FontWeight.bold)
                                  : TextStyles.t20BlackBold,
                            ),
                            SizedBox(
                              height: displayWidth(context) > 600 ? 8 : 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'From : ' + employeeLeave[index].fromDate,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 24,
                                        )
                                      : TextStyles.t16Black,
                                ),
                                Text(
                                  ' To : ' + employeeLeave[index].toDate,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 24,
                                        )
                                      : TextStyles.t16Black,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Reason : ' + employeeLeave[index].description,
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 24,
                                      )
                                    : TextStyles.t16Black,
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
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 24,
                                        )
                                      : TextStyles.t16Black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Half Day : ' +
                                      employeeLeave[index].halfDay.toString(),
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 24,
                                        )
                                      : TextStyles.t16Black,
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
                              style: displayWidth(context) > 600
                                  ? TextStyle(
                                      fontSize: 24,
                                    )
                                  : TextStyles.t16Black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            employeeLeave[index].leaveApprover == null
                                ? Container()
                                : Text(
                                    'Approved by : ' +
                                        employeeLeave[index].leaveApprover,
                                    style: displayWidth(context) > 600
                                        ? TextStyle(
                                            fontSize: 24,
                                          )
                                        : TextStyles.t16Black,
                                  ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: displayWidth(context) > 600 ? 30 : 15,
                          height: displayWidth(context) > 600 ? 30 : 15,
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
