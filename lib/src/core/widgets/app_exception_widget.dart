import 'package:flutter/material.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/core/extensions/build_context_extensions.dart';

class AppExceptionWidget extends StatelessWidget {
  const AppExceptionWidget({Key? key, required this.exception, this.onRetry})
      : super(key: key);

  final AppException exception;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exception.statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: Text(
                  context.localizations.retryButtonLabel,
                  style: TextStyle(
                    color: context.colorScheme.primaryColor,
                    fontSize: 17,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
