import 'package:flutter/material.dart';
import 'package:sultan_cab/models/vehicleDetail.dart';
import 'package:sultan_cab/services/catalogue_services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatefulWidget {
  final String imgUrl;
  // ignore: non_constant_identifier_names
  final String vehicle_id;

  const GalleryWidget(
      {Key? key,
      required this.imgUrl,
      // ignore: non_constant_identifier_names
      required this.vehicle_id})
      : super(key: key);
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  VehicleDetailModel? detail;
  List url = [];

  Future getDetails() async {
    detail = await BasicServices.getVehcileDetails();
    if (detail!.data!.images != null) {
      for (int i = 0; i < detail!.data!.images!.length; i++) {
        url.add(detail!.data!.images!.elementAt(i));
      }

      if (mounted) {
        setState(() {});
      }
    } else {
      if (detail!.data!.images == null) {
        url.add(widget.imgUrl);
      }
      if (mounted) {
        setState(() {});
      }

      return;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDetails();
  }

  PageController pageController = PageController(initialPage: 0);
  int indexSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            pageController: pageController,
            itemCount: url.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                imageProvider: NetworkImage(url[index]),
              );
            },
            onPageChanged: (index) {
              setState(() {
                indexSelect = index;
              });
            },
          ),
          Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${indexSelect + 1}/${url.length}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
