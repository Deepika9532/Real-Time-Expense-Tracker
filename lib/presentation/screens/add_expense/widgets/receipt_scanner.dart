import 'package:flutter/material.dart';

class ReceiptScanner extends StatelessWidget {
  final Function(String)? onReceiptScanned;

  const ReceiptScanner({super.key, this.onReceiptScanned});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Scan Receipt',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Automatically extract expense details from receipts',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Open camera to scan receipt
                    _scanReceipt(context, 'camera');
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Open gallery to select receipt
                    _scanReceipt(context, 'gallery');
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _scanReceipt(BuildContext context, String source) {
    // This is a placeholder for receipt scanning functionality
    // In a real app, you would:
    // 1. Use image_picker to get the image
    // 2. Use ML Kit or Google Vision API to extract text
    // 3. Parse the text to extract amount, date, merchant, etc.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receipt scanning from $source - Coming soon!')),
    );
  }
}
