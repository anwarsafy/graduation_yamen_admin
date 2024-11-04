import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/core/loader/loading_indicator.dart';
import 'package:graduation_yamen_afmin/core/widgets/custom_image_view.dart';
import '../../../core/utils/utils/toast.dart';
import '../repositry/parent_repo.dart';
import '../viewmodel/parent_cubit.dart';
import '../viewmodel/parent_state.dart';

class ParentListScreen extends StatelessWidget {
  const ParentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parents'),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocProvider(
        create: (_) => ParentCubit(ParentRepository())..fetchParents(),
        child: BlocBuilder<ParentCubit, ParentState>(
          builder: (context, state) {
            if (state.status == ParentStateStatus.loading) {
              return  Center(child: loadingIndicator());
            } else if (state.status == ParentStateStatus.loaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.parents.length,
                itemBuilder: (context, index) {
                  final parent = state.parents[index];
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
                          _buildRow(context, 'Name:', parent.name),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Email:', parent.email),
                          const SizedBox(height: 8),
                          _buildRow(context, 'National ID:', parent.nationalId),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Relation:', parent.relationWithStudent),
                          const SizedBox(height: 8),
                          _buildRow(context, 'Parent of Student :', parent.studentIds.join(', ')),
                          CustomImageView(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: CachedNetworkImage(
                                    imageUrl: parent.nationalIdImageUrl,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              );
                            },
                            imagePath: parent.nationalIdImageUrl,
                            width: 100,
                            height: 100,

                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state.status == ParentStateStatus.error) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No parents found.'));
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
