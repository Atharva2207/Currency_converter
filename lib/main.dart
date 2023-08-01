import 'package:flutter/material.dart';
import 'package:async_await/services/api_client.dart';
import 'package:async_await/widgets/drop_down.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 21, 139, 213)),
        useMaterial3: true,
      ),
      home: const Homepage(),
      
    );
  }
}
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //first we need to create an instance fothe AAPI Client
  ApiClient client = ApiClient();
  // Setting the main colour
  Color mainColor = Color.fromARGB(255, 22, 28, 48);
  Color secondcolor = Color.fromARGB(255, 63, 89, 219);
  // Setting the Variables
   List<String>currencies = []; 
    String from = '';
    String to = '';

//varible for exchange rate
late double rate;
String result = "";
//let's make a function to call the api
Future<List<String>> getCurrencyList() async{
  return await client.getCurrencies();
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (()async {
      List<String> list = await getCurrencyList();
      setState(() {
        currencies =list;
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Text("Currency Converter",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              Expanded(child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      onSubmitted: (value) async {
                        //let's make the function to get exchange the rate
                        rate = await client.getRate(from,to);
                        setState(() {
                          result = (rate * double.parse(value)).toStringAsFixed(3);
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Input value to convert",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                          color: secondcolor,
                        )
                      ),
                      style:   TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customDropDown(currencies, from, (val) {
                          setState(() {
                            from = val;
                            
                          });
                        }),
                        FloatingActionButton(
                          onPressed: () {
                            String temp = from;
                            setState(() {
                              from = to;
                              to = temp;
                            });
                          },
                        child : Icon(Icons.swap_horiz),
                        elevation: 0.0,
                        backgroundColor: secondcolor,
                     ),
                         customDropDown(currencies, to, (val) {
                          setState(() {
                            from = val;
                          });
                        }),
                      ],
                    ),
                    SizedBox(
                      height:50.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Text("Result", style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,

                          ),),
                          Text(result,style: TextStyle(
                            color: secondcolor,
                            fontSize: 36,
                            fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    )

                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
