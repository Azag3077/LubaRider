import 'package:flutter/material.dart';

showSpinnerDialog(BuildContext context, {bool canPop = false}) {
  showDialog(
    context: context,
    barrierColor: Colors.black38,
    builder: (BuildContext context) {
      return SpinnerDialog(
        canPop: canPop,
      );
    },
  );
}

class SpinnerDialog extends StatelessWidget {
  const SpinnerDialog({
    super.key,
    this.canPop = true,
  });

  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Center(
        child: SizedBox.square(
          dimension: 56.0,
          child: CircularProgressIndicator(
            strokeWidth: 8.0,
            strokeCap: StrokeCap.round,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}

class AppSpinner extends StatelessWidget {
  const AppSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ],
    );
  }
}
