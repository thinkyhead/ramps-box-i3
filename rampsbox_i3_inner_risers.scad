//
// Prusa i3 RAMPS 1.4 Enclosure (SeeMeCNC Laser Cut Frame)
// by Thinkyhead
//
// Inner Risers
//

include <configuration.scad>

module inner_riser() {
	difference() {
		cylinder(r1=3mm_hole_r + 3, r2=3mm_hole_r + 1.5, h=rh, $fn=6);
		translate([0, 0, -0.5])
			cylinder(r=3mm_hole_r, h=rh + 1, $fn=18);
	}
}

for (x=[-10,10]) {
	for (y=[-10,10]) {
		translate([x,y]) inner_riser();
	}
}
