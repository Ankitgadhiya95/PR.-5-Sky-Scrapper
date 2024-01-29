part of 'screens.dart';

class LocationScreen extends StatefulWidget {
  final Weather weatherData;

  LocationScreen({required this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherController weatherController = WeatherController();
  late Weather weather;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(Weather weatherData) {
    setState(() {
      weather = weatherData;
    });
  }

  String _selectedValue = '1';

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.location_searching),
          onPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoadingScreen(
                  fromPage: 'location',
                  cityName: '',
                ),
              ),
            );
          },
        ),
        title: Text(
          weather.city,
          style: kLocationTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.heart),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              List<String> list = [];
              setState(() {
                if (pref.getStringList('locationList') != null) {
                  list = pref.getStringList('locationList')!;
                }
                list.add(weather.city);
              });

              pref.setStringList('locationList', list);
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CityScreen(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _selectedValue = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: '1',
                child: ListTile(
                  onTap: () {
                    setState(() {
                      darkTheme.setDarkTheme = darkTheme.isDarkMethod;
                    });
                  },
                  leading: Icon(Icons.wb_sunny_outlined),
                  title: Text("Theme"),
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LikeScreen(),
                    ),
                  );
                },
                value: '2',
                child: Text('Save Location'),
              ),
            ],
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: WeatherContent(
                  weatherImage: weatherController.getWeatherImage(
                    weather.condition as int,
                  ),
                  temperature: weather.temperature,
                  wind: weather.wind,
                  humidity: weather.humidity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
