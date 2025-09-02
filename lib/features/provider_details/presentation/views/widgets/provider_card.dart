import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Row(
          children: [
            Container(
              width: 109,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr. Mohamed Ali", style: AppTextStyles.w600_16),
                SizedBox(
                  width: 197,
                  child: Divider(color: Colors.black, thickness: 1),
                ),
                Text(
                  "cardiologist",
                  style: AppTextStyles.w600_14.copyWith(
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 5),
                    Text("Mazzeh-Damascus-syria"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
