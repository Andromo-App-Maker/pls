import 'package:pls/pls.dart';

class MediaItem {
  final String? url;
  final String? title;
  final int? length;

  MediaItem({this.url, this.title, this.length});
}

void main() {
  List<MediaItem> mediaItems = [];

  final String fileString = """[playlist]
    numberofentries=1
    File1=http://example/stream/1
    Title1=EXAMPLE | FM
    Length1=-1
    Version=2
    """;

  final plsParser = PlsPlaylist.parse(fileString);

  final List<PlsEntry>? plsEntries = plsParser.entries;

  for (PlsEntry plsEntry in plsEntries!) {
    mediaItems.add(MediaItem(
      url: plsEntry.file,
      title: plsEntry.title,
      length: plsEntry.length,
    ));
  }
// [MediaItem(file: http://example/stream/1, title: EXAMPLE | FM, length: -1)]
  print(mediaItems);
}
