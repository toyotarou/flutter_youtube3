import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/bunrui/bunrui.dart';

import '../controllers/category/category.dart';
import '../extensions/extensions.dart';
import '../models/category.dart';

class BunruiScreen extends ConsumerStatefulWidget {
  const BunruiScreen({super.key});

  @override
  ConsumerState<BunruiScreen> createState() => _BunruiScreenState();
}

class _BunruiScreenState extends ConsumerState<BunruiScreen> {
  ///
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final List<String> category1List = <String>[];
    for (final CategoryModel element in categoryList) {
      if (!category1List.contains(element.category1)) {
        category1List.add(element.category1);
      }
    }

    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    return Scaffold(
      appBar: AppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: category1List.map((String e) {
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(categoryProvider.notifier)
                                    .setSelectedCategory1(category1: e);
                              },
                              child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: (selectedCategory1 == e)
                                        ? Colors.yellowAccent.withOpacity(0.2)
                                        : Colors.greenAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(e)),
                            );
                          }).toList()),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: displayCategory2Widget(),
                  ),
                  SizedBox(
                    height: context.screenSize.height * 0.8,
                    child: Column(
                      children: <Widget>[
                        Expanded(child: displayLeftList()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.greenAccent.withOpacity(0.4),
                      width: 3,
                    ),
                  ),
                ),
                height: context.screenSize.height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: displayRightList()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  Widget displayLeftList() {
    final List<Widget> list = <Widget>[];

    final List<List<String>> bunruiList = ref
        .watch(bunruiProvider.select((BunruiState value) => value.bunruiList));

    for (int i = 0; i < 10; i++) {
      list.add(Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        height: 100,
        child: DragTarget<String>(
          // ignore: unnecessary_null_comparison
          onWillAcceptWithDetails: (DragTargetDetails<String> data) =>
              // ignore: unnecessary_null_comparison
              null != data,
          // ignore: deprecated_member_use
          onAccept: (String data) {
            setState(() {
              ref
                  .read(bunruiProvider.notifier)
                  .setBunruiList(parentNumber: i, text: data);
            });
          },

          builder: (BuildContext context, List<String?> candidateData,
              List<dynamic> rejectedData) {
            return SingleChildScrollView(
              child: Wrap(
                children: bunruiList[i].map((String e) {
                  if (e != '') {
                    return Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Text(e));
                  } else {
                    return Container();
                  }
                }).toList(),
              ),
            );
          },
        ),
      ));
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Widget buildDraggable({required String text}) {
    // ignore: always_specify_types
    return Draggable(
      data: text,
      feedback: Container(
        width: 50,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 50,
        color: Colors.blueAccent.withOpacity(0.5),
        child: const Scaffold(body: Text('F')),
      ),
      childWhenDragging: Container(
        width: 110,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 50,
        color: Colors.white.withOpacity(0.1),
        child: Text(
          'now dragging',
          style: TextStyle(color: Colors.white.withOpacity(0.6)),
        ),
      ),
      child: Container(
        width: 110,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Text(text.padLeft(2, '0')),
      ),
    );
  }

  ///
  Widget displayRightList() {
    final List<Widget> list = <Widget>[];

    final List<String> jogaiItemList = <String>[];

    ref
        .watch(bunruiProvider.select((BunruiState value) => value.bunruiList))
        .forEach((List<String> element) {
      for (int i = 0; i < element.length; i++) {
        final String element2 = element[i];
        jogaiItemList.add(element2);
      }
    });

    for (int i = 0; i < 100; i++) {
      final String item = 'child_$i';

      if (!jogaiItemList.contains(item)) {
        list.add(buildDraggable(text: item));
      }
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ),
    );
  }

  ///
  Widget displayCategory2Widget() {
    final List<Widget> list = <Widget>[];

    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    if (selectedCategory1 == '') {
      return Align(
        child: Text(
          'select category 1',
          style: TextStyle(color: Colors.white.withOpacity(0.4)),
        ),
      );
    }

    final String selectedCategory2 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    final List<String> category2List = <String>[];
    for (final CategoryModel element in categoryList) {
      if (element.category1 == selectedCategory1) {
        if (!category2List.contains(element.category2)) {
          category2List.add(element.category2);
        }
      }
    }

    for (final String element in category2List) {
      list.add(GestureDetector(
        onTap: () {
          ref
              .read(categoryProvider.notifier)
              .setSelectedCategory2(category2: element);
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: (selectedCategory2 == element)
                ? Colors.yellowAccent.withOpacity(0.2)
                : Colors.greenAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(element),
        ),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }
}
