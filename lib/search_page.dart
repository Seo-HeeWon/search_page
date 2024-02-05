import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> _searchHistory = [];
  final int _maxHistoryLength = 10;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('searchHistory') ?? [];
    setState(() {});
  }

  _saveSearchTerm(String term) async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory.add(term);
    if (_searchHistory.length > _maxHistoryLength) {
      _searchHistory.removeRange(0, _searchHistory.length - _maxHistoryLength);
    }
    await prefs.setStringList('searchHistory', _searchHistory);
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
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "검색어를 입력하세요.",
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            _saveSearchTerm(_controller.text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchHistory[_searchHistory.length - index - 1]),
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
