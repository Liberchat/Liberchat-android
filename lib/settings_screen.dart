import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        elevation: 0,
      ),
      body: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildThemeModeSection(context, themeManager),
              const SizedBox(height: 24),
              _buildColorThemeSection(context, themeManager),
              const SizedBox(height: 24),
              _buildFontSizeSection(context, themeManager),
              const SizedBox(height: 24),
              _buildPreviewSection(context, themeManager),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeModeSection(BuildContext context, ThemeManager themeManager) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.brightness_6, color: themeManager.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Mode d\'affichage',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...AppThemeMode.values.map((mode) {
              return RadioListTile<AppThemeMode>(
                title: Text(_getThemeModeLabel(mode)),
                subtitle: Text(_getThemeModeDescription(mode)),
                value: mode,
                groupValue: themeManager.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    themeManager.setThemeMode(value);
                  }
                },
                activeColor: themeManager.primaryColor,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorThemeSection(BuildContext context, ThemeManager themeManager) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette, color: themeManager.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Couleur du thème',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: AppColorTheme.values.map((colorTheme) {
                final color = _getColorForTheme(colorTheme);
                final isSelected = themeManager.colorTheme == colorTheme;
                
                return GestureDetector(
                  onTap: () => themeManager.setColorTheme(colorTheme),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected 
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: isSelected ? 2 : 0,
                        ),
                      ],
                    ),
                    child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 30)
                      : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'Couleur sélectionnée: ${themeManager.colorName}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeSection(BuildContext context, ThemeManager themeManager) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: themeManager.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Taille de police',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.text_decrease),
                Expanded(
                  child: Slider(
                    value: themeManager.fontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 12,
                    label: '${themeManager.fontSize.round()}px',
                    activeColor: themeManager.primaryColor,
                    onChanged: (value) {
                      themeManager.setFontSize(value);
                    },
                  ),
                ),
                const Icon(Icons.text_increase),
              ],
            ),
            Text(
              'Taille actuelle: ${themeManager.fontSize.round()}px',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection(BuildContext context, ThemeManager themeManager) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.preview, color: themeManager.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Aperçu',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: themeManager.primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Titre principal',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ceci est un exemple de texte avec la taille de police actuelle. Vous pouvez voir comment le texte apparaîtra dans l\'application.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Texte secondaire plus petit',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeLabel(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Clair';
      case AppThemeMode.dark:
        return 'Sombre';
      case AppThemeMode.auto:
        return 'Automatique';
    }
  }

  String _getThemeModeDescription(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Toujours en mode clair';
      case AppThemeMode.dark:
        return 'Toujours en mode sombre';
      case AppThemeMode.auto:
        return 'Suit les paramètres du système';
    }
  }

  Color _getColorForTheme(AppColorTheme theme) {
    switch (theme) {
      case AppColorTheme.red:
        return Colors.red;
      case AppColorTheme.blue:
        return Colors.blue;
      case AppColorTheme.green:
        return Colors.green;
      case AppColorTheme.purple:
        return Colors.purple;
      case AppColorTheme.orange:
        return Colors.orange;
      case AppColorTheme.teal:
        return Colors.teal;
    }
  }
}