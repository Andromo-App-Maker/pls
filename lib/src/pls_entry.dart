import 'package:equatable/equatable.dart';

/// Pls entry that specifies the media file.
class PlsEntry extends Equatable {
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
  List<Object?> get props => [file, title, length];
}
