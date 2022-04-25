import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lemon_tree/domain/usecase/memory/add_memory_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_count_use_case.dart';
import 'package:lemon_tree/presentation/add/add_screen.dart';
import 'package:lemon_tree/presentation/add/add_view_model.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/map/map_event.dart';
import 'package:provider/provider.dart';

import 'map_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();
    final state = viewModel.state;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel),
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
            markers: state.trees
                .map(
                  (tree) => Marker(
                    markerId: MarkerId(
                      tree.id.toString(),
                    ),
                    position: LatLng(tree.lat, tree.lng),
                    icon: tree.status ? lemonIcon : treeIcon,
                    infoWindow: InfoWindow(
                        onTap: () {
                          !tree.status
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                      create: (context) => AddViewModel(
                                        context.read<GetTreeCountUseCase>(),
                                        context.read<AddMemoryUseCase>(),
                                      ),
                                      child: const AddScreen(),
                                    ),
                                  ),
                                )
                              : () {};
                        },
                        title: tree.woodName,
                        snippet: tree.status ? '정보 보기' : '새로 추가하기'),
                  ),
                )
                .toSet(),
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              viewModel.onEvent(
                  MapEvent.loadMarkers(37.53418808743609, 126.9908467680216));
            },
            onCameraMove: (position) {
              // print('${position.target.latitude}, ${position.target.longitude}');
              _onPosChanged(() => viewModel.onEvent(MapEvent.loadMarkers(
                  position.target.latitude, position.target.longitude)));
            },
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
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
                ),
                child: const AddScreen(),
              ),
            ),
          )
              .then((_) async {
            final controller = await _controller.future;
            final region = await controller.getVisibleRegion();
            final newLoc = LatLng(
                (region.northeast.latitude + region.southwest.latitude) / 2,
                (region.northeast.longitude + region.southwest.longitude) / 2);
            viewModel.onEvent(
                MapEvent.loadMarkers(newLoc.latitude, newLoc.longitude));
          });
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
