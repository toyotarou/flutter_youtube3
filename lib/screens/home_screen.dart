import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/bunrui/bunrui.dart';
import '../controllers/category/category.dart';
import 'bunrui_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                ref.read(categoryProvider.notifier).getCategory();

                ref
                    .read(categoryProvider.notifier)
                    .setSelectedCategory1(category1: '');
                ref
                    .read(categoryProvider.notifier)
                    .setSelectedCategory2(category2: '');

                ref.read(bunruiProvider.notifier).clearBunruiList();

                Navigator.push(
                  context,
                  // ignore: inference_failure_on_instance_creation, always_specify_types
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BunruiScreen(),
                  ),
                );
              },
              child: const Text('bunrui'),
            ),
          ],
        ),
      ),
    );
  }
}
