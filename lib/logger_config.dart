import 'package:logging/logging.dart';

final Logger logger = Logger('YourApp');

void configureLogging() {
  Logger.root.level = Level.ALL; 
  Logger.root.onRecord.listen((LogRecord rec) {
    // ignore: avoid_print
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
