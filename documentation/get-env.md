Documentation :
https://pub.dev/packages/flutter_dotenv

Create:
.env in root

Define:
key/value in . env

Install env :  
flutter pub add flutter_dotenv

Get lib:
import 'package:flutter_dotenv/flutter_dotenv.dart';

Call env:
await dotenv.load(fileName: ".env");

Print value:
print(dotenv.env['CITY_API_KEY']);

