import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImg extends StatelessWidget {
  final String imgUrl;
  double? imgHeight;
  double? imgWidth;
  BoxFit? imgFit;
  CustomImg({
    Key? key,
    required this.imgUrl,
    this.imgHeight,
    this.imgWidth,
    this.imgFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgWidth ?? 348.h,
      height: imgHeight,
      child: imgUrl.isNotEmpty
          ? Image.network(
              imgUrl,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                      ),
                    ),
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image,
                size: 30.h,
                color: Colors.grey,
              ),
              fit: imgFit ?? BoxFit.fill,
            )
          : Image.asset(
              'assets/imgs/img_ph.png',
              fit: imgFit,
              width: imgWidth,
              height: imgHeight,
            ),
    );
  }
}
