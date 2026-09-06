class PhoneHelper {
  /// تهيئة رقم الهاتف لفتحه في الواتساب بالصيغة الدولية السورية
  static String formatForWhatsapp(String phone) {
    String clean = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (clean.startsWith('00')) {
      clean = clean.substring(2);
    } else if (clean.startsWith('+')) {
      clean = clean.substring(1);
    }
    if (clean.startsWith('09')) {
      clean = '963' + clean.substring(1);
    } else if (clean.startsWith('9') && clean.length == 9) {
      clean = '963' + clean;
    }
    return clean;
  }

  /// التحقق من صحة طول رقم الهاتف المدخل
  static bool isValidPhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return clean.length >= 9 && clean.length <= 14;
  }
}