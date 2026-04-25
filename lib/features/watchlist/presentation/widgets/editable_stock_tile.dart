import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/stock.dart';

class EditableStockTile extends StatelessWidget {
  const EditableStockTile({
    required this.stock,
    required this.index,
    required this.onDelete,
    super.key,
  });

  final Stock stock;
  final int index;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 0.6),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                Icons.drag_handle,
                size: 22,
                color: AppColors.secondaryText,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              stock.symbol,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              size: 22,
              color: AppColors.primaryText,
            ),
            tooltip: 'Remove from watchlist',
          ),
        ],
      ),
    );
  }
}
