import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_with_maestro/modules/tasks/model/task.dart';

class TasksCubit extends Cubit<List<Task>> {
  TasksCubit() : super([]);

  void addTask({required String description}) =>
      emit([...state, Task(description: description)]);

  void removeTask({required int index}) {
    List<Task> newList = [...state];
    newList.removeAt(index);

    emit(newList);
  }
}
