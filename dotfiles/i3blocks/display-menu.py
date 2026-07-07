#!/usr/bin/env python3
import subprocess
import wx

class DisplayMenu(wx.Menu):
    def __init__(self, parent):
        super().__init__()
        self.parent = parent

        item_settings = self.Append(-1, "🖥️  Open Display Settings")
        item_cancel = self.Append(-1, "❌  Cancel")

        parent.Bind(wx.EVT_MENU, self.open_settings, item_settings)
        parent.Bind(wx.EVT_MENU, self.on_cancel, item_cancel)

    def open_settings(self, event):
        subprocess.Popen(["xfce4-display-settings"])

    def on_cancel(self, event):
        pass

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
        menu = DisplayMenu(self)
        self.PopupMenu(menu, 0, 0)
        menu.Destroy()
        self.Close()

def main():
    app = wx.App(False)
    InvisibleFrame()
    app.MainLoop()

if __name__ == "__main__":
    main()
