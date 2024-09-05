import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            // Circle indicator (loading placeholder)
            Container(
              width: 11.sp,
              height: 11.sp,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10.w), // Space between indicator and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    height: 20.h,
                    width: 0.6.sw, // Takes 60% of screen width
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8.h),
                  // Body placeholder (simulating the notification body)
                  Container(
                    height: 14.h,
                    width: 0.75.sw, // Takes 75% of screen width
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w), // Space between text and time
            // Time placeholder
            Container(
              height: 15.h,
              width: 40.w, // Fixed width for time
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
