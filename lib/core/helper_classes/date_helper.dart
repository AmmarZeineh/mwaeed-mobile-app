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

  /// Convert date to "time ago" format in English
  static String getTimeAgoEnglish(String dateString) {
    try {
      // Convert string to DateTime
      DateTime dateTime = DateTime.parse(dateString);

      // Get current time
      DateTime now = DateTime.now();

      // Calculate difference
      Duration difference = now.difference(dateTime);

      return _formatTimeDifferenceEnglish(difference);
    } catch (e) {
      return 'Invalid date';
    }
  }

  /// Convert DateTime to "time ago" format in English
  static String getTimeAgoFromDateTimeEnglish(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    return _formatTimeDifferenceEnglish(difference);
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

  /// Format time difference in English
  static String _formatTimeDifferenceEnglish(Duration difference) {
    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Now';
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

  /// Convert UTC to local time in English
  static String getTimeAgoWithLocalTimeEnglish(String dateString) {
    try {
      DateTime utcDateTime = DateTime.parse(dateString);
      DateTime localDateTime = utcDateTime.toLocal();

      DateTime now = DateTime.now();
      Duration difference = now.difference(localDateTime);

      return _formatTimeDifferenceEnglish(difference);
    } catch (e) {
      return 'Invalid date';
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

  /// Get formatted date in English
  static String getFormattedDateEnglish(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();

      // Format the date
      String day = localDateTime.day.toString().padLeft(2, '0');
      String month = localDateTime.month.toString().padLeft(2, '0');
      String year = localDateTime.year.toString();
      String hour = localDateTime.hour.toString().padLeft(2, '0');
      String minute = localDateTime.minute.toString().padLeft(2, '0');

      return '$day/$month/$year at $hour:$minute';
    } catch (e) {
      return 'Invalid date';
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

  /// Get formatted date with English month names
  static String getFormattedDateEnglishMonths(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();

      List<String> monthsEnglish = [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];

      String day = localDateTime.day.toString();
      String month = monthsEnglish[localDateTime.month];
      String year = localDateTime.year.toString();

      // Convert to 12-hour format
      int hour24 = localDateTime.hour;
      int hour12;
      String period;

      if (hour24 == 0) {
        hour12 = 12;
        period = 'AM';
      } else if (hour24 < 12) {
        hour12 = hour24;
        period = 'AM';
      } else if (hour24 == 12) {
        hour12 = 12;
        period = 'PM';
      } else {
        hour12 = hour24 - 12;
        period = 'PM';
      }

      String hour = hour12.toString().padLeft(2, '0');
      String minute = localDateTime.minute.toString().padLeft(2, '0');

      return 'On $day $month $year at $hour:$minute $period';
    } catch (e) {
      return 'Invalid date';
    }
  }

  /// Get short formatted date in English (e.g., "Jan 15, 2024")
  static String getShortFormattedDateEnglish(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();

      List<String> monthsShort = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      String day = localDateTime.day.toString();
      String month = monthsShort[localDateTime.month];
      String year = localDateTime.year.toString();

      return '$month $day, $year';
    } catch (e) {
      return 'Invalid date';
    }
  }

  /// Get relative date in English (e.g., "Today", "Yesterday", "Tomorrow")
  static String getRelativeDateEnglish(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();
      DateTime now = DateTime.now();

      // Remove time part for comparison
      DateTime dateOnly = DateTime(
        localDateTime.year,
        localDateTime.month,
        localDateTime.day,
      );
      DateTime nowOnly = DateTime(now.year, now.month, now.day);

      Duration difference = dateOnly.difference(nowOnly);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == -1) {
        return 'Yesterday';
      } else if (difference.inDays == 1) {
        return 'Tomorrow';
      } else if (difference.inDays < 0) {
        return '${difference.inDays.abs()} days ago';
      } else {
        return 'In ${difference.inDays} days';
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  /// Get relative date in Arabic (e.g., "اليوم", "أمس", "غداً")
  static String getRelativeDateArabic(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime localDateTime = dateTime.toLocal();
      DateTime now = DateTime.now();

      // Remove time part for comparison
      DateTime dateOnly = DateTime(
        localDateTime.year,
        localDateTime.month,
        localDateTime.day,
      );
      DateTime nowOnly = DateTime(now.year, now.month, now.day);

      Duration difference = dateOnly.difference(nowOnly);

      if (difference.inDays == 0) {
        return 'اليوم';
      } else if (difference.inDays == -1) {
        return 'أمس';
      } else if (difference.inDays == 1) {
        return 'غداً';
      } else if (difference.inDays < 0) {
        return 'منذ ${difference.inDays.abs()} أيام';
      } else {
        return 'خلال ${difference.inDays} أيام';
      }
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
  }
}
