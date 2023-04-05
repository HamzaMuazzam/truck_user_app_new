import 'package:flutter/material.dart';
import 'package:sultan_cab/models/vehicleDetail.dart';
import 'package:sultan_cab/services/catalogue_services.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/cachedImage.dart';

class SwipeCar extends StatefulWidget {
  final String vehicleId;
  final String imgUrl;
  final bool isBorder;
  const SwipeCar({
    Key? key,
    required this.imgUrl,
    required this.vehicleId,
    this.isBorder = true,
  }) : super(key: key);

  @override
  _SwipeCarState createState() => _SwipeCarState();
}

class _SwipeCarState extends State<SwipeCar> {
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

  @override
  void initState() {
    super.initState();
  }

  PageController pageController = PageController(initialPage: 0);
  int indexSelect = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      height: h * 140,
      alignment: Alignment.center,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(vertical: h * 10),
      margin: EdgeInsets.symmetric(horizontal: widget.isBorder ? b * 15 : 0),
      decoration: widget.isBorder
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(b * 4),
              border: Border.all(
                color: Color(0xfff2f2f2),
              ),
            )
          : BoxDecoration(),
      child: PageView.builder(
        controller: pageController,
        itemCount: url.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: widget.vehicleId.toString(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: b * 10),
              child: CachedImage(
                imgUrl: url[index],
                height: h * 1200,
                width: SizeConfig.screenWidth,
                vehicleId: widget.vehicleId.toString(),
              ),
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            indexSelect = index;
          });
        },
      ),
    );
  }
}
