
class ProductFullDetails{

  String name;
  List<String> imageUrl;
  String currency;
  String description;
  double rating;
  String seller_ID;
  int ratingCount;
  double price;
  Seller seller;
  List<Reviews> listReview;
  List<String> tags;
  ProductFullDetails(this.name,this.imageUrl,this.currency,this.description,this.rating,this.seller_ID,this.ratingCount,this.price,this.seller,this.listReview,this.tags);

  factory ProductFullDetails.fromResults(Map<String, dynamic> result){


    List<String> imageUrl = List<String>();

    result['Images'].forEach((val) {
      imageUrl.add(val['url']);
    });


    Seller temp = Seller.fromResult(result['Seller']);
    ReviewList listReviews = ReviewList.fromResponse(result['reviews']);

    List<String> tag = List<String>();
    result['product_tags'].forEach((val){
        tag.add(val['tag']['tag']);
    });
    return ProductFullDetails(result['name'],imageUrl,result['currency'],result['description'],result['rating']+.0,result['seller_ID'],result['ratingCount'], result['price'] + .0,temp,listReviews.getReview(),tag);
  }
}


class Seller{

  String name;
  int rating_count;
  String seller_profile;
  double seller_rating;
  String ID;

  Seller(this.name,this.rating_count,this.seller_profile,this.seller_rating,this.ID);

  factory Seller.fromResult(Map<String, dynamic> result){
    return Seller(result['Name'],100,result['seller_profile'],result['seller_rating'],result['ID']);
  }

}

class Reviews {
  String profile_url;
  double rating;
  String review;
  String timestamp;
  String name;

  Reviews(this.profile_url,this.rating,this.review,this.timestamp,this.name);
}

class ReviewList{
  List<Reviews> review;

  ReviewList(this.review);


  factory ReviewList.fromResponse(List<dynamic> list){
    List<Reviews> temp = List<Reviews>();
    list.forEach((item) {
      if(item['profile_url'] == null){
        temp.add(Reviews("",item['rating']+.0,item['review'],item['timestamp'],item['name']));
      }else{
        temp.add(Reviews(item['profile_url'],item['rating']+.0,item['review'],item['timestamp'],item['name']));
      }

    });
    return ReviewList(temp);
  }

  List<Reviews> getReview(){
    return review;
  }
}
