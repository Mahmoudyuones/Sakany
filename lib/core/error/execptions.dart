abstract class AppExceptions implements Exception {
  final String message;

  const AppExceptions(this.message);
}

class RemoteException extends AppExceptions {
  RemoteException(super.message);
}

class LocalException extends AppExceptions {
  LocalException(super.message);
}
