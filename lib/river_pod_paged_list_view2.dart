import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_project/river_pod_paged_list_view.dart';

class RiverPodPagedListView2 extends ConsumerWidget {
  const RiverPodPagedListView2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("List 입력 페이지")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: textEditingController, // TextField에 TextEditingController를 할당합니다.
              decoration: const InputDecoration(labelText: 'Enter text'),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  ref.read(textListProvider.notifier).addText(text);
                  textEditingController.clear(); // 텍스트가 제출된 후, 텍스트 필드를 지웁니다.
                }
              },
            ),
          ),
          // 추가 버튼 등 다른 UI 구성요소
        ],
      ),
    );
  }
}