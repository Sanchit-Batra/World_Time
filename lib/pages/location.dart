import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_time/services/timezones.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List match_countries = [];
  void updateTime(index) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    WorldTime some = match_countries[index];
    await some.getTime();
    Navigator.pop(context, {
      "time": some.time,
      "location": some.location,
      "date": some.date,
      "isday": some.isDay,
      "url": some.url
    });
  }
  @override
  void initState() {
    match_countries = allCountries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Timezone"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              onChanged: (input) {
                List results = [];
                if (input.isEmpty == true) {
                  match_countries = allCountries;
                } else {
                  results = allCountries
                      .where((worlder) => worlder.location.toString().trim()
                          .toLowerCase()
                          .startsWith(input.toLowerCase()))
                      .toList();
                  setState(() {
                    match_countries = results;
                  });
                }
              },
            ),
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: match_countries.isNotEmpty
                    ? match_countries.length
                    : match_countries.length + 1,
                itemBuilder: (context, index) {
                  return match_countries.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              updateTime(index);
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200)),
                                    color: Colors.blue),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      match_countries[index].location,
                                      style: const TextStyle(fontSize: 30),
                                    ))),
                          ),
                        )
                      : const Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(fontSize: 24),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }
}
