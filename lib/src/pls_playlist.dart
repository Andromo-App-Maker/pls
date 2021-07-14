library pls;

import 'pls_entry.dart';

/// Pls playlist.
class PlsPlaylist {
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
  PlsPlaylist({this.entries, this.numberOfEntries, this.version});

  /// Parses Pls playlist from a document string.
  factory PlsPlaylist.parse(String src) {
    List<PlsEntry> entryList = [];
    List<String?> fileList = [];
    List<String?> listTitle = [];
    List<int?> lengthsList = [];
    int? entriesCount;
    int? plsVersion;

    // Get url
    final regexUrl = RegExp(r'[Ff]ile[0-9]+\=(.*)');
    final matchUrl = regexUrl.allMatches(src);
    for (RegExpMatch element in matchUrl) {
      final url = element.group(1);
      fileList.add(url);
    }

    // Get title
    final regexTitle = RegExp(r'[Tt]itle[0-9]+\=(.*)');
    final matchTitle = regexTitle.allMatches(src);
    for (RegExpMatch element in matchTitle) {
      final title = element.group(1);
      listTitle.add(title);
    }

    // Get length
    final regexLength = RegExp(r'[Ll]ength[0-9]+\=(.*)');
    final matchLength = regexLength.allMatches(src);
    for (RegExpMatch element in matchLength) {
      final length = element.group(1);
      lengthsList.add(length != null ? int.tryParse(length) : null);
    }

    // Get numberOfEntries
    final regexNumberOfEntries = RegExp(r'[Nn]umber[oO]f[eE]ntries\=(.*)');
    final match = regexNumberOfEntries.firstMatch(src);
    final entriesString = match?.group(1);
    entriesCount = entriesString != null ? int.tryParse(entriesString) : null;

    // Get version
    final regexVersion = RegExp(r'[Vv]ersion\=(.*)');
    final matchVersion = regexVersion.firstMatch(src);
    final versionString = matchVersion?.group(1);
    plsVersion = versionString != null ? int.tryParse(versionString) : null;

    for (int i = 0; i < fileList.length; i++) {
      entryList.add(
        PlsEntry(
          file: fileList[i],
          title: listTitle[i],
          length: lengthsList.isEmpty ? null : lengthsList[i],
        ),
      );
    }

    return PlsPlaylist(
      entries: entryList,
      version: plsVersion,
      numberOfEntries: entriesCount,
    );
  }
}
