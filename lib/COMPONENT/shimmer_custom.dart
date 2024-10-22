/* SHIMMER SKELETON */
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer buildShimmerAvatar(double valueRadius) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: valueRadius,
    ),
  );
}

Shimmer buildShimmerWidget(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(11)),
    ),
  );
}

Shimmer buildShimmerText(String text) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Text(text));
}

/* SHIMMER SKELETON */