//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Rear Wall
//

include <common.scad>

module ramps_board() {
  mega_w = 53.2; mega_h = 101.75; mega_d = 13.8;
  mega_hole_y = 13.6; mega_hole_x = 2;

  shield_w = 61.52; shield_h = mega_h; shield_d = 11.7;

  lcd_w = 73.52; lcd_h = 46.7; lcd_d = 18.5; lcd_v = 14.3;

  translate([-mega_hole_x, -mega_hole_y]) {
    color([0,0,1,0.5]) {
      cube([mega_w, mega_h, mega_d]);
    }
    translate([0,0,mega_d])
      color([0,1,0,0.5]) {
        cube([shield_w, shield_h, shield_d]);
    }
    translate([0, mega_h - (lcd_h - lcd_v), mega_d + shield_d])
      color([0,1,1,0.5]) {
        cube([lcd_w, lcd_h, lcd_d]);
    }

    translate([usb_x-0.5, -10, usb_y])
      color([0.8,0.8,1,0.5]) {
        cube([usb_w, 10, usb_h]);
    }

    translate([dc_x-0.5, -10, dc_y])
      color([0.8,1,0.5,0.8]) {
        cube([dc_w, 10, dc_h - 2]);
    }
  }
}

module board_riser(h=1.5) {
  cylinder(r1=3mm_hole_r + 3, r2=3mm_hole_r + 1.25, h=h, $fn=8);
}

module board_risers(h) {
  translate([0, 1.27, 0])   board_riser(h);
  translate([48.26, 0, 0])  board_riser(h);
  translate([0, 76.2, 0])   board_riser(h);
  translate([48.26, 82.55, 0]) board_riser(h);
}

module peg_mount() {
  peg_len = 15;
  nub_size = 5;
  difference() {
    union() {
      cylinder(r=3mm_hole_r, h=peg_len);
      translate([0, 0, peg_len - nub_size])
        cylinder(r1=3mm_hole_r + 0.2, r2=3mm_hole_r, h=nub_size, $fn=12);
      translate([0, 0, peg_len - nub_size * 2])
        cylinder(r1=3mm_hole_r, r2=3mm_hole_r + 0.2, h=nub_size, $fn=12);
    }
    // translate([-0.125, -3mm_hole_r, rh + 3])
    //   cube([0.25, 3mm_hole_r * 2, peg_len - rh]);
  }
}

module mounting_pegs() {
  translate([0, 0, rh]) {
    translate([0, 1.27])     peg_mount();
    translate([48.26, 0])    peg_mount();
    translate([0, 76.2])     peg_mount();
    translate([48.26, 82.55])  peg_mount();
  }
}

module hole_with_trap(trap=true) {
  translate([0, 0, -0.5]) {
      cylinder(r=3mm_hole_r, h=wt+rh+1);
    if (trap) {
      if (screw_mounts) {
        cylinder(r=3, h=nut_depth, $fn=12);
      }
      else {
        cylinder(r=3.6, h=nut_depth - 0.75, $fn=6);
      }
    }
  }
}

module mounting_holes(trap=true) {
  for (v=[[0, 1.27], [48.26, 0], [0, 76.2], [48.26, 82.55]])
    translate([v[0], v[1], -wt])
      hole_with_trap(trap);
}

module rear_wall() {
  difference() {
    // The main box structure
    union() {
      // Wall
      translate([-wt,-wt,-wt])
        cube([fw, fh, wt]);

      if (!beveled_walls && (!whole_box || show_glued)) assign(xx=(bw-fan_width)/2) {
        translate([0,bh-wt]) {
          cube([xx,wt,rim_depth]);
          translate([bw-xx,0]) cube([xx,wt,rim_depth]);
        }
        cube([bw,wt,rim_depth]);
        cube([wt,bh,rim_depth]);
        translate([bw-wt,0]) cube([wt,bh,rim_depth]);
      }

      // Mounting
      translate([mount_x, mount_y]) {

        // Risers that the board mounts on
        // These may be printed separately or built-in
        if (builtin_risers)
          board_risers(screw_mounts ? rh - nut_depth : rh);

        // Shorter risers for rear-mounting screws
        translate([mount_offset_x, mount_offset_y, 0])
          board_risers(2);

        // If pegs are used, stick them on the risers
        if (use_peg_mounts) {
          translate([0, 0, -wt])
            mounting_pegs();
        }
      }
    }

    // Remove the lower wall to clip overhanging risers
    translate([0, -wt]) {
      translate([-wt, 0]) {
        cube([fw-wt, wt, wt*2]);
        cube([wt, fh-wt, wt*2]);
      }
      translate([bw, 0]) cube([wt, fh-wt, wt*2]);
    }

    // Mounting Holes to connect to the frame
    translate([mount_x + mount_offset_x, mount_y + mount_offset_y, 0]) {
      mounting_holes(false);
      translate([0, 0, 5+2])
        for (v=[[0, 1.27], [48.26, 0], [0, 76.2], [48.26, 82.55]]) translate(v) cube([10,10,10], center=true);
    }

    // Make 3mm holes if not using pegs
    if (!use_peg_mounts) {
      translate([mount_x, mount_y, 0])
        mounting_holes();
    }

    if (!whole_box && beveled_walls) {
      for (y=[-wt,fh-wt]) {
        translate([bw/2,y])
          difference() {
            rotate([45,0,0])
              cube([fw+1, wt*1.414, wt*1.414], center=true);
            cube([wt2, wt2, wt2], center=true);
          }
      }
      for (x=[-wt,fw-wt]) {
        translate([x,bh/2]) {
          difference() {
            rotate([0,45,0])
              cube([wt*1.414, fh+1, wt*1.414], center=true);
            cube([wt2, wt2, wt2], center=true);
          }
        }
      }
    }
  }

  if (preview_mode) translate([mount_x,mount_y,rh]) ramps_board();
}

if (whole_box) { rear_wall(); } else { translate([0,0,wt]) rear_wall(); }
