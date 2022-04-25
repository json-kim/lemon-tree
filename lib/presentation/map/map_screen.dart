import 'dart:async';
import 'dart:math';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lemon_tree/domain/usecase/memory/add_memory_use_case.dart';
import 'package:lemon_tree/domain/usecase/memory/add_memory_with_tree_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_count_use_case.dart';
import 'package:lemon_tree/presentation/add/add_screen.dart';
import 'package:lemon_tree/presentation/add/add_view_model.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/detail/detail_screen.dart';
import 'package:lemon_tree/presentation/detail/detail_view_model.dart';
import 'package:lemon_tree/presentation/global_widget/triangle.dart';
import 'package:lemon_tree/presentation/map/map_event.dart';
import 'package:provider/provider.dart';

import 'map_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late BitmapDescriptor lemonIcon;
  late BitmapDescriptor treeIcon;
  Timer? _debounce;
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.53418808743609, 126.9908467680216),
    zoom: 19,
  );

  Future<void> _onPosChanged(void Function() requestFunc) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), requestFunc);
  }

  Future<void> _loadWithCurrentPos() async {
    _customInfoWindowController.hideInfoWindow!();
    final controller = await _controller.future;
    final region = await controller.getVisibleRegion();
    final newLoc = LatLng(
        (region.northeast.latitude + region.southwest.latitude) / 2,
        (region.northeast.longitude + region.southwest.longitude) / 2);
    context
        .read<MapViewModel>()
        .onEvent(MapEvent.loadMarkers(newLoc.latitude, newLoc.longitude));
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'asset/icon/lemon.png')
        .then((value) => lemonIcon = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'asset/icon/tree_1.png')
        .then((value) => treeIcon = value);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();
    final state = viewModel.state;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.cancel,
            size: 36,
          ),
          color: mainGreen,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onTap: (positoin) {
              _customInfoWindowController.hideInfoWindow!();
            },
            markers: state.trees
                .map(
                  (tree) => Marker(
                    markerId: MarkerId(
                      tree.id.toString(),
                    ),
                    onTap: () {
                      _customInfoWindowController.addInfoWindow!(
                        Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // 등록된 나무라면 상세 페이지
                                  // 아니라면 추가 페이지
                                  tree.status
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                              create: (context) =>
                                                  DetailViewModel(),
                                              child: const DetailScreen(),
                                            ),
                                          ),
                                        )
                                      : Navigator.of(context)
                                          .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                create: (context) =>
                                                    AddViewModel(
                                                  context.read<
                                                      GetTreeCountUseCase>(),
                                                  context
                                                      .read<AddMemoryUseCase>(),
                                                  context.read<
                                                      AddMemoryWithTreeUseCase>(),
                                                  tree: tree,
                                                ),
                                                child: const AddScreen(),
                                              ),
                                            ),
                                          )
                                          .then((_) => _loadWithCurrentPos());
                                },
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: mainGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Image.asset(tree.status
                                                ? 'asset/icon/lemon.png'
                                                : 'asset/icon/tree_2.png')),
                                      ),
                                      Expanded(
                                        child: tree.status
                                            ? Text(
                                                '재승 님의\n레몬트리',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.center,
                                              )
                                            : Text(
                                                '수종: ${tree.woodName}\n\n새로 추가하기',
                                                style: TextStyle(
                                                    color: Colors.white),
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.center,
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                              height: 16,
                              child: CustomPaint(
                                painter:
                                    ReverseTriangle(color: mainGreen, width: 1),
                              ),
                            ),
                          ],
                        ),
                        LatLng(tree.lat, tree.lng),
                      );
                    },
                    position: LatLng(tree.lat, tree.lng),
                    icon: tree.status ? lemonIcon : treeIcon,
                  ),
                )
                .toSet(),
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _customInfoWindowController.googleMapController = controller;
              viewModel.onEvent(
                  MapEvent.loadMarkers(37.53418808743609, 126.9908467680216));
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
              _onPosChanged(() => viewModel.onEvent(MapEvent.loadMarkers(
                  position.target.latitude, position.target.longitude)));
            },
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 200,
            offset: 32,
          ),
          if (state.isLoading)
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => AddViewModel(
                      context.read<GetTreeCountUseCase>(),
                      context.read<AddMemoryUseCase>(),
                      context.read<AddMemoryWithTreeUseCase>(),
                    ),
                    child: const AddScreen(),
                  ),
                ),
              )
              .then((value) => _loadWithCurrentPos());
        },
        label: Text('새로 추가하기'),
        backgroundColor: mainGreen,
        icon: Image.asset(
          'asset/image/lemon.png',
          width: 36,
        ),
      ),
    );
  }
}
