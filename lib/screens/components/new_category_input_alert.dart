import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/category/category.dart';
import '../../extensions/extensions.dart';
import 'parts/error_dialog.dart';

class NewCategoryInputAlert extends ConsumerStatefulWidget {
  const NewCategoryInputAlert({super.key, required this.flag});

  final String flag;

  @override
  ConsumerState<NewCategoryInputAlert> createState() =>
      _NewCategoryInputAlertState();
}

class _NewCategoryInputAlertState extends ConsumerState<NewCategoryInputAlert> {
  TextEditingController category1EditingController = TextEditingController();
  TextEditingController category2EditingController = TextEditingController();
  TextEditingController bunruiEditingController = TextEditingController();

  ///
  @override
  void initState() {
    super.initState();

    final String selectedCategory1 = ref.read(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    final String selectedCategory2 = ref.read(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    if (selectedCategory1 != '' && widget.flag == 'category2') {
      category1EditingController.text = selectedCategory1;
    }

    if (selectedCategory1 != '' &&
        selectedCategory2 != '' &&
        widget.flag == 'bunrui') {
      category1EditingController.text = selectedCategory1;
      category2EditingController.text = selectedCategory2;
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),
            const Text('New Category'),
            Divider(
              color: Colors.white.withOpacity(0.5),
              thickness: 5,
            ),
            TextField(
              // ignore: avoid_bool_literals_in_conditional_expressions
              enabled: (widget.flag == 'category2' || widget.flag == 'bunrui')
                  ? false
                  : true,
              controller: category1EditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                hintText: 'category1',
                filled: true,
                fillColor:
                    (widget.flag == 'category2' || widget.flag == 'bunrui')
                        ? Colors.white12
                        : Colors.black26,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)),
              ),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              onTapOutside: (PointerDownEvent event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const SizedBox(height: 10),
            TextField(
              // ignore: avoid_bool_literals_in_conditional_expressions
              enabled: (widget.flag == 'bunrui') ? false : true,
              controller: category2EditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                hintText: 'category2',
                filled: true,
                fillColor:
                    (widget.flag == 'bunrui') ? Colors.white12 : Colors.black26,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)),
              ),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              onTapOutside: (PointerDownEvent event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bunruiEditingController,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                hintText: 'bunrui',
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)),
              ),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              onTapOutside: (PointerDownEvent event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (category1EditingController.text.trim() == '' ||
                    category2EditingController.text.trim() == '' ||
                    bunruiEditingController.text.trim() == '') {
                  // ignore: always_specify_types
                  Future.delayed(
                    Duration.zero,
                    () => error_dialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        title: '登録できません。',
                        content: '値を正しく入力してください。'),
                  );

                  return;
                }

                ref.read(categoryProvider.notifier).setAdditionalCategoryList(
                      category1: category1EditingController.text.trim(),
                      category2: category2EditingController.text.trim(),
                      bunrui: bunruiEditingController.text.trim(),
                    );

                Navigator.pop(context);
              },
              child: const Text('input'),
            ),
          ],
        ),
      ),
    );
  }
}
