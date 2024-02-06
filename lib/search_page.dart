import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> searchHistory = [];
  List<String> searchResults = []; // 검색 결과를 저장할 리스트
  int maxHistoryLength = 10;
  List<String> staticList = ['apple', 'banana', 'cherry', 'date', 'elderberry'];


  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  void loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory = prefs.getStringList('searchHistory') ?? [];
    setState(() {});
  }

  void saveSearchTerm(String term) async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory.add(term);
    if (searchHistory.length > maxHistoryLength) {
      searchHistory.removeRange(0, searchHistory.length - maxHistoryLength);
    }
    await prefs.setStringList('searchHistory', searchHistory);
    search(term); // 검색어 저장 후 검색 실행

    setState(() {});
  }

  void search(String searchTerm) {
    searchResults = staticList
        .where((element) => element.contains(searchTerm))
        .toList();
    if (searchResults.isNotEmpty) {
      // 검색 결과가 있으면 콘솔에 출력
      print('검색 결과:');
      for (var result in searchResults) {
        print(result);
      }
    } else {
      print('검색 결과가 없습니다.');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
              child: Column(
                children: [
                  TextFormField(
                    focusNode: focusNode,
                    controller: controller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "검색어를 입력하세요.",
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            saveSearchTerm(controller.text);
                            controller.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchHistory[searchHistory.length - index - 1]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
