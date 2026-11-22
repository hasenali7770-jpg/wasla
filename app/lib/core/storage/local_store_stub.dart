import 'local_store.dart';

/// Web: chats stay in memory for the session (SQLite on the web needs a
/// WebAssembly build and worker; planned with the web release).
Future<LocalStore> openPlatformStore() async => MemoryStore();
