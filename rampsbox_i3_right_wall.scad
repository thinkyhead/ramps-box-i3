//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Right Wall
//

include <common.scad>

module right_wall() {
  reset_r = 4.2;
  chop = (!whole_box && !beveled_walls) ? wt : 0;
  difference() {
    // Exterior Solid Wall
    translate([bw,-wt+chop,-wt])
      cube([wt, fh - chop*2, fd]);

    // Reset switch hole
    translate([bw-0.5, mount_y + 21.2, rh + 19])
      rotate([0, 90, 0])
        cylinder(r=reset_r, h=wt+1);

    // Clip-on cover holes
    if (cover_clipon) {
      translate([-0.5, 0, bd - 7.5]) {
        for (y=[10, bh-10-8]) {
          translate([bw, y]) cube([wt + 1, 8, 2]);
        }
      }
    }

    // Make bevels for glueable parts
    if (!whole_box && beveled_walls) {
      for (y=[-wt,fh-wt]) {
        translate([bw,y,-wt + fd / 2]) {
          difference() {
            rotate([0,0,45])
              cube([wt*1.414, wt*1.414, fd + 1], center=true);
            cube([wt2,wt2,wt2], center=true);
          }
        }
      }
      translate([bw,fh/2-wt,-wt]) {
        rotate([0,45,0])
          cube([wt*1.414, fh + 1, wt*1.414], center=true);
        cube([wt2*2,wt2+0.1,wt2], center=true);
      }
    }

  }
}

if (whole_box) { right_wall(); } else { rotate([0,90,0]) translate([-bw-wt,0]) right_wall(); }
