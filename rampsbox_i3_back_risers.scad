//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Back Risers
//

include <configuration.scad>

module back_riser() {
	difference() {
		cylinder(r=3mm_hole_r + 3, h=10, $fn=6);
		cylinder(r=3mm_hole_r, h=10, $fn=12);
	}
}

for (x=[-10,10]) {
	for (y=[-10,10]) {
		translate([x,y]) back_riser();
	}
}
