// Copyright 2011 Cliff L. Biffle.
// This file is licensed Creative Commons Attribution-ShareAlike 3.0.
// http://creativecommons.org/licenses/by-sa/3.0/

// You can get this file from http://www.thingiverse.com/thing:3575
use <parametric_involute_gear_v5.0.scad>

// Couple handy arithmetic shortcuts
function sqr(n) = pow(n, 2);
function cube(n) = pow(n, 3);

// This was derived as follows:
// In Greg Frost's original script, the outer radius of a spur
// gear can be computed as...
function gear_outer_radius(number_of_teeth, circular_pitch) =
	(sqr(number_of_teeth) * sqr(circular_pitch) + 64800)
		/ (360 * number_of_teeth * circular_pitch);

// We can fit gears to the spacing by working it backwards.
//  spacing = gear_outer_radius(teeth1, cp)
//          + gear_outer_radius(teeth2, cp);
//
// I plugged this into an algebra system, assuming that spacing,
// teeth1, and teeth2 are given.  By solving for circular pitch,
// we get this terrifying equation:
function fit_spur_gears(n1, n2, spacing) =
	(180 * spacing * n1 * n2  +  180
		* sqrt(-(2*n1*cube(n2)-(sqr(spacing)-4)*sqr(n1)*sqr(n2)+2*cube(n1)*n2)))
	/ (n1*sqr(n2) + sqr(n1)*n2);

// Here's an example.
module example_gears() {
	n1 = 19; n2 = 7;
	p = fit_spur_gears(n1, n2, 50);
	// Simple Test:
	gear (circular_pitch=p,
		gear_thickness = 12,
		rim_thickness = 15,
		hub_thickness = 17,
	    number_of_teeth = n1,
		circles=8);
	
	translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,0])
	gear (circular_pitch=p,
		gear_thickness = 12,
		rim_thickness = 15,
		hub_thickness = 17,
		circles=8,
		number_of_teeth = n2,
		rim_width = 2);
	
	// Sub shaft
	color("Aqua") translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,-25]) cylinder(h=100, r=3);
}

example_gears();

// Spool
color("White") {
translate([0, 0, -2]) cylinder(h=2, r=35);
translate([0, 0, -70]) cylinder(h=68, r=29);
translate([0, 0, -72]) cylinder(h=2, r=35);
}

// Main shaft
color("Aqua") translate([0, 0, -100]) cylinder(h=150, r=3);

// Main shaft bearings
translate([0, 0, 40]) {
	cylinder(h=5, r=10);
	translate([-10, 0, 0]) cube(size = [20, 50, 5], center = false);
}
translate([0, 0, -95]) {
	cylinder(h=5, r=10);
	translate([-10, 0, 0]) cube(size = [20, 50, 5], center = false);
}

// Motor box
color("grey") translate([0, -25, 70]) cube([100, 75, 100]);

