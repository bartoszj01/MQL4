//+------------------------------------------------------------------+
//|                                                        test2.mq4 |
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

int ticketGlobal = 0;

void OnTick() {   
         
      if (OrdersTotal() == 0) {
         
         if (Close[3] > Close[2] && Close[2] > Close[1]) {
            int ticket = OrderSend(Symbol(), OP_SELL,lotsize, Bid,10,Ask + stoploss*Point,Ask - takeprofit*Point );
            ticketGlobal = ticket;
         } else if (Close[3] < Close[2] && Close[2] < Close[1]) {
            int ticket = OrderSend(Symbol(), OP_BUY,lotsize, Ask,10,Bid - stoploss*Point,Bid + takeprofit*Point );               
            ticketGlobal = ticket;
         }
      } else {
         
         int ticket = OrderSelect(OrdersTotal() - 1,SELECT_BY_POS);
         Print("Ticket found: "+ ticket);
         if (OrderProfit() > 200 && OrderType() == 1) {
            bool res = OrderModify(ticket,0, OrderStopLoss() - 200, OrderProfit(),0);
         } else if (OrderProfit() > 200 && OrderType() == 0) {
            bool res = OrderModify(ticket,0, OrderStopLoss() + 200, OrderProfit(),0);
         } else if (OrderProfit() > 800 && OrderType() == 1) {
            bool res = OrderModify(ticket,0, OrderStopLoss() - 800, OrderProfit(),0);
         } else if (OrderProfit() > 800 && OrderType() == 0) {
            bool res = OrderModify(ticket,0, OrderStopLoss() + 800, OrderProfit(),0);
         }
      }
        
  }