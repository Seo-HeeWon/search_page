import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> searchHistory = []; // 사용자가 입력한 검색 결과를 입력 받을 리스트
  List<String> searchAllHistory = []; // 사용자가 입력한 검색 결과를 입력 받을 리스트
  List<String> searchResults = []; // 사용자가 현재 입력한 검색 결과를 저장할 리스트
  int maxHistoryLength = 50; // 리스트에 저장할 검색 결과 갯수
  List<String> itemList = ['사과', '바나나', '망고', '고구마', '청사과'];


  @override
  void initState() {
    super.initState();
    loadingSearch();

    // for (var term in searchHistory) {
    //   print(term);
    // }
  }

  Future<void> loadingSearch() async {
    //SharedPreferences 선언
    final SharedPreferences pref = await SharedPreferences.getInstance();
    //SharedPreferences에서 검색 결과 불러오기
    searchHistory = pref.getStringList('searchHistory') ?? [];
    searchAllHistory = searchHistory;
    setState(() {});
  }

  void saveSearch(String item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //searchHistory 리스트에 값 저장
    searchHistory.add(item);
    // 검색 결과를 20개까지만 보관하기 위해 오래된 검색어 제거
    if (searchHistory.length > maxHistoryLength) {
      searchHistory.removeRange(0, searchHistory.length - maxHistoryLength);
    }
    // 검색 결과 SharedPreferences에 저장
    await prefs.setStringList('searchHistory', searchHistory);
    // 검색어 저장 후 검색 실행.
    search(item);

     for (var term in searchHistory) {
       print(term);
     }

    setState(() {});
  }

  // 검색 함수
  void search(String searchItem) {
    searchResults = itemList
        .where((element) => element.contains(searchItem))
        .toList();
    if (searchResults.isNotEmpty) {
      for (var result in searchResults) {
        print("검색 결과: $result");
      }
    } else {
      print("검색 결과가 없습니다.");
    }
    setState(() {});
  }

  void removeSearch(int index) async {
    final prefs = await SharedPreferences.getInstance();

    // index 위치의 항목을 제거
    searchHistory.remove(searchHistory[index]);

    // 변경된 검색 기록을 SharedPreferences에 저장
    await prefs.setStringList('searchHistory', searchHistory);

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
                  Container(
                    height: 100,
                    child: TextFormField(
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
                              saveSearch(controller.text);
                              // controller.clear();
                            }
                          },
                        ),
                      ),
                      onChanged: (value){
                        searchHistory = searchAllHistory
                            .where((element) => element.contains(value))
                            .toList();
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      //리스트 뷰에 출력되는 건 10개 까지
                      itemCount: math.min(searchHistory.length, 10),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: 100,
                          child: ListTile
                            (
                            title: Text(searchHistory[searchHistory.length - index - 1]),
                            trailing: IconButton(onPressed: () {removeSearch(searchHistory.length - index - 1);  }, icon: const Icon(Icons.dangerous),),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      //리스트 뷰에 출력되는 건 10개 까지
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile
                          (
                          title: Text(searchResults[searchResults.length - index - 1]),
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
