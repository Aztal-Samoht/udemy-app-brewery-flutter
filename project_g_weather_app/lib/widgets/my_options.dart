import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/widgets/status_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:clima/widgets/my_options.dart';

class Options extends StatelessWidget {
  Options(
      {this.requestPermission,
      this.updateStatus,
      this.toggle,
      this.printWeather1});
  final Function requestPermission;
  final Function updateStatus;
  final Function toggle;
  final Function printWeather1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusText(
              enabled: Location.getLocationIsEnabled(),
              permission: Location.getPermission(),
              debug: Location.getDebugmode()),
          TextButton(
            child: Text('request permission'),
            onPressed: requestPermission,
          ),
          TextButton(
            child: Text('update status'),
            onPressed: updateStatus,
          ),
          TextButton(
            child: Text('Get Location'),
            onPressed: () {
              Location.printPossition();
            },
          ),
          TextButton(
            child: Text('toggle debug'),
            onPressed: toggle,
          ),
          TextButton(
              child: Text('print London Weather'), onPressed: printWeather1)
        ],
      ),
    );
  }
}
