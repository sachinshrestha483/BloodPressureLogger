import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/user_repository/src/user_repository.dart';
import 'package:mvp1/pages/readings/widgets/widgets.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:mvp1/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadingsPage extends StatelessWidget {
  const ReadingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserSpecificAppBar("Readings", context),
      body: Container(
          child: Column(
        children: [
          // Text("Providr in Hive:" +
          //     UserRepository.getSelectedProfile().toString()),
          // Consumer(builder: (context, watch, child) {
          //   final selectedProfile = watch(selectedProfileProvider).state;
          //   return Text("Value by Provider" + selectedProfile.toString());
          // }),
          // ElevatedButton(
          //     onPressed: () {
          //       context.read(selectedProfileProvider).state = 6;
          //       setSelectedProfleProvider(5, context);
          //     },
          //     child: Text("Change The Person")),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Pallete.BorderColor,
                  width: 1.0,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bp ",
                            style: AppTypography.PrimaryHeading,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer(
                        builder: (context, watch, child) {
                          final selectedProfileId =
                              watch(selectedProfileProvider).state;

                          return ValueListenableBuilder<Box<Bp>>(
                            valueListenable: BpRepository.GetBox().listenable(),
                            builder: (context, box, _) {
                              final readings = box.values
                                  .toList()
                                  .cast<Bp>()
                                  .where((element) =>
                                      element.userId == selectedProfileId)
                                  .toList();
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: readings.length >= 3
                                      ? 3
                                      : readings.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "❤️",
                                                  style:
                                                      TextStyle(fontSize: 45),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${readings[index].systolic}/${readings[index].diastolic} ",
                                                          style: TextStyle(
                                                              fontSize: 25),
                                                        ),
                                                        
                                                        Text(
                                                          "${ BpRepository.GetBpStatusDisplayString(BpRepository.GetBpStatus(readings[index]))    }",
                                                          style: TextStyle(
                                                              color:BpRepository.GetBpStatusColor(BpRepository.GetBpStatus(readings[index])),
                                                              fontSize: 22),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${readings[index].pulse}",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            " ${readings[index].readingDateTime.toLocal().day}/${readings[index].readingDateTime.toLocal().month}/${readings[index].readingDateTime.toLocal().year}, ${readings[index].readingDateTime.toLocal().hour}:${readings[index].readingDateTime.toLocal().minute} ",
                                                            style: TextStyle(
                                                                fontSize: 20)),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  ShowBpInfoBottomModalSheet(
                                                      context, readings[index]);
                                                },
                                                child:
                                                    Icon(Icons.chevron_right))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(
                                            color: Pallete.GrayTextColor,
                                            thickness: 2,
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          );
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child:
                              PrimaryButton(()=>{
                                    Navigator.of(context).pushNamed(
                                        '/newReadingPage',
                                        arguments: BpRepository.Get(null)),   
                              }, "ADD")
                              
                              ,
                            ),
                          ),
                          Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                            flex: 4,
                            child: 
                            
                            PrimaryButton((){
                                  Navigator.of(context).pushNamed(
                                            '/allReadingPage',
                                          );
                            }, "SEE ALL")
                            
                           
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
