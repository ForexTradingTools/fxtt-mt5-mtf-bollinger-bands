//+------------------------------------------------------------------+
//| CBollingerBandMTF.mqh                                            |
//| Reusable multi-timeframe Bollinger Band wrapper.                 |
//|                                                                  |
//| Usage (any indicator):                                           |
//|   #include <FXTT/CBollingerBandMTF.mqh>                         |
//|   CBollingerBand bb;                                             |
//|   bb.Init(_Symbol, PERIOD_H4, 20, 0, 2.0);                      |
//|   // in OnCalculate:                                             |
//|   if(bb.IsReady())                                               |
//|       bb.FillBands(upper[], middle[], lower[], start, total, time[]);
//|                                                                  |
//| NOTE: time[] must be series (index 0 = newest), as provided     |
//|       directly by OnCalculate.                                   |
//+------------------------------------------------------------------+
#ifndef CBOLLINGER_BAND_MTF_MQH
#define CBOLLINGER_BAND_MTF_MQH

//+------------------------------------------------------------------+
class CBollingerBand
{
private:
   int              m_handle;
   ENUM_TIMEFRAMES  m_tf;
   string           m_symbol;

   //--- Internal: map pre-copied HTF data onto dest[] via series time alignment.
   //    Iterates newest→oldest (i = start..total-1), advancing j through HTF
   //    in the same direction so each chart bar finds its containing HTF candle.
   static void      MapBuffer(const double &htfBuf[], const datetime &htfTime[],
                               int htfSize, double &dest[],
                               int start, int total, const datetime &time[]);

public:
                    CBollingerBand();
                   ~CBollingerBand();

   bool             Init(const string symbol, ENUM_TIMEFRAMES tf,
                         int period, int shift, double deviations);
   void             Release();

   bool             IsValid()   const { return m_handle != INVALID_HANDLE; }
   bool             IsReady()   const { return IsValid() && BarsCalculated(m_handle) > 0; }
   ENUM_TIMEFRAMES  GetTF()     const { return m_tf; }
   int              GetHandle() const { return m_handle; }

   //--- Fill a single band buffer.
   //    iBands buffer convention: 0=middle, 1=upper, 2=lower
   void             FillBuffer(int bufIdx, double &dest[],
                                int start, int total,
                                const datetime &time[]) const;

   //--- Fill upper, middle, lower in one call (CopyTime called once, not three times).
   void             FillBands(double &upper[], double &middle[], double &lower[],
                               int start, int total,
                               const datetime &time[]) const;

   //--- Reset all three buffers to EMPTY_VALUE.
   static void      ClearBands(double &upper[], double &middle[], double &lower[]);
};

//+------------------------------------------------------------------+
CBollingerBand::CBollingerBand()
   : m_handle(INVALID_HANDLE), m_tf(PERIOD_CURRENT), m_symbol("") {}

CBollingerBand::~CBollingerBand() { Release(); }

//+------------------------------------------------------------------+
bool CBollingerBand::Init(const string symbol, ENUM_TIMEFRAMES tf,
                          int period, int shift, double deviations)
{
   Release();
   m_symbol = symbol;
   m_tf     = tf;
   m_handle = iBands(symbol, tf, period, shift, deviations, PRICE_CLOSE);
   return IsValid();
}

//+------------------------------------------------------------------+
void CBollingerBand::Release()
{
   if(m_handle != INVALID_HANDLE)
   {
      IndicatorRelease(m_handle);
      m_handle = INVALID_HANDLE;
   }
}

//+------------------------------------------------------------------+
void CBollingerBand::MapBuffer(const double &htfBuf[], const datetime &htfTime[],
                                int htfSize, double &dest[],
                                int start, int total, const datetime &time[])
{
   if(ArraySize(dest) < total)
      return;  // dest too small; caller's buffer is mis-sized

   int j = 0;
   for(int i = start; i < total; i++)  // newest (start) → oldest (total-1)
   {
      while(j < htfSize - 1 && htfTime[j] > time[i])
         j++;
      dest[i] = (j < htfSize && htfTime[j] <= time[i]) ? htfBuf[j] : EMPTY_VALUE;
   }
}

//+------------------------------------------------------------------+
void CBollingerBand::FillBuffer(int bufIdx, double &dest[],
                                 int start, int total,
                                 const datetime &time[]) const
{
   if(start >= total || !IsValid())
      return;

   int nHTF = (int)BarsCalculated(m_handle);
   if(nHTF <= 0)
   {
      ArrayFill(dest, start, total - start, EMPTY_VALUE);
      return;
   }

   int count = MathMin(nHTF, total);  // never need more HTF bars than chart bars

   double   htfBuf[];
   datetime htfTime[];
   ArraySetAsSeries(htfBuf,  true);
   ArraySetAsSeries(htfTime, true);

   int copiedBuf  = CopyBuffer(m_handle, bufIdx, 0, count, htfBuf);
   int copiedTime = CopyTime(m_symbol, m_tf, 0, count, htfTime);

   if(copiedBuf <= 0 || copiedTime <= 0)
   {
      ArrayFill(dest, start, total - start, EMPTY_VALUE);
      return;
   }

   MapBuffer(htfBuf, htfTime, MathMin(copiedBuf, copiedTime), dest, start, total, time);
}

//+------------------------------------------------------------------+
void CBollingerBand::FillBands(double &upper[], double &middle[], double &lower[],
                               int start, int total,
                               const datetime &time[]) const
{
   if(start >= total || !IsValid())
      return;

   int nHTF = (int)BarsCalculated(m_handle);
   if(nHTF <= 0)
   {
      ArrayFill(upper,  start, total - start, EMPTY_VALUE);
      ArrayFill(middle, start, total - start, EMPTY_VALUE);
      ArrayFill(lower,  start, total - start, EMPTY_VALUE);
      return;
   }

   int count = MathMin(nHTF, total);

   double   htfUpper[], htfMiddle[], htfLower[];
   datetime htfTime[];
   ArraySetAsSeries(htfUpper,  true);
   ArraySetAsSeries(htfMiddle, true);
   ArraySetAsSeries(htfLower,  true);
   ArraySetAsSeries(htfTime,   true);

   // CopyTime once, shared across all three bands
   int copiedTime   = CopyTime(m_symbol, m_tf, 0, count, htfTime);
   int copiedUpper  = CopyBuffer(m_handle, 1, 0, count, htfUpper);
   int copiedMiddle = CopyBuffer(m_handle, 0, 0, count, htfMiddle);
   int copiedLower  = CopyBuffer(m_handle, 2, 0, count, htfLower);

   if(copiedTime <= 0 || copiedUpper <= 0 || copiedMiddle <= 0 || copiedLower <= 0)
   {
      ArrayFill(upper,  start, total - start, EMPTY_VALUE);
      ArrayFill(middle, start, total - start, EMPTY_VALUE);
      ArrayFill(lower,  start, total - start, EMPTY_VALUE);
      return;
   }

   int htfSize = MathMin(MathMin(copiedTime, copiedUpper), MathMin(copiedMiddle, copiedLower));
   MapBuffer(htfUpper,  htfTime, htfSize, upper,  start, total, time);
   MapBuffer(htfMiddle, htfTime, htfSize, middle, start, total, time);
   MapBuffer(htfLower,  htfTime, htfSize, lower,  start, total, time);
}

//+------------------------------------------------------------------+
void CBollingerBand::ClearBands(double &upper[], double &middle[], double &lower[])
{
   ArrayInitialize(upper,  EMPTY_VALUE);
   ArrayInitialize(middle, EMPTY_VALUE);
   ArrayInitialize(lower,  EMPTY_VALUE);
}

#endif // CBOLLINGER_BAND_MTF_MQH
