
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

const String _stripeSecretKey = 'sk_ test_51T077dCKFXLK7DEHg5VpHvWNDg26MtJxhUHXQ9YNdzjk570jZxNQATaErQhwAemJACHECxmFWHp66j08858EpSER009LgLu4Fk';

class StripePaymentService {
  // ── Singleton ─────────────────────────────────────────────────────────────
  StripePaymentService._();
  static final StripePaymentService instance = StripePaymentService._();

  // ── Create Payment Intent ─────────────────────────────────────────────────
  Future<Map<String, dynamic>?> _createPaymentIntent({
    required int amountInCents,
    required String currency,
    String? description,
    Map<String, String>? metadata,
  }) async {
    try {
      final body = {
        'amount': amountInCents.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
        if (description != null) 'description': description,
        if (metadata != null)
          ...metadata.map((k, v) => MapEntry('metadata[$k]', v)),
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Stripe API error: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('createPaymentIntent error: $e');
      return null;
    }
  }

  // ── Main Payment Method ───────────────────────────────────────────────────
  /// Call this from anywhere. Shows a built-in loading overlay.
  /// Returns true if payment succeeded, false otherwise.
  Future<bool> processPayment({
    required BuildContext context,
    required double amount,
    required String currency,
    String? description,
    Map<String, String>? metadata,
    Color primaryColor = const Color(0xffFF6B00),
    String merchantName = 'Lyri Calibrations',
  }) async {
    // Show loading overlay
    _showLoader(context);

    try {
      final int amountInCents = (amount * 100).toInt();

      // Step 1: Create PaymentIntent
      final paymentIntent = await _createPaymentIntent(
        amountInCents: amountInCents,
        currency: currency,
        description: description,
        metadata: metadata,
      );

      if (paymentIntent == null) {
        _hideLoader(context);
        _showSnack(context, 'Failed to initialize payment.', isError: true);
        return false;
      }

      // Step 2: Init Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: merchantName,
          style: ThemeMode.light,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: primaryColor),
            shapes: const PaymentSheetShape(borderRadius: 14),
          ),
        ),
      );

      _hideLoader(context);

      // Step 3: Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      return true;
    } on StripeException catch (e) {
      _hideLoader(context);
      if (e.error.code == FailureCode.Canceled) {
        _showSnack(context, 'Payment cancelled.', isError: false);
      } else {
        _showSnack(
          context,
          e.error.localizedMessage ?? 'Payment failed.',
          isError: true,
        );
      }
      return false;
    } catch (e) {
      _hideLoader(context);
      debugPrint('Stripe processPayment error: $e');
      _showSnack(context, 'Something went wrong.', isError: true);
      return false;
    }
  }

  // ── Loader Overlay ────────────────────────────────────────────────────────
  OverlayEntry? _loaderOverlay;

  void _showLoader(BuildContext context) {
    _loaderOverlay = OverlayEntry(
      builder: (_) => const _PaymentLoadingOverlay(),
    );
    Overlay.of(context).insert(_loaderOverlay!);
  }

  void _hideLoader(BuildContext context) {
    _loaderOverlay?.remove();
    _loaderOverlay = null;
  }

  // ── Snackbar ──────────────────────────────────────────────────────────────
  void _showSnack(BuildContext context, String message,
      {required bool isError}) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.info_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor:
        isError ? const Color(0xffE53935) : const Color(0xff4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
      ),
    );
  }
}

// ── Loading Overlay Widget ────────────────────────────────────────────────────
class _PaymentLoadingOverlay extends StatelessWidget {
  const _PaymentLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.45),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(
                  color: Color(0xffFF6B00),
                  strokeWidth: 3.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Processing Payment...',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Please do not close the app',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}