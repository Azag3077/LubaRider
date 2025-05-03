import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/colors.dart';
import '../../core/routers/router.dart';

class SuccessfulPageArgs {
  const SuccessfulPageArgs({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.duration = const Duration(seconds: 4),
    this.actionButtonText,
  });

  final String icon;
  final String title;
  final String subtitle;
  final Duration duration;
  final String? actionButtonText;
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

  bool get _canPop => widget.args.actionButtonText != null;

  Future<void> _initState() async {
    if (_canPop) return;

    await Future.delayed(widget.args.duration);
    if (mounted) pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(widget.args.icon)
                        .animate()
                        .scale(curve: Curves.elasticOut, duration: 1000.ms)
                        .fadeIn(duration: 500.ms),
                    const SizedBox(height: 12.0),
                    Text(
                      widget.args.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19.0,
                        color: Color(0xFF1A1A1A),
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slide(
                          begin: const Offset(0, 0.3),
                          end: const Offset(0, 0),
                          curve: Curves.easeOut,
                          duration: 800.ms,
                        ),
                    Text(
                      widget.args.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: AppColors.secText,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slide(
                          begin: const Offset(0, 0.3),
                          end: const Offset(0, 0),
                          curve: Curves.easeOut,
                          duration: 800.ms,
                        ),
                  ],
                ),
              ),
              if (widget.args.actionButtonText != null)
                FilledButton(
                  onPressed: () => pop(context, true),
                  child: Center(child: Text(widget.args.actionButtonText!)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
