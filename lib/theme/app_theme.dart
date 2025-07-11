import 'package:flutter/material.dart';

// Custom color extensions for theme
extension AppColorsExtension on ColorScheme {
  // Primary gradient colors
  Color get primaryGradientStart => const Color(0xFF6C63FF);
  Color get primaryGradientMiddle => const Color(0xFF5A52FF);
  Color get primaryGradientEnd => const Color(0xFF4B42FF);
  
  // Status colors
  Color get activeTaskColor => const Color(0xFFFF6B6B);
  Color get completedTaskColor => const Color(0xFF4ECDC4);
  Color get totalTaskColor => const Color(0xFF6C63FF);
  
  // Surface colors
  Color get surfaceLight => const Color(0xFFF8F9FA);
  Color get surfaceCard => Colors.white;
  
  // Text colors
  Color get textPrimary => const Color(0xFF2C3E50);
  Color get textSecondary => const Color(0xFF7F8C8D);
  Color get textHint => const Color(0xFFBDC3C7);
  
  // State colors
  Color get successColor => const Color(0xFF4ECDC4);
  Color get warningColor => const Color(0xFFFF6B6B);
  Color get infoColor => const Color(0xFF6C63FF);
  
  // Utility methods for gradients
  LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGradientStart, primaryGradientMiddle, primaryGradientEnd],
  );
  
  LinearGradient get completedGradient => LinearGradient(
    colors: [
      completedTaskColor.withValues(alpha: 0.1),
      completedTaskColor.withValues(alpha: 0.05),
    ],
  );
  
  LinearGradient get surfaceGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryGradientStart.withValues(alpha: 0.1),
      primaryGradientEnd.withValues(alpha: 0.05),
    ],
  );
}

class AppTheme {
  AppTheme._();
  
  static ThemeData get lightTheme {
    const primaryColor = Color(0xFF6C63FF);
    
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      fontFamilyFallback: const ['SF Pro Display', 'Roboto', 'Arial', 'sans-serif'],
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          fontWeight: FontWeight.w600, // SemiBold
          color: Colors.white,
          letterSpacing: -0.25,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 8,
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
        ),
        prefixIconColor: primaryColor,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          color: Color(0xFF7F8C8D),
          fontWeight: FontWeight.w400,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600, // SemiBold
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600, // SemiBold
          ),
        ),
      ),
      
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          padding: const EdgeInsets.all(8),
          iconSize: 24,
        ),
      ),
      
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        checkColor: WidgetStateProperty.all(Colors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF4ECDC4);
          }
          return Colors.transparent;
        }),
      ),
      
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 32,
          fontWeight: FontWeight.w600, // SemiBold
          color: Color(0xFF2C3E50),
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          fontWeight: FontWeight.w600, // SemiBold
          color: Color(0xFF2C3E50),
          letterSpacing: -0.25,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600, // SemiBold
          color: Color(0xFF2C3E50),
          letterSpacing: -0.15,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w600, // SemiBold
          color: Color(0xFF2C3E50),
          letterSpacing: -0.1,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600, // SemiBold
          color: Color(0xFF2C3E50),
          letterSpacing: -0.05,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600, // SemiBold
          color: Color(0xFF2C3E50),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFF2C3E50),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFF7F8C8D),
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFF7F8C8D),
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFF7F8C8D),
        ),
        labelMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFF7F8C8D),
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFFBDC3C7),
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    const primaryColor = Color(0xFF6C63FF);
    
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      fontFamilyFallback: const ['SF Pro Display', 'Roboto', 'Arial', 'sans-serif'],
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}