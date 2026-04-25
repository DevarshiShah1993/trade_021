import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../data/models/price_direction_x.dart';
import '../../data/models/stock.dart';

/// Row in the main watchlist — symbol + segment on left, price + change on right.
class StockTile extends StatelessWidget {
  const StockTile({
    required this.stock,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  final Stock stock;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  String get _subtitle {
    if (stock.exchange == Exchange.idx) return stock.segment.label;
    return '${stock.exchange.label} | ${stock.segment.label}';
  }

  @override
  Widget build(BuildContext context) {
    final color = stock.direction.color;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  PriceFormatter.price(stock.lastPrice),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${PriceFormatter.change(stock.absoluteChange)} '
                  '(${PriceFormatter.percent(stock.percentChange)})',
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
