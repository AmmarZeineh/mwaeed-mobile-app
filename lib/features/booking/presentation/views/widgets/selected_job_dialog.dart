
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/job_model.dart';

class JobSelectionDialog extends StatelessWidget {
  final List<Job> jobs;

  const JobSelectionDialog({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر المهنة"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return ListTile(
              title: Text(job.jobName),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context, job);
              },
            );
          },
        ),
      ),
    );
  }
}
