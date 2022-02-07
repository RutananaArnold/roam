import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/model/doctor.dart';
import 'package:flutter_health_care_app/widgets/palette.dart';
import 'package:hive_flutter/adapters.dart';

class Uploads extends StatefulWidget {
  const Uploads({Key key}) : super(key: key);

  @override
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "Uploaded Doctor",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
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
                        trailing: IconButton(
                            onPressed: () async {
                              await box.deleteAt(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
