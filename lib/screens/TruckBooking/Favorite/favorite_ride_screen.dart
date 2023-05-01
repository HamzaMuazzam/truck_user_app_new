import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/mode_selector.dart';
import 'package:sultan_cab/models/AddToFav/get_fav_drivers.dart';
import 'package:sultan_cab/providers/AddToFav/add_to_fav_controller.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

class FavoriteRideScreen extends StatefulWidget {
  const FavoriteRideScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteRideScreen> createState() => _FavoriteRideScreenState();
}

class _FavoriteRideScreenState extends State<FavoriteRideScreen> {
  late AddToFavourite addToFavourite;
  bool isFav = false;
  TextEditingController searchCtrl = TextEditingController();
  @override
  void initState() {
    addToFavourite = Provider.of<AddToFavourite>(context, listen: false);

    addToFavourite.getAllFavourite();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Driver"),
      ),
      body: Consumer<AddToFavourite>(
        builder: (BuildContext context, value, Widget? child) {
          return value.getFavDriverModel != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Search for New Driver",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: AppTextField(
                              label: "Search",
                              onChange: (v) {
                                searchCtrl.text = v;
                                setState(() {});
                              },
                              suffix: null,
                              isVisibilty: true,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.getFavDriverModel?.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = value.getFavDriverModel?.data?[index];

                            if (searchCtrl.text.isEmpty) {
                              return item(data!);
                            } else if (data!.driver!.name!.toString().contains(searchCtrl.text)) {
                              return item(data);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.black),
                );
        },
      ),
    );
  }

  Widget item(Datum data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.driver?.name ?? "",
                        style: TextStyle(color: Colors.green),
                      ),
                      // onlineStatus(data.isOnline),
                      SizedBox(height: 10),
                      Text(
                        data.driver?.mobileNumber ?? "",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              optionButton(
                isFav: true,
                onRemove: () async {
                  await addToFavProv.removeFromFavourite(data.id);
                  await addToFavourite.getAllFavourite();
                },
                onRequest: () async {
                  Get.to(() => ModeSelectorScreen());
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionButton({
    required bool isFav,
    required VoidCallback onRequest,
    required VoidCallback onRemove,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// Request
        if (isFav)
          GestureDetector(
            onTap: onRequest,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
                  ],
                  border: Border.all(width: 1.5, color: Colors.green),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Request",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ),

        /// remove
        if (isFav)
          GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
                  ],
                  border: Border.all(width: 1.5, color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

        /// add to fav
        // if (!isFav)
        //   GestureDetector(
        //     onTap: onAdd,
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
        //           ],
        //           border: Border.all(width: 1.5, color: Colors.green),
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        //         child: Text(
        //           "Add to Favorite",
        //           style: TextStyle(color: Colors.green),
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget onlineStatus(bool online) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: online ? Colors.green : Colors.red,
        ),
        SizedBox(width: 5),
        Text(
          online ? "online" : "offline",
          style: TextStyle(color: online ? Colors.green : Colors.red),
        ),
      ],
    );
  }
}

class DriverData {
  final String name;
  final String vechile;
  final bool isOnline;
  final bool isFav;
  DriverData(this.name, this.vechile, this.isFav, this.isOnline);
}
