class DateHelper {
  /// تحويل التاريخ إلى صيغة "منذ كذا"
  static String getTimeAgo(String dateString) {
    try {
      // تحويل النص إلى DateTime
      DateTime dateTime = DateTime.parse(dateString);

      // الحصول على التوقيت الحالي
      DateTime now = DateTime.now();

      // حساب الفرق
      Duration difference = now.difference(dateTime);

      return _formatTimeDifference(difference);
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
  }

  /// تحويل DateTime إلى صيغة "منذ كذا"
  static String getTimeAgoFromDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    return _formatTimeDifference(difference);
  }

  /// تنسيق الفرق الزمني
  static String _formatTimeDifference(Duration difference) {
    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return years == 1 ? 'منذ سنة' : 'منذ $years سنوات';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return months == 1 ? 'منذ شهر' : 'منذ $months أشهر';
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? 'منذ أسبوع' : 'منذ $weeks أسابيع';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? 'منذ يوم'
          : 'منذ ${difference.inDays} أيام';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? 'منذ ساعة'
          : 'منذ ${difference.inHours} ساعات';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? 'منذ دقيقة'
          : 'منذ ${difference.inMinutes} دقائق';
    } else {
      return 'الآن';
    }
  }

  /// تحويل UTC إلى التوقيت المحلي
  static String getTimeAgoWithLocalTime(String dateString) {
    try {
      DateTime utcDateTime = DateTime.parse(dateString);
      DateTime localDateTime = utcDateTime.toLocal();

      DateTime now = DateTime.now();
      Duration difference = now.difference(localDateTime);

      return _formatTimeDifference(difference);
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
  }

  /// الحصول على التاريخ المنسق بشكل كامل
  static String getFormattedDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();

      // تنسيق التاريخ
      String day = localDateTime.day.toString().padLeft(2, '0');
      String month = localDateTime.month.toString().padLeft(2, '0');
      String year = localDateTime.year.toString();
      String hour = localDateTime.hour.toString().padLeft(2, '0');
      String minute = localDateTime.minute.toString().padLeft(2, '0');

      return '$day/$month/$year في $hour:$minute';
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
  }

  /// أسماء الشهور بالعربية
  static String getFormattedDateArabic(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();

      List<String> monthsArabic = [
        '',
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];

      String day = localDateTime.day.toString();
      String month = monthsArabic[localDateTime.month];
      String year = localDateTime.year.toString();

      // تحويل إلى نظام 12 ساعة
      int hour24 = localDateTime.hour;
      int hour12;
      String period;

      if (hour24 == 0) {
        hour12 = 12;
        period = 'ص'; // صباحاً
      } else if (hour24 < 12) {
        hour12 = hour24;
        period = 'ص'; // صباحاً
      } else if (hour24 == 12) {
        hour12 = 12;
        period = 'م'; // مساءً
      } else {
        hour12 = hour24 - 12;
        period = 'م'; // مساءً
      }

      String hour = hour12.toString().padLeft(2, '0');
      String minute = localDateTime.minute.toString().padLeft(2, '0');

      return 'في $day $month $year الساعة $hour:$minute $period';
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
  }
}
