import 'dart:io';
import 'package:path_provider/path_provider.dart';
class Txtfile{
   Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "today is my day";
    }
  }
}