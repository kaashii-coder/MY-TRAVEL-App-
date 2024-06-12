import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';

class JourneyChecklistPage extends StatefulWidget {
  const JourneyChecklistPage({super.key});

  @override
  State<JourneyChecklistPage> createState() => _JourneyChecklistPageState();
}

class _JourneyChecklistPageState extends State<JourneyChecklistPage> {
  List<bool> ischecked = List.generate(2, (_) => false); // Initialize list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Checklist',
                  hintText: 'eg:Tickets, passport, Any items'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ischecked.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    key: ValueKey(index), // Add unique key
                    leading: Checkbox(
                      value: ischecked[index],
                      onChanged: (value) {
                        print('Checkbox $index changed to $value');
                        setState(() {
                          ischecked[index] = value!;
                        });
                      }
                    ),
                    title: CustomText(text: 'example $index'), // Can replace with Text widget for testing
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
