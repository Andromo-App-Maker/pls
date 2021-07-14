
# pls

pls is a lightweight library for parsing .pls files.

## [](#installation)Installation

Import the library into your Dart code using:

```
import 'pls/pls.dart';
```

## [](#usage)Usage

```

 final String fileString = """[playlist]  
numberofentries=1
File1=http://example/stream/1
Title1=EXAMPLE | FM
Length1=-1
Version=2
""";

  final plsParser = PlsPlaylist.parse(fileString);

  final List<PlsEntry> plsEntries = plsParser.entries;

  for (PlsEntry plsEntry in plsEntries!) {
      // file: http://example/stream/1, title: EXAMPLE | FM, length: '-1'
      print("file: ${plsEntry.file}, title: ${plsEntry.title}, length: ${plsEntry.length}");
    }

```

## [](#contributing)Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## [](#license)License

[MIT](https://choosealicense.com/licenses/mit/)