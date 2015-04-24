//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Configuration Options
//

$fn = 36;
3mm_hole_r = 1.65;
preview_mode = false;	// include reference object in the view

use_peg_mounts = false; // Mount Arduino on pegs, not bolts
screw_mounts = false;	// Use screws instead of printed pegs
smart_lcd = true;       // Make opening for LCD ribbon
lcd_bulge = false;      // Only the LCD mount part of the box is wider
top_mounted_fan = true; // Mount the fan on the top or the front
use_convection = false; // Make holes for vertical airflow
cover_clipon = true;	// Make a clip-on cover

beveled_walls = false;	// make the walls beveled for face-to-face gluing (not recommended)
show_glued = false;		// show glue tabs in whole box view

wall_thickness = 2;     // Outer walls thickness
rim_thickness = 2;      // Lid rim thickness
rim_depth = 4;          // Lid rim depth

// Fan dimensions
fan_thickness = 19.9;
fan_width = 50;

//
// Standard RAMPS dimensions
//
ramps_width = smart_lcd ? 74 : 60.2;
ramps_height = smart_lcd ? 116 : 102;
ramps_depth = smart_lcd ? 40 : 39;
ramps_clearance = 4;
front_clearance = 5 + (top_mounted_fan ? 0 : fan_thickness);

// Internal risers will make the box deeper
builtin_risers = true;	// Risers part of the rear wall or separate?
riser_height = 5;      	// Height of mounting risers
nut_depth = 2.3;        // 3mm nut depth


//
// The size of the box
//
box_width = ramps_width + ramps_clearance * 2;
box_height = ramps_height + ramps_clearance + (top_mounted_fan ? fan_thickness + 1 : 0);
min_depth = ramps_depth + riser_height + front_clearance;
box_depth = (top_mounted_fan && min_depth < fan_width + 2) ? fan_width + 2 : min_depth;

//
// Offset for Arduino-style mounting holes
//
mount_offset_x = 23;
mount_offset_y = -11;

lcd_plug_w = 18; lcd_plug_h = 10;

mount_x = 2.5 + ramps_clearance;
mount_y = 14.5;

vent_holes = 14;


// // // // // // // // // // // // // // // // // //


wt = wall_thickness;  wt2 = wt * 2;
rt = rim_thickness;   rt2 = rt * 2;
wandr = wt + rt;

bh = box_height; fh = bh + wt2;
bw = box_width; fw = bw + wt2;
bd = box_depth; fd = bd + wt;
rh = riser_height;

whole_box = (make_whole == true) ? true : false;

// Bottom Ports
usb_w = 12.4 + 1; usb_h = 10.85 + 1;
usb_x = 8.8 - 0.5; usb_y = 2 - 0.5;

pwr_w = 28; pwr_h = 8;
pwr_x = 6; pwr_y = 15.4;

dc_w = 22; dc_h = 11.5;
dc_x = 37.5; dc_y = 13.4;

