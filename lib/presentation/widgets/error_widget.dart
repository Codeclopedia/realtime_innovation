import 'package:flutter/material.dart';
import 'package:realtime_innovation/core/utils/app_sizing.dart';

Widget errorWidget({required String message, VoidCallback? onRetry}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: AppSizing.w(15)),
          SizedBox(height: AppSizing.h(4)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppSizing.sp(16), fontWeight: FontWeight.w500),
          ),
          if (onRetry != null) ...[
            SizedBox(height: AppSizing.h(4)),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Retry", style: TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    ),
  );
}
