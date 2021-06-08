import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/models/product.dart';

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

  Future updateMerchantData(String merchantName, String email,
      String phoneNumber, String address, String profilePictureUrl) async {
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
      String productDeliveryFee,
      String uid,
      String productName,
      String productPrice,
      String onlineOrderLocation,
      String productImageUrl,
      String storeNumber) async {
    return await productCollection.add({
      "productStoreLocation": productStoreLocation,
      "productStoreName": productStoreName,
      "productDeliveryFee": productDeliveryFee,
      "uid": uid,
      "productName": productName,
      "productPrice": productPrice,
      "onlineOrderLocation": onlineOrderLocation,
      "productImageUrl": productImageUrl,
      "searchKey": productName[0].toUpperCase(),
      "productStoreNumber": storeNumber
    });
  }

  Future updateMerchantData2(String merchantName, String email,
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
        productImageUrl: doc.data()["productImageUrl"] ??
            "https://firebasestorage.googleapis.com/v0/b/loketa-project.appspot.com/o/default_Product_image.png?alt=media&token=24d3be4b-14cc-447c-aaf3-899db733afa3",
        documentId: doc.id,
        productDeliveryFee: doc.data()["productDeliveryFee"] ?? "",
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
        productImageUrl: doc["productImageUrl"] ??
            "https://firebasestorage.googleapis.com/v0/b/loketa-project.appspot.com/o/default_Product_image.png?alt=media&token=24d3be4b-14cc-447c-aaf3-899db733afa3",
        productDeliveryFee: doc["productDeliveryFee"] ?? "",
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
