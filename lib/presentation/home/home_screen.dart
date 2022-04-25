import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lemon_tree/domain/model/tree_count_response.dart';
import 'package:lemon_tree/domain/usecase/memory/add_memory_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_count_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_tile_use_case.dart';
import 'package:lemon_tree/presentation/add/add_screen.dart';
import 'package:lemon_tree/presentation/add/add_view_model.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/constants/data.dart';
import 'package:lemon_tree/presentation/constants/offset.dart';
import 'package:lemon_tree/presentation/home/home_event.dart';
import 'package:lemon_tree/presentation/home/home_view_model.dart';
import 'package:lemon_tree/presentation/map/map_screen.dart';
import 'package:lemon_tree/presentation/map/map_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  int idx = 0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String buildText(int idx, TreeCountResponse count) {
    if (idx == 0) {
      return '${NumberFormat('###,###,###,###').format(count.connectedCount)} 그루';
    } else if (idx == 1) {
      return '${NumberFormat('###,###,###,###').format(count.totalCount)}\n그루 중';
    } else if (idx == 2) {
      return '${NumberFormat('###,###,###,###').format(count.todayCount)} 그루';
    } else {
      return '${NumberFormat('###,###,###,###').format(count.myCount)} 그루';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    final countResponse = state.countResponse;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) =>
                      MapViewModel(context.read<GetTreeTileUseCase>()),
                  child: MapScreen(),
                ),
              ));
            },
            icon: const Icon(Icons.map_outlined),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Center(
                    child: FittedBox(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Text(
                          homeTitle[idx],
                          key: ValueKey(idx),
                          style:
                              TextStyle(fontSize: 22.sp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: AnimatedRotation(
                    turns: idx / 4,
                    curve: Curves.easeOutExpo,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      width: 65.w,
                      height: 65.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: mainGreen,
                        boxShadow: [
                          BoxShadow(
                            color: darkGreen,
                            offset: darkOffsets[idx],
                            blurRadius: 30,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            offset: lightOffsets[idx],
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            setState(() {
                              idx += 1;
                              idx %= 4;
                            });
                          },
                          child: AnimatedRotation(
                            turns: -idx / 4,
                            curve: Curves.easeOutExpo,
                            duration: const Duration(microseconds: 1000),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(microseconds: 1000),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    child: Column(
                                      key: ValueKey(idx),
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          iconPath[idx],
                                          width: 20.w,
                                        ),
                                        const SizedBox(height: 8),
                                        FittedBox(
                                          child: Text(
                                            countResponse == null
                                                ? '...'
                                                : buildText(idx, countResponse),
                                            style: TextStyle(
                                                fontSize: 26.sp,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => AddViewModel(
                                context.read<GetTreeCountUseCase>(),
                                context.read<AddMemoryUseCase>(),
                              ),
                              child: const AddScreen(),
                            ),
                          ),
                        )
                        .then((_) => viewModel.onEvent(const HomeEvent.load()));
                  },
                  child: Text(
                    '추가 하기',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: mainGreen,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 36)),
                ),
                const Spacer(),
              ],
            ),
    );
  }
}
