import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:praylude/main.dart';
import 'package:praylude/providers/app_state.dart';
import 'package:praylude/services/content_service.dart';
import 'package:praylude/services/storage_service.dart';

// Boot smoke test. Also occupies the test/widget_test.dart path so the CI
// `flutter create` step doesn't generate Flutter's boilerplate example test,
// which references a class this app doesn't have.
void main() {
  testWidgets('app boots to the welcome screen when not onboarded',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService(await SharedPreferences.getInstance());
    final state = AppState(storage, ContentService());

    await tester.pumpWidget(PrayludeApp(state: state));

    expect(find.text('Praylude'), findsOneWidget);
    expect(find.text('Begin'), findsOneWidget);
  });
}
