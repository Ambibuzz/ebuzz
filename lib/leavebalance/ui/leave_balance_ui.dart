import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/leavebalance/service/leave_balance_api_service.dart';
import 'package:flutter/material.dart';

//LeaveUi class contains ui of leave balance
class LeaveUi extends StatefulWidget {
  @override
  _LeaveUiState createState() => _LeaveUiState();
}

class _LeaveUiState extends State<LeaveUi> {
  List<double> privilegeLeaveList = [];
  List<double> concessionalLeaveList = [];
  List<double> leaveWithoutPayList = [];
  List<double> compensatoryOffList = [];
  LeaveApiService _leaveApiService = LeaveApiService();
  List list = [];
  double privilegeSum = 0;
  double concessionalSum = 0;
  double leaveWithoutPaySum = 0;
  double compensatoryOffSum = 0;
  @override
  void initState() {
    super.initState();
    fetchLeave();
  }

  //for fetching leave based on each leave type
  fetchLeave() async {
    String privilegeLeave = "Privilege Leave";
    String concessionalLeave = "Concessional Leave";
    String leaveWithoutPay = "Leave Without Pay";
    String compensatoryOff = "Compensatory Off";
    list = await _leaveApiService.fetchLeave(context);

    for (var listJson in list) {
      if (listJson['leave_type'] == privilegeLeave) {
        privilegeLeaveList.add(listJson['leaves']);
      }
      if (listJson['leave_type'] == concessionalLeave) {
        concessionalLeaveList.add(listJson['leaves']);
      }
      if (listJson['leave_type'] == leaveWithoutPay) {
        leaveWithoutPayList.add(listJson['leaves']);
      }
      if (listJson['leave_type'] == compensatoryOff) {
        compensatoryOffList.add(listJson['leaves']);
      }
    }
    for (double sum in privilegeLeaveList) {
      privilegeSum += sum;
    }
    for (double sum in concessionalLeaveList) {
      concessionalSum += sum;
    }
    for (double sum in leaveWithoutPayList) {
      leaveWithoutPaySum += sum;
    }
    for (double sum in compensatoryOffList) {
      compensatoryOffSum += sum;
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Leave Balance',
          )),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          children: [
            cardUi('Privilege Leave', privilegeSum),
            cardUi('Concessional Leave', concessionalSum),
            cardUi('Leave Without Pay', leaveWithoutPaySum),
            cardUi('Compensatory Off', compensatoryOffSum),
          ],
        ),
      ),
    );
  }

  //it is a reusable widget for displaying ui of each leave type
  Widget cardUi(String text, double leaveType) {
    return Container(
      width: displayWidth(context) * 0.45,
      height: displayWidth(context) * 0.45,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(top: displayWidth(context) > 600 ? 20 : 15),
                child: Text(
                  text,
                  style: displayWidth(context) > 600
                      ? TextStyle(fontSize: 26)
                      : TextStyles.t16Black,
                  maxLines: 3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                leaveType.toString(),
                style: TextStyle(
                    color: blueAccent,
                    fontSize: displayWidth(context) > 600 ? 55 : 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
