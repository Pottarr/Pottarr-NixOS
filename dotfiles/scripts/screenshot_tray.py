#!/usr/bin/env python3

import subprocess
import wx
import wx.adv

SCREENSHOT_CMD = "/home/pottarr/.local/bin/screenshot"


class ScreenshotTray(wx.adv.TaskBarIcon):
    def __init__(self, frame):
        super().__init__()
        self.frame = frame

        # Create a simple camera icon programmatically (16x16)
        bmp = wx.Bitmap(16, 16)
        dc = wx.MemoryDC(bmp)
        dc.SetBackground(wx.Brush(wx.Colour(0, 0, 0, 0)))
        dc.Clear()
        dc.SetPen(wx.Pen(wx.WHITE, 1))
        dc.SetBrush(wx.Brush(wx.WHITE))
        # Camera body
        dc.DrawRoundedRectangle(1, 4, 14, 10, 2)
        # Camera lens
        dc.SetBrush(wx.Brush(wx.BLACK))
        dc.DrawCircle(8, 9, 3)
        # Camera top bump
        dc.DrawRectangle(5, 2, 6, 3)
        dc.SelectObject(wx.NullBitmap)

        icon = wx.Icon()
        icon.CopyFromBitmap(bmp)
        self.SetIcon(icon, "Screenshot")

        self.Bind(wx.adv.EVT_TASKBAR_LEFT_DOWN, self.on_left_click)

    def on_left_click(self, event):
        self.PopupMenu(self.CreatePopupMenu())

    def CreatePopupMenu(self):
        menu = wx.Menu()

        item_sel = menu.Append(-1, "\U0001f4f7  Selection")
        item_full = menu.Append(-1, "\U0001f5a5\ufe0f  Full Screen")
        item_win = menu.Append(-1, "\U0001fa9f  Current Window")
        item_color = menu.Append(-1, "\U0001f3a8  Color Picker")
        menu.AppendSeparator()
        item_quit = menu.Append(-1, "\u274c  Quit")

        self.Bind(wx.EVT_MENU, lambda e: self.take(""), item_sel)
        self.Bind(wx.EVT_MENU, lambda e: self.take("full"), item_full)
        self.Bind(wx.EVT_MENU, lambda e: self.take("window"), item_win)
        self.Bind(wx.EVT_MENU, lambda e: self.take("color"), item_color)
        self.Bind(wx.EVT_MENU, self.on_quit, item_quit)

        return menu

    def take(self, mode):
        cmd = [SCREENSHOT_CMD]
        if mode:
            cmd.append(mode)
        subprocess.Popen(cmd)

    def on_quit(self, event):
        self.RemoveIcon()
        self.frame.Close()


def main():
    app = wx.App(False)

    # Hidden frame to keep the app alive
    frame = wx.Frame(None, style=wx.FRAME_NO_TASKBAR)
    frame.Show(False)

    ScreenshotTray(frame)
    app.MainLoop()


if __name__ == "__main__":
    main()
