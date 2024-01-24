import 'package:pls/src/pls_entry.dart';
import 'package:pls/src/pls_playlist.dart';
import 'package:test/test.dart';

void main() async {
  group('Parse pls file', () {
    const String fileString = """
[playlist]
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

    test('Entries not null', () {
      expect(plsParser.entries, isNotNull);
    });

    test('Parses entry', () {
      expect(plsParser.entries.length, 2);
    });

    test('Version not null', () {
      expect(plsParser.version, isNotNull);
    });

    test('NumberOfEntries not null', () {
      expect(plsParser.numberOfEntries, isNotNull);
    });

    test('Parses numberOfEntries', () {
      expect(plsParser.numberOfEntries, 2);
    });

    test('Parses version', () {
      expect(plsParser.version, 2);
    });
    final PlsEntry entry = plsParser.entries[0];

    test('Parses title', () {
      expect(
        entry.title,
        'EXAMPLE | FM',
        reason: "Parsed title doesn’t match the expected one",
      );
    });

    test('Parses file', () {
      expect(
        entry.file,
        'http://example/stream/1',
        reason: "File location doesn’t match the expected one",
      );
    });

    test('Parses length', () {
      expect(
        entry.length,
        -1,
        reason: "the parsed length doesn’t match the expected one",
      );
    });

    test('Playlist without title', () {
      const String fileString = """
[playlist]
NumberOfEntries=1
File1=http://live.viacom.id:8800/

    """;
      final plsParser = PlsPlaylist.parse(fileString);
      expect(
        plsParser,
        const PlsPlaylist(
          entries: [
            PlsEntry(
              file: "http://live.viacom.id:8800/",
            ),
          ],
          numberOfEntries: 1,
        ),
      );
    });

    test('Playlist from https://en.wikipedia.org/wiki/PLS_(file_format)', () {
      const String fileString = r"""
[playlist]

File1=http://relay5.181.fm:8068
Length1=-1

File2=example2.mp3
Title2=Just some local audio that is 2mins long
Length2=120

File3=F:Music\whatever.m4a
Title3=absolute path on Windows

File4=%UserProfile%\Music\short.ogg
Title4=example for an Environment variable
Length4=5

NumberOfEntries=4
Version=2

    """;
      final plsParser = PlsPlaylist.parse(fileString);

      expect(
        plsParser,
        const PlsPlaylist(
          entries: [
            PlsEntry(file: "http://relay5.181.fm:8068", length: -1),
            PlsEntry(
              file: "example2.mp3",
              title: "Just some local audio that is 2mins long",
              length: 120,
            ),
            PlsEntry(
              file: "F:Music\\whatever.m4a",
              title: "absolute path on Windows",
            ),
            PlsEntry(
              file: "%UserProfile%\\Music\\short.ogg",
              title: "example for an Environment variable",
              length: 5,
            ),
          ],
          version: 2,
          numberOfEntries: 4,
        ),
      );
    });

    test('Playlist file empty or null', () {
      const String fileString = """
[playlist]

File1=http://relay5.181.fm:8068
Length1=-1

File2=https://mp3.barchin.com/1705323741_klavdia-petrivna-osty-chorn-bl.mp3
Title2=MP3
Length2=120

File3=
Title3=absolute path on Windows

Title4=example for an Environment variable
Length4=5

NumberOfEntries=4
Version=2
    """;
      final plsParser = PlsPlaylist.parse(fileString);
      expect(
        plsParser,
        const PlsPlaylist(
          entries: [
            PlsEntry(
              file: "http://relay5.181.fm:8068",
              length: -1,
            ),
            PlsEntry(
              file:
                  "https://muz9.z2.fm/8/e7/irina_allegrova_-_ugnala_tebja__ugnala_(zf.fm).mp3",
              title: "MP3",
              length: 120,
            ),
            PlsEntry(
              file: "",
              title: "absolute path on Windows",
            ),
            PlsEntry(
              title: "example for an Environment variable",
              length: 5,
            ),
          ],
          version: 2,
          numberOfEntries: 4,
        ),
      );
    });
  });
}
