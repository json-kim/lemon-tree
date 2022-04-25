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
import 'package:lemon_tree/presentation/setting/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'my_view_model.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyViewModel>();
    final state = viewModel.state;

    return Scaffold(
      backgroundColor: mainGreen,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                '내가 등록한 레몬트리는',
                style: defStyle.copyWith(fontSize: 22.sp),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  viewModel.memoryPagingController.refresh();
                },
                child: PagedListView(
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
                      padding: const EdgeInsets.only(bottom: 16),
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
                              Image.asset(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
