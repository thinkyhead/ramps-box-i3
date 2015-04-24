//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Cover
//

include <common.scad>

clip_width = 8;
clips_test_piece = true;

module cover_clip() {
  clip_length = 8.214;
  union() {
    cube([rim_thickness * 2.5, clip_width, clip_length]);
    translate([0, clip_width / 2, clip_length - 1.414])
      rotate([0, 45, 0])
        cube([rim_thickness,clip_width,rim_thickness], center=true);
  }
}

module cover() {
  hole1_w = 20; hole1_h = 50;
  hole2_w = bw - rt * 2 - 2; hole2_h = 20;

  hole3_w = hole2_w; hole3_h = 3;
  hole4_w = 18; hole4_h = 10;

  fan_space = fan_width + 2;

  rd = rim_depth * 1.5;
  chop = 36;

  difference() {
    union() {
      translate([-wt, -wt, -wt])
        cube([fw, fh, wt]);

      if (!beveled_walls && (!whole_box || show_glued)) assign(xx=(bw-fan_width)/2) {
        if (chop == 0) {
          // top rims
          translate([0,bh-wt])
            for (x=[bw-xx,0]) translate([x,0]) cube([xx,wt,rd]);
        }
        // bottom rim
        translate([chop/6,0]) cube([bw-chop/3,wt,rd]);
        // left/right rim
        for (x=[bw-wt,0]) translate([x,chop/2]) cube([wt,bh-chop,rd]);
      }
    }

    // 10 vent holes
    translate([0, rt + 1, -wt - 0.5])
      for (x=[0:10])
        translate([(bw - 10 * 6.5) / 2 + x * 6.5 - 1, 0])
          cube([3, 10, wt + 1]);

  	// The optional fan mount
    if (!top_mounted_fan) {
        translate([25 + rt, bh - rt - 50, -wt - 0.5])
          fan_mount();
    }

    // For the SmartLCD add cable holes
    if (smart_lcd) {
      translate([mount_x - 2.5 + 14, mount_y - 14.6 + ramps_height - 12, -wt - 0.5]) {
        cube([43.1, 12, wt + 1]);
      }
      // translate([(bw - hole3_w) / 2, bh - rt - 1, -wt - 0.5]) {
      //   // Or it can have LCD holes, but not both
      //   translate([0, -hole3_h, 0])
      //     cube([hole3_w, hole3_h, wt + 1]);
      //   translate([hole3_w - lcd_plug_w, -lcd_plug_h, 0])
      //     cube([lcd_plug_w, lcd_plug_h, wt + 1]);
      // }
    }
  }

  if (cover_clipon) assign(cw2=clip_width/2, end1=14, end2=bh-14) {
    for (t=[ [0, end1-cw2], [bw, end1+cw2], [0, end2-cw2], [bw, end2+cw2] ]) {
      translate(t) rotate([0,0,t[0]==0?0:180]) cover_clip();
    }
  }
}

if (whole_box) {
  translate([bw, 0, bd]) rotate([0,180,0]) color([1,1,1,0.75]) %cover();
} else {
  intersection() {
    color([0.5,0.9,0.5]) cover();
    if (clips_test_piece) {
      translate([0,0,-wt]) {
        translate([-wt, bh-14-wt2, -wt]) cube([fw,clip_width,20]);
      }
    }
  }
}
