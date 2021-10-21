import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/pages/charts/view/charts_page.dart';
import 'package:mvp1/pages/readings/readings.dart';
import 'package:mvp1/pages/statistics/view/statistics_page.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/buttons.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvp1/widgets/widgets.dart';

class AllReadingsPage extends StatefulWidget {
  const AllReadingsPage({Key? key}) : super(key: key);

  @override
  State<AllReadingsPage> createState() => _AllReadingsPageState();
}

class _AllReadingsPageState extends State<AllReadingsPage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserSpecificAppBar("All Readings", context),
  
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.LightGreen,
        onPressed: () {
          var bp = BpRepository.Get(null);

          Navigator.of(context).pushNamed('/newReadingPage', arguments: bp);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                BuildSafeText("Bp", AppTypography.PrimaryHeading),
                Consumer(builder: (context, watch, child) {
                  final selectedProfileId =
                      watch(selectedProfileProvider).state;

                  return ValueListenableBuilder<Box<Bp>>(
                      valueListenable: BpRepository.GetBox().listenable(),
                      builder: (context, box, _) {
                        return Text(
                          " (${BpRepository.GetBox().values.where((element) => element.userId == selectedProfileId).toList().length}) ",
                          style: AppTypography.PrimaryText,
                          textAlign: TextAlign.left,
                        );
                      });
                }),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Consumer(
              builder: (context, watch, child) {
                final selectedProfileId = watch(selectedProfileProvider).state;

                return Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      ValueListenableBuilder<Box<Bp>>(
                        valueListenable: BpRepository.GetBox().listenable(),
                        builder: (context, box, _) {
                          final readings = box.values
                              .toList()
                              .cast<Bp>()
                              .where((element) =>
                                  element.userId == selectedProfileId)
                              .toList();
                          return SizedBox(
                            height: 450,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: readings.length,
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
                                                style: TextStyle(fontSize: 45),
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
                                                        "${BpRepository.GetBpStatusDisplayString(BpRepository.GetBpStatus(readings[index]))}",
                                                        style: TextStyle(
                                                            color: BpRepository
                                                                .GetBpStatusColor(
                                                                    BpRepository
                                                                        .GetBpStatus(
                                                                            readings[index])),
                                                            fontSize: 22),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "${readings[index].pulse}",
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                                              child: Icon(Icons.chevron_right))
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
                                }),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
