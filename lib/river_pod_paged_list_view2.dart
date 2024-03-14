import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_project/river_pod_paged_list_view.dart';

class RiverPodPagedListView2 extends ConsumerWidget {
  const RiverPodPagedListView2({super.key});

  //ConsumerWidget 에는 WidgetRef ref 있어야 함.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("List 입력 페이지")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(labelText: 'Enter text'),
          onSubmitted: (text) {
            if (text.isNotEmpty) {
              ref.read(textListProvider.notifier).addText(text);
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}