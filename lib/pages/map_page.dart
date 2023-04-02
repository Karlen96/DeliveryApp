import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? currentLocation;
  // StreamSubscription _locationSubscription;
  // Location _locationTracker = Location();
  late final GoogleMapController? _controller;
  // final markers = <Marker>{};
  // final polylines = <Polyline>{};
  final marker = const Marker(
    markerId: MarkerId("home"),
    position: LatLng(
      40.17689646349881,
      44.513325575576275,
    ),
    // rotation: newLocalData.heading,
    draggable: false,
    zIndex: 2,
    flat: true,
    anchor: Offset(0.5, 0.5),
    // icon: BitmapDescriptor.fromBytes(imageData),
  );

  final initialLocation = const CameraPosition(
    target: LatLng(
      40.17689646349881,
      44.513325575576275,
    ),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _initState();
  }

  Future<void> onSearch() async {
    try {

      final permission = await Geolocator.checkPermission();
      switch (permission) {
        case LocationPermission.denied:
          final res = await Geolocator.requestPermission();

          try {
            if (res == LocationPermission.denied ||
                res == LocationPermission.whileInUse ||
                res == LocationPermission.always) {
              final position = await Geolocator.getCurrentPosition();
              currentLocation = LatLng(
              position.latitude,
                position.longitude,
              );
              break;
            } else {
              // showPopup(context: context);
            }
          } catch (e) {
            // showPopup(context: context);
          }

          break;
        case LocationPermission.deniedForever:
          // showPopup(context: context);
          break;
        case LocationPermission.whileInUse:
        case LocationPermission.always:
        case LocationPermission.unableToDetermine:
          final position = await Geolocator.getCurrentPosition();
          currentLocation =  LatLng(
            position.latitude,
            position.longitude,
          );
          break;
      }

      if (currentLocation != null) {

      }
    } catch (e) {
    }
  }

  Future<void> _initState() async {
    //add currentLocation
    // final currentLocationMarker = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   Assets.person,
    // );

    // markers.add(
    //   Marker(
    //     markerId: const MarkerId('currentLocation'),
    //     position: widget.currentLocal,
    //     infoWindow: const InfoWindow(
    //       title: 'Current location',
    //     ),
    //     icon: currentLocationMarker,
    //   ),
    // );
    // for (final item in widget.airportsList) {
    //   markers.add(
    //     Marker(
    //       markerId: MarkerId(item.code),
    //       position: LatLng(
    //         item.lat,
    //         item.lon,
    //       ),
    //       infoWindow: InfoWindow(
    //         title: item.name,
    //         snippet: '${item.country}, ${item.city}',
    //       ),
    //       icon: BitmapDescriptor.defaultMarker,
    //     ),
    //   );
    // }

    ///TODO add endPint to get all polylines
    // polylines.add(
    //   Polyline(
    //     polylineId: const PolylineId('direction'),
    //     width: 2,
    //     color: Colors.blue,
    //     points: [
    //       widget.currentLocal,
    //       LatLng(
    //         widget.airportsList.first.lat,
    //         widget.airportsList.first.lon,
    //       ),
    //     ],
    //   ),
    // );

    // setState(() {});
  }

  // Future<Uint8List> getMarker() async {
  //   ByteData byteData = await DefaultAssetBundle.of(context).load(
  //     "assets/car_icon.png",
  //   );
  //   return byteData.buffer.asUint8List();
  // }

  void getCurrentLocation() async {
    try {
      // Uint8List imageData = await getMarker();
      // var location = await _locationTracker.getLocation();
      //
      // updateMarkerAndCircle(location, imageData);
      //
      // if (_locationSubscription != null) {
      //   _locationSubscription.cancel();
      // }
      //
      // _locationSubscription =
      //     _locationTracker.onLocationChanged.listen((newLocalData) {
      //       if (_controller != null) {
      //         _controller.animateCamera(CameraUpdate.newCameraPosition(
      //             new CameraPosition(
      //                 bearing: 0.0,
      //                 target: LatLng(newLocalData.latitude, newLocalData.longitude),
      //                 tilt: 0,
      //                 zoom: 17.00)));
      //         updateMarkerAndCircle(newLocalData, imageData);
      //       }
      //     });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    // if (_locationSubscription != null) {
    //   _locationSubscription.cancel();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: {marker},
        // circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.location_searching),
            onPressed: () {
              getCurrentLocation();
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () {
              // Phoenix.rebirth(context);
            },
          ),
        ],
      ),
    );
  }
}
