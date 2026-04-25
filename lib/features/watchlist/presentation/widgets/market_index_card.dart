import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../data/models/market_index.dart';
import '../../data/models/price_direction_x.dart';

class MarketIndexCard extends StatelessWidget {
  const MarketIndexCard({
    required this.index,
    this.showChevron = false,
    super.key,
  });

  final MarketIndex index;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final dirColor = index.direction.color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        index.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                    if (index.exchangeLabel.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        index.exchangeLabel,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      PriceFormatter.price(index.value),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${PriceFormatter.change(index.change)} '
                        '(${PriceFormatter.percent(index.percentChange)})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: dirColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showChevron)
            const Icon(
              Icons.chevron_right,
              size: 22,
              color: AppColors.secondaryText,
            ),
        ],
      ),
    );
  }
}
