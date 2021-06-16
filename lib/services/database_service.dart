import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/shared/constants.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // Create Firestore instance
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Collection reference
  final CollectionReference merchantCollection =
      FirebaseFirestore.instance.collection("Merchants");

  // Collection for products
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("Products");

  Future deleteProduct(String docId) async {
    return await productCollection.doc(docId).delete();
  }

  Future addMerchantData(String merchantName, String email, String phoneNumber,
      String address, String profilePictureUrl) async {
    return await merchantCollection.doc(uid).set({
      "merchantName": merchantName,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
      "profilePictureUrl": profilePictureUrl
    });
  }

  Future updateProductCatalogue(
      String productStoreLocation,
      String productStoreName,
      String uid,
      String productName,
      String productPrice,
      String productImageUrl1,
      String productImageUrl2,
      String productImageUrl3,
      String productState,
      String storeNumber) async {
    return await productCollection.add({
      "productStoreLocation": productStoreLocation,
      "productStoreName": productStoreName,
      "uid": uid,
      "productName": productName,
      "productPrice": productPrice,
      "productImageUrl1": productImageUrl1,
      "productImageUrl2": productImageUrl2,
      "productImageUrl3": productImageUrl3,
      "searchKey": productName[0].toUpperCase(),
      "productState": productState,
      "productStoreNumber": storeNumber
    });
  }

  Future updateMerchantData(String merchantName, String email,
      String phoneNumber, String address) async {
    return await merchantCollection.doc(uid).update({
      "merchantName": merchantName,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
    });
  }

  Future updateProfilePictureUrl(String profilePictureUrl) async {
    return await merchantCollection
        .doc(uid)
        .update({"profilePictureUrl": profilePictureUrl});
  }

  // Get merchant data from snapshot
  MerchantData _merchantDataFromSnapshot(DocumentSnapshot snapshot) {
    return MerchantData(
        uid: uid,
        merchantName: snapshot.data()["merchantName"],
        email: snapshot.data()["email"],
        phoneNumber: snapshot.data()["phoneNumber"],
        address: snapshot.data()["address"],
        profilePictureUrl: snapshot.data()["profilePictureUrl"]);
  }

  // Get Merchant Data stream
  Stream<MerchantData> get merchantData {
    return merchantCollection
        .doc(uid)
        .snapshots()
        .map(_merchantDataFromSnapshot);
  }

  // Get product list from snapshot
  List<Product> productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        uid: doc.data()["uid"] ?? "",
        productName: doc.data()["productName"] ?? "",
        productPrice: doc.data()["productPrice"] ?? "",
        onlineOrderLocation: doc.data()["onlineOrderLocation"] ?? "",
        productImageUrl1: doc.data()["productImageUrl1"] ?? defaultUrl,
        productImageUrl2: doc.data()["productImageUrl2"] ?? defaultUrl,
        productImageUrl3: doc.data()["productImageUrl3"] ?? defaultUrl,
        documentId: doc.id,
        productState: doc.data()["productState"] ?? "",
        productStoreName: doc.data()["productStoreName"] ?? "",
        productStoreLocation: doc.data()["productStoreLocation"] ?? "",
        searchKey: doc.data()["searchKey"] ?? "",
        productStoreNumber: doc.data()["productStoreNumber"] ?? "",
      );
    }).toList();
  }

  Product productListFromDocument(doc) {
    return Product(
        uid: doc["uid"] ?? "",
        productName: doc["productName"] ?? "",
        productPrice: doc["productPrice"] ?? "",
        onlineOrderLocation: doc["onlineOrderLocation"] ?? "",
        productImageUrl1: doc["productImageUrl1"] ?? defaultUrl,
        productImageUrl2: doc["productImageUrl2"] ?? defaultUrl,
        productImageUrl3: doc["productImageUrl1"] ?? defaultUrl,
        productState: doc["productState"] ?? "",
        productStoreName: doc["productStoreName"] ?? "",
        productStoreLocation: doc["productStoreLocation"] ?? "",
        searchKey: doc["searchKey"] ?? "",
        productStoreNumber: doc["productStoreNumber"] ?? "");
  }

  // Get product stream
  Stream<List<Product>> get products {
    return productCollection.snapshots().map(productListFromSnapshot);
  }

  Future searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
