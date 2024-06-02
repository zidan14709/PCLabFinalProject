import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:portfolio/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  List<Weather> _forecast = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather("Dhaka");
    _fetchWeatherForecast("Dhaka");
  }

  void _fetchWeather(String location) {
    _wf.currentWeatherByCityName(location).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  void _fetchWeatherForecast(String location) {
    _wf.fiveDayForecastByCityName(location).then((forecast) {
      setState(() {
        _forecast = forecast;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 186, 131, 131), Colors.blueGrey.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null || _forecast.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          _searchLocation(),
          _dateTimeInfo(),
          _weatherIcon(),
          _currentTemp(),
          _extraInfo(),
          _weatherForecast(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        _weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _searchLocation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search location...',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color.fromARGB(255, 250, 255, 100)),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: const Color.fromARGB(255, 100, 115, 255)),
            onPressed: () {
              String searchLocation = _searchController.text.trim();
              if (searchLocation.isNotEmpty) {
                _fetchWeather(searchLocation);
                _fetchWeatherForecast(searchLocation);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
            color: Color.fromARGB(255, 100, 134, 255),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 100, 162, 255),
              ),
            ),
            Text(
              "  ${DateFormat("d.M.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Color.fromARGB(255, 100, 159, 255),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 198, 89, 89).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _weatherForecast() {
    List<Weather> nextSevenDaysForecast = _forecast.take(7).toList();
    List<DateTime> nextSevenDays = [];
    List<Weather> uniqueForecast = [];

    for (Weather forecastItem in nextSevenDaysForecast) {
      DateTime date = forecastItem.date!;
      if (!nextSevenDays.contains(date) && uniqueForecast.length < 7) {
        nextSevenDays.add(date);
        uniqueForecast.add(forecastItem);
      }
    }

    return Column(
      children: [
       
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: uniqueForecast.length,
          itemBuilder: (context, index) {
            Weather forecastItem = uniqueForecast[index];
            return ListTile(
              title: Text(
                DateFormat("EEEE").format(forecastItem.date!),
                style: TextStyle(
                  color: const Color.fromARGB(255, 100, 141, 255),
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Max: ${forecastItem.tempMax?.celsius?.toStringAsFixed(0)}°C, "
                "Min: ${forecastItem.tempMin?.celsius?.toStringAsFixed(0)}°C",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
