class AuthEmail {
  const AuthEmail._();

  static String normalize(String value) {
    final email = value.trim().toLowerCase();
    final atIndex = email.indexOf('@');

    if (atIndex <= 0) return email;

    final localPart = email.substring(0, atIndex).replaceAll('.', '');
    final domainPart = email.substring(atIndex);

    return '$localPart$domainPart';
  }

  static bool isValid(String value) {
    final email = value.trim().toLowerCase();
    final atIndex = email.indexOf('@');

    if (atIndex <= 0 || atIndex != email.lastIndexOf('@')) {
      return false;
    }

    final localPart = email.substring(0, atIndex);
    if (localPart.endsWith('.')) {
      return false;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
