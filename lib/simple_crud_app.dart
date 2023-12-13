import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_state/simple_crud_controller.dart';

class SimpleCrudApp extends StatefulWidget {
  const SimpleCrudApp({super.key});

  @override
  State<SimpleCrudApp> createState() => _SimpleCrudAppState();
}

class _SimpleCrudAppState extends State<SimpleCrudApp> {
  final simpleCrudController = Get.put(SimpleCrudController());
  addView() {
    final editInput = TextEditingController();
    DInfo.customDialog(
      context: context,
      content: Column(
        children: [
          DInput(
            controller: editInput,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                simpleCrudController.add(editInput.text);
                Navigator.pop(context);
                DInfo.toastSuccess('Success Add Data');
              },
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }

  updateView(String oldData, int index) {
    final editInput = TextEditingController();
    editInput.text = oldData;
    DInfo.customDialog(
      context: context,
      content: Column(
        children: [
          DInput(controller: editInput),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                simpleCrudController.updateItem(index, editInput.text);
                Navigator.pop(context);
                DInfo.toastSuccess('Success Update Data');
              },
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }

  deleteView(String oldData, int index) {
    DInfo.dialogConfirmation(
      context,
      'Delete',
      'Are you sure want to delete $oldData?',
    ).then((value) {
      if (value ?? false) {
        simpleCrudController.delete(index);
      }
    });
  }

  @override
  void dispose() {
    simpleCrudController.clearState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List listItem = ['Japan', 'Mecca', 'Swiss'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple CRUD App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addView();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GetX(
          init: SimpleCrudController(),
          builder: (controller) {
            List<String> listItem = controller.list;
            if (listItem.isEmpty) {
              return const Center(child: Text('No Data'));
            }
            return ListView.builder(
              itemCount: listItem.length,
              itemBuilder: (context, index) {
                String item = listItem[index];
                return ListTile(
                  leading: IconButton.filled(
                    onPressed: () => updateView(item, index),
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  ),
                  title: Text(item),
                  trailing: IconButton.filled(
                    onPressed: () => deleteView(item, index),
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                  ),
                );
              },
            );
          }),
    );
  }
}
