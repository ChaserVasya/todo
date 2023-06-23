import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/repositories/revision_repository.dart';

@Singleton(as: RevisionRepository)
class RevLocalStorage implements RevisionRepository {
  static const revPrefsKey = 'rev';

  final SharedPreferences prefs;

  RevLocalStorage(this.prefs);

  @override
  int get() => prefs.getInt(revPrefsKey)!;

  @override
  void set(int rev) => prefs.setInt(revPrefsKey, rev);
}
