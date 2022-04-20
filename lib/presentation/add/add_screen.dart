import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lemon_tree/presentation/add/add_event.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/constants/data.dart';
import 'package:lemon_tree/presentation/constants/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'add_view_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final viewModel = context.read<AddViewModel>();

      _subscription = viewModel.uiEventStream.listen((event) {
        event.when(snackBar: (message) {
          final snackBar = SnackBar(
            content: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }, addSuccess: () {
          final snackBar = SnackBar(
            content: const Text(
              '추가되었습니다.',
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          Navigator.of(context).pop();
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _add() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddViewModel>();
    final state = viewModel.state;
    final woodCounts = state.countResponse?.woodCounts;

    return Scaffold(
      backgroundColor: mainGreen,
      appBar: AppBar(
        title: Text(
          '새로운 레몬 트리 추가',
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('나무 선택',
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 4),
                          woodCounts == null
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == null) {
                                      return '나무를 선택해주세요';
                                    }

                                    return null;
                                  },
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  isExpanded: true,
                                  dropdownColor: mainGreen,
                                  value: state.selectedWood,
                                  decoration: addFormDecoration,
                                  alignment: Alignment.center,
                                  items: woodCounts
                                      .map(
                                        (count) => DropdownMenuItem<String>(
                                          alignment: Alignment.center,
                                          value: count.keys.first,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${count.keys.first} x ${NumberFormat('###,###,###,###').format(count.values.first)}그루',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      viewModel
                                          .onEvent(AddEvent.woodSelect(val));
                                    }
                                  },
                                ),
                          const SizedBox(height: 8),

                          // ******************
                          // 테마 선택 드랍다운 버튼
                          // ******************
                          const Text('테마 선택',
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<int>(
                            validator: (value) {
                              if (value == null) {
                                return '테마를 선택해주세요';
                              }

                              return null;
                            },
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                            isExpanded: true,
                            dropdownColor: mainGreen,
                            decoration: addFormDecoration,
                            value: state.selectedTheme,
                            alignment: Alignment.center,
                            items: themeMap.keys
                                .map(
                                  (theme) => DropdownMenuItem<int>(
                                    alignment: Alignment.center,
                                    value: themeMap[theme],
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        theme,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                viewModel.onEvent(AddEvent.themeSelect(val));
                              }
                            },
                          ),
                          const SizedBox(height: 8),

                          // ******************
                          // 메모 텍스트 폼 필드
                          // ******************
                          const Text('메모',
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 4),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '메모를 입력해주세요';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              viewModel.onEvent(AddEvent.add(value!));
                            },
                            // expands: true,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(color: Colors.white),
                            decoration: addFormDecoration.copyWith(
                              hintText: '메모를 입력해주세요',
                              hintStyle: const TextStyle(color: Colors.white),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                            maxLines: null,
                            minLines: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ******************
                  // 추가하기 버튼
                  // ******************
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        maximumSize: Size(double.infinity, 64),
                        minimumSize: Size(double.infinity, 64),
                        primary: Colors.white,
                        // onSurface: Colors.grey,
                        onPrimary: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _add,
                      child: Text(
                        '추가하기',
                        style: TextStyle(fontSize: 18.sp, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state.isLoading)
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
