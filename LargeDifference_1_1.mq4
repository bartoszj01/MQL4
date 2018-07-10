//+------------------------------------------------------------------+
//|                                              LargeDifference.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern int stoploss = 800;
extern int takeprofit = 2000;
extern double lotsize = 0.1;

void OnTick(){

   int count = 0;

   bool tradeOn = CheckOpenOrders();

   if (tradeOn == false) {
      
      if ((Close[2] - Open[2]) > 300*Point && Close[1] > Open[1] ) {
         int ticket = OrderSend(Symbol(), OP_BUY,lotsize, Ask,10,Bid - stoploss*Point,Bid + takeprofit*Point ); 
      } else if ((Open[2]-Close[2] > 300*Point) && Open[1] > Close[1] )  {
         int ticket = OrderSend(Symbol(), OP_SELL,lotsize, Bid,10,Ask + stoploss*Point,Ask - takeprofit*Point );
      }
   }
}

bool CheckOpenOrders() {
   
   for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      //We select the order of index i selecting by position and from the pool of market/pending trades
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      //If the pair of the order (OrderSymbol() is equal to the pair where the EA is running (Symbol()) then return true
      if( OrderSymbol() == Symbol() ) return(true);
   }
   return(false);
}

