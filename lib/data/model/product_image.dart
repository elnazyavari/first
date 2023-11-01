class Productimage {
  String? imgUrl;
  String? productId;

  Productimage(this.imgUrl, this.productId);

  factory Productimage.fromMapJson(Map<String, dynamic> jsonObject) {
    return Productimage(
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
      jsonObject['product_id'],
    );
  }
}
