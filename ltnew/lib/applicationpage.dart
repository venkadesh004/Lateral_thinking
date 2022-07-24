import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:ltnew/childrenspage.dart';

class ApplicationPageNew extends StatefulWidget {
  const ApplicationPageNew({ Key? key, required this.name, required this.time, required this.imageName }) : super(key: key);

  final String name;
  final String time;
  final String imageName;

  @override
  State<ApplicationPageNew> createState() => _ApplicationPageNewState();
}

class _ApplicationPageNewState extends State<ApplicationPageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: Color.fromRGBO(0, 87, 255, 1),
        elevation: 0,
        centerTitle: true,
      ),
      body: ApplicationContainer(name: widget.name, imageName: widget.imageName, time: widget.time),
    );
  }
}

class ApplicationContainer extends StatelessWidget {
  ApplicationContainer({
    Key? key,
    required this.name,
    required this.imageName,
    required this.time
  }) : super(key: key);

  final String name;
  final String imageName;
  final String time;

  final List<Feature> features = [
    Feature(
      title: "Game timing",
      color: Colors.green,
      data: [0.2, 0.8, 0.4, 0.7, 0.6],
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 87, 255, 1),
            Color.fromRGBO(17, 203,	247, 1)
          ]
        )
      ),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/'+imageName+'.png')
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "Todays Usage",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Past Usages",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35
                  ),
                ),
              ),
              Container(
                height: 300,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                margin: EdgeInsets.only(top: 30),
                child: LineGraph(
                  features: features,
                  size: Size(320, 400),
                  labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
                  labelY: ['15Min', '35Min', '50Min', '1Hr', '1.5Hr'],
                  graphColor: Colors.white,
                  graphOpacity: 0.2,
                  verticalFeatureDirection: true,
                ),
              ),
            ],
          ),
          ]
        ),
      ),
    );
  }
}