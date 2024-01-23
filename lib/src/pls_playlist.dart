import 'package:equatable/equatable.dart';
import 'package:pls/src/pls_entry.dart';

/// Pls playlist.
class PlsPlaylist extends Equatable {
  /// The total number of entries in the playlist.
  final int? numberOfEntries;

  /// Playlist version.
  ///
  /// This informs what format the PLS is in.
  final int? version;

  /// List of entries media files [PlsEntry].
  final List<PlsEntry>? entries;

  /// Creates a [PlsPlaylist] with a list [PlsEntry],
  /// total number of records [numberOfEntries],
  /// and PLS [version].
  const PlsPlaylist({this.entries, this.numberOfEntries, this.version});

  /// Parses Pls playlist from a document string.
  factory PlsPlaylist.parse(String src) {
    final List<PlsEntry> entryList = [];

    final regexNumberOfEntries = RegExp('[Nn]umber[oO]f[eE]ntries=(.*)');
    final matchEntries = regexNumberOfEntries.firstMatch(src);
    final entriesString = matchEntries?.group(1);
    final int entriesCount =
        entriesString != null ? int.tryParse(entriesString) ?? 0 : 0;

    final regexVersion = RegExp('[Vv]ersion=(.*)');
    final matchVersion = regexVersion.firstMatch(src);
    final versionString = matchVersion?.group(1);
    final int? plsVersion =
        versionString != null ? int.tryParse(versionString) : null;

    for (int i = 1; i <= entriesCount; i++) {
      final fileRegex = RegExp('File$i=(.*)', caseSensitive: false);
      final titleRegex = RegExp('Title$i=(.*)', caseSensitive: false);
      final lengthRegex = RegExp('Length$i=(.*)', caseSensitive: false);

      final fileMatch = fileRegex.firstMatch(src);
      final titleMatch = titleRegex.firstMatch(src);
      final lengthMatch = lengthRegex.firstMatch(src);

      final file = fileMatch?.group(1);
      final title = titleMatch?.group(1);
      final length = lengthMatch?.group(1) != null
          ? int.tryParse(lengthMatch!.group(1)!)
          : null;

      entryList.add(PlsEntry(file: file, title: title, length: length));
    }

    return PlsPlaylist(
      entries: entryList,
      version: plsVersion,
      numberOfEntries: entriesCount,
    );
  }

  @override
  List<Object?> get props => [entries, version, numberOfEntries];
}
