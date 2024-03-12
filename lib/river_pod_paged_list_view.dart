import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:search_project/term.dart';

final textListProvider = StateNotifierProvider<TextListNotifier, List<String>>((ref) => TextListNotifier());
class TextListNotifier extends StateNotifier<List<String>> {
  TextListNotifier() : super([]);

  void addText(String text) {
    state = [...state, text];
  }
}

class RiverPodPagedListView extends ConsumerStatefulWidget {
  const RiverPodPagedListView({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverPodPagedListView> createState() => _RiverPodPagedListViewState();
}

class _RiverPodPagedListViewState extends ConsumerState<RiverPodPagedListView> {
  final PagingController<int, Term> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _loadPage(pageKey);
    });
  }

  void _loadPage(int pageKey) {
    final textList = ref.read(textListProvider);
    final newItems = List.generate(
      textList.length,
          (index) => Term(textList[index]),
    );

    _pagingController.itemList = newItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("List 출력 페이지")),
        body: PagedListView<int, Term>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Term>(
            newPageProgressIndicatorBuilder: (context) => Container(),
            firstPageProgressIndicatorBuilder: (context) =>
                const Center(child: Text("내용이 없습니다.")),
            noItemsFoundIndicatorBuilder: (context) =>
                const Center(child: Text("내용이 없습니다.")),
            itemBuilder: (context, item, index) => ListTile(title: Text(item.title)),
          ),
        ),
      );
  }
}
