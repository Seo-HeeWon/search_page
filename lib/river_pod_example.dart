import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(this.ref) : super(0);

  final Ref ref;

  Future<void> increment() async {
    state++;
  }

  Future<void> decrement() async {
    state--;
  }
}

final counterStateProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier(ref);
});

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        child: Text(
          '$count',
          style: const TextStyle(fontSize: 32.0),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'incrementButton', // 고유한 heroTag 지정
            key: const Key('counterView_increment_floatingActionButton'),
            onPressed: () => ref.read(counterStateProvider.notifier).increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'decrementButton', // 다른 고유한 heroTag 지정
            key: const Key('counterView_decrement_floatingActionButton'),
            onPressed: () => ref.read(counterStateProvider.notifier).decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}