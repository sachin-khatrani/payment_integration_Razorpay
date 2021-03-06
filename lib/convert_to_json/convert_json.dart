import 'package:paymentgateway/models/Products.dart';

class ConvertJson{

  static Map<String,dynamic> map = {
    "data": {
      "product": [
        {
          "name": "Muscleblaze Beginner's Whey Protein Supplement",
          "description": "The Muscleblaze Beginner's Whey Protein Supplement is a perfect choice for the beginners. The protein powder comes with 40% protein mixture. Apart from this, it has 5.5g of EAAs and 2.6g of BCAA. So for beginners, this protein powder is good to go.  Also, the product is free from any banned substance. So beginners can try it easily. If you are a beginner, I would suggest going for only one scoop.  The best time to have it? Morning nourishment would make the day better at any time. But remember that this Protein Supplement is good for the beginners.  So if you are looking for bigger muscles, I suggest you get a better Protein Supplement.",
          "currency": "INR",
          "price": 1899,
          "rating": 1.9,
          "ratingCount": 100,
          "Images": [
            {
              "url": "https://res.cloudinary.com/djisilfwk/image/upload/v1593330185/Training/products/muscleblaze1_c69hj4.jpg"
            },
            {
              "url": "https://res.cloudinary.com/djisilfwk/image/upload/v1593330186/Training/products/muscleblazw_xttfsr.jpg"
            },
            {
              "url": "https://res.cloudinary.com/djisilfwk/image/upload/v1593330185/Training/products/muscleblaze2_ebepqd.jpg"
            }
          ],
          "reviews": [
            {
              "name": "Vijay Nath",
              "profile_url": "https://res.cloudinary.com/djisilfwk/image/upload/v1593327380/Training/seller_profile/46_mnz89r.jpg",
              "review": "Best Brand for Proteins",
              "rating": 4.5
            },
            {
              "name": "Dina Nath",
              "profile_url": "https://res.cloudinary.com/djisilfwk/image/upload/v1593327380/Training/seller_profile/97_lmutha.jpg",
              "review": "Good enough",
              "rating": 4
            },
            {
              "name": "Dina Nath",
              "profile_url": "https://res.cloudinary.com/djisilfwk/image/upload/v1593327380/Training/seller_profile/97_lmutha.jpg",
              "review": "Good enough",
              "rating": 4
            }
          ],
          "product_tags": [
            {
              "tag": {
                "tag": "Healthy"
              }
            },
            {
              "tag": {
                "tag": "Gym Products"
              }
            }
          ],
          "Seller": {
            "Name": "Singhal Manufactures",
            "ID": "dfe2d0a0-aed6-4109-93cf-b3470b98219c",
            "seller_rating": 2.3,
            "seller_profile": "https://res.cloudinary.com/djisilfwk/image/upload/v1593327380/Training/seller_profile/97_lmutha.jpg"
          }
        }
      ]
    }
  };


  ProductFullDetails getProduct(){
    ProductFullDetails productDetails = ProductFullDetails.fromResults(map["data"]['product'][0]);
    return productDetails;
  }

}