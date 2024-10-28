import 'package:flutter/material.dart';

void main() {
  runApp(FutbalnetApp());
}

class FutbalnetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futbalové Zákulisie',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> leagues = [
    {"name": "VIII. liga - ObFZ TO + NR", "date": "27.10.2024"},
    {"name": "VII. liga - ObFZ TO", "date": "20.10.2024"},
  ];

  List<Map<String, String>> filteredLeagues = [];

  @override
  void initState() {
    super.initState();
    filteredLeagues = leagues; 
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        String formattedDate = "${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}";
        filteredLeagues = leagues.where((league) => league['date'] == formattedDate).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Futbalnet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ), 
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: filteredLeagues.isNotEmpty
            ? ListView.builder(
                itemCount: filteredLeagues.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        filteredLeagues[index]['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Dátum: ${filteredLeagues[index]['date']}"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LeagueDetailScreen(
                              leagueName: filteredLeagues[index]['name']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            : Center(child: Text('Žiadne zápasy pre vybraný dátum')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Zápasy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Ligy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Obľúbené',
          ),
        ],
      ),
    );
  }
}

class LeagueDetailScreen extends StatelessWidget {
  final String leagueName;

  LeagueDetailScreen({required this.leagueName});

  final List<Map<String, String>> matches = [
    {"team1": "FK Orešany", "team2": "TJ Koniarovce", "score": "3:1"},
    {"team1": "OFK Kuzmice", "team2": "TJ - ŠK Radošina", "score": "0:1"},
    {"team1": "Šalgovce", "team2": "Oponice", "score": "5:1"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(leagueName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  "${matches[index]['team1']} vs ${matches[index]['team2']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Výsledok: ${matches[index]['score']}"),
                trailing: Icon(Icons.sports_soccer),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailScreen(
                        team1: matches[index]['team1']!,
                        team2: matches[index]['team2']!,
                        score: matches[index]['score']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class MatchDetailScreen extends StatelessWidget {
  final String team1;
  final String team2;
  final String score;

  MatchDetailScreen({required this.team1, required this.team2, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$team1 vs $team2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$team1 vs $team2",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Výsledok: $score",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
