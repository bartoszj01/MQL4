//+------------------------------------------------------------------+
//|                                                        test2.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern int stoploss = 50;
extern int takeprofit = 50;
extern double lotsize = 0.1;

int ticketGlobal = 0;

void OnTick()
  {   
         
      if (OrdersTotal() == 0) {
         
         if (Close[3] > Close[2] && Close[2] > Close[1]) {
            int ticket = OrderSend(Symbol(), OP_SELL,lotsize, Ask,10,Bid + stoploss*Point,Bid - takeprofit*Point );
            ticketGlobal = ticket;
         } else if (Close[3] < Close[2] && Close[1] < Close[1]) {
            int ticket = OrderSend(Symbol(), OP_BUY,lotsize, Bid,10,Ask - stoploss*Point,Ask + takeprofit*Point );               
            ticketGlobal = ticket;
         }
      } else {
         Print("ticketGlobal: "+ticketGlobal);
         
         int ticket = OrderSelect(ticketGlobal, SELECT_BY_TICKET);
         Print("ticket: "+ticket);
         
         Print("TimeCurrent() "+TimeCurrent());
         
         Print("OrderOpenTime() +15 "+ (OrderOpenTime()+60));
         
         if (TimeCurrent() > OrderOpenTime() +60) {
            OrderClose(ticket,lotsize,OrderClosePrice(),0);
         }
         
      }  
  }