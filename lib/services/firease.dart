import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/car.dart';

const carCollectionName = "car";
const trackerCollectionName = "tracker";

final carsRef =
    FirebaseFirestore.instance.collection(carCollectionName).withConverter<Car>(
          fromFirestore: (snapshots, _) =>
              Car.fromJson(snapshots.data()!, snapshots.id),
          toFirestore: (car, _) => car.toJson(),
        );

final trackerRef = FirebaseFirestore.instance.collection(trackerCollectionName);
