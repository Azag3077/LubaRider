import 'package:flutter/material.dart';

import '../../core/routers/router.dart';

class SuccessfulPageArgs {
  const SuccessfulPageArgs({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.duration = const Duration(seconds: 4),
  });

  final String icon;
  final String title;
  final String subtitle;
  final Duration duration;
}

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage(this.args, {super.key});
  final SuccessfulPageArgs args;

  static const routeName = '/successful';

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  void initState() {
    super.initState();
    _initState();
  }

  Future<void> _initState() async {
    await Future.delayed(widget.args.duration);
    if (mounted) pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(widget.args.icon),
                const SizedBox(height: 12.0),
                Text(
                  widget.args.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  widget.args.subtitle,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3D3D3D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
