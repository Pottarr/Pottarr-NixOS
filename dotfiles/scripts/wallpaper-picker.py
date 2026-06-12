#!/usr/bin/env python3

import os
import shutil
import subprocess
import wx

STATE_FILE = os.path.expanduser("~/.config/i3/.current_wallpaper")
DAEMON_CMD = "/home/pottarr/.local/bin/wallpaper-daemon.sh"
START_DIR = os.path.expanduser("~/Pictures")


class WallpaperPicker(wx.Frame):
    def __init__(self):
        super().__init__(
            None,
            title="Wallpaper Picker",
            size=(950, 600),
            style=wx.DEFAULT_FRAME_STYLE,
        )

        self.selected_file = None
        self.init_ui()
        self.Centre()

    def init_ui(self):
        # Premium Dark Palette (Catppuccin Macchiato style)
        self.SetBackgroundColour(wx.Colour(30, 30, 46))

        main_sizer = wx.BoxSizer(wx.HORIZONTAL)

        # Left panel: Directory and File Explorer (wxWidgets built-in)
        left_panel = wx.Panel(self)
        left_panel.SetBackgroundColour(wx.Colour(36, 39, 58))
        left_sizer = wx.BoxSizer(wx.VERTICAL)

        explorer_label = wx.StaticText(left_panel, label="📁 Browse Wallpapers:")
        explorer_label.SetForegroundColour(wx.Colour(202, 211, 245))
        left_sizer.Add(explorer_label, 0, wx.ALL, 10)

        # Ensure starting directory exists
        if not os.path.exists(START_DIR):
            try:
                os.makedirs(START_DIR)
            except Exception:
                pass

        # Native wxWidgets generic file/directory control
        self.dir_ctrl = wx.GenericDirCtrl(
            left_panel,
            dir=START_DIR,
            style=wx.DIRCTRL_SHOW_FILTERS | wx.BORDER_NONE,
            filter="Image files (*.png;*.jpg;*.jpeg;*.bmp)|*.png;*.jpg;*.jpeg;*.bmp",
        )
        self.dir_ctrl.SetBackgroundColour(wx.Colour(48, 52, 70))
        self.dir_ctrl.SetForegroundColour(wx.Colour(202, 211, 245))
        
        # Bind file selection change
        self.dir_ctrl.Bind(wx.EVT_DIRCTRL_SELECTIONCHANGED, self.on_file_changed)
        
        left_sizer.Add(self.dir_ctrl, 1, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 10)

        # Show hidden checkbox
        self.chk_hidden = wx.CheckBox(left_panel, label="Show Hidden (Ctrl+H)")
        self.chk_hidden.SetForegroundColour(wx.Colour(202, 211, 245))
        self.chk_hidden.Bind(wx.EVT_CHECKBOX, self.on_toggle_hidden)
        left_sizer.Add(self.chk_hidden, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 10)

        # Accelerator Table for Ctrl+H shortcut
        self.accel_tbl_id = wx.NewIdRef()
        self.Bind(wx.EVT_MENU, self.on_toggle_hidden, id=self.accel_tbl_id)
        accel_tbl = wx.AcceleratorTable([(wx.ACCEL_CTRL, ord('h'), self.accel_tbl_id)])
        self.SetAcceleratorTable(accel_tbl)
        left_panel.SetSizer(left_sizer)

        # Right panel: Preview & Actions
        right_panel = wx.Panel(self)
        right_sizer = wx.BoxSizer(wx.VERTICAL)

        # Preview area (custom drawn)
        self.preview_canvas = wx.Panel(right_panel)
        self.preview_canvas.SetBackgroundColour(wx.Colour(30, 30, 46))
        self.preview_canvas.Bind(wx.EVT_PAINT, self.on_paint)
        right_sizer.Add(self.preview_canvas, 1, wx.EXPAND | wx.ALL, 10)

        # Button row
        btn_sizer = wx.BoxSizer(wx.HORIZONTAL)

        self.btn_set = wx.Button(right_panel, label="Set Wallpaper")
        self.btn_set.SetBackgroundColour(wx.Colour(139, 213, 202)) # Teal green
        self.btn_set.SetForegroundColour(wx.Colour(30, 30, 46))
        self.btn_set.Bind(wx.EVT_BUTTON, self.on_set_wallpaper)
        self.btn_set.Disable()
        btn_sizer.Add(self.btn_set, 1, wx.RIGHT, 10)

        btn_close = wx.Button(right_panel, label="Close")
        btn_close.SetBackgroundColour(wx.Colour(238, 153, 160)) # Pastel red
        btn_close.SetForegroundColour(wx.Colour(30, 30, 46))
        btn_close.Bind(wx.EVT_BUTTON, lambda e: self.Close())
        btn_sizer.Add(btn_close, 1, wx.LEFT, 10)

        right_sizer.Add(btn_sizer, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 15)
        right_panel.SetSizer(right_sizer)

        # Assemble layout
        main_sizer.Add(left_panel, 2, wx.EXPAND)
        main_sizer.Add(right_panel, 3, wx.EXPAND)
        self.SetSizer(main_sizer)

    def on_file_changed(self, event):
        path = self.dir_ctrl.GetFilePath()
        if path and os.path.isfile(path):
            self.selected_file = path
            self.btn_set.Enable()
        else:
            self.selected_file = None
            self.btn_set.Disable()
        self.preview_canvas.Refresh()

    def on_toggle_hidden(self, event):
        # Toggle checkbox if triggered via shortcut
        if not isinstance(event.GetEventObject(), wx.CheckBox):
            self.chk_hidden.SetValue(not self.chk_hidden.GetValue())
            
        show = self.chk_hidden.GetValue()
        self.dir_ctrl.ShowHidden(show)
        self.dir_ctrl.ReCreateTree()

    def on_paint(self, event):
        dc = wx.PaintDC(self.preview_canvas)
        size = self.preview_canvas.GetSize()

        # Fill background color
        dc.SetBackground(wx.Brush(wx.Colour(30, 30, 46)))
        dc.Clear()

        if not self.selected_file:
            # Draw helper info text
            dc.SetTextForeground(wx.Colour(165, 173, 203))
            font = wx.Font(13, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD)
            dc.SetFont(font)
            text = "Select an image from the file explorer"
            tw, th = dc.GetTextExtent(text)
            dc.DrawText(text, (size.width - tw) // 2, (size.height - th) // 2)
            return

        try:
            # Scale and display image
            img = wx.Image(self.selected_file, wx.BITMAP_TYPE_ANY)
            img_w, img_h = img.GetWidth(), img.GetHeight()

            scale = min(size.width / img_w, size.height / img_h)
            new_w = max(1, int(img_w * scale))
            new_h = max(1, int(img_h * scale))

            x = (size.width - new_w) // 2
            y = (size.height - new_h) // 2

            img.Rescale(new_w, new_h, wx.IMAGE_QUALITY_HIGH)
            bmp = wx.Bitmap(img)
            dc.DrawBitmap(bmp, x, y)
        except Exception as e:
            dc.SetTextForeground(wx.Colour(238, 153, 160))
            dc.DrawText(f"Failed to load preview: {str(e)}", 10, 10)

    def on_set_wallpaper(self, event):
        if not self.selected_file or not os.path.exists(self.selected_file):
            return

        try:
            # Save the wallpaper path to the state file
            target_dir = os.path.dirname(STATE_FILE)
            if not os.path.exists(target_dir):
                os.makedirs(target_dir)

            with open(STATE_FILE, "w") as f:
                f.write(self.selected_file)

            # Trigger background daemon update
            subprocess.Popen([DAEMON_CMD, "--once"])

            wx.MessageBox(
                "Wallpaper applied successfully!",
                "Success",
                wx.OK | wx.ICON_INFORMATION,
            )
            self.Close()
        except Exception as e:
            wx.MessageBox(
                f"Failed to set wallpaper: {str(e)}",
                "Error",
                wx.OK | wx.ICON_ERROR,
            )


def main():
    app = wx.App(False)
    frame = WallpaperPicker()
    frame.Show()
    app.MainLoop()


if __name__ == "__main__":
    main()
