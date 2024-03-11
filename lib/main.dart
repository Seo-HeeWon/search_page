import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:search_project/river_pod_example.dart';
import 'package:search_project/search_page.dart'; // 이 경로가 실제 SearchPage 위젯의 위치와 일치하는지 확인하세요.

void main() {
  runApp(
    // ProviderScope를 추가하여 Riverpod의 상태 관리 범위를 앱 전체에 제공합니다.
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Button Demo'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 버튼을 중앙에 위치시키기 위해 추가
              children: [
                ElevatedButton(
                  onPressed: () => Get.to(() => const SearchPage()),
                  child: const Text("Search"),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const CounterScreen()),
                  child: const Text("riverPod"),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const CounterScreen()),
                  child: const Text("ref.watch"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}