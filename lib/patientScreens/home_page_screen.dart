import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/model/doctor.dart';
import 'package:flutter_health_care_app/model/doctor_model.dart';
import 'package:flutter_health_care_app/model/data.dart';
import 'package:flutter_health_care_app/theme/light_color.dart';
import 'package:flutter_health_care_app/theme/text_styles.dart';
import 'package:flutter_health_care_app/theme/extention.dart';
import 'package:hive_flutter/adapters.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  List<DoctorModel> doctorDataList;
  @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Top Doctors", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {})
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          getdoctorWidgetList(),
        ],
      ),
    );
  }

  Widget getdoctorWidgetList() {
    return Column(
        children: doctorDataList.map((x) {
      return _doctorTile(x);
    }).toList());
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.asset(
                model.image,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Text(
            model.location,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(
        () {
          Navigator.pushNamed(context, "/DetailPage", arguments: model);
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  Widget _doctorData() {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Doctor>('doctorBox').listenable(),
        builder: (context, Box<Doctor> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("Empty Doctor content"),
            );
          } else {
            return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  Doctor currentDoctor = box.getAt(index);
                  return Container(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage("assets/doctorPic.png"),
                        radius: 50,
                      ),
                      title: Text(currentDoctor.name),
                      subtitle: Column(
                        children: [
                          Text(currentDoctor.type),
                          Text(currentDoctor.location),
                          Text(currentDoctor.description)
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to ROAM"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          _doctorsList(),
          // _doctorData(),
        ],
      ),
    );
  }
}
