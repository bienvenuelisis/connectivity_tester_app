# Connectivity Tester

How to listen and react to phone connectivity in Flutter?

1. Add the [connectivity_plus](https://pub.dev/packages/connectivity_plus) package to your project.
2. Add a Stream variable, which will allow you to listen for connectivity changes and act accordingly. Don't forget to cancel active listening for connectivity in the dispose method. If you want more detail on the life cycle of stateful Widgets, I wrote [an article](https://www.linkedin.com/pulse/devenir-d%25C3%25A9veloppeur-senior-flutter-cycle-de-vie-dun-widget-agbavon/) which details the role of each method.
3. Add a variable that lets you know whether the dialog (or bottom sheet) that tells the user they're not logged in is visible or not.
4. Create your dialog or background sheet.
5. Write the method that listens for connectivity changes, and displays the Dialog or Bottom Sheet if the user is not logged in.

In addition, this method does not guarantee that the user has a good user connection, and in particular on Android, even when the user is connected to Wifi, this does not guarantee that he has access to the Internet. If you want to test that the user actually has a good connection, use the [cross_connectivity](https://pub.dev/packages/cross_connectivity) package instead of connectivity_plus. This package actually tests connectivity by seeing an HTTP request to an online server; the interval before each attempt and the server to contact are configurable.
