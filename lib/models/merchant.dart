class Merchant {
  final String uid;

  Merchant({this.uid});
}

class MerchantData {
  final String uid;
  final String merchantName;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePictureUrl;

  MerchantData(
      {this.uid,
      this.merchantName,
      this.email,
      this.phoneNumber,
      this.address,
      this.profilePictureUrl});
}
