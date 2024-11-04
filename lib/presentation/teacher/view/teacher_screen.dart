import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/loader/loading_indicator.dart';
import '../../../core/utils/utils/toast.dart';
import '../repositry/teacher_repo.dart';
import '../viewmodel/teacher_cubit.dart';
import '../viewmodel/teacher_state.dart';

class TeacherListScreen extends StatelessWidget {
  const TeacherListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocProvider(
        create: (_) => TeacherCubit(TeacherRepository())..fetchTeachers(),
        child: BlocBuilder<TeacherCubit, TeacherState>(
          builder: (context, state) {
            if (state.status == TeacherStateStatus.loading) {
              return  Center(child: loadingIndicator());
            } else if (state.status == TeacherStateStatus.loaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.teachers.length,
                itemBuilder: (context, index) {
                  final teacher = state.teachers[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow(context, 'Name:', teacher.name),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Email:', teacher.email),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Job ID:', teacher.jobId),
                          const SizedBox(height: 8),
                          _buildRow(context, 'User Type:', teacher.userType.toString().split('.').last),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state.status == TeacherStateStatus.error) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No teachers found.'));
            }
          },
        ),
      ),
    );
  }

  // Helper method to build a row with text and copy icon
  Widget _buildRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$label $value',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, color: Colors.blueGrey),
          onPressed: () => _copyToClipboard(context, value),
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    openToast(context, 'Copied to clipboard');
  }
}
