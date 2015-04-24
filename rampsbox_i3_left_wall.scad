//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Left Wall
//

include <common.scad>

module left_wall() {
  chop = (!whole_box && !beveled_walls) ? rt : 0;
  difference() {
    // Exterior Solid Wall
    translate([-wt,-wt+chop,-wt])
      cube([wt, fh - chop*2, fd]);

    // A narrow opening for Y endstops, Y motor, bed thermistor, etc.
    translate([0, fh / 2, rh + 30])
      cube([wt2+1,bh/2,8], center=true);

    // Clip-on cover holes
    if (cover_clipon) {
      translate([-0.5, 0, bd - 7.5]) {
        for (y=[10, bh-10-8]) {
          translate([-wt, y]) cube([wt + 1, 8, 2]);
        }
      }
    }

    // Make bevels for glueable parts
    if (!whole_box && beveled_walls) {
      for (y=[-wt,fh-wt]) {
        translate([-wt,y,-wt + fd / 2])
          difference() {
            rotate([0,0,45])
              cube([wt*1.414, wt*1.414, fd + 1], center=true);
            cube([wt2,wt2,wt2], center=true);
          }
      }
      translate([-wt,bh/2,-wt]) {
        rotate([0,45,0])
          cube([wt*1.414, fh + 1, wt*1.414], center=true);
        cube([wt2*2,wt2+0.1,wt2], center=true);
      }
    }
  }
}

if (whole_box) { left_wall(); } else { rotate([0,90,0]) left_wall(); }
