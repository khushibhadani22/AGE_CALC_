import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  String birthDay = "";
  String birthMonth = "";
  String birthYear = "";

  String calculatedDay = "00";
  String calculatedMonth = "00";
  String calculatedYear = "00";

  String nextBirthDay = "00";
  String nextBirthMonth = "00";

  List<String> months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Agu',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<int> monthDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  TextStyle textStyle = const TextStyle(
      color: Color(
        0xff000000,
      ),
      fontWeight: FontWeight.w600,
      fontSize: 15);
  TextStyle titleStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  DateTime liveTime = DateTime.now();

  late int currentDay;
  late int currentMonth;
  late int currentYear;
  @override
  void initState() {
    super.initState();
    currentDay = liveTime.day;
    currentMonth = liveTime.month;
    currentYear = liveTime.year;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Age Calculator",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xffFFFFFF)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff203A43),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Today's Date",
                style: textStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  " $currentDay ${months[currentMonth - 1]},$currentYear",
                  style: const TextStyle(
                      color: Color(0xff1C003E),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Date Of Birth",
                style: textStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      birthDay = val;
                    },
                    controller: dateController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "DD"),
                  )),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      birthMonth = val;
                    },
                    controller: monthController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "MM"),
                  )),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (val) {
                        birthYear = val;
                      },
                      controller: yearController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "YYYY"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      dateController.clear();
                      monthController.clear();
                      yearController.clear();

                      birthYear = "";
                      birthMonth = "";
                      birthDay = "";

                      calculatedYear = "00";
                      calculatedMonth = "00";
                      calculatedDay = "00";
                      nextBirthDay = "00";
                      nextBirthMonth = "00";
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 3, color: const Color(0xff13547A)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                              color: Color(0xff13547A),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      birthDay = dateController.text;
                      birthMonth = monthController.text;
                      birthYear = yearController.text;

                      int tempDay = currentDay;
                      int tempMonth = currentMonth;
                      int tempYear = currentYear;

                      if (int.parse(birthDay) > currentDay) {
                        tempMonth--;
                        tempDay += monthDay[int.parse(birthMonth) - 1];
                        if (int.parse(birthMonth) == currentMonth) {
                          tempYear--;
                          tempMonth += 12;
                        }
                      }

                      if (int.parse(birthMonth) > currentMonth) {
                        tempYear--;
                        tempMonth += 12;
                      }

                      setState(() {
                        calculatedYear =
                            (tempYear - int.parse(birthYear)).toString();
                        calculatedMonth =
                            (tempMonth - int.parse(birthMonth)).toString();
                        calculatedDay =
                            (tempDay - int.parse(birthDay)).toString();

                        tempDay = int.parse(birthDay);
                        tempMonth = int.parse(birthMonth);

                        if (currentDay > int.parse(birthDay)) {
                          tempMonth--;
                          tempDay += monthDay[currentMonth - 1];
                          if (currentMonth == int.parse(birthMonth)) {
                            tempMonth += 12;
                          }
                        }

                        if (currentMonth > int.parse(birthMonth)) {
                          tempMonth += 12;
                        }
                        nextBirthMonth = (tempMonth - currentMonth).toString();
                        nextBirthDay = (tempDay - currentDay).toString();
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: const Color(0xff13547A),
                          border: Border.all(
                              width: 3, color: const Color(0xff13547A)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Present Age",
                style: textStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff13547A),
                          Color(0xff203A43),
                        ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(calculatedYear, style: titleStyle),
                        Text("Year", style: titleStyle),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(calculatedMonth, style: titleStyle),
                        Text("MM", style: titleStyle),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(calculatedDay, style: titleStyle),
                        Text("DD", style: titleStyle),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Next Birthday",
                style: textStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff6BBED9),
                          Color(0xff0D6ACB),
                        ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(nextBirthMonth, style: titleStyle),
                        Text("MM", style: titleStyle),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(nextBirthDay, style: titleStyle),
                        Text("DD", style: titleStyle),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
