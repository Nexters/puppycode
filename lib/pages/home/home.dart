import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppycode/apis/models/user.dart';
import 'package:puppycode/apis/models/weather.dart';
import 'package:puppycode/pages/onboarding/register.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/image.dart';
import 'package:puppycode/shared/styles/button.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:puppycode/shared/states/user.dart';

bool isToday(DateTime date) {
  DateTime today = DateTime.now();

  return date.year == today.year &&
      date.month == today.month &&
      date.day == today.day;
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeTitle(user: controller.user.value),
            const SizedBox(height: 40),
            Expanded(
                child: HomeContent(
              user: controller.user.value,
            )),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    this.user,
  });

  final User? user;

  Future getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      Get.toNamed('/create', arguments: {
        'photoPath': pickedFile.path,
        'from': 'home',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Center(
        child: Head3(
          value: '오늘의 데이터를 가져오고 있어요!',
          color: ThemeColor.gray3,
        ),
      );
    }

    final hasWalkDone = user!.walkDone == true;

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SharedNetworkImage(
            url: user?.mainScreenImageUrl ?? 'assets/images/empty',
            width: 292,
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            height: 56,
            bottom: 32,
            child: DefaultTextButton(
                disabled: hasWalkDone,
                text: '',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/paw_small.svg',
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            hasWalkDone ? ThemeColor.gray4 : ThemeColor.gray6,
                            BlendMode.srcIn)),
                    const SizedBox(width: 6),
                    Body1(
                      value: hasWalkDone ? '오늘도 산책 완료!' : '오늘 산책 인증하기',
                      bold: true,
                      color: hasWalkDone ? ThemeColor.gray4 : ThemeColor.gray6,
                    )
                  ],
                ),
                onPressed: () {
                  if (hasWalkDone) return;
                  getImage(ImageSource.camera);
                }))
      ],
    );
  }
}

class WeatherGuide extends StatefulWidget {
  final String city;
  const WeatherGuide({
    required this.city,
    super.key,
  });

  @override
  State<WeatherGuide> createState() => _WeatherGuideState();
}

class _WeatherGuideState extends State<WeatherGuide> {
  late int temp = 0;
  late String weather = '';
  late LOCATION? locationKey = widget.city.toLocation();
  static const storage = FlutterSecureStorage();

  Future<void> _fetchWeather(location) async {
    try {
      try {
        final savedWeatherString = await storage.read(key: 'weather') ?? '';
        if (savedWeatherString.isNotEmpty) {
          // ignore: no_leading_underscores_for_local_identifiers
          final [_temp, _weather, _location, _savedDate] =
              savedWeatherString.split(';');
          final savedDate = DateTime.parse(_savedDate);
          if (_location == widget.city && isToday(savedDate)) {
            setState(() {
              temp = int.parse(_temp);
              weather = _weather;
            });
            return;
          } else {
            storage.delete(key: 'weather');
          }
        }
      } catch (e) {
        storage.delete(key: 'weather');
      }

      final weatherItem =
          await HttpService.getOne('weather', params: {'city': location});

      Weather weatherData = Weather(weatherItem);
      storage.write(
          key: 'weather',
          value: [
            weatherData.temp,
            weatherData.weather,
            widget.city,
            DateTime.now().toString()
          ].join(';'));

      setState(() {
        temp = weatherData.temp;
        weather = weatherData.weather;
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  @override
  void initState() {
    _fetchWeather(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (weather.isEmpty) return Container();

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: ThemeColor.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ThemeColor.gray2)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: weather.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SvgPicture.asset(
                        'assets/icons/weather_${weather.toLowerCase()}.svg',
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Body2(
                    value: '나갈 때 물통을 챙겨주세요💦',
                    bold: true,
                    color: ThemeColor.gray5),
                Body4(
                  value: '${locationNames[locationKey]} $temp℃',
                  color: ThemeColor.gray4,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    super.key,
    this.user,
  });

  final User? user;

  int calculateHoursUntilMidnight() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1);
    return midnight.difference(now).inHours;
  }

  String _generateTitle(bool walkDone) {
    if (walkDone) {
      if (DateTime.now().minute / 2 == 0) return '산책 어렵지 않아요! 오.산.완 🙌';
      return '역시 오늘도 산책했군요 😎';
    }
    int remainHours = calculateHoursUntilMidnight();
    if (remainHours == 0) return '끝날 때까지 끝난 게 아니에요 💪';
    return remainHours < 6
        ? '$remainHours시간 남았어요! 얼른 나가요 🐾'
        : '오늘도 산책하러 나갈 거죠? 🥹';
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return Container();
    final city = user!.location;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Head2(value: _generateTitle(user!.walkDone)),
        const SizedBox(height: 12),
        WeatherGuide(city: city),
      ],
    );
  }
}
