//+------------------------------------------------------------------+
//|                               BBMultiTimeframePanel.mq5          |
//|                                                       FxTT        |
//+------------------------------------------------------------------+
#property copyright "FxTT"
#property link      ""
#property version   "2.00"
#property description "Bollinger Bands Multi-Timeframe Panel"

#property indicator_chart_window
#property indicator_buffers 27
#property indicator_plots   27

//--- Plots: MN1
#property indicator_label1  "BB MN1 Upper"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrMagenta
#property indicator_style1  STYLE_DASH
#property indicator_width1  1

#property indicator_label2  "BB MN1 Middle"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrMagenta
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

#property indicator_label3  "BB MN1 Lower"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrMagenta
#property indicator_style3  STYLE_DASH
#property indicator_width3  1

//--- Plots: W1
#property indicator_label4  "BB W1 Upper"
#property indicator_type4   DRAW_LINE
#property indicator_color4  clrDodgerBlue
#property indicator_style4  STYLE_DASH
#property indicator_width4  1

#property indicator_label5  "BB W1 Middle"
#property indicator_type5   DRAW_LINE
#property indicator_color5  clrDodgerBlue
#property indicator_style5  STYLE_SOLID
#property indicator_width5  1

#property indicator_label6  "BB W1 Lower"
#property indicator_type6   DRAW_LINE
#property indicator_color6  clrDodgerBlue
#property indicator_style6  STYLE_DASH
#property indicator_width6  1

//--- Plots: D1
#property indicator_label7  "BB D1 Upper"
#property indicator_type7   DRAW_LINE
#property indicator_color7  clrOrange
#property indicator_style7  STYLE_DASH
#property indicator_width7  1

#property indicator_label8  "BB D1 Middle"
#property indicator_type8   DRAW_LINE
#property indicator_color8  clrOrange
#property indicator_style8  STYLE_SOLID
#property indicator_width8  1

#property indicator_label9  "BB D1 Lower"
#property indicator_type9   DRAW_LINE
#property indicator_color9  clrOrange
#property indicator_style9  STYLE_DASH
#property indicator_width9  1

//--- Plots: H4
#property indicator_label10 "BB H4 Upper"
#property indicator_type10  DRAW_LINE
#property indicator_color10 clrLimeGreen
#property indicator_style10 STYLE_DASH
#property indicator_width10 1

#property indicator_label11 "BB H4 Middle"
#property indicator_type11  DRAW_LINE
#property indicator_color11 clrLimeGreen
#property indicator_style11 STYLE_SOLID
#property indicator_width11 1

#property indicator_label12 "BB H4 Lower"
#property indicator_type12  DRAW_LINE
#property indicator_color12 clrLimeGreen
#property indicator_style12 STYLE_DASH
#property indicator_width12 1

//--- Plots: H1
#property indicator_label13 "BB H1 Upper"
#property indicator_type13  DRAW_LINE
#property indicator_color13 clrGold
#property indicator_style13 STYLE_DASH
#property indicator_width13 1

#property indicator_label14 "BB H1 Middle"
#property indicator_type14  DRAW_LINE
#property indicator_color14 clrGold
#property indicator_style14 STYLE_SOLID
#property indicator_width14 1

#property indicator_label15 "BB H1 Lower"
#property indicator_type15  DRAW_LINE
#property indicator_color15 clrGold
#property indicator_style15 STYLE_DASH
#property indicator_width15 1

//--- Plots: M30
#property indicator_label16 "BB M30 Upper"
#property indicator_type16  DRAW_LINE
#property indicator_color16 clrTomato
#property indicator_style16 STYLE_DASH
#property indicator_width16 1

#property indicator_label17 "BB M30 Middle"
#property indicator_type17  DRAW_LINE
#property indicator_color17 clrTomato
#property indicator_style17 STYLE_SOLID
#property indicator_width17 1

#property indicator_label18 "BB M30 Lower"
#property indicator_type18  DRAW_LINE
#property indicator_color18 clrTomato
#property indicator_style18 STYLE_DASH
#property indicator_width18 1

//--- Plots: M15
#property indicator_label19 "BB M15 Upper"
#property indicator_type19  DRAW_LINE
#property indicator_color19 clrDeepSkyBlue
#property indicator_style19 STYLE_DASH
#property indicator_width19 1

#property indicator_label20 "BB M15 Middle"
#property indicator_type20  DRAW_LINE
#property indicator_color20 clrDeepSkyBlue
#property indicator_style20 STYLE_SOLID
#property indicator_width20 1

#property indicator_label21 "BB M15 Lower"
#property indicator_type21  DRAW_LINE
#property indicator_color21 clrDeepSkyBlue
#property indicator_style21 STYLE_DASH
#property indicator_width21 1

//--- Plots: M5
#property indicator_label22 "BB M5 Upper"
#property indicator_type22  DRAW_LINE
#property indicator_color22 clrViolet
#property indicator_style22 STYLE_DASH
#property indicator_width22 1

#property indicator_label23 "BB M5 Middle"
#property indicator_type23  DRAW_LINE
#property indicator_color23 clrViolet
#property indicator_style23 STYLE_SOLID
#property indicator_width23 1

#property indicator_label24 "BB M5 Lower"
#property indicator_type24  DRAW_LINE
#property indicator_color24 clrViolet
#property indicator_style24 STYLE_DASH
#property indicator_width24 1

//--- Plots: M1
#property indicator_label25 "BB M1 Upper"
#property indicator_type25  DRAW_LINE
#property indicator_color25 clrSilver
#property indicator_style25 STYLE_DASH
#property indicator_width25 1

#property indicator_label26 "BB M1 Middle"
#property indicator_type26  DRAW_LINE
#property indicator_color26 clrSilver
#property indicator_style26 STYLE_SOLID
#property indicator_width26 1

#property indicator_label27 "BB M1 Lower"
#property indicator_type27  DRAW_LINE
#property indicator_color27 clrSilver
#property indicator_style27 STYLE_DASH
#property indicator_width27 1

//+------------------------------------------------------------------+
#include "FXTT/CBollingerBandMTF.mqh"

//+------------------------------------------------------------------+
//| Input parameters                                                  |
//+------------------------------------------------------------------+
input group "Bollinger Bands"
input int    InpPeriod     = 20;   // Period
input double InpDeviations = 2.0;  // Deviations
input int    InpBBShift    = 0;    // Shift

input group "Panel"
input int    InpPanelX     = 20;   // Panel X (pixels from corner)
input int    InpPanelY     = 30;   // Panel Y (pixels from corner)

input group "Band Labels"
input bool   InpShowBandLabels = true; // Show right-side band labels
input int    InpLabelShiftBars = 1;    // Label shift to the right (bars)
input int    InpLabelFontSize  = 8;    // Label font size

//+------------------------------------------------------------------+
//| TF index constants                                                |
//+------------------------------------------------------------------+
#define TF_COUNT 9

enum EBandTfIndex
{
   TF_MN1 = 0,
   TF_W1  = 1,
   TF_D1  = 2,
   TF_H4  = 3,
   TF_H1  = 4,
   TF_M30 = 5,
   TF_M15 = 6,
   TF_M5  = 7,
   TF_M1  = 8
};

//+------------------------------------------------------------------+
//| TF metadata  (indexed by EBandTfIndex — treat as read-only)      |
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES TF_PERIODS[TF_COUNT];
color           TF_COLORS[TF_COUNT];
string          TF_LABELS[TF_COUNT];
string          TF_CB_IDS[TF_COUNT];
string          TF_GV_KEYS[TF_COUNT];

void InitMetadata()
{
   TF_PERIODS[TF_MN1] = PERIOD_MN1;  TF_COLORS[TF_MN1] = clrMagenta;     TF_LABELS[TF_MN1] = "MN1";  TF_CB_IDS[TF_MN1] = "CbMN1";  TF_GV_KEYS[TF_MN1] = "ShowMN1";
   TF_PERIODS[TF_W1]  = PERIOD_W1;   TF_COLORS[TF_W1]  = clrDodgerBlue;  TF_LABELS[TF_W1]  = "W1";   TF_CB_IDS[TF_W1]  = "CbW1";   TF_GV_KEYS[TF_W1]  = "ShowW1";
   TF_PERIODS[TF_D1]  = PERIOD_D1;   TF_COLORS[TF_D1]  = clrOrange;      TF_LABELS[TF_D1]  = "D1";   TF_CB_IDS[TF_D1]  = "CbD1";   TF_GV_KEYS[TF_D1]  = "ShowD1";
   TF_PERIODS[TF_H4]  = PERIOD_H4;   TF_COLORS[TF_H4]  = clrLimeGreen;   TF_LABELS[TF_H4]  = "H4";   TF_CB_IDS[TF_H4]  = "CbH4";   TF_GV_KEYS[TF_H4]  = "ShowH4";
   TF_PERIODS[TF_H1]  = PERIOD_H1;   TF_COLORS[TF_H1]  = clrGold;        TF_LABELS[TF_H1]  = "H1";   TF_CB_IDS[TF_H1]  = "CbH1";   TF_GV_KEYS[TF_H1]  = "ShowH1";
   TF_PERIODS[TF_M30] = PERIOD_M30;  TF_COLORS[TF_M30] = clrTomato;      TF_LABELS[TF_M30] = "M30";  TF_CB_IDS[TF_M30] = "CbM30";  TF_GV_KEYS[TF_M30] = "ShowM30";
   TF_PERIODS[TF_M15] = PERIOD_M15;  TF_COLORS[TF_M15] = clrDeepSkyBlue; TF_LABELS[TF_M15] = "M15";  TF_CB_IDS[TF_M15] = "CbM15";  TF_GV_KEYS[TF_M15] = "ShowM15";
   TF_PERIODS[TF_M5]  = PERIOD_M5;   TF_COLORS[TF_M5]  = clrViolet;      TF_LABELS[TF_M5]  = "M5";   TF_CB_IDS[TF_M5]  = "CbM5";   TF_GV_KEYS[TF_M5]  = "ShowM5";
   TF_PERIODS[TF_M1]  = PERIOD_M1;   TF_COLORS[TF_M1]  = clrSilver;      TF_LABELS[TF_M1]  = "M1";   TF_CB_IDS[TF_M1]  = "CbM1";   TF_GV_KEYS[TF_M1]  = "ShowM1";
}

//+------------------------------------------------------------------+
//| Bollinger Band instances — one per TF                             |
//+------------------------------------------------------------------+
CBollingerBand g_BB[TF_COUNT];

//+------------------------------------------------------------------+
//| Per-TF indexed state                                              |
//+------------------------------------------------------------------+
bool     g_Show[TF_COUNT];
bool     g_Eligible[TF_COUNT];
bool     g_PrevShow[TF_COUNT];
datetime g_LastTFTime[TF_COUNT];
datetime g_LastBarTime = 0;

//+------------------------------------------------------------------+
//| Indicator buffers (27 globals required by MQL5 for SetIndexBuffer)|
//+------------------------------------------------------------------+
double g_MN1Upper[], g_MN1Middle[], g_MN1Lower[];
double g_W1Upper[],  g_W1Middle[],  g_W1Lower[];
double g_D1Upper[],  g_D1Middle[],  g_D1Lower[];
double g_H4Upper[],  g_H4Middle[],  g_H4Lower[];
double g_H1Upper[],  g_H1Middle[],  g_H1Lower[];
double g_M30Upper[], g_M30Middle[], g_M30Lower[];
double g_M15Upper[], g_M15Middle[], g_M15Lower[];
double g_M5Upper[],  g_M5Middle[],  g_M5Lower[];
double g_M1Upper[],  g_M1Middle[],  g_M1Lower[];

//+------------------------------------------------------------------+
//| Cached chart data                                                 |
//+------------------------------------------------------------------+
int      g_RatesTotal = 0;
datetime g_Time[];

//+------------------------------------------------------------------+
//| Panel / visibility state                                          |
//+------------------------------------------------------------------+
bool g_Expanded = true;
int  g_PanelX   = 0;
int  g_PanelY   = 0;

//+------------------------------------------------------------------+
//| Drag state                                                        |
//+------------------------------------------------------------------+
bool g_Dragging        = false;
bool g_ActuallyDragged = false;
bool g_WasLBDown       = false;
int  g_DragOffX        = 0;
int  g_DragOffY        = 0;
int  g_DragStartX      = 0;
int  g_DragStartY      = 0;

const int DRAG_THRESHOLD = 4;

//+------------------------------------------------------------------+
//| Object-name prefix                                                |
//+------------------------------------------------------------------+
string g_Pfx;

//+------------------------------------------------------------------+
//| Panel layout constants                                            |
//+------------------------------------------------------------------+
const int PANEL_W  = 215;
const int TOGGLE_H = 24;
const int CHECK_H  = 22;
const int PADDING  = 4;
const int GAP      = 2;

const color CLR_PANEL_BG       = C'18,26,42';
const color CLR_PANEL_BORDER   = C'55,85,130';
const color CLR_TOGGLE_BG      = C'35,55,90';
const color CLR_CHECK_BG_ON    = C'28,44,68';
const color CLR_CHECK_BG_OFF   = C'16,22,34';
const color CLR_CHECKED_TEXT   = clrWhite;
const color CLR_UNCHECKED_TEXT = C'70,85,100';
const color CLR_DISABLED_BG    = C'14,18,24';
const color CLR_DISABLED_TEXT  = C'40,48,58';

//+------------------------------------------------------------------+
//| Basic helpers                                                     |
//+------------------------------------------------------------------+
string N(const string name)          { return g_Pfx + name; }
int    PlotBaseByIndex(int i)        { return i * 3; }
int    SecondsPerCurrentBar()        { int s = PeriodSeconds(Period()); return s > 0 ? s : 60; }

int PanelHeight(bool expanded)
{
   return expanded
      ? PADDING + TOGGLE_H + GAP + TF_COUNT * (CHECK_H + GAP) + PADDING
      : PADDING + TOGGLE_H + PADDING;
}

string GVK(const string suffix) { return "BBMTF_" + IntegerToString(ChartID()) + "_" + suffix; }

//+------------------------------------------------------------------+
//| Global-variable state persistence                                 |
//+------------------------------------------------------------------+
void State_Save()
{
   GlobalVariableSet(GVK("X"),        g_PanelX);
   GlobalVariableSet(GVK("Y"),        g_PanelY);
   GlobalVariableSet(GVK("Expanded"), g_Expanded ? 1.0 : 0.0);
   for(int i = 0; i < TF_COUNT; i++)
      GlobalVariableSet(GVK(TF_GV_KEYS[i]), g_Show[i] ? 1.0 : 0.0);
}

bool State_Load()
{
   if(!GlobalVariableCheck(GVK("X")))
      return false;

   g_PanelX   = (int)GlobalVariableGet(GVK("X"));
   g_PanelY   = (int)GlobalVariableGet(GVK("Y"));
   g_Expanded = GlobalVariableGet(GVK("Expanded")) != 0.0;

   for(int i = 0; i < TF_COUNT; i++)
      if(GlobalVariableCheck(GVK(TF_GV_KEYS[i])))
         g_Show[i] = GlobalVariableGet(GVK(TF_GV_KEYS[i])) != 0.0;

   return true;
}

void State_Delete()
{
   GlobalVariableDel(GVK("X"));
   GlobalVariableDel(GVK("Y"));
   GlobalVariableDel(GVK("Expanded"));
   for(int i = 0; i < TF_COUNT; i++)
      GlobalVariableDel(GVK(TF_GV_KEYS[i]));
}

//+------------------------------------------------------------------+
//| Band-label helpers                                                |
//+------------------------------------------------------------------+
string BandNameByOffset(int offset)
{
   switch(offset) { case 0: return "Upper"; case 1: return "Middle"; case 2: return "Lower"; }
   return "";
}

string PlotLabelByIndex(int plotIndex)
{
   return "BB " + TF_LABELS[plotIndex / 3] + " " + BandNameByOffset(plotIndex % 3);
}

string BandLabelObjId(int plotIndex) { return "BandLabel_" + IntegerToString(plotIndex); }

void DeleteBandLabel(int plotIndex) { ObjectDelete(0, N(BandLabelObjId(plotIndex))); }

void BandLabels_DeleteAll()
{
   for(int plot = 0; plot < TF_COUNT * 3; plot++)
      DeleteBandLabel(plot);
}

void SetBandLabel(int plotIndex, bool visible, datetime baseTime,
                  double price, int barSeconds)
{
   if(!InpShowBandLabels || !visible || price == EMPTY_VALUE || !MathIsValidNumber(price))
   {
      DeleteBandLabel(plotIndex);
      return;
   }

   string   objName     = N(BandLabelObjId(plotIndex));
   datetime shiftedTime = baseTime + (datetime)(MathMax(0, InpLabelShiftBars) * barSeconds);

   if(ObjectFind(0, objName) < 0)
      ObjectCreate(0, objName, OBJ_TEXT, 0, shiftedTime, price);
   else
      ObjectMove(0, objName, 0, shiftedTime, price);

   ObjectSetString(0, objName, OBJPROP_TEXT, PlotLabelByIndex(plotIndex));
   ObjectSetInteger(0, objName, OBJPROP_COLOR,      TF_COLORS[plotIndex / 3]);
   ObjectSetInteger(0, objName, OBJPROP_ANCHOR,     ANCHOR_LEFT);
   ObjectSetInteger(0, objName, OBJPROP_FONTSIZE,   InpLabelFontSize);
   ObjectSetString(0, objName, OBJPROP_FONT,        "Segoe UI");
   ObjectSetInteger(0, objName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, objName, OBJPROP_HIDDEN,     true);
   ObjectSetInteger(0, objName, OBJPROP_BACK,       false);
   ObjectSetInteger(0, objName, OBJPROP_ZORDER,     0);
}

void SetTFBandLabels(int tfIndex, bool visible, datetime baseTime, int barSeconds,
                     double &upper[], double &middle[], double &lower[])
{
   int base = PlotBaseByIndex(tfIndex);

   if(g_RatesTotal <= 0 || !visible)
   {
      for(int b = 0; b < 3; b++) DeleteBandLabel(base + b);
      return;
   }

   int last = g_RatesTotal - 1;
   SetBandLabel(base + 0, true, baseTime, upper[last],  barSeconds);
   SetBandLabel(base + 1, true, baseTime, middle[last], barSeconds);
   SetBandLabel(base + 2, true, baseTime, lower[last],  barSeconds);
}

//+------------------------------------------------------------------+
//| Buffer dispatch helpers                                           |
//| MQL5 does not support array references in structs/arrays, so     |
//| these two switch-based functions are the single point of contact  |
//| between the TF index and the concrete global buffer arrays.       |
//+------------------------------------------------------------------+

// Fill (fill=true) or clear (fill=false) the three buffers for TF[i].
void Bands_Update(int i, bool fill, int start, int total, const datetime &time[])
{
   #define BANDS_OP(U, M, L) \
      if(fill) g_BB[i].FillBands(U, M, L, start, total, time); \
      else     CBollingerBand::ClearBands(U, M, L)

   switch(i)
   {
      case TF_MN1: BANDS_OP(g_MN1Upper, g_MN1Middle, g_MN1Lower); break;
      case TF_W1:  BANDS_OP(g_W1Upper,  g_W1Middle,  g_W1Lower);  break;
      case TF_D1:  BANDS_OP(g_D1Upper,  g_D1Middle,  g_D1Lower);  break;
      case TF_H4:  BANDS_OP(g_H4Upper,  g_H4Middle,  g_H4Lower);  break;
      case TF_H1:  BANDS_OP(g_H1Upper,  g_H1Middle,  g_H1Lower);  break;
      case TF_M30: BANDS_OP(g_M30Upper, g_M30Middle, g_M30Lower); break;
      case TF_M15: BANDS_OP(g_M15Upper, g_M15Middle, g_M15Lower); break;
      case TF_M5:  BANDS_OP(g_M5Upper,  g_M5Middle,  g_M5Lower);  break;
      case TF_M1:  BANDS_OP(g_M1Upper,  g_M1Middle,  g_M1Lower);  break;
   }
   #undef BANDS_OP
}

// Refresh right-side labels for TF[i].
void Labels_RefreshTF(int i, bool visible, datetime baseTime, int barSec)
{
   switch(i)
   {
      case TF_MN1: SetTFBandLabels(i, visible, baseTime, barSec, g_MN1Upper, g_MN1Middle, g_MN1Lower); break;
      case TF_W1:  SetTFBandLabels(i, visible, baseTime, barSec, g_W1Upper,  g_W1Middle,  g_W1Lower);  break;
      case TF_D1:  SetTFBandLabels(i, visible, baseTime, barSec, g_D1Upper,  g_D1Middle,  g_D1Lower);  break;
      case TF_H4:  SetTFBandLabels(i, visible, baseTime, barSec, g_H4Upper,  g_H4Middle,  g_H4Lower);  break;
      case TF_H1:  SetTFBandLabels(i, visible, baseTime, barSec, g_H1Upper,  g_H1Middle,  g_H1Lower);  break;
      case TF_M30: SetTFBandLabels(i, visible, baseTime, barSec, g_M30Upper, g_M30Middle, g_M30Lower); break;
      case TF_M15: SetTFBandLabels(i, visible, baseTime, barSec, g_M15Upper, g_M15Middle, g_M15Lower); break;
      case TF_M5:  SetTFBandLabels(i, visible, baseTime, barSec, g_M5Upper,  g_M5Middle,  g_M5Lower);  break;
      case TF_M1:  SetTFBandLabels(i, visible, baseTime, barSec, g_M1Upper,  g_M1Middle,  g_M1Lower);  break;
   }
}

void BandLabels_Refresh()
{
   if(!InpShowBandLabels || g_RatesTotal <= 0 || ArraySize(g_Time) <= 0)
   {
      BandLabels_DeleteAll();
      return;
   }

   datetime baseTime = g_Time[g_RatesTotal - 1];
   if(baseTime <= 0) { BandLabels_DeleteAll(); return; }

   int barSec = SecondsPerCurrentBar();
   for(int i = 0; i < TF_COUNT; i++)
      Labels_RefreshTF(i, g_Show[i] && g_Eligible[i], baseTime, barSec);
}

//+------------------------------------------------------------------+
//| Low-level object creators                                         |
//+------------------------------------------------------------------+
void _CreateBackground(const string name, int x, int y, int w, int h)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE,   x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE,   y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE,        w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE,        h);
   ObjectSetInteger(0, name, OBJPROP_CORNER,       CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR,      CLR_PANEL_BG);
   ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE,  BORDER_FLAT);
   ObjectSetInteger(0, name, OBJPROP_COLOR,        CLR_PANEL_BORDER);
   ObjectSetInteger(0, name, OBJPROP_WIDTH,        1);
   ObjectSetInteger(0, name, OBJPROP_BACK,         false);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0, name, OBJPROP_ZORDER,       1);
}

void _CreateButton(const string name, int x, int y, int w, int h,
                   const string text, color bg, color clr,
                   int fontsize = 9, bool state = false)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE,    x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE,         w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE,         h);
   ObjectSetInteger(0, name, OBJPROP_CORNER,        CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR,       bg);
   ObjectSetInteger(0, name, OBJPROP_COLOR,         clr);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR,  CLR_PANEL_BORDER);
   ObjectSetString(0,  name, OBJPROP_TEXT,          text);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE,      fontsize);
   ObjectSetString(0,  name, OBJPROP_FONT,          "Segoe UI");
   ObjectSetInteger(0, name, OBJPROP_STATE,         state);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,    false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,        true);
   ObjectSetInteger(0, name, OBJPROP_ZORDER,        10);
}

//+------------------------------------------------------------------+
//| Plot / checkbox helpers                                           |
//+------------------------------------------------------------------+
void SetPlotVisibility(int plotBase, bool show)
{
   for(int j = 0; j < 3; j++)
      PlotIndexSetInteger(plotBase + j, PLOT_DRAW_TYPE, show ? DRAW_LINE : DRAW_NONE);
}

void Panel_UpdateCheckbox(const string id, bool checked, color accentClr)
{
   ObjectSetInteger(0, N(id), OBJPROP_STATE,  checked);
   ObjectSetInteger(0, N(id), OBJPROP_BGCOLOR, checked ? CLR_CHECK_BG_ON : CLR_CHECK_BG_OFF);
   ObjectSetInteger(0, N(id), OBJPROP_COLOR,   checked ? accentClr : CLR_UNCHECKED_TEXT);
}

//+------------------------------------------------------------------+
//| Panel functions                                                   |
//+------------------------------------------------------------------+
void Panel_Create()
{
   int x  = g_PanelX;
   int y  = g_PanelY;
   int bx = x + PADDING;
   int bw = PANEL_W - 2 * PADDING;

   _CreateBackground(N("BG"), x, y, PANEL_W, PanelHeight(g_Expanded));
   _CreateButton(N("Toggle"), bx, y + PADDING, bw, TOGGLE_H,
                 g_Expanded ? " BB Panel  ▲" : " BB Panel  ▼",
                 CLR_TOGGLE_BG, clrWhite, 9, false);

   int cy = y + PADDING + TOGGLE_H + GAP;
   for(int i = 0; i < TF_COUNT; i++)
   {
      bool  show    = g_Show[i] && g_Eligible[i];
      color accent  = TF_COLORS[i];
      color fg      = !g_Eligible[i] ? CLR_DISABLED_TEXT : (show ? accent        : CLR_UNCHECKED_TEXT);
      color bg      = !g_Eligible[i] ? CLR_DISABLED_BG   : (show ? CLR_CHECK_BG_ON : CLR_CHECK_BG_OFF);

      _CreateButton(N(TF_CB_IDS[i]), bx, cy, bw, CHECK_H,
                    "■  Bollinger Bands " + TF_LABELS[i], bg, fg, 9, show);
      ObjectSetInteger(0, N(TF_CB_IDS[i]), OBJPROP_TIMEFRAMES,
                       g_Expanded ? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
      cy += CHECK_H + GAP;
   }

   for(int i = 0; i < TF_COUNT; i++)
      SetPlotVisibility(PlotBaseByIndex(i), g_Show[i] && g_Eligible[i]);

   BandLabels_Refresh();
   ChartRedraw(0);
}

void Panel_Delete()
{
   ObjectDelete(0, N("BG"));
   ObjectDelete(0, N("Toggle"));
   for(int i = 0; i < TF_COUNT; i++)
      ObjectDelete(0, N(TF_CB_IDS[i]));
   BandLabels_DeleteAll();
}

void Panel_Move(int x, int y)
{
   g_PanelX = x;
   g_PanelY = y;

   ObjectSetInteger(0, N("BG"),     OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, N("BG"),     OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, N("Toggle"), OBJPROP_XDISTANCE, x + PADDING);
   ObjectSetInteger(0, N("Toggle"), OBJPROP_YDISTANCE, y + PADDING);

   int cy = y + PADDING + TOGGLE_H + GAP;
   for(int i = 0; i < TF_COUNT; i++)
   {
      ObjectSetInteger(0, N(TF_CB_IDS[i]), OBJPROP_XDISTANCE, x + PADDING);
      ObjectSetInteger(0, N(TF_CB_IDS[i]), OBJPROP_YDISTANCE, cy);
      cy += CHECK_H + GAP;
   }

   State_Save();
   ChartRedraw(0);
}

void Panel_SetExpanded(bool expand)
{
   g_Expanded = expand;
   ObjectSetInteger(0, N("BG"), OBJPROP_YSIZE, PanelHeight(expand));

   long vis = expand ? OBJ_ALL_PERIODS : OBJ_NO_PERIODS;
   for(int i = 0; i < TF_COUNT; i++)
      ObjectSetInteger(0, N(TF_CB_IDS[i]), OBJPROP_TIMEFRAMES, vis);

   ObjectSetString(0, N("Toggle"), OBJPROP_TEXT, expand ? " BB Panel  ▲" : " BB Panel  ▼");

   State_Save();
   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//| Toggle a TF band on/off from a checkbox click                    |
//+------------------------------------------------------------------+
void ToggleBandByIndex(int i)
{
   if(!g_Eligible[i])
   {
      ObjectSetInteger(0, N(TF_CB_IDS[i]), OBJPROP_STATE, false);
      return;
   }

   g_Show[i] = (bool)ObjectGetInteger(0, N(TF_CB_IDS[i]), OBJPROP_STATE);
   Panel_UpdateCheckbox(TF_CB_IDS[i], g_Show[i], TF_COLORS[i]);
   SetPlotVisibility(PlotBaseByIndex(i), g_Show[i]);

   Bands_Update(i, g_Show[i], 0, g_RatesTotal, g_Time);
   if(g_Show[i]) g_PrevShow[i] = true;

   BandLabels_Refresh();
   State_Save();
   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//| Buffer registration (runs once in OnInit)                        |
//+------------------------------------------------------------------+
void RegisterBuffers()
{
   SetIndexBuffer(0,  g_MN1Upper,  INDICATOR_DATA); SetIndexBuffer(1,  g_MN1Middle, INDICATOR_DATA); SetIndexBuffer(2,  g_MN1Lower,  INDICATOR_DATA);
   SetIndexBuffer(3,  g_W1Upper,   INDICATOR_DATA); SetIndexBuffer(4,  g_W1Middle,  INDICATOR_DATA); SetIndexBuffer(5,  g_W1Lower,   INDICATOR_DATA);
   SetIndexBuffer(6,  g_D1Upper,   INDICATOR_DATA); SetIndexBuffer(7,  g_D1Middle,  INDICATOR_DATA); SetIndexBuffer(8,  g_D1Lower,   INDICATOR_DATA);
   SetIndexBuffer(9,  g_H4Upper,   INDICATOR_DATA); SetIndexBuffer(10, g_H4Middle,  INDICATOR_DATA); SetIndexBuffer(11, g_H4Lower,   INDICATOR_DATA);
   SetIndexBuffer(12, g_H1Upper,   INDICATOR_DATA); SetIndexBuffer(13, g_H1Middle,  INDICATOR_DATA); SetIndexBuffer(14, g_H1Lower,   INDICATOR_DATA);
   SetIndexBuffer(15, g_M30Upper,  INDICATOR_DATA); SetIndexBuffer(16, g_M30Middle, INDICATOR_DATA); SetIndexBuffer(17, g_M30Lower,  INDICATOR_DATA);
   SetIndexBuffer(18, g_M15Upper,  INDICATOR_DATA); SetIndexBuffer(19, g_M15Middle, INDICATOR_DATA); SetIndexBuffer(20, g_M15Lower,  INDICATOR_DATA);
   SetIndexBuffer(21, g_M5Upper,   INDICATOR_DATA); SetIndexBuffer(22, g_M5Middle,  INDICATOR_DATA); SetIndexBuffer(23, g_M5Lower,   INDICATOR_DATA);
   SetIndexBuffer(24, g_M1Upper,   INDICATOR_DATA); SetIndexBuffer(25, g_M1Middle,  INDICATOR_DATA); SetIndexBuffer(26, g_M1Lower,   INDICATOR_DATA);
}

//+------------------------------------------------------------------+
//| Init / Deinit                                                     |
//+------------------------------------------------------------------+
int OnInit()
{
   InitMetadata();

   g_Pfx = "BBMTF_" + IntegerToString(ChartID()) + "_";

   ArrayInitialize(g_Show,     true);
   ArrayInitialize(g_PrevShow, true);
   ArrayInitialize(g_LastTFTime, 0);

   if(!State_Load())
   {
      g_PanelX = InpPanelX;
      g_PanelY = InpPanelY;
   }

   ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, true);

   RegisterBuffers();

   for(int i = 0; i < 27; i++)
   {
      PlotIndexSetDouble(i, PLOT_EMPTY_VALUE, EMPTY_VALUE);
      PlotIndexSetInteger(i, PLOT_DRAW_BEGIN, InpPeriod);
   }

   for(int i = 0; i < TF_COUNT; i++)
      if(!g_BB[i].Init(_Symbol, TF_PERIODS[i], InpPeriod, InpBBShift, InpDeviations))
      {
         Print("[BBMultiTF] ERROR: failed to create BB handle for ", TF_LABELS[i]);
         return INIT_FAILED;
      }

   int chartSecs = PeriodSeconds(Period());
   for(int i = 0; i < TF_COUNT; i++)
      g_Eligible[i] = chartSecs <= PeriodSeconds(TF_PERIODS[i]);

   IndicatorSetString(INDICATOR_SHORTNAME,
                      StringFormat("BB MTF (%d, %.1f)", InpPeriod, InpDeviations));

   g_LastBarTime = 0;
   Panel_Create();
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   ChartSetInteger(0, CHART_MOUSE_SCROLL, true);
   Panel_Delete();

   if(reason == REASON_REMOVE || reason == REASON_RECOMPILE)
      State_Delete();

   for(int i = 0; i < TF_COUNT; i++)
      g_BB[i].Release();

   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//| Calculation                                                       |
//+------------------------------------------------------------------+
int OnCalculate(const int       rates_total,
                const int       prev_calculated,
                const datetime &time[],
                const double   &open[],
                const double   &high[],
                const double   &low[],
                const double   &close[],
                const long     &tick_volume[],
                const long     &volume[],
                const int      &spread[])
{
   g_RatesTotal = rates_total;
   ArrayCopy(g_Time, time);

   if(rates_total < InpPeriod)
      return 0;

   //--- Detect new bars per TF
   datetime curTFTime[TF_COUNT];
   bool     newTFBar[TF_COUNT];
   for(int i = 0; i < TF_COUNT; i++)
   {
      curTFTime[i] = iTime(_Symbol, TF_PERIODS[i], 0);
      newTFBar[i]  = (curTFTime[i] != g_LastTFTime[i]);
   }
   bool newCurrentBar = (time[rates_total - 1] != g_LastBarTime);

   //--- Effective visibility and force-redraw flags
   bool eff[TF_COUNT], force[TF_COUNT];
   for(int i = 0; i < TF_COUNT; i++)
   {
      eff[i]   = g_Show[i] && g_Eligible[i];
      force[i] = eff[i] && !g_PrevShow[i];
   }

   //--- Early-out: nothing changed
   if(prev_calculated > 0 && !newCurrentBar)
   {
      bool anyChange = false;
      for(int i = 0; i < TF_COUNT; i++)
         if(newTFBar[i] || force[i]) { anyChange = true; break; }
      if(!anyChange)
         return rates_total;
   }

   //--- Wait until all active TFs have data
   for(int i = 0; i < TF_COUNT; i++)
      if(eff[i] && !g_BB[i].IsReady())
         return 0;

   //--- Commit bar timestamps
   g_LastBarTime = time[rates_total - 1];
   for(int i = 0; i < TF_COUNT; i++)
   {
      g_LastTFTime[i] = curTFTime[i];
      g_PrevShow[i]   = eff[i];
   }

   //--- Fill or clear each TF
   int baseStart = (prev_calculated == 0) ? 0 : MathMax(0, prev_calculated - 2);
   for(int i = 0; i < TF_COUNT; i++)
   {
      int start = (force[i] || prev_calculated == 0) ? 0 : baseStart;
      if(eff[i])
         Bands_Update(i, true, start, rates_total, time);
      else if(prev_calculated == 0)
         Bands_Update(i, false, 0, rates_total, time);
   }

   BandLabels_Refresh();
   return rates_total;
}

//+------------------------------------------------------------------+
//| Chart events                                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam,
                  const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_MOUSE_MOVE)
   {
      int  mouseX = (int)lparam;
      int  mouseY = (int)dparam;
      bool lbDown = ((int)StringToInteger(sparam) & 1) != 0;

      if(lbDown && !g_WasLBDown)
      {
         bool overTitle =
            mouseX >= g_PanelX + PADDING &&
            mouseX <= g_PanelX + PANEL_W - PADDING &&
            mouseY >= g_PanelY + PADDING &&
            mouseY <= g_PanelY + PADDING + TOGGLE_H;

         if(overTitle)
         {
            g_Dragging        = true;
            g_ActuallyDragged = false;
            g_DragOffX        = mouseX - g_PanelX;
            g_DragOffY        = mouseY - g_PanelY;
            g_DragStartX      = mouseX;
            g_DragStartY      = mouseY;
            ChartSetInteger(0, CHART_MOUSE_SCROLL, false);
         }
      }

      if(!lbDown && g_Dragging)
      {
         g_Dragging = false;
         ChartSetInteger(0, CHART_MOUSE_SCROLL, true);
      }

      if(g_Dragging && lbDown)
      {
         int dx = mouseX - g_DragStartX;
         int dy = mouseY - g_DragStartY;

         if(!g_ActuallyDragged &&
            (MathAbs(dx) > DRAG_THRESHOLD || MathAbs(dy) > DRAG_THRESHOLD))
            g_ActuallyDragged = true;

         if(g_ActuallyDragged)
            Panel_Move(mouseX - g_DragOffX, mouseY - g_DragOffY);
      }

      g_WasLBDown = lbDown;
      return;
   }

   if(id != CHARTEVENT_OBJECT_CLICK)
      return;

   if(sparam == N("Toggle"))
   {
      ObjectSetInteger(0, N("Toggle"), OBJPROP_STATE, false);
      if(g_ActuallyDragged) { g_ActuallyDragged = false; return; }
      Panel_SetExpanded(!g_Expanded);
      return;
   }

   for(int i = 0; i < TF_COUNT; i++)
   {
      if(sparam == N(TF_CB_IDS[i]))
      {
         ToggleBandByIndex(i);
         return;
      }
   }
}
//+------------------------------------------------------------------+
