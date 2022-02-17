import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class GiftHubWebAppFirebaseUser {
  GiftHubWebAppFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

GiftHubWebAppFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<GiftHubWebAppFirebaseUser> giftHubWebAppFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<GiftHubWebAppFirebaseUser>(
            (user) => currentUser = GiftHubWebAppFirebaseUser(user));
