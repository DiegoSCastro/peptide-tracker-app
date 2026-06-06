import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:peptide_tracker_app/src/features/library/data/models/compound_info_model.dart';

/// Loads bundled library content from `assets/library/compounds.json`.
class LibraryAssetDataSource {
  /// Creates the asset data source.
  const LibraryAssetDataSource({this.assetPath = 'assets/library/compounds.json'});

  /// Asset path for the compound catalog.
  final String assetPath;

  /// Loads and parses all compounds from the bundled JSON file.
  Future<List<CompoundInfoModel>> loadCompounds() async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final items = decoded['compounds'] as List<dynamic>;

    return items
        .map(
          (item) => CompoundInfoModel.fromJson(item as Map<String, dynamic>),
        )
        .toList(growable: false);
  }
}
