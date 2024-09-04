import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_and_api_handeling_process/providers/counter_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterProvider =
        StateNotifierProvider<Counter, int>((ref) => Counter());
    return Scaffold(
        appBar: AppBar(
          title: Text("My Home Screen"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "This is Counter",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final counter = ref.watch(counterProvider);
                  return Text(
                    counter.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                ref.read(counterProvider.notifier).decrement();
              },
              backgroundColor: Color.fromARGB(255, 43, 15, 46),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 38,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
              },
              backgroundColor: const Color.fromARGB(255, 18, 51, 79),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 38,
              ),
            ),
          ],
        ));
  }
}
