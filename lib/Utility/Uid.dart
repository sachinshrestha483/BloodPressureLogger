import 'package:uuid_type/uuid_type.dart';

String GetUID(){
  return TimeUuidGenerator().generate().toString();
}