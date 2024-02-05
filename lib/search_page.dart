import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
              child: Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: textEditingController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 14.0, color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "검색어를 입력하세요.",
                          hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey)
                        ),
                      )),
                  const Expanded(flex: 2, child: Icon(Icons.search))
                ],
              ),
            )),
      ),
    );
  }
}
