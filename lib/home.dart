import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/hexcolors.dart';


class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage = 0;
  int _personCount = 1;
  double _billAmount = 0.0;

  Color _purple = HexColor('#6908D6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin:EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1 ) ,
        alignment: Alignment.center,
        color: Colors.white10,
        child: ListView(
          scrollDirection:Axis.vertical ,
          padding: EdgeInsets.all(20),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color:_purple.withOpacity(0.2),
                //Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total per person',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: _purple
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('\$ ${calculateTotalPerson(_billAmount,_personCount,_tipPercentage)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: _purple
                      ),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: _purple
                    ),
                    decoration: InputDecoration(
                      prefixText:'Bill Amount ',
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);
                      }catch(exception){
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Split',style: TextStyle(
                        color: Colors.grey.shade700,
                      ),),
                      Row(
                        children: [
                          InkWell(
                            onTap:(){
                              setState(() {
                                if(_personCount > 1){
                                  _personCount --;
                                }else{
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.2)
                              ),
                              child: Center(
                                child: Text("-",
                                style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                                ),),
                              ),
                            ),
                          ),
                          Text('$_personCount',style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCount++;
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.2)
                              ),
                              child: Center(
                                child: Text("+",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0
                                  ),),
                              ),

                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip',
                        style: TextStyle(
                            color: Colors.grey.shade700
                        ),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\$ ${(calculateTotalTip(_billAmount, _personCount, _tipPercentage)).toStringAsFixed(2)}',style: TextStyle(
                          color: _purple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: [
                      Text("$_tipPercentage%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: _purple
                      ),),
                      Slider(
                        min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey.shade400,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue){
                        setState(() {

                          _tipPercentage = newValue.round();

                        });
                          })
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ) ,
    );
  }
  calculateTotalPerson( double billAmount,int splitBy, int tipPercentage ){
      var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
      return totalPerPerson.toStringAsFixed(2);
  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercenatge){
    double totalTip = 0.0;

    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){
      //nothing to do
    }else{
      totalTip = (billAmount * tipPercenatge) / 100;
    }
    return totalTip;
  }
}
