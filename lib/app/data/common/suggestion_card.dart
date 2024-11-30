import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/models/suggestion.dart';
import 'package:timeago/timeago.dart' as timeago;

class SuggestionCard extends StatelessWidget {
  final Suggestion suggestion;

  SuggestionCard({
    required this.suggestion
  });

  @override
  Widget build(BuildContext context) {
    // Set status color based on status value
    Color statusColor = suggestion.status == 'Opened' ? Colors.green : Colors.redAccent;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  suggestion.title!.length > 20 ?suggestion.title!.substring(0,20): suggestion.title!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Status with color
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    suggestion.status!,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            // Created At - Time Ago
            Text(
              " ${timeago.format(DateTime.parse(suggestion.createAt!))}",
              // 
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

