import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final counterProvider2 = StateNotifierProvider<Counter, int>((ref) => Counter());
// 사용자 입력을 관리할 새로운 StateNotifierProvider
final textProvider = StateNotifierProvider<TextStateNotifier, String>((ref) => TextStateNotifier());

class RiverPodWatch extends ConsumerWidget {
  const RiverPodWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final counter2 = ref.watch(counterProvider2);
    // 사용자 입력값을 구독
    final userInput = ref.watch(textProvider);

    TextEditingController textEditingController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Riverpod Study")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter 1: $counter'),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state++;
                },
                child: const Text("버튼 1"),
              ),
              const SizedBox(height: 20),
              Text('Counter 2: $counter2'),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterProvider2.notifier).increment();
                },
                child: const Text("버튼 2"),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  ref.read(textProvider.notifier).setText(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                },
                child: const Text("확인"),
              ),
              const SizedBox(height: 20),
              Text(userInput),

            ],
          ),
        ),
      ),
    );
  }
}

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}

// 사용자 입력을 관리할 StateNotifier
class TextStateNotifier extends StateNotifier<String> {
  TextStateNotifier() : super('');
  void setText(String newText) => state = newText;
}