import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_with_maestro/modules/tasks/controller/tasks_cubit.dart';
import 'package:testing_with_maestro/modules/tasks/model/task.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final TasksCubit cubit = TasksCubit();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: BlocBuilder<TasksCubit, List<Task>>(
        bloc: cubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Semantics(
                        identifier: "textfield",
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Semantics(
                      identifier: "add-btn",
                      child: ElevatedButton(
                        onPressed:
                            textController.text.isNotEmpty
                                ? () {
                                  cubit.addTask(
                                    description: textController.text,
                                  );
                                  textController.clear();
                                }
                                : null,
                        child: Text("+", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.state.length,
                  itemBuilder: (context, index) {
                    return Semantics(
                      identifier: "item$index",
                      child: GestureDetector(
                        onTap: () {
                          cubit.removeTask(index: index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withAlpha(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.state[index].description,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
