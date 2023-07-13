import 'package:flutter/material.dart';

class ResponsiveLayoutBuilder<T> {
  final dynamic xs;
  final dynamic sm;
  final dynamic md;
  final dynamic lg;
  final dynamic xl;

  ResponsiveLayoutBuilder({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  T get(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return sm;
    } else if (MediaQuery.of(context).size.width < 960) {
      return md;
    } else {
      return lg;
    }
  }
}
