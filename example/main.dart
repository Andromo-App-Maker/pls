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
    numberofentries=2
    File1=http://example/stream/1
    Title1=EXAMPLE | FM
    Length1=-1
    File2=http://example2/stream/1
    Title1=EXAMPLE2 | FM
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
// [MediaItem(url: http://example/stream/1, title: EXAMPLE | FM, length: -1),
// MediaItem(url: http://example2/stream/1, title: EXAMPLE2 | FM, length: -1)]
  print(mediaItems);
}
