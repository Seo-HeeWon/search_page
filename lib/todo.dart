// import 'package:flutter/foundation.dart' show immutable;
// import 'package:riverpod/riverpod.dart';
// import 'package:uuid/uuid.dart';
//
// const _uuid = Uuid();
//
// /// 할 일 항목의 읽기 전용 설명
// @immutable
// class Todo {
//   const Todo({
//     required this.description,
//     required this.id,
//     this.completed = false,
//   });
//
//   final String id;
//   final String description;
//   final bool completed;
//
//   @override
//   String toString() {
//     return 'Todo(description: $description, completed: $completed)';
//   }
// }
//
// /// [Todo] 리스트를 제어하는 객체입니다.
// class TodoList extends Notifier<List<Todo>> {
//   @override
//   List<Todo> build() => [
//     const Todo(id: 'todo-0', description: 'Buy cookies'),
//     const Todo(id: 'todo-1', description: 'Star Riverpod'),
//     const Todo(id: 'todo-2', description: 'Have a walk'),
//   ];
//
//   void add(String description) {
//     state = [
//       ...state,
//       Todo(
//         id: _uuid.v4(),
//         description: description,
//       ),
//     ];
//   }
//
//   void toggle(String id) {
//     state = [
//       for (final todo in state)
//         if (todo.id == id)
//           Todo(
//             id: todo.id,
//             completed: !todo.completed,
//             description: todo.description,
//           )
//         else
//           todo,
//     ];
//   }
//
//   void edit({required String id, required String description}) {
//     state = [
//       for (final todo in state)
//         if (todo.id == id)
//           Todo(
//             id: todo.id,
//             completed: todo.completed,
//             description: description,
//           )
//         else
//           todo,
//     ];
//   }
//
//   void remove(Todo target) {
//     state = state.where((todo) => todo.id != target.id).toList();
//   }
// }