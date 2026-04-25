import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../models/stock.dart';


extension PriceDirectionColor on PriceDirection {
  Color get color {
    switch (this) {
      case PriceDirection.up:
        return AppColors.up;
      case PriceDirection.down:
        return AppColors.down;
      case PriceDirection.neutral:
        return AppColors.neutral;
    }
  }
}
