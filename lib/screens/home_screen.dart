// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// const LatLng START = LatLng(6.64844, 3.58812);
// const LatLng FIRST_STOP = LatLng(6.62135, 3.50357);
// const LatLng DEST = LatLng(6.62036, 3.47551);
//
// class RideScreen extends StatefulWidget {
//   const RideScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _RideScreenState createState() => _RideScreenState();
// }
//
// class _RideScreenState extends State<RideScreen> {
//   GoogleMapController? mapController;
//   final Set<Marker> _markers = Set<Marker>();
//
//   // drawing route(polyline) on map
//   final Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   List<LatLng> polylineCoordinatesTwo = [];
//   PolylinePoints? polylinePoints;
//   Uint8List? coasterMarker;
//   Uint8List? startCap;
//   Uint8List? endCap;
//
//   // custom marker holders
//   BitmapDescriptor? sourcePin;
//   BitmapDescriptor? destinationPin;
//
//   // user's location reference
//   LocationData? currentLocation;
//
//   // destination location
//   LocationData? destinationLocation;
//
//   // destination location reference
//   // late Location location;
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     showPinsOnMap();
//     showMyLocation();
//     setState(() {});
//   }
//
//   void showPinsOnMap() {
//     final pinPosition = LatLng(
//       START.latitude,
//       START.longitude,
//     );
//
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('userPin'),
//         position: pinPosition,
//         zIndex: 1,
//         icon: BitmapDescriptor.fromBytes(coasterMarker!),
//       ),
//     );
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('destinationPin'),
//         position: DEST,
//         zIndex: 1,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ),
//     );
//     setPolylines();
//   }
//
//   void setPolylines() async {
//     final apiKey = dotenv.env['GOOGLE_MAP_API_KEY']!;
//
//     final _result = await polylinePoints!.getRouteBetweenCoordinates(
//       apiKey,
//       PointLatLng(
//         START.latitude,
//         START.longitude,
//       ),
//       PointLatLng(
//         FIRST_STOP.latitude,
//         FIRST_STOP.longitude,
//       ),
//     );
//
//     final _resultTwo = await polylinePoints!.getRouteBetweenCoordinates(
//       apiKey,
//       PointLatLng(
//         FIRST_STOP.latitude,
//         FIRST_STOP.longitude,
//       ),
//       PointLatLng(
//         DEST.latitude,
//         DEST.longitude,
//       ),
//     );
//
//     final result = _result.points;
//     final resultTwo = _resultTwo.points;
//
//     if (result.isNotEmpty && resultTwo.isNotEmpty) {
//       result.forEach((PointLatLng point) {
//         polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         );
//       });
//       resultTwo.forEach((PointLatLng point) {
//         polylineCoordinatesTwo.add(
//           LatLng(point.latitude, point.longitude),
//         );
//       });
//       setState(() {
//         _polylines.addAll(
//           [
//             Polyline(
//               polylineId: const PolylineId('poly'),
//               width: 5,
//               startCap: Cap.customCapFromBitmap(
//                 BitmapDescriptor.fromBytes(startCap!),
//               ),
//               endCap: Cap.roundCap,
//               zIndex: 0,
//               color: Colors.green,
//               points: polylineCoordinates,
//             ),
//             Polyline(
//               polylineId: const PolylineId('poly-end'),
//               width: 5,
//               startCap: Cap.roundCap,
//               endCap: Cap.customCapFromBitmap(
//                 BitmapDescriptor.fromBytes(endCap!),
//               ),
//               zIndex: 0,
//               color: Colors.greenAccent,
//               patterns: [
//                 PatternItem.dot,
//               ],
//               points: polylineCoordinatesTwo,
//             ),
//           ],
//         );
//       });
//     }
//   }
//
//   void updatePinOnMap() async {
//     final pinPosition =
//         LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
//
//     // the trick is to remove the marker(by id) and add it again at the
//     // updated location
//     _markers.removeWhere(
//       (element) => element.markerId.value == 'userPin',
//     );
//
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('userPin'),
//         position: pinPosition,
//         zIndex: 1,
//         icon: BitmapDescriptor.fromBytes(coasterMarker!),
//       ),
//     );
//   }
//
//   void showMyLocation() {
//     final cPosition = CameraPosition(
//       zoom: 12,
//       target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
//     );
//     mapController!.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//   }
//
//   Future<Uint8List> getMarker() async {
//     final byteData =
//         await DefaultAssetBundle.of(context).load('assets/images/Coaster.png');
//     return byteData.buffer.asUint8List();
//   }
//
//   Future<Uint8List> getStartCap() async {
//     final byteData = await DefaultAssetBundle.of(context)
//         .load('assets/images/start_cap.png');
//
//     return byteData.buffer.asUint8List();
//   }
//
//   Future<Uint8List> getEndCap() async {
//     final byteData =
//         await DefaultAssetBundle.of(context).load('assets/images/end_cap.png');
//
//     return byteData.buffer.asUint8List();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     polylinePoints = PolylinePoints();
//
//     initCoasterMarker();
//   }
//
//   void initCoasterMarker() async {
//     coasterMarker = await getMarker();
//     startCap = await getStartCap();
//     endCap = await getEndCap();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return StreamBuilder<LocationData>(
//     //   stream: location.onLocationChanged,
//     //   builder: (context, snapshot) {
//     //     if (snapshot.data == null) {
//     //       return const Center(
//     //         child: CircularProgressIndicator(),
//     //       );
//     //     } else {
//     //       // currentLocation = snapshot.data;
//     //       // updatePinOnMap();
//     return Scaffold(
//       bottomSheet: const CustomDragSheet(),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: const CameraPosition(
//                 target: START,
//                 zoom: 12,
//               ),
//               markers: _markers,
//               mapType: MapType.normal,
//               polylines: _polylines,
//               myLocationButtonEnabled: false,
//               myLocationEnabled: false,
//               compassEnabled: false,
//               onMapCreated: _onMapCreated,
//             ),
//             Padding(
//               padding: UIHelper.paddingLTRB(20, 40, 0, 0),
//               child: Container(
//                 height: SizeConfig.height(40),
//                 width: SizeConfig.width(183),
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(24),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.all(2),
//                       height: SizeConfig.height(32),
//                       width: SizeConfig.width(32),
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.black12,
//                       ),
//                       child: const Center(
//                         child: Icon(
//                           Icons.directions_bus_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'Book new trip',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: SizeConfig.textSize(14),
//                       ),
//                     ),
//                     const Spacer(),
//                     const IconButton(
//                       onPressed: null,
//                       icon: Icon(
//                         Icons.arrow_right_alt_rounded,
//                         color: Colors.green,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: SizeConfig.height(40),
//               right: SizeConfig.width(20),
//               left: SizeConfig.width(300),
//               child: Container(
//                 height: SizeConfig.height(40),
//                 width: SizeConfig.width(40),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: const Icon(Icons.notifications_sharp),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// //   },
// // );
// // }
// }
