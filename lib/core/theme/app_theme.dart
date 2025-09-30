import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_sizes.dart';

final themeModeProvider = StateNotifierProvider<AppThemeController, ThemeMode>(
  (ref) => AppThemeController(),
);

class AppThemeController extends StateNotifier<ThemeMode> {
  AppThemeController() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) => state = mode;

  void toggle() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }
}

abstract class AppTheme {
  static ThemeData get light => _baseTheme(Brightness.light);

  static ThemeData get dark => _baseTheme(Brightness.dark);

  static ThemeData _baseTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final baseScheme = ColorScheme.fromSeed(
      seedColor: isLight ? const Color(0xFF146C94) : const Color(0xFF4B9FC1),
      brightness: brightness,
    );

    final colorScheme = baseScheme.copyWith(
      surface: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF141B2D),
      surfaceContainerHighest: isLight
          ? const Color(0xFFE2E8F0)
          : const Color(0xFF1F2738),
      outline: isLight ? const Color(0xFFCBD5E1) : const Color(0xFF3B4A66),
      outlineVariant: isLight
          ? const Color(0xFFE2E8F0)
          : const Color(0xFF303A52),
      secondary: isLight ? const Color(0xFF2563EB) : const Color(0xFF8BA4FF),
      tertiary: isLight ? const Color(0xFFEA580C) : const Color(0xFFFBBF24),
    );

    final textTheme = _textTheme(brightness);

    final theme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: isLight
          ? const Color(0xFFF4F6F8)
          : const Color(0xFF0B121F),
      visualDensity: const VisualDensity(horizontal: -0.5, vertical: -0.5),
    );

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        toolbarHeight: 56,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadius,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      chipTheme: theme.chipTheme.copyWith(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        labelStyle: textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.chipRadius),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius,
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius,
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
      listTileTheme: theme.listTileTheme.copyWith(
        contentPadding: AppSpacing.listTile,
        dense: true,
        horizontalTitleGap: 12,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadius),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadius),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadius),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadius),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.all(
          textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadius),
        backgroundColor: colorScheme.surface,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final base = ThemeData(brightness: brightness).textTheme;
    final color = brightness == Brightness.light
        ? const Color(0xFF1F2933)
        : const Color(0xFFE2E8F0);

    return base
        .copyWith(
          titleLarge: base.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: base.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: base.titleSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: base.bodyLarge?.copyWith(fontSize: 15, height: 1.4),
          bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, height: 1.45),
          bodySmall: base.bodySmall?.copyWith(fontSize: 12, height: 1.4),
          labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          labelMedium: base.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        )
        .apply(bodyColor: color, displayColor: color);
  }
}
