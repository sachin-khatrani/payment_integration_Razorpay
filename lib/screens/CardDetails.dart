import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paymentgateway/models/Products.dart';
import 'package:paymentgateway/widget/CustomDialog.dart';
import 'package:paymentgateway/widget/popup.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class CartDetails extends StatefulWidget {

  final ProductFullDetails productFullDetails;

  CartDetails({this.productFullDetails});
  @override
  _CartDetailsState createState() => _CartDetailsState();
}


class _CartDetailsState extends State<CartDetails> {

  int counter = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String fullname = "John Doe";
  String mobileNumber = "6325963215";
  String address = "Kamrej";
  String city = "Surat";
  String state = "Gujrat";
  String pincode  = "362563";
  Razorpay razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,_handleExternalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }
  void increament(){

    if(counter < 10){
      setState(() {
        counter++;
      });
    }else{
      FlutterToast.showToast(
          msg: 'You Can not Buy More then 10 items', timeInSecForIosWeb: 4);
    }
  }

  void deacrement(){
    if(counter > 1){
      setState(() {
        counter--;
      });
    }else{
      FlutterToast.showToast(
          msg: 'You Can not Buy less then 1 items', timeInSecForIosWeb: 4);
    }
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Payment Successful",
        transectionId: response.orderId,
        total: widget.productFullDetails.price*counter,
        buttonText: "Okay",
      ),
    );

  }

  void _handlePaymentError(PaymentFailureResponse response) {

    print(response.message);
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Payment Failed",
        total: widget.productFullDetails.price*counter,
        buttonText: "Okay",
      ),
    );

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    FlutterToast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  void despose(){
    super.dispose();
    razorpay.clear();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'CheckOut',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow[400],
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              try {
                Navigator.pop(context); //close the popup
              } catch (e) {}
            },
          );
        },),
      ),

      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: size.height - 60,
              child: Column(
                children: <Widget>[

                  Card(

                    child: Container(
                        margin: EdgeInsets.only(left:14.0,right: 14,top: 8),
                        width: size.width,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border(
                              left: const BorderSide(color: Colors.grey, width: 2),
                              right: const BorderSide(color: Colors.grey, width: 2),
                              bottom: const BorderSide(color: Colors.grey, width: 2),
                              top: const BorderSide(color: Colors.grey, width: 2),
                            )
                        ),

                        child: Row(
                          children: <Widget>[
                            Container(
                              width: size.width/4,
                              height: 120,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border(
                                    left: const BorderSide(color: Colors.black, width: 2),
                                    right: const BorderSide(color: Colors.black, width: 2),
                                    bottom: const BorderSide(color: Colors.black, width: 2),
                                    top: const BorderSide(color: Colors.black, width: 2),
                                  )
                              ),

                              child: Image(

                                image: widget.productFullDetails.imageUrl[0] == "" ? NetworkImage('https://iaaglobal.org/storage/bulk_images/no-image.png'):NetworkImage('${widget.productFullDetails.imageUrl[0]}'),
                              ),
                            ),

                            Container(
                              width: 3*size.width/4 - 40,
                              height: 120,
                              padding: EdgeInsets.only(left: 8,top: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),

                                  color: Colors.white
                              ),
                              child: Column(
                                children: <Widget>[

                                  Text(
                                    '${widget.productFullDetails.name}\n',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Rs.${widget.productFullDetails.price}/Pcs',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),

                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        width:30,
                                        height: 30,
                                        child: new FloatingActionButton(
                                          onPressed: deacrement,
                                          child: new Icon(Icons.remove, color: Colors.black,size: 20),
                                          backgroundColor: Colors.white,
                                          heroTag: 'dec',
                                        ),
                                      ),

                                      new Text(' $counter ',
                                          style: new TextStyle(fontSize: 20.0)),

                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        width:30,
                                        height: 30,
                                        child: new FloatingActionButton(
                                          onPressed: increament,
                                          child: new Icon(Icons.add,color: Colors.black,size: 20,),
                                          heroTag: 'add',
                                          backgroundColor: Colors.white,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),


                          ],

                        )

                    ),
                  ),

                  Divider(indent:20,endIndent:20,color: Colors.grey,thickness: 2,),

                  Card(
                    child: Container(
                      margin: EdgeInsets.only(left:14.0,right: 14,top: 8),
                      width: size.width,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            left: const BorderSide(color: Colors.grey, width: 2),
                            right: const BorderSide(color: Colors.grey, width: 2),
                            bottom: const BorderSide(color: Colors.grey, width: 2),
                            top: const BorderSide(color: Colors.grey, width: 2),
                          )
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top:8.0,left: 5),
                            child: Text(
                              'Summary',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                              textAlign: TextAlign.start ,
                            ),
                          ),

                          Padding(

                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(

                              children: <Widget>[

                                Container(
                                  width: size.width-130,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${widget.productFullDetails.name}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Spacer(),

                                Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Rs.${widget.productFullDetails.price * counter}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(

                            padding: EdgeInsets.only(top: 5.0,left: 10,bottom: 5),
                            child: Text(
                                'Quantity: $counter'
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  Divider(indent:20,endIndent:20,color: Colors.grey,thickness: 2,),

                  Card(
                      child:Container(
                        margin: EdgeInsets.only(left:14.0,right: 14,top: 8),
                        width: size.width,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border(
                              left: const BorderSide(color: Colors.grey, width: 2),
                              right: const BorderSide(color: Colors.grey, width: 2),
                              bottom: const BorderSide(color: Colors.grey, width: 2),
                              top: const BorderSide(color: Colors.grey, width: 2),
                            )
                        ),
                        child: Row(
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(top: 5.0,left: 10),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),
                              ),
                            ),

                            Spacer(),

                            Container(
                              padding: EdgeInsets.only(top:5,right: 5,bottom: 5),
                              child: Text(
                                'Rs.${widget.productFullDetails.price * counter}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ),

                  Divider(indent:20,endIndent:20,color: Colors.grey,thickness: 2,),

                  Card(
                    child: Container(
                      margin: EdgeInsets.only(left:14.0,right: 14,top: 8),
                      width: size.width,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            left: const BorderSide(color: Colors.grey, width: 2),
                            right: const BorderSide(color: Colors.grey, width: 2),
                            bottom: const BorderSide(color: Colors.grey, width: 2),
                            top: const BorderSide(color: Colors.grey, width: 2),
                          )
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Shipping',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                  textAlign: TextAlign.start ,
                                ),
                              ),

                              Spacer(),

                              Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: IconButton(

                                  icon: Icon(Icons.edit,color: Colors.black,),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      PopupLayout(
                                        top: 30,
                                        left: 30,
                                        right: 30,
                                        bottom: 50,
                                        child: PopupContent(
                                          content: Scaffold(
                                            appBar: AppBar(
                                              title: Text("Edit",style: TextStyle(color: Colors.black),),
                                              brightness: Brightness.light,
                                              centerTitle: true,
                                              backgroundColor: Colors.yellow[300],
                                              leading: Builder(builder: (context) {
                                                return IconButton(
                                                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                                                  onPressed: () {
                                                    try {
                                                      Navigator.pop(context); //close the popup
                                                    } catch (e) {}
                                                  },
                                                );
                                              },),
                                            ),
                                            resizeToAvoidBottomPadding: false,
                                            body: _popupBody(),
                                          ),
                                        ),
                                      ),
                                    );


                                  },
                                ),
                              )
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 5,left: 10),
                            child: Text(
                              '$fullname',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 3,left: 10),
                            child: Text(
                                '$mobileNumber'
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 3,left: 10),
                            child: Text(
                                '$address'
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 3,left: 10),
                            child: Text(
                                '$city'
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 3,left: 10),
                            child: Text(
                                '$state'
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3,left: 10,bottom: 5),
                            child: Text(
                                '$pincode'
                            ),
                          )


                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Positioned(
            top: size.height - 135,
            child: Container(
              width: size.width,
              height: 60,
              padding: EdgeInsets.only(left: 10,top: 6),
              color: Colors.limeAccent[400],
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Rs.${widget.productFullDetails.price*counter }',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star,color: Colors.red,size: 20,),
                          SizedBox(width: 2,),
                          Text(
                            '${widget.productFullDetails.rating}(${widget.productFullDetails.ratingCount})',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),

                  Container(

                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      color: Colors.yellow[600],
                      child: Text(
                          'PAY'
                      ),
                      onPressed: (){
                        print(widget.productFullDetails.price*counter*100);
                        try {
                        razorpay.open({
                          'key': 'rzp_test_SCrh1S96HJHwFe',
                          'amount': widget.productFullDetails.price*counter*100,
                          'currency':widget.productFullDetails.currency,
                          'name': widget.productFullDetails.name,
                          'description': widget.productFullDetails.name,
                          'prefill': {'contact': mobileNumber, 'email': 'test@razorpay.com'},
                          'external': {
                          'wallets': ['paytm']
                          }
                        }
                        );

                        } catch (e) {
                          debugPrint(e);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _popupBody() {
    return Container(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your first and last name',
                labelText: 'Full Name',
              ),
              validator: (value){
                if(value == "" || value == null){
                  return 'Please Enter Your Full Name';
                }

              },
              onSaved: (value){
                  fullname = value;
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'Enter your Mobile Number',
                labelText: 'Mobile Number',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              validator: (value){
                if(value == "" || value == null || value.length != 10){
                  return 'Please Enter Your Number';
                }

              },
              onSaved: (value){
                mobileNumber = value;
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.place),
                hintText: 'Enter a address',
                labelText: 'Address',
              ),
              keyboardType: TextInputType.text,
              validator: (value){
                if(value == "" || value == null){
                  return 'Please Enter Your Address';
                }

              },
              onSaved: (value){
                address = value;
              },
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.location_city),
                hintText: 'Enter a City',
                labelText: 'City',
              ),
              keyboardType: TextInputType.text,
              validator: (value){
                if(value == "" || value == null){
                  return 'Please Enter Your City';
                }

              },
              onSaved: (value){
                city = value;
              },
            ),

            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.place),
                hintText: 'Enter a State',
                labelText: 'State',
              ),
              keyboardType: TextInputType.text,
              validator: (value){
                if(value == "" || value == null){
                  return 'Please Enter Your State';
                }

              },
              onSaved: (value){
                state = value;
              },
            ),

            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.pin_drop),
                hintText: 'Enter a Pincode',
                labelText: 'Pincode',
              ),
              keyboardType: TextInputType.number,
              validator: (value){
                if(value == "" || value == null){
                  return 'Please Enter Your Pincode';
                }

              },
              onSaved: (value){
                pincode = value;
              },
            ),


            new Container(
              width: 40,
                height: 40,

                margin:const EdgeInsets.only( top: 40.0),
                child: new RaisedButton(
                  color: Colors.yellow[400],
                  child: const Text('Submit'),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                        _formKey.currentState.save();

                        setState(() {

                        });
                        Navigator.pop(context);
                     }
                  },
                )),
          ],
        ),
      )
    );
  }
}
