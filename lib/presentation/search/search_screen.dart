import 'package:flutter/material.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/search/search_event.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    final state = viewModel.state;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainGreen,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              // TODO:
              // 검색 화면
              // 검색 기능 구현
            },
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.onEvent(const SearchEvent.load());
              },
              child: ListView(
                children: [
                  Center(
                      child: Text(
                    '다른 사람들의 레몬트리를 찾아보세요',
                    style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: Card(
                        color: Colors.white.withOpacity(0.6),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '나무',
                                    style: TextStyle(
                                        fontSize: 20.sp, color: darkGreen),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('더 보기'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: Card(
                        color: Colors.white.withOpacity(0.6),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '테마',
                                    style: TextStyle(
                                        fontSize: 20.sp, color: darkGreen),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('더 보기'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: Card(
                        color: Colors.white.withOpacity(0.6),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '지역',
                                    style: TextStyle(
                                        fontSize: 20.sp, color: darkGreen),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('더 보기'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 로딩 시 로딩 바
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
