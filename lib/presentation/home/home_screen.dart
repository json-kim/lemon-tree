import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lemon_tree/presentation/auth/auth_event.dart';
import 'package:lemon_tree/presentation/auth/auth_view_model.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/home/home_event.dart';
import 'package:lemon_tree/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isClicked = false;
  double turns = 0.0;

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

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    final countResponse = state.countResponse;

    return Scaffold(
      backgroundColor: mainGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.map_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.onEvent(const HomeEvent.load());
        },
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          '지금까지 등록된 레몬트리는',
                          style:
                              TextStyle(fontSize: 22.sp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: AnimatedRotation(
                      turns: turns,
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
                              offset: isClicked
                                  ? const Offset(10, -10)
                                  : const Offset(10, 10),
                              blurRadius: 30,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              offset: isClicked
                                  ? const Offset(-10, 10)
                                  : const Offset(-10, -10),
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
                              if (isClicked) {
                                setState(() {
                                  turns -= 1 / 4;
                                  _animationController.forward();
                                });
                              } else {
                                setState(() {
                                  turns += 1 / 4;
                                  _animationController.reverse();
                                });
                              }
                              isClicked = !isClicked;
                            },
                            child: AnimatedRotation(
                              turns: -turns,
                              curve: Curves.easeOutExpo,
                              duration: const Duration(microseconds: 1000),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(microseconds: 1000),
                                  child: isClicked
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'asset/image/tree.png',
                                                width: 20.w,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  countResponse == null
                                                      ? '...'
                                                      : '${NumberFormat('###,###,###,###').format(countResponse.totalCount)}\n그루 중',
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'asset/image/lemon.png',
                                              width: 20.w,
                                            ),
                                            Text(
                                              countResponse == null
                                                  ? '...'
                                                  : '${NumberFormat('###,###,###,###').format(countResponse.connectedCount)} 그루',
                                              style: TextStyle(
                                                  fontSize: 28.sp,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
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
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '추가 하기',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: mainGreen,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 36)),
                  ),
                  const Spacer(),
                ],
              ),
      ),
    );
  }
}
