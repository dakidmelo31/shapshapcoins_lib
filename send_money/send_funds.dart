// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../history_model.dart';
import '../send_money_model.dart';
import 'qr_code_scanner.dart';

class SendFunds extends StatefulWidget {
    static const routeName = "/sendFunds";

    const SendFunds({Key? key}) : super(key: key);

    @override
    _SendFundsState createState() => _SendFundsState();
}

class _SendFundsState extends State<SendFunds> {
    int switchUsage = 0;
    Widget _Usage = SendMoneyForm();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        switchUsage = 0;
        _Usage = SendMoneyForm();
    }
    void _changeView() {
        setState(() {
            _Usage = SendMoneyForm();

            _Usage = AnimatedSwitcher(
                switchInCurve: Curves.easeInOutQuad,
                switchOutCurve: Curves.easeInOut,
                duration: Duration(milliseconds: 1000),
                child: _Usage,
            );

        });
    }

    @override
    Widget build(BuildContext context) {
        double deviceHeight= MediaQuery.of(context).size.height;
        Color themeColor = const Color.fromRGBO(47, 27, 86, 1);
        return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: CustomScrollView(
                slivers: [
                    SliverAppBar(
                        actions: [
                            IconButton(onPressed: (){
                                Navigator.pushNamed(context, MyHome.routeName);
                            }, icon: const Icon(Icons.qr_code))
                        ],
                        backgroundColor: themeColor,
                        pinned: true,
                        floating: true,
                        elevation: 20,
                        expandedHeight: 130,
                        shadowColor: themeColor.withOpacity(0.7),
                        flexibleSpace: FlexibleSpaceBar(
                            background: Opacity(
                                opacity: 0.25,
                                child: Image.asset("assets/curves.png", fit: BoxFit.contain, width: 60, alignment: Alignment.topRight,),
                            ),
                            title: const  Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Add recipient", style: TextStyle(fontSize: 20),),
                            ),
                            titlePadding: const  EdgeInsets.only(left: 20, bottom: 20),

                        ),
                    ),
                    SliverList(delegate: SliverChildListDelegate(
                        [
                            const SizedBox(
                                height: 25,
                            ),
                            Container(
                                margin: const  EdgeInsets.symmetric(horizontal: 8),
                                width: MediaQuery.of(context).size.width - 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow:[
                                        BoxShadow(
                                            color: themeColor.withOpacity(0.5),
                                            spreadRadius: 10,
                                            blurRadius: 10,
                                        ),
                                    ]
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        const SizedBox(
                                            height: 10,
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.all(15),
                                        ),
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                const Padding(
                                                    padding: EdgeInsets.only(left: 15),
                                                    child: Text("Recent Contacts", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),),
                                                ),

                                                Padding(
                                                    padding: const  EdgeInsets.only(right: 15),
                                                    child:IconButton(
                                                        icon:  const Icon(Icons.person_add_alt, size: 20, color: Colors.grey,),
                                                        onPressed: (){},
                                                        splashColor: Colors.purple,
                                                        focusColor: Colors.purple,
                                                        highlightColor: Colors.purple,
                                                    ),
                                                ),
                                            ],
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: SizedBox(
                                                    height: 100,
                                                    child: FutureBuilder<List<HistoryItem>>(
                                                        future: DatabaseHelper.instance.allHistory(),
                                                        builder: (BuildContext context, AsyncSnapshot<List<HistoryItem>> snapshot) {
                                                            if(!snapshot.hasData){
                                                                return Center(child: Padding(
                                                                    padding: EdgeInsets.only(top: 108),
                                                                    child: Lottie.asset("assets/search2.json",  height: 350, fit: BoxFit.contain,),
                                                                ),);
                                                            }
                                                            else{
                                                                return snapshot.data!.isEmpty? Center( child: Padding(
                                                                    padding: EdgeInsets.only(top: 108),
                                                                    child:  ListView(
                                                                        scrollDirection: Axis.horizontal,
                                                                        shrinkWrap: false,
                                                                        children: [
                                                                            Text("No transactions yet", style: TextStyle(color: Colors.grey.withOpacity(0.7))),
                                                                            Lottie.asset("assets/nothing1.json", height: 350, fit: BoxFit.contain,),

                                                                        ],
                                                                    ),
                                                                ),) :
                                                                ListView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    shrinkWrap: true,
                                                                    children: snapshot.data!.map((tx) {

                                                                        var transactionTime = DateFormat().add_yMMMMEEEEd().format(DateTime.now());
                                                                        return
                                                                            Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                    Card(
                                                                                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                        elevation: 20,
                                                                                        shadowColor: Colors.black12,
                                                                                        child: InkWell(
                                                                                            onTap: (){
                                                                                            },
                                                                                            child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                children: [
                                                                                                    Padding(
                                                                                                        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
                                                                                                        child: ClipOval(
                                                                                                            child: Hero(
                                                                                                                tag: "hero",
                                                                                                                child: Image.asset(tx.avatar, width: 40, height: 40, fit: BoxFit.cover,),
                                                                                                            ),
                                                                                                        ),
                                                                                                    ),
                                                                                                    Column(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                                        children: [
                                                                                                            Text(
                                                                                                                tx.name.length > 8? tx.name.substring(0, tx.name.indexOf(" ")) : tx.name,
                                                                                                                style: const TextStyle(
                                                                                                                    color: Colors.black,
                                                                                                                    fontWeight: FontWeight.w400,
                                                                                                                    fontSize: 12,
                                                                                                                )
                                                                                                            ),
                                                                                                        ],
                                                                                                    ),
                                                                                                ],
                                                                                            ),
                                                                                        ),
                                                                                    ),
                                                                                ],
                                                                            );
                                                                    }).toList(),
                                                                );
                                                            }
                                                        },
                                                    )
                                                ),
                                            ),
                                        ),
                                        const SendMoneyForm(),

                                        const SizedBox(
                                            height: 100,
                                        )

                                    ],

                                ),
                            ),
                        ]
                    ))
                ],
            ),
        );
    }
}
