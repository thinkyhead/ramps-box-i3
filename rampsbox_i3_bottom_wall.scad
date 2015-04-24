//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Bottom Wall
//

include <common.scad>

module bottom_wall() {

  ard_r = 3.15 + 2;
  reset_r = 4.2;

  difference() {
    union() {
      // Exterior Solid Wall 3mm thick
      translate([-wt,-wt,-wt])
        cube([fw, wt, fd]);

      if (!beveled_walls && (!whole_box || show_glued)) {
          for (x=[0,bw-rt]) translate([x,0,-wt+rim_depth]) cube([rt,rim_depth,fd-rim_depth*2.5]);  // leave room for cover tabs
        }
    }

    // Vent holes
    translate([0,-wt-0.5,bd-10-rim_depth-2]) {
      for (x=[0:vent_holes]) {
        translate([(bw - vent_holes * 5) / 2 + x * 5 - 1, 0])
          cube([2, wt+1, 10]);
      }
    }

    // Board-relative openings - relative to left-bottom edge
    translate([0, 0, rh]) {

      translate([mount_x-2.5, -wt - 0.5, 0]) {
        // USB connector
        translate([usb_x, 0, usb_y])
          cube([usb_w, wt+1, usb_h]);

        // RAMPS D8 D9 D10 Holes
        translate([pwr_x, 0, pwr_y])
          cube([pwr_w, wt+1, pwr_h]);

        // DC connector
        translate([dc_x, 0, dc_y])
          cube([dc_w, wt+1, dc_h]);

        // Arduino power connector
        // translate([45, wt+1, 2 + 6.05])
        //   rotate([90, 0, 0])
        //     cylinder(r=ard_r, h=wt+1);

        // Arduino power connector
        translate([45 - ard_r - 0.5, 0, 2 + 6.05 - ard_r - 1.5])
          cube([ard_r * 2 + 1, wt + 1, ard_r * 2 + 3]);

      }
    }

    // Make bevels for glueable parts
    if (!whole_box) {
      if (beveled_walls) {
        for (x=[-wt,bw+wt]) {
          translate([x, 0, -wt + fd / 2]) {
            rotate([0,0,45])
              cube([wt*1.414, wt*1.414, fd + 1], center=true);
            cube([wt2,wt2*2,wt2+0.1], center=true);
          }
        }
        translate([fw/2-wt, 0, -wt]) {
          rotate([45,0,0])
            cube([fw + 1,wt*1.414, wt*1.414], center=true);
          cube([wt2+0.1,wt2*2,wt2], center=true);
        }
      }
    }
  }
}

if (whole_box) { bottom_wall(); } else { rotate([90,0,0]) translate([0,wt,0]) bottom_wall(); }
