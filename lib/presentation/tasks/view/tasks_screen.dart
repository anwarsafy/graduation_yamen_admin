import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/core/loader/loading_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/tasks_model.dart';
import '../viewmodel/tasks_cubit.dart';
import '../viewmodel/tasks_state.dart';


class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  late AssignmentDataGridSource _assignmentDataGridSource;

  @override
  void initState() {
    super.initState();
    _assignmentDataGridSource = AssignmentDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentCubit()..loadAllAssignmentsData(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Assignments'),
          ),
          body: BlocBuilder<AssignmentCubit, AssignmentState>(
            builder: (context, state) {
              if (state.status == AssignmentStatus.loading) {
                return  Center(child: loadingIndicator());
              } else if (state.status == AssignmentStatus.error) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              final dataToDisplay = state.assignmentsData;

              if (dataToDisplay == null || dataToDisplay.isEmpty) {
                return const Center(child: Text("No data available."));
              }

              _assignmentDataGridSource.updateDataSource(dataToDisplay);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDataGrid(
                  source: _assignmentDataGridSource,
                  columns: _obtainColumns(),
                  allowSorting: true,
                  allowFiltering: true,
                  columnWidthMode: ColumnWidthMode.fill,
                ),
              );
            },
          ),
        );
      }),
    );
  }

  List<GridColumn> _obtainColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'courseName',
        label: const Center(child: Text('Course Name')),
      ),
      GridColumn(
        columnName: 'department',
        label: const Center(child: Text('Department')),
      ),
      GridColumn(
        columnName: 'level',
        label: const Center(child: Text('Level')),
      ),
      GridColumn(
        columnName: 'taskDate',
        label: const Center(child: Text('Task Date')),
      ),
      GridColumn(
        columnName: 'taskType',
        label: const Center(child: Text('Task Type')),
      ),
      GridColumn(
        columnName: 'students',
        label: const Center(child: Text('Students')),
      ),
    ];
  }
}

class AssignmentDataGridSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void updateDataSource(List<AssignmentModel> assignmentsData) {
    _dataGridRows = assignmentsData.map<DataGridRow>((assignment) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'courseName', value: assignment.courseName),
        DataGridCell(columnName: 'department', value: assignment.department),
        DataGridCell(columnName: 'level', value: assignment.level),
        DataGridCell(columnName: 'taskDate', value: assignment.taskDate?.toIso8601String()),
        DataGridCell(columnName: 'taskType', value: assignment.taskType),
        DataGridCell(columnName: 'students', value: assignment.students?.join(', ')),
      ]);
    }).toList();

    notifyListeners();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
