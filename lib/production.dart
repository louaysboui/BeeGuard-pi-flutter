/*import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class ProductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(180, 255, 235, 59),
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade700,
          title: const Text(
            'Honey Production',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<List<HoneyProduction>>(
                  future: _getProductionData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HoneyProductionChart(
                        key: UniqueKey(), // Add a unique key here
                        seriesList: [
                          charts.Series<HoneyProduction, DateTime>(
                            id: 'HoneyProduction',
                            colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                                const Color.fromARGB(255, 255, 59, 59)),
                            domainFn: (HoneyProduction production, _) =>
                                production.date,
                            measureFn: (HoneyProduction production, _) =>
                                production.production,
                            data: snapshot.data!,
                            // Add this block to display values in the chart
                            labelAccessorFn: (HoneyProduction production, _) =>
                                '${production.production}',
                            // Add this block to display values in the chart
                            insideLabelStyleAccessorFn:
                                (HoneyProduction production, _) =>
                                    const charts.TextStyleSpec(
                              color: charts.MaterialPalette.black,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 253, 253, 253),
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonTextStyle:
                      const TextStyle().copyWith(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                focusedDay: DateTime(2024, 2, 3),
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2024, 12, 31),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<HoneyProduction>> _getProductionData() async {
    final DatabaseReference _databaseReference =
        FirebaseDatabase.instance.reference().child('poids');

    try {
      Completer<List<HoneyProduction>> completer =
          Completer<List<HoneyProduction>>();

      _databaseReference.orderByKey().limitToLast(5).onValue.listen((event) {
        DataSnapshot dataSnapshot = event.snapshot;

        if (dataSnapshot.value != null) {
          Map<dynamic, dynamic> values =
              dataSnapshot.value as Map<dynamic, dynamic>;

          List<HoneyProduction> productionData = [];
          values.forEach((key, value) {
            try {
              DateTime date = DateTime.parse(key);
              double production = double.parse(value.toString());
              productionData.add(HoneyProduction(date, production));
            } catch (e) {
              print("Error parsing date: $e");
            }
          });

          completer.complete(productionData);
        } else {
          completer.complete([]);
        }
      });

      return completer.future;
    } catch (error) {
      print("Error retrieving production data: $error");
      return [];
    }
  }
}

class HoneyProduction {
  final DateTime date;
  final double production;

  HoneyProduction(this.date, this.production);
}

class HoneyProductionChart extends StatelessWidget {
  final List<charts.Series<HoneyProduction, DateTime>> seriesList;

  // Named constructor
  const HoneyProductionChart({
    required Key key,
    required this.seriesList,
  }) : super(key: key);

  // Factory method for sample data
  factory HoneyProductionChart.withSampleData(
      List<HoneyProduction> productionData) {
    // Sort the production data by date in ascending order
    productionData.sort((a, b) => a.date.compareTo(b.date));

    // Split the production data into last five and the rest
    List<HoneyProduction> lastFive =
        productionData.sublist(productionData.length - 5);
    List<HoneyProduction> rest =
        productionData.sublist(0, productionData.length - 5);

    return HoneyProductionChart(
      key: UniqueKey(), // Add a unique key here
      seriesList: [
        charts.Series<HoneyProduction, DateTime>(
          id: 'LastFiveProduction',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Colors.red), // Color the last five entries red
          domainFn: (HoneyProduction production, _) => production.date,
          measureFn: (HoneyProduction production, _) => production.production,
          data: lastFive,
          labelAccessorFn: (HoneyProduction production, _) =>
              '${production.production}',
          insideLabelStyleAccessorFn: (HoneyProduction production, _) =>
              const charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
        ),
        charts.Series<HoneyProduction, DateTime>(
          id: 'RestProduction',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              const Color.fromARGB(255, 255, 59, 59)),
          domainFn: (HoneyProduction production, _) => production.date,
          measureFn: (HoneyProduction production, _) => production.production,
          data: rest,
          labelAccessorFn: (HoneyProduction production, _) =>
              '${production.production}',
          insideLabelStyleAccessorFn: (HoneyProduction production, _) =>
              const charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: const EdgeInsets.all(4.0),
          entryTextStyle: const charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:table_calendar/table_calendar.dart';

class ProductionPage extends StatelessWidget {
  const ProductionPage({super.key});

  //const ProductionPage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(180, 255, 235, 59),
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade700,
          title: const Text(
            'Honey Production',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: HoneyProductionChart.withSampleData(),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 253, 253, 253),
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonTextStyle:
                      const TextStyle().copyWith(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                focusedDay: DateTime(2024, 2, 3),
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2024, 12, 31),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoneyProduction {
  final DateTime date;
  final int production;

  HoneyProduction(this.date, this.production);
}

class HoneyProductionChart extends StatelessWidget {
  final List<charts.Series<HoneyProduction, DateTime>> seriesList;

  const HoneyProductionChart({required Key key, required this.seriesList})
      : super(key: key);

  factory HoneyProductionChart.withSampleData() {
    return HoneyProductionChart(
      key: UniqueKey(), // Add a unique key here
      seriesList: [
        charts.Series<HoneyProduction, DateTime>(
          id: 'HoneyProduction',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              const Color.fromARGB(255, 255, 59, 59)),
          domainFn: (HoneyProduction production, _) => production.date,
          measureFn: (HoneyProduction production, _) => production.production,
          data: [
            HoneyProduction(DateTime(2024, 2, 1), 10),
            HoneyProduction(DateTime(2024, 2, 2), 20),
            HoneyProduction(DateTime(2024, 2, 3), 15),
            HoneyProduction(DateTime(2024, 2, 4), 30),
            HoneyProduction(DateTime(2024, 2, 5), 25),
            HoneyProduction(DateTime(2024, 2, 6), 40),
            HoneyProduction(DateTime(2024, 2, 7), 35),
          ],
          // Add this block to display values in the chart
          labelAccessorFn: (HoneyProduction production, _) =>
              '${production.production}',
          // Add this block to display values in the chart
          insideLabelStyleAccessorFn: (HoneyProduction production, _) =>
              const charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      //key: key, // Pass the key to the TimeSeriesChart widget
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: const EdgeInsets.all(4.0),
          entryTextStyle: const charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
