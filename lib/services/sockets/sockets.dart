import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/services/apiServices/StorageServices/get_storage.dart';
import 'package:sultan_cab/utils/commons.dart';

class AppSockets {
  static Socket? socket;

  static initSockets() {
    if (socket != null) {
      socket!.disconnect();
    }
    print(StorageCRUD.getUser().id.toString() + "USER ID");
    socket = io('http://taxicab.techhivedemo.xyz:8009',
        OptionBuilder().setTransports(['websocket']).enableAutoConnect().build());

    socket!.onConnect((data) {
      logger.wtf("SOCKET CONNECTED: ${socket!.id}");
    });

    socket!.connect();

    if (socket != null) {
      onFunctionsAll();
    }
  }

  static void onFunctionsAll() {
    onReceivingBids();
    onRideStart();
    onDriverArrival();
    onRideEnd();
    onReceivingMsg();
    onRideCancel();
  }

  static void onReceivingMsg() async {
    AppSockets.socket!.on('ON_NEW_MESSAGE/${StorageCRUD.getUser().id}', (data) async {
      logger.wtf(data);

      await chatProvider.getAllMessages(data['requestId']);
    });
  }

  static void onReceivingBids() async {
    TruckBookingProvider taxiBookingProvider =
        Provider.of<TruckBookingProvider>(Get.context!, listen: false);
    AppSockets.socket!.on(
      "ON_NEW_BID_RECEIVED/${StorageCRUD.getUser().id}",
      (data) async {
        logger.wtf(data);
        taxiBookingProvider.receiveBiddingData(data);
      },
    );
  }

  static void onRideStart() async {
    AppSockets.socket!.on(
      "RIDE_STARTED/${StorageCRUD.getUser().id}",
      (data) async {
        taxiBookingProvider.getStartRideData(data);
        taxiBookingProvider.biddingList = [];
        taxiBookingProvider.changeRideStage(RideStage.RideStarted);
        logger.wtf(data);
      },
    );
  }

  static void onDriverArrival() async {
    TruckBookingProvider taxiBookingProvider =
        Provider.of<TruckBookingProvider>(Get.context!, listen: false);
    AppSockets.socket!.on(
      "DRIVER_ARRIVED/${StorageCRUD.getUser().id}",
      (data) async {
        logger.wtf(data);
        taxiBookingProvider.onDriverArrival(data);
      },
    );
  }

  static void onRideCancel() async {
    TruckBookingProvider taxiBookingProvider =
        Provider.of<TruckBookingProvider>(Get.context!, listen: false);
    AppSockets.socket!.on(
      "RIDE_CANCELLED/${StorageCRUD.getUser().id}",
      (data) async {
        logger.wtf(data);
        taxiBookingProvider.onRideCancel(data);
      },
    );
  }

  static void onRideEnd() async {
    TruckBookingProvider taxiBookingProvider =
        Provider.of<TruckBookingProvider>(Get.context!, listen: false);
    AppSockets.socket!.on(
      "RIDE_ENDED/${StorageCRUD.getUser().id}",
      (data) async {
        logger.wtf(data);

        taxiBookingProvider.onRideEnd(data);
      },
    );
  }

  static void trackDriver({required String rideId}) {
    socket!.on(
      "BOOKED_RIDE/$rideId",
      (data) async {
        taxiBookingProvider.showDriverOnMap(data);
      },
    );
  }
}
