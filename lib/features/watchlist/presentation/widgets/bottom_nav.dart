import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.5),
        ),
        color: AppColors.background,
      ),
      child: const SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children:  [
              _NavItem(icon: Icons.bookmark_border, label: 'Watchlist',
                  active: true),
              _NavItem(icon: Icons.shopping_cart_outlined, label: 'Orders'),
              _NavItem(icon: Icons.bolt_outlined, label: 'GTT+'),
              _NavItem(icon: Icons.work_outline, label: 'Portfolio'),
              _NavItem(icon: Icons.account_balance_wallet_outlined,
                  label: 'Funds'),
              _NavItem(icon: Icons.person_outline, label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color =
        active ? AppColors.primaryText : AppColors.secondaryText;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
