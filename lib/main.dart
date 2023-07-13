import 'dart:async';

import 'package:countdown/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:countdown/layout_builder.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: theme,
      home: const Countdown(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Timer _timer;
  late StreamController<Duration> _streamController;
  Duration _duration = const Duration();
  final DateTime _finalTime = DateTime(2023, 08, 11, 22, 00, 00);

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<Duration>();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _duration = _finalTime.difference(DateTime.now());
        _streamController.add(_duration);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Duration>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          int days = snapshot.data?.inDays ?? 0;
          int hours = (snapshot.data?.inHours ?? 0) % 24;
          int minutes = (snapshot.data?.inMinutes ?? 0) % 60;
          // int seconds = (snapshot.data?.inSeconds ?? 0) % 60;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CounterComponent(
                title: 'DAYS',
                value: '$days',
              ),
              const _VerticalDivider(),
              CounterComponent(
                title: 'HOURS',
                value: '$hours',
              ),
              const _VerticalDivider(),
              CounterComponent(
                title: 'MINUTES',
                value: '$minutes',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Theme.of(context).colorScheme.primary,
      thickness: 0.5,
      width: 1,
      endIndent: ResponsiveLayoutBuilder<double>(
        sm: 320.toDouble(),
        md: 470.toDouble(),
        lg: 190.toDouble(),
      ).get(context),
      indent: ResponsiveLayoutBuilder<double>(
        sm: 330.toDouble(),
        md: 480.toDouble(),
        lg: 200.toDouble(),
      ).get(context),
    );
  }
}

class CounterComponent extends StatelessWidget {
  final String value;
  final String title;

  const CounterComponent({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: ResponsiveLayoutBuilder<double>(
              sm: 60.toDouble(),
              md: 100.toDouble(),
              lg: 120.toDouble(),
            ).get(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveLayoutBuilder<double>(
              sm: 16.toDouble(),
              md: 32.toDouble(),
              lg: 64.toDouble(),
            ).get(context),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
