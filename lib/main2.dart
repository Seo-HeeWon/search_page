// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import 'todo.dart';
//
// /// 테스트에 사용되는 몇 가지 키
// final addTodoKey = UniqueKey();
// final activeFilterKey = UniqueKey();
// final completedFilterKey = UniqueKey();
// final allFilterKey = UniqueKey();
//
// /// [TodoList]를 생성하고 사전 정의된 값으로 초기화합니다.
// ///
// /// 여기서는 `List<Todo>`가 복잡한 객체이며, 할 일을 편집하는 방법과 같은 고급 비즈니스 로직을 가지고 있기 때문에
// /// [StateNotifierProvider]를 사용합니다.
// final todoListProvider = NotifierProvider<TodoList, List<Todo>>(TodoList.new);
//
// /// 할 일 목록을 필터링하는 다양한 방법
// enum TodoListFilter {
//   all,
//   active,
//   completed,
// }
//
// /// 현재 활성화된 필터.
// ///
// /// 값의 조작 뒤에 복잡한 로직이 없기 때문에 여기서는 [StateProvider]를 사용합니다.
// /// 단순히 열거형입니다.
// final todoListFilter = StateProvider((_) => TodoListFilter.all);
//
// /// 완료되지 않은 할 일의 수
// ///
// /// [Provider]를 사용함으로써, 이 값은 캐시되어 성능이 향상됩니다.
// /// 여러 위젯이 완료되지 않은 할 일의 수를 읽더라도, 할 일 목록이 변경될 때까지 값은 한 번만 계산됩니다.
// ///
// /// 할 일 목록이 변경되어도 완료되지 않은 할 일의 수가 변경되지 않는 경우(예: 할 일을 편집하는 경우)에는
// /// 불필요한 리빌드를 최적화합니다.
// final uncompletedTodosCount = Provider<int>((ref) {
//   return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
// });
//
// /// [todoListFilter]를 적용한 후의 할 일 목록.
// ///
// /// 이 역시 [Provider]를 사용하여, 필터 또는 할 일 목록이 업데이트될 때만
// /// 필터링된 목록을 다시 계산하지 않도록 합니다.
// final filteredTodos = Provider<List<Todo>>((ref) {
//   final filter = ref.watch(todoListFilter);
//   final todos = ref.watch(todoListProvider);
//
//   switch (filter) {
//     case TodoListFilter.completed:
//       return todos.where((todo) => todo.completed).toList();
//     case TodoListFilter.active:
//       return todos.where((todo) => !todo.completed).toList();
//     case TodoListFilter.all:
//       return todos;
//   }
// });
//
// void main() {
//   runApp(const ProviderScope(
//       child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Home(),
//     );
//   }
// }
//
// class Home extends HookConsumerWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final todos = ref.watch(filteredTodos);
//     final newTodoController = useTextEditingController();
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//           children: [
//             const Title(),
//             TextField(
//               key: addTodoKey,
//               controller: newTodoController,
//               decoration: const InputDecoration(
//                 labelText: 'What needs to be done?',
//               ),
//               onSubmitted: (value) {
//                 ref.read(todoListProvider.notifier).add(value);
//                 newTodoController.clear();
//               },
//             ),
//             const SizedBox(height: 42),
//             const Toolbar(),
//             if (todos.isNotEmpty) const Divider(height: 0),
//             for (var i = 0; i < todos.length; i++) ...[
//               if (i > 0) const Divider(height: 0),
//               Dismissible(
//                 key: ValueKey(todos[i].id),
//                 onDismissed: (_) {
//                   ref.read(todoListProvider.notifier).remove(todos[i]);
//                 },
//                 child: ProviderScope(
//                   overrides: [
//                     _currentTodo.overrideWithValue(todos[i]),
//                   ],
//                   child: const TodoItem(),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Toolbar extends HookConsumerWidget {
//   const Toolbar({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final filter = ref.watch(todoListFilter);
//
//     Color? textColorFor(TodoListFilter value) {
//       return filter == value ? Colors.blue : Colors.black;
//     }
//
//     return Material(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               '${ref.watch(uncompletedTodosCount)} items left',
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           Tooltip(
//             key: allFilterKey,
//             message: 'All todos',
//             child: TextButton(
//               onPressed: () =>
//               ref.read(todoListFilter.notifier).state = TodoListFilter.all,
//               style: ButtonStyle(
//                 visualDensity: VisualDensity.compact,
//                 foregroundColor:
//                 MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
//               ),
//               child: const Text('All'),
//             ),
//           ),
//           Tooltip(
//             key: activeFilterKey,
//             message: 'Only uncompleted todos',
//             child: TextButton(
//               onPressed: () => ref.read(todoListFilter.notifier).state =
//                   TodoListFilter.active,
//               style: ButtonStyle(
//                 visualDensity: VisualDensity.compact,
//                 foregroundColor: MaterialStateProperty.all(
//                   textColorFor(TodoListFilter.active),
//                 ),
//               ),
//               child: const Text('Active'),
//             ),
//           ),
//           Tooltip(
//             key: completedFilterKey,
//             message: 'Only completed todos',
//             child: TextButton(
//               onPressed: () => ref.read(todoListFilter.notifier).state =
//                   TodoListFilter.completed,
//               style: ButtonStyle(
//                 visualDensity: VisualDensity.compact,
//                 foregroundColor: MaterialStateProperty.all(
//                   textColorFor(TodoListFilter.completed),
//                 ),
//               ),
//               child: const Text('Completed'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Title extends StatelessWidget {
//   const Title({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       'todos',
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         color: Color.fromARGB(38, 47, 47, 247),
//         fontSize: 100,
//         fontWeight: FontWeight.w100,
//         fontFamily: 'Helvetica Neue',
//       ),
//     );
//   }
// }
//
// /// [TodoItem]에 표시되는 [Todo]를 노출하는 프로바이더입니다.
// ///
// /// [Todo]를 생성자를 통해 전달하는 대신 프로바이더를 통해 검색함으로써, [TodoItem]을 `const` 키워드를 사용하여 인스턴스화할 수 있습니다.
// ///
// /// 이를 통해 할 일을 추가/제거/편집할 때 영향을 받는 위젯만 리빌드되고, 전체 항목 목록이 리빌드되는 것을 방지할 수 있습니다.
// final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());
//
// /// 개별 할 일 항목의 구성요소를 표시하는 위젯입니다.
// class TodoItem extends HookConsumerWidget {
//   const TodoItem({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final todo = ref.watch(_currentTodo);
//     final itemFocusNode = useFocusNode();
//     final itemIsFocused = useIsFocused(itemFocusNode);
//
//     final textEditingController = useTextEditingController();
//     final textFieldFocusNode = useFocusNode();
//
//     return Material(
//       color: Colors.white,
//       elevation: 6,
//       child: Focus(
//         focusNode: itemFocusNode,
//         onFocusChange: (focused) {
//           if (focused) {
//             textEditingController.text = todo.description;
//           } else {
//             // Commit changes only when the textfield is unfocused, for performance
//             ref
//                 .read(todoListProvider.notifier)
//                 .edit(id: todo.id, description: textEditingController.text);
//           }
//         },
//         child: ListTile(
//           onTap: () {
//             itemFocusNode.requestFocus();
//             textFieldFocusNode.requestFocus();
//           },
//           leading: Checkbox(
//             value: todo.completed,
//             onChanged: (value) =>
//                 ref.read(todoListProvider.notifier).toggle(todo.id),
//           ),
//           title: itemIsFocused
//               ? TextField(
//             autofocus: true,
//             focusNode: textFieldFocusNode,
//             controller: textEditingController,
//           )
//               : Text(todo.description),
//         ),
//       ),
//     );
//   }
// }
//
// bool useIsFocused(FocusNode node) {
//   final isFocused = useState(node.hasFocus);
//
//   useEffect(
//         () {
//       void listener() {
//         isFocused.value = node.hasFocus;
//       }
//
//       node.addListener(listener);
//       return () => node.removeListener(listener);
//     },
//     [node],
//   );
//
//   return isFocused.value;
// }
