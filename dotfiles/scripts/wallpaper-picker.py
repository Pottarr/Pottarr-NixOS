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
        main_sizer = wx.BoxSizer(wx.HORIZONTAL)

        # Left panel: Directory and File Explorer
        left_panel = wx.Panel(self)
        left_sizer = wx.BoxSizer(wx.VERTICAL)

        explorer_label = wx.StaticText(left_panel, label="📁 Browse Wallpapers:")
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
        
        # Bind file selection change
        self.dir_ctrl.Bind(wx.EVT_DIRCTRL_SELECTIONCHANGED, self.on_file_changed)
        
        left_sizer.Add(self.dir_ctrl, 1, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 10)

        # Show hidden checkbox
        self.chk_hidden = wx.CheckBox(left_panel, label="Show Hidden (Ctrl+H)")
        self.chk_hidden.Bind(wx.EVT_CHECKBOX, self.on_toggle_hidden)
        left_sizer.Add(self.chk_hidden, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 10)

        # Accelerator Table for Ctrl+H shortcut
        self.accel_tbl_id = wx.NewIdRef()
        self.Bind(wx.EVT_MENU, self.on_toggle_hidden, id=self.accel_tbl_id)
        accel_tbl = wx.AcceleratorTable([(wx.ACCEL_CTRL, ord('h'), self.accel_tbl_id)])
        self.SetAcceleratorTable(accel_tbl)

        # Wallpaper mode choice
        mode_label = wx.StaticText(left_panel, label="Style (Scale/Tile/Center/Fill):")
        left_sizer.Add(mode_label, 0, wx.TOP | wx.LEFT | wx.RIGHT, 10)

        # Load existing mode if saved
        saved_mode = "scale"
        if os.path.exists(STATE_FILE + "_mode"):
            try:
                with open(STATE_FILE + "_mode", "r") as f:
                    saved_mode = f.read().strip().lower()
            except Exception:
                pass
        
        mode_choices = ["Scale", "Tile", "Center", "Fill"]
        default_sel = 0
        for idx, m in enumerate(mode_choices):
            if m.lower() == saved_mode:
                default_sel = idx
                break

        self.mode_choice = wx.Choice(left_panel, choices=mode_choices)
        self.mode_choice.SetSelection(default_sel)
        self.mode_choice.Bind(wx.EVT_CHOICE, self.on_mode_changed)
        left_sizer.Add(self.mode_choice, 0, wx.EXPAND | wx.LEFT | wx.RIGHT | wx.BOTTOM, 10)

        left_panel.SetSizer(left_sizer)

        # Right panel: Preview & Actions
        right_panel = wx.Panel(self)
        right_sizer = wx.BoxSizer(wx.VERTICAL)

        # Preview area (custom drawn)
        self.preview_canvas = wx.Panel(right_panel)
        self.preview_canvas.Bind(wx.EVT_PAINT, self.on_paint)
        right_sizer.Add(self.preview_canvas, 1, wx.EXPAND | wx.ALL, 10)

        # Button row
        btn_sizer = wx.BoxSizer(wx.HORIZONTAL)

        self.btn_set = wx.Button(right_panel, label="Set Wallpaper")
        self.btn_set.Bind(wx.EVT_BUTTON, self.on_set_wallpaper)
        self.btn_set.Disable()
        btn_sizer.Add(self.btn_set, 1, wx.RIGHT, 10)

        btn_close = wx.Button(right_panel, label="Close")
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

    def on_mode_changed(self, event):
        self.preview_canvas.Refresh()

    def on_paint(self, event):
        dc = wx.PaintDC(self.preview_canvas)
        size = self.preview_canvas.GetSize()

        # Fill background color matching standard window/panel color
        bg_color = wx.SystemSettings.GetColour(wx.SYS_COLOUR_3DFACE)
        dc.SetBackground(wx.Brush(bg_color))
        dc.Clear()

        # Get actual screen dimensions to calculate aspect ratio
        screen_w, screen_h = wx.GetDisplaySize()
        screen_ratio = screen_w / screen_h

        # Calculate largest box inside size that has screen_ratio (leave a small margin)
        margin = 15
        canvas_w = size.width - margin * 2
        canvas_h = size.height - margin * 2

        if canvas_w / canvas_h > screen_ratio:
            # Fit by height
            box_h = canvas_h
            box_w = int(box_h * screen_ratio)
        else:
            # Fit by width
            box_w = canvas_w
            box_h = int(box_w / screen_ratio)

        # Center this simulated screen box
        box_x = (size.width - box_w) // 2
        box_y = (size.height - box_h) // 2

        # Standard dark theme gray colors
        border_color = wx.Colour(80, 80, 80)
        text_color = wx.SystemSettings.GetColour(wx.SYS_COLOUR_WINDOWTEXT)

        if not self.selected_file:
            # Draw helper info text
            dc.SetTextForeground(text_color)
            font = wx.Font(11, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD)
            dc.SetFont(font)
            text = "Select an image from the explorer"
            tw, th = dc.GetTextExtent(text)
            dc.DrawText(text, box_x + (box_w - tw) // 2, box_y + (box_h - th) // 2)
            
            # Draw border representing screen edges (neutral gray)
            dc.SetPen(wx.Pen(border_color, 2))
            dc.SetBrush(wx.TRANSPARENT_BRUSH)
            dc.DrawRectangle(box_x, box_y, box_w, box_h)
            return

        try:
            img = wx.Image(self.selected_file, wx.BITMAP_TYPE_ANY)
            img_w, img_h = img.GetWidth(), img.GetHeight()
            mode = self.mode_choice.GetString(self.mode_choice.GetSelection()).lower()

            if mode == "scale":
                # Stretches image to fit simulated screen completely
                img.Rescale(box_w, box_h, wx.IMAGE_QUALITY_HIGH)
                bmp = wx.Bitmap(img)
                dc.DrawBitmap(bmp, box_x, box_y)

            elif mode == "tile":
                # Tiles image repeatedly at original size inside simulated screen
                bmp = wx.Bitmap(img)
                # Create a clipping region so tiles don't overflow the simulated screen box
                dc.SetClippingRegion(box_x, box_y, box_w, box_h)
                for x in range(box_x, box_x + box_w, img_w):
                    for y in range(box_y, box_y + box_h, img_h):
                        dc.DrawBitmap(bmp, x, y)
                dc.DestroyClippingRegion()

            elif mode == "center":
                # Centers original size image inside simulated screen, clipping if too large
                x = box_x + (box_w - img_w) // 2
                y = box_y + (box_h - img_h) // 2
                bmp = wx.Bitmap(img)
                dc.SetClippingRegion(box_x, box_y, box_w, box_h)
                dc.DrawBitmap(bmp, x, y)
                dc.DestroyClippingRegion()

            elif mode == "fill":
                # Scales to fill simulated screen maintaining aspect ratio (crops excess)
                scale = max(box_w / img_w, box_h / img_h)
                new_w = max(1, int(img_w * scale))
                new_h = max(1, int(img_h * scale))
                x = box_x + (box_w - new_w) // 2
                y = box_y + (box_h - new_h) // 2
                img.Rescale(new_w, new_h, wx.IMAGE_QUALITY_HIGH)
                bmp = wx.Bitmap(img)
                dc.SetClippingRegion(box_x, box_y, box_w, box_h)
                dc.DrawBitmap(bmp, x, y)
                dc.DestroyClippingRegion()

            # Draw border representing screen edges (neutral gray)
            dc.SetPen(wx.Pen(border_color, 2))
            dc.SetBrush(wx.TRANSPARENT_BRUSH)
            dc.DrawRectangle(box_x, box_y, box_w, box_h)

            # Draw i3bar simulation at the top of the simulated screen box
            bar_height = max(12, int(box_h * 0.045))
            dc.SetPen(wx.TRANSPARENT_PEN)
            dc.SetBrush(wx.Brush(wx.Colour(20, 20, 20))) # Normal dark i3bar background
            dc.DrawRectangle(box_x + 1, box_y + 1, box_w - 2, bar_height)
            
            # Draw thin separator line below the i3bar simulation
            dc.SetPen(wx.Pen(wx.Colour(50, 50, 50), 1)) # Dark separator line
            dc.DrawLine(box_x + 1, box_y + bar_height + 1, box_x + box_w - 2, box_y + bar_height + 1)
            
            dc.SetTextForeground(wx.Colour(200, 200, 200))
            font = wx.Font(max(6, int(bar_height * 0.45)), wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL)
            dc.SetFont(font)
            dc.DrawText("i3status / i3bar zone (top)", box_x + 6, box_y + (bar_height - dc.GetTextExtent("i3status")[1]) // 2)

        except Exception as e:
            dc.SetTextForeground(wx.Colour(220, 80, 80)) # Softer dark theme red
            dc.DrawText(f"Failed to load preview: {str(e)}", 10, 10)
            
            # Draw border around simulated screen box (neutral gray)
            dc.SetPen(wx.Pen(border_color, 2))
            dc.SetBrush(wx.TRANSPARENT_BRUSH)
            dc.DrawRectangle(box_x, box_y, box_w, box_h)

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

            # Save the wallpaper mode to the state file
            mode = self.mode_choice.GetString(self.mode_choice.GetSelection()).lower()
            with open(STATE_FILE + "_mode", "w") as f:
                f.write(mode)

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
