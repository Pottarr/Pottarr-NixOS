#!/usr/bin/env python3
import wx
import wx.adv
import sys

class CalendarPopup(wx.PopupTransientWindow):
    def __init__(self, parent):
        # SIMPLE_BORDER to give it a nice edge
        super(CalendarPopup, self).__init__(parent, wx.SIMPLE_BORDER)

        panel = wx.Panel(self)
        panel.SetBackgroundColour(wx.Colour(0, 0, 0, 0))

        self.today = wx.DateTime.Now()
        self.calendar = wx.adv.CalendarCtrl(panel, -1, self.today, 
                                            style=wx.adv.CAL_SHOW_HOLIDAYS | 
                                                  wx.adv.CAL_SEQUENTIAL_MONTH_SELECTION | 
                                                  wx.adv.CAL_SUNDAY_FIRST)

        # Intercept mouse clicks to prevent selecting a different day
        self.calendar.Bind(wx.EVT_LEFT_DOWN, self.OnCalendarLeftDown)

        sizer = wx.BoxSizer(wx.VERTICAL)
        sizer.Add(self.calendar, 1, wx.EXPAND | wx.ALL, 10)
        panel.SetSizer(sizer)

        sizer.Fit(panel)
        self.Fit()

    def OnCalendarLeftDown(self, event):
        # HitTest tells us what part of the calendar was clicked
        hit_result = self.calendar.HitTest(event.GetPosition())
        # hit_result is a tuple: (HitTestPlace, DateTime, WeekDay)
        if hit_result[0] == wx.adv.CAL_HITTEST_DAY:
            # The user clicked on a day. We simply return and DO NOT call event.Skip()
            # This blocks the click, preventing the selection from moving!
            return
        
        # For everything else (like month/year arrows), allow the click through
        event.Skip()


    def OnDismiss(self):
        # Close the app when the popup is dismissed (clicked outside)
        wx.GetApp().ExitMainLoop()
        super(CalendarPopup, self).OnDismiss()

class MainApp(wx.App):
    def OnInit(self):
        # We create a hidden frame as the parent to the popup
        self.frame = wx.Frame(None, -1, "Hidden Frame")
        self.popup = CalendarPopup(self.frame)

        self.Bind(wx.EVT_ACTIVATE_APP, self.OnActivateApp)

        mouse_pos = wx.GetMousePosition()
        popup_size = self.popup.GetSize()
        display_size = wx.GetDisplaySize()

        # Position slightly below and centered to the mouse
        x = mouse_pos.x - (popup_size.width // 2)
        y = mouse_pos.y + 10

        if y + popup_size.height > display_size.height:
            y = mouse_pos.y - popup_size.height - 10

        if x < 0:
            x = 0
        elif x + popup_size.width > display_size.width:
            x = display_size.width - popup_size.width

        self.popup.SetPosition((x, y))
        self.popup.Popup()
        return True

    def OnActivateApp(self, event):
        if not event.GetActive():
            self.popup.Dismiss()
        event.Skip()

if __name__ == "__main__":
    app = MainApp(False)
    app.MainLoop()
