import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/dashboard/bloc/bloc/dashboard_bloc.dart';
import 'package:my_app/shared/UIHelper.dart';
import 'package:my_app/shared/global.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, required String this.groupId});
  final String groupId;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _dashboardBloc
            .add(DashboardAddUserToCurrentGroupEvent(groupId: widget.groupId)),
      ),
      appBar: AppBar(
        title: Text("Group DashBoard"),
        backgroundColor: Colors.lightBlue,
        actions: [],
      ),
      body: Container(
        decoration: UIHelper.customContainerDecoration(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
