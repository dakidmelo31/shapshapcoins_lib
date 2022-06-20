import 'dart:ui';
import 'package:shapshapcoins/send_money/sent_successfully.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slider_button/slider_button.dart';
import 'package:vibration/vibration.dart';

class EnterAmount extends StatefulWidget {
    static const routeName = "/enterAmountToSend";
    const EnterAmount({Key? key}) : super(key: key);

    @override
    _EnterAmountState createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
    String currentAmount = "0";
    String currentCommission = "0";
    int realBalance = 901;
    int balance = 901;
    Color errorColor = Colors.white;
    int temp = 0;


    calculateAmount(String amount){
        setState(() {
            if(amount == "-"){
                if(currentAmount.length <= 1){
                    currentAmount = "0"
                        "";
                }
                else{
                    currentAmount = currentAmount.substring(0, currentAmount.length - 1);
                    print(currentAmount);
                }

            }
            else{
                if(currentAmount == "0.0" || currentAmount == "0"){
                    currentAmount = "0";
                }


                if(currentAmount.length >= 7){
                    print("reduce it?? $currentAmount");
                }
                else{
                    if(currentAmount == "0"){
                        currentAmount = amount;
                    }
                    else{
                        currentAmount += amount;
                    }
                    print("keep typing $currentAmount");

                    if(currentAmount.length > 2){
                        currentCommission = "5";
                    }
                }

            }

            balance  = realBalance - int.parse(currentAmount);
            balance < 0? errorColor = Colors.red : errorColor = Colors.white;
            currentAmount.length >=3? currentCommission = "5" : currentCommission = "0";
        });
    }
    String userNumber = "";
    getNumber() async{
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final prefs = await _prefs;
        setState(() {
            userNumber = prefs.getInt("recipient")!.toString();
            List<String> segments = [];
            segments.add(userNumber.substring(0, 3));
            segments.add(userNumber.substring(3, 6));
            segments.add(userNumber.substring(6, 9));
            userNumber = "+237 " + segments[0] + " - " + segments[1] + " - " + segments[2];
        });
    }
    makePayment( int amount) async{
        Future<SharedPreferences> _myPrefs = SharedPreferences.getInstance();
        final prefs = await _myPrefs;
        prefs.setInt("amount_to_send", amount);
        prefs.setInt("transactionFee", int.parse(currentCommission));
        prefs.setString("recipientName", "Juliana Pam");
        prefs.setString("transactionID", "AASDKLFE33239343");
        setState(() {
            Navigator.pushNamed(context, SentSuccessfully.routeName);
        });

    }

    Color themeColor =  const Color.fromRGBO(47, 27, 86, 1);
    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        getNumber();
    }
    @override
    Widget build(BuildContext context) {
        const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
        );

        double deviceHeight = MediaQuery.of(context).size.height;
        double deviceWidth  = MediaQuery.of(context).size.width;
        TextStyle numberStyle = const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w200);
        return Material(
            child: Container(
                width: deviceWidth,
                height: deviceHeight,
                decoration: const  BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/gradient3.png"
                        ),
                        fit: BoxFit.cover
                    ),


                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 29,
                        sigmaY: 29
                    ),
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            SizedBox(
                                height: 80,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        IconButton(onPressed: (){
                                            Navigator.pop(context);
                                        }, icon: const Icon(Icons.arrow_back), color: Colors.white,),
                                        const Padding(
                                            padding: EdgeInsets.only(bottom: 15),
                                            child:  Text("Transferring", style: TextStyle(color: Colors.white, fontSize: 18),),
                                        ),
                                        Text(
                                            "$balance F", style: TextStyle( color: errorColor, fontSize: 22),
                                        ),
                                    ],
                                ),
                            ),
                            ClipOval(
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration:const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("assets/people9.jpg"),
                                            fit: BoxFit.cover,
                                        ),
                                    ),
                                ),
                            ),
                            const SizedBox(
                                height: 15,
                            ),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    const Text("Juliana Pam", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
                                    const SizedBox(
                                        height: 5,
                                    ),
                                    Text("$userNumber", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),),
                                    const SizedBox(
                                        height: 25,
                                    ),
                                    Container(
                                        width: deviceWidth - 20,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1, color: Colors.white,
                                                )
                                            )
                                        ),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                        Text(" $currentAmount F", style:  const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: 8),),
                                                        Text(" Commission: $currentCommission F", style: const  TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 8),),
                                                    ],
                                                ),
                                            ],
                                        ),
                                    ),
                                    const SizedBox(
                                        height: 5,
                                    ),
                                    SliderButton(
                                        height: 60,
                                        radius: 0,
                                        width: double.infinity,
                                        alignLabel: Alignment.center,
                                        dismissible: false,
                                        action: (){
                                            if(int.parse(currentAmount) <= realBalance){
                                                makePayment(int.parse( currentAmount ));
                                            }
                                            else{
                                                print("Cannot Confirm payment since we have a negative balance");
                                            }
                                        },
                                        dismissThresholds: 0.7,
                                        icon: const Icon(Icons.arrow_right_alt_sharp, size: 32, color: Colors.black,),
                                        highlightedColor: Colors.amber,
                                        backgroundColor:  Colors.white.withOpacity(0.3),
                                        baseColor: Colors.white,
                                        shimmer: true,
                                        vibrationFlag: true,
                                        buttonColor: Colors.white,
                                        label: const Text("Slide to Send"),
                                        boxShadow: const BoxShadow(
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            color: Colors.white
                                        ),
                                    ),
                                    const SizedBox(
                                        height: 40,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: deviceWidth,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("1");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("1", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("2");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("2", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("3");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("3", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),

                                    const SizedBox(
                                        height: 40,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: deviceWidth,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("4");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("4", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("5");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("5", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("6");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("6", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                    const SizedBox(
                                        height: 40,
                                    ),
                                    SizedBox(
                                        height: 30,
                                        width: deviceWidth,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("7");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("7", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("8");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("8", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("9");
                                                        },
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                                child: Text("9", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),

                                    const SizedBox(
                                        height: 40,
                                    ),
                                    SizedBox(
                                        height: 60,
                                        width: deviceWidth,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: TextButton(
                                                            onPressed: (){},
                                                            child: const Icon(Icons.check, color: Colors.blue),
                                                        ),
                                                    )
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("0");
                                                        },
                                                        child: SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child: Center(
                                                                child: Text("0", style: numberStyle,),
                                                            ),
                                                        ),
                                                    ),
                                                ),

                                                Flexible(
                                                    fit: FlexFit.loose,
                                                    child: TextButton(
                                                        onPressed: (){
                                                            calculateAmount("-");
                                                        },
                                                        child: const SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child: Center(
                                                                child: Icon(Icons.backspace, color: Colors.red,),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
