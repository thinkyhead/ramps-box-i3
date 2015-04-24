//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Main Enclosure
//

include <common.scad>

module top_wall() {
  hole3_w = fw - wandr * 2 - 2; hole3_h = 3;
  hole4_w = 18; hole4_h = 10;

  difference() {
    union () {
      // Exterior Solid Wall
      translate([-wt,bh,-wt])
        cube([fw, wt, fd]);

      if (!beveled_walls && (!whole_box || show_glued)) assign(xx=(bw-fan_width)/2) {
        translate([0,bh-rim_depth]) {
          for (x=[0,bw-rt]) translate([x,0]) cube([rt,rim_depth,bd-rt*4]);  // leave room for cover tabs
        }
      }

      if (preview_mode && top_mounted_fan) {
          %color([1, 0, 0, 0.5]) {
            translate([bw / 2 - fan_width / 2 + 3, bh, bd / 2 - fan_width / 2 + 3]) {
              rotate([90,0,0]) {
                minkowski() {
                cube([fan_width - 6, fan_width - 6, fan_thickness]);
                cylinder(r=3, h=1);
              }
            }
          }
        }
      }
    }

    if (top_mounted_fan) {
      rotate([-90, 0, 0]) {
        difference() {
          translate([bw / 2, -bd / 2, bh - 0.5]) fan_mount();
          translate([bw / 2, -bd / 2, bh - 0.5]) {
            cylinder(r=10.25, h=10, center=true);
            for (a=[45,135,225,315]) {
              rotate([0,0,a])
                translate([8.7, 13, wt/2]) // change to -6 to flip the pattern
                  cube([3, fan_width / 2, wt + 1], center=true);
            }
          }
        }
      }
    }
    else if (smart_lcd) {
      rotate([-90, 0, 0])
        translate([(bw - hole3_w) / 2, -bd + wandr, bh - 0.5])
          union() {
            cube([hole3_w, hole3_h, wt + 1]);
            cube([hole4_w, hole4_h, wt + 1]);
          }
    }

    // Make bevels for glueable parts
    if (!whole_box && beveled_walls) {
      for (x=[-wt,bw+wt]) {
        translate([x, bh, -wt + fd / 2]) {
          rotate([0,0,45])
            cube([wt*1.414, wt*1.414, fd + 1], center=true);
          cube([wt2,wt2*2,wt2+0.1], center=true);
        }
      }
      translate([fw/2-wt, bh, -wt]) {
        rotate([45,0,0])
          cube([fw + 1,wt*1.414, wt*1.414], center=true);
        cube([wt2+0.1,wt2*2,wt2], center=true);
      }
    }

  }
}

if (whole_box) { top_wall(); } else { rotate([-90,0,0]) translate([0,-bh-wt]) top_wall(); }

