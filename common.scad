//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Common Modules
//

include <configuration.scad>

module bolthole() {
  cylinder(r=3mm_hole_r, h=wt+1, $fn=36);
}

module fan_mount() {
  cylinder(r=23, h=wt+1);
  translate([-20, -20, 0]) {
                            bolthole();
    translate([0, 40, 0])   bolthole();
    translate([40, 0, 0])   bolthole();
    translate([40, 40, 0])  bolthole();
  }
}

