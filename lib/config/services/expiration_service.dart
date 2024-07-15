import 'package:jwt_decoder/jwt_decoder.dart';

class ExpirationService {
  static bool isTokenAboutToExpire(String token) {
    final expirationDate = JwtDecoder.getExpirationDate(token);
    final currentTime = DateTime.now();
    final timeDifference = expirationDate.difference(currentTime);
    return timeDifference.inMinutes <= 5;
  }
}
