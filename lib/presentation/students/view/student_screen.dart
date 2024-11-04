import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/loader/loading_indicator.dart';
import '../../../core/utils/utils/toast.dart';
import '../repositry/stuent_repo.dart';
import '../viewmodel/student_cubit.dart';
import '../viewmodel/student_state.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocProvider(
        create: (_) => UserCubit(UserRepository())..fetchStudents(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state.status == UserStateStatus.loading) {
              return  Center(child: loadingIndicator());
            } else if (state.status == UserStateStatus.loaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
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
                          _buildRow(context, 'Name:', user.name),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Email:', user.email),
                          const SizedBox(height: 8),
                          _buildRow(context, 'National ID:', user.nationalId),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Student ID:', user.studentId),
                          const SizedBox(height: 8),
                          _buildRow(context, 'User Type:', user.userType.toString().split('.').last),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state.status == UserStateStatus.error) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No students found.'));
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
    openToast(context,'Copied to clipboard');

  }
}
