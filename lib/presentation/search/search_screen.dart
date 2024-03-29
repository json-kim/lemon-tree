import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lemon_tree/domain/model/memory.dart';
import 'package:lemon_tree/domain/usecase/memory/load_memory_with_tree_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_tile_use_case.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/constants/ui_constants.dart';
import 'package:lemon_tree/presentation/detail/detail_screen.dart';
import 'package:lemon_tree/presentation/detail/detail_view_model.dart';
import 'package:lemon_tree/presentation/map/map_screen.dart';
import 'package:lemon_tree/presentation/map/map_view_model.dart';
import 'package:lemon_tree/presentation/search/search_event.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/data.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  expandedHeight: 150,
                  collapsedHeight: 150,
                  flexibleSpace: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                '다른 사람들의 레몬트리를 찾아보세요',
                                style: defStyle.copyWith(fontSize: 22.sp),
                                textAlign: TextAlign.center,
                              )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            /**
                             * 테마 셀렉트 버튼
                             */
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: DropdownButton<int>(
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                      isExpanded: true,
                                      dropdownColor: mainGreen,
                                      borderRadius: BorderRadius.circular(8),
                                      underline: Container(),
                                      value: state.selectedTheme,
                                      alignment: Alignment.center,
                                      items: [
                                        DropdownMenuItem<int>(
                                          alignment: Alignment.center,
                                          value: null,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '테마',
                                              style: defStyle,
                                            ),
                                          ),
                                        ),
                                        ...themeMap.keys
                                            .map(
                                              (theme) => DropdownMenuItem<int>(
                                                alignment: Alignment.center,
                                                value: themeMap[theme],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    theme,
                                                    style: defStyle,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList()
                                      ],
                                      onChanged: (val) {
                                        viewModel.onEvent(
                                            SearchEvent.themeSelect(val));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            /**
                             * 나무 셀렉트 버튼
                             */
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButton<String>(
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                      isExpanded: true,
                                      dropdownColor: mainGreen,
                                      borderRadius: BorderRadius.circular(8),
                                      underline: Container(),
                                      value: state.selectedWood,
                                      alignment: Alignment.center,
                                      items: [
                                        DropdownMenuItem<String>(
                                          alignment: Alignment.center,
                                          value: null,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '나무',
                                              style: defStyle,
                                            ),
                                          ),
                                        ),
                                        ...woodData
                                            .map(
                                              (wood) =>
                                                  DropdownMenuItem<String>(
                                                alignment: Alignment.center,
                                                value: wood,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    wood,
                                                    style: defStyle,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList()
                                      ],
                                      onChanged: (val) {
                                        viewModel.onEvent(
                                            SearchEvent.woodSelect(val));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    viewModel.memoryPagingController.refresh();
                  },
                ),

                /**
                 * 레몬트리 리스트 박스
                 */
                PagedSliverList(
                  pagingController: viewModel.memoryPagingController,
                  builderDelegate: PagedChildBuilderDelegate<Memory>(
                    noItemsFoundIndicatorBuilder: (context) => Column(
                      children: const [
                        Text(
                          '등록된 레몬트리가 없습니다.',
                          style: defStyle,
                        ),
                      ],
                    ),
                    firstPageErrorIndicatorBuilder: (context) =>
                        const Center(child: Text('가져오기 실패', style: defStyle)),
                    newPageErrorIndicatorBuilder: (context) =>
                        const Center(child: Text('가져오기 실패', style: defStyle)),
                    itemBuilder: (context, memory, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => DetailViewModel(
                                  context.read<LoadMemoryWithTreeUseCase>(),
                                  memory.treeId,
                                ),
                                child: const DetailScreen(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              memory.url != ''
                                  ? CachedNetworkImage(
                                      imageUrl: memory.url,
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'asset/image/lemon.png',
                                      width: 48,
                                    ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${memory.writerName}님의 레몬트리',
                                    style: defStyle,
                                  ),
                                  Text(
                                    memory.content,
                                    style: defStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                        create: (context) => MapViewModel(
                                            context.read<GetTreeTileUseCase>()),
                                        child: MapScreen(
                                          initialLatLng:
                                              LatLng(memory.lat, memory.lng),
                                        ),
                                      ),
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.map_outlined,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 로딩 시 로딩 바
            if (state.isLoading)
              Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
