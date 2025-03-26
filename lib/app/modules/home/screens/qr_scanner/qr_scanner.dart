import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthguiderobin/app/widgets/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../../data/clrs.dart';
import '../../../../designs/custom_btn.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  String? scannedData;

  late AnimationController _controller;
  late Animation<double> _animation;

  PermissionStatus status = PermissionStatus.granted;

  @override
  void initState() {
    super.initState();
    checkCameraPermission();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    // Define the animation (top to bottom)
    _animation = Tween<double>(begin: 0, end: 290).animate(_controller)
      ..addListener(() {
        setState(() {}); // Trigger rebuild on animation update
      });
  }

  checkCameraPermission() async {
    status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      await Permission.camera.request();
      status = await Permission.camera.status;
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppClrs.kPrimaryClr,
        title: Text(
          'Scan QR Code',
          style: TextStyle(
            color: AppClrs.kAccentClr,
          ),
        ),
        centerTitle: true,
      ),
      body: status.isGranted
          ? Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      // QRView
                      QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                      // Blurred surroundings with a hole for the clear area
                      Positioned.fill(
                        child: ClipPath(
                          clipper:
                              _HoleClipper(), // Custom clipper to create a hole
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      // White bordered box
                      Center(
                        child: Container(
                          width: 300.w,
                          height: 300.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      if (scannedData == null)
                        Positioned(
                          left: (MediaQuery.of(context).size.width - 280.w) / 2,
                          top:
                              (MediaQuery.of(context).size.height - 595.h) / 2 +
                                  _animation.value,
                          child: Container(
                            width: 280.w,
                            height: 2.h,
                            color: Colors.red,
                          ),
                        ),
                      // Flash icon
                      if (scannedData == null)
                        Positioned(
                          right: 20.w,
                          bottom: 20.h,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svgs/flash.svg',
                              width: 22.w,
                              height: 22.h,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              controller?.toggleFlash();
                            },
                          ),
                        ),
                      // Camera flip icon
                      if (scannedData == null)
                        Positioned(
                          left: 20.w,
                          bottom: 20.h,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svgs/camera_flip.svg',
                              width: 22.w,
                              height: 22.h,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              controller?.flipCamera();
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        scannedData ?? 'Scan a QR Code',
                      ),
                      addH(20.h),
                      // scan again button
                      if (scannedData != null)
                        CustomBtn(
                          btnTxt: 'Scan Again',
                          onPressedFn: () {
                            controller?.resumeCamera();
                            setState(() {
                              scannedData = null;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No camera permissions',
                  ),
                  addH(20.h),
                  status.isPermanentlyDenied
                      ? Text('Please enable camera permissions in settings')
                      : CustomBtn(
                          btnTxt: 'Request Permissions',
                          onPressedFn: () async {
                            print('Camera status: $status');
                            await Permission.camera.request();
                            status = await Permission.camera.status;
                            if (status.isGranted) {
                              setState(() {});
                            }
                          },
                        ),
                ],
              ),
            ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code;
      });
      controller.pauseCamera();
      print('Scanned Data: ${scanData.code}');
      // Navigator.pop(context, scannedData); // Return scanned data to Home
    });
  }
}

// Custom clipper to create a hole in the blurred overlay
class _HoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the hole (clear area) in the center
    final holeSize = Size(300, 300);
    final holeOffset = Offset(
      (size.width - holeSize.width) / 2,
      (size.height - holeSize.height) / 2,
    );
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            holeOffset.dx, holeOffset.dy, holeSize.width, holeSize.height),
        Radius.circular(12),
      ),
    );

    // Set the hole as a non-fill area
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
