import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/core/loader/loading_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/notes_model.dart';
import '../viewmodel/notes_cubit.dart';
import '../viewmodel/notes_state.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late NoteDataGridSource _noteDataGridSource;

  @override
  void initState() {
    super.initState();
    _noteDataGridSource = NoteDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit()..loadAllNotesData(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
          ),
          body: BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              if (state.status == NoteStatus.loading) {
                return  Center(child: loadingIndicator());
              } else if (state.status == NoteStatus.error) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              final dataToDisplay = state.notesData;

              if (dataToDisplay == null || dataToDisplay.isEmpty) {
                return const Center(child: Text("No data available."));
              }

              _noteDataGridSource.updateDataSource(dataToDisplay);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDataGrid(
                  source: _noteDataGridSource,
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
        columnName: 'assignedTo',
        label: const Center(child: Text('Assigned To')),
      ),
      GridColumn(
        columnName: 'authorId',
        label: const Center(child: Text('Author ID')),
      ),
      GridColumn(
        columnName: 'authorName',
        label: const Center(child: Text('Author Name')),
      ),
      GridColumn(
        columnName: 'content',
        label: const Center(child: Text('Content')),
      ),
    ];
  }
}

class NoteDataGridSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void updateDataSource(List<NoteModel> notesData) {
    _dataGridRows = notesData.map<DataGridRow>((note) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'assignedTo', value: note.assignedTo),
        DataGridCell(columnName: 'authorId', value: note.authorId),
        DataGridCell(columnName: 'authorName', value: note.authorName),
        DataGridCell(columnName: 'content', value: note.content),
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
