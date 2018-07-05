//+------------------------------------------------------------------+
//|                                              LargeDifference.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern int stoploss = 1000;
extern int takeprofit = 1000;
extern double lotsize = 0.1;

void OnTick(){
   if (OrdersTotal() == 0) {
      
      if ((Close[2] - Open[2]) > 400*Point && Close[1] > Open[1] ) {
         int ticket = OrderSend(Symbol(), OP_BUY,lotsize, Ask,10,Bid - stoploss*Point,Bid + takeprofit*Point ); 
      } else if ((Open[2]-Close[2] > 400*Point) && Open[1] > Close[1] )  {
         int ticket = OrderSend(Symbol(), OP_SELL,lotsize, Bid,10,Ask + stoploss*Point,Ask - takeprofit*Point );
      }
   }
}

