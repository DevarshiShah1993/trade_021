import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/watchlist.dart';

class WatchlistTabs extends StatelessWidget {
  const WatchlistTabs({
    required this.watchlists,
    required this.activeId,
    required this.onTap,
    required this.onEditPressed,
    super.key,
  });

  final List<Watchlist> watchlists;
  final String? activeId;
  final ValueChanged<String> onTap;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: watchlists.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, i) {
                final wl = watchlists[i];
                final isActive = wl.id == activeId;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(wl.id),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        wl.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w500,
                          color: isActive
                              ? AppColors.primaryText
                              : AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: 2,
                        width: isActive ? 30 : 0,
                        color: AppColors.primaryText,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(
              Icons.edit_outlined,
              size: 20,
              color: AppColors.primaryText,
            ),
            tooltip: 'Edit watchlist',
          ),
        ],
      ),
    );
  }
}
