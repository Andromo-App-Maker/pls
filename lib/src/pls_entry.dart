/// Pls entry that specifies the media file.
class PlsEntry {
  /// Location of media file/stream.
  final String? file;

  /// A text string specifying the title for entry element.
  final String? title;

  /// Length in seconds.
  ///
  /// It can be is negative if it is a stream.
  final int? length;

  /// Creates [PlsEntry] that specifies the media file.
  const PlsEntry({this.file, this.title, this.length});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlsEntry &&
        other.file == file &&
        other.title == title &&
        other.length == length;
  }

  @override
  int get hashCode => file.hashCode ^ title.hashCode ^ length.hashCode;
}
