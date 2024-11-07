import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../cubit/attendance_cubit.dart';
import '../cubit/attendance_state.dart';
import '../model/attendance_model.dart';

class SimplifiedAttendanceListScreen extends StatefulWidget {
  const SimplifiedAttendanceListScreen({super.key});

  @override
  _SimplifiedAttendanceListScreenState createState() => _SimplifiedAttendanceListScreenState();
}

class _SimplifiedAttendanceListScreenState extends State<SimplifiedAttendanceListScreen> {
  late SimplifiedAttendanceDataGridSource _attendanceDataGridSource;

  @override
  void initState() {
    super.initState();
    _attendanceDataGridSource = SimplifiedAttendanceDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SimplifiedAttendanceCubit()..loadAllAttendanceData(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Records'),
          ),
          body: BlocBuilder<SimplifiedAttendanceCubit, SimplifiedAttendanceState>(
            builder: (context, state) {
              if (state.status == AttendanceStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == AttendanceStatus.error) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              final dataToDisplay = state.attendanceData;

              if (dataToDisplay == null || dataToDisplay.isEmpty) {
                return const Center(child: Text("No data available."));
              }

              _attendanceDataGridSource.updateDataSource(dataToDisplay);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDataGrid(
                  allowSorting: true,
                  allowFiltering: true,
                  verticalScrollPhysics: const BouncingScrollPhysics(),
                  showCheckboxColumn: false,
                  allowColumnsResizing: true,
                  allowEditing: false,
                  allowExpandCollapseGroup: true,
                  allowMultiColumnSorting: true,
                  allowTriStateSorting: true,
                  allowSwiping: true,
                  allowPullToRefresh: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  autoExpandGroups: true,
                  defaultColumnWidth: 150,
                  editingGestureType: EditingGestureType.doubleTap,
                  isScrollbarAlwaysShown: true,
                  selectionMode: SelectionMode.single,
                  showColumnHeaderIconOnHover: true,
                  showHorizontalScrollbar: true,
                  showSortNumbers: true,
                  showVerticalScrollbar: true,
                  shrinkWrapColumns: false,
                  shrinkWrapRows: false,
                  sortingGestureType: SortingGestureType.tap,
                  swipeMaxOffset: 200,
                  groupCaptionTitleFormat:
                  'Grouping by: {name} - {value} items',
                  headerRowHeight: 56,
                  highlightRowOnHover: true,
                  horizontalScrollController: ScrollController(),
                  horizontalScrollPhysics: const BouncingScrollPhysics(),
                  columnSizer: ColumnSizer(),
                  verticalScrollController: ScrollController(),
                  navigationMode: GridNavigationMode.cell,
                  allowColumnsDragging: true,
                  source: _attendanceDataGridSource,
                  columns: _obtainColumns(),

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
          columnName: 'attendanceTime',
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Attendance Time',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'email',
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Email',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'macAddress',
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'MAC Address',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'qrID',
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'QR ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'userId',
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'User ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
    ];
  }
}

class SimplifiedAttendanceDataGridSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void updateDataSource(List<AttendanceModel> attendanceData) {
    _dataGridRows = attendanceData.map<DataGridRow>((attendance) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'attendanceTime', value: attendance.attendanceTime),
        DataGridCell(columnName: 'email', value: attendance.email),
        DataGridCell(columnName: 'macAddress', value: attendance.macAddress),
        DataGridCell(columnName: 'qrID', value: attendance.qrID),
        DataGridCell(columnName: 'userId', value: attendance.userId),
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
