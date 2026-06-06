#!/usr/bin/env python3

import subprocess
import wx

SCREENSHOT_CMD = "/home/pottarr/.local/bin/screenshot"


class ScreenshotMenu(wx.Menu):
    def __init__(self, parent):
        super().__init__()
        self.parent = parent

        item_sel = self.Append(-1, "📷  Selection")
        item_full = self.Append(-1, "🖥️  Full Screen")
        item_win = self.Append(-1, "🖼️  Current Window")
        item_color = self.Append(-1, "🎨  Color Picker")

        parent.Bind(wx.EVT_MENU, lambda e: self.take(""), item_sel)
        parent.Bind(wx.EVT_MENU, lambda e: self.take("full"), item_full)
        parent.Bind(wx.EVT_MENU, lambda e: self.take("window"), item_win)
        parent.Bind(wx.EVT_MENU, lambda e: self.take("color"), item_color)

    def take(self, mode):
        cmd = [SCREENSHOT_CMD]
        if mode:
            cmd.append(mode)
        subprocess.Popen(cmd)


class InvisibleFrame(wx.Frame):
    def __init__(self):
        mouse_pos = wx.GetMousePosition()
        # Create a tiny invisible frameless window at the mouse position
        super().__init__(
            None,
            style=wx.FRAME_NO_TASKBAR | wx.BORDER_NONE,
            size=(1, 1),
            pos=mouse_pos,
        )
        self.Show()

        # Open the popup menu on startup
        wx.CallAfter(self.show_menu)

    def show_menu(self):
        menu = ScreenshotMenu(self)
        self.PopupMenu(menu, 0, 0)
        menu.Destroy()
        self.Close()


def main():
    app = wx.App(False)
    InvisibleFrame()
    app.MainLoop()


if __name__ == "__main__":
    main()
