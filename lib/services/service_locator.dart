import 'package:get_it/get_it.dart';
import 'call_and_message_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}