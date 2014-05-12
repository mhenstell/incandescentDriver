//angle = -152.308;
angle = -144;
angle2 = -135;
angle3 = -120;

module brace(a) {
	difference() {
		translate([-1.2, 0, -3.35]) 
		{
			cube([13, 51, 4]);
		}
		translate([5, 0, .5]) {
			rotate([0, 20, 0]) {
				cube([13, 51, 4]);
			}
		}
	
		translate([7, 5, -5]) {
			cylinder(h = 10, r = 1.5, $fn=20);
		}
	
		translate([7, 45, -5]) {
			cylinder(h = 10, r = 1.5, $fn=20);
		}
	}
	
	
	difference() {
		rotate([0, a, 0]) {
			translate([-1, 0, -.5]) {
				cube([14, 51, 4]);
			}
		}
		rotate([0, a - 20 ,0]) {
			translate([5, 0, -6.]) {
				cube([13, 51, 4]);
			}
		}
	
		rotate([0, a, 0])
		{
			translate([8.5, 5, 0]) {
				cylinder(h = 10, r = 1.5, $fn=20);
			}
		}
		
		rotate([0, a, 0])
		{
			translate([8.5, 45, 0]) {
				cylinder(h = 10, r = 1.5, $fn=20);
			}
		}
	}
}

module brace2(a) {
	difference() {
		translate([-1.7, 0, -3.2]) 
		{
			cube([13, 51, 4]);
		}
		translate([5, 0, .5]) {
			rotate([0, 20, 0]) {
				cube([13, 51, 4]);
			}
		}
	
		translate([7, 5, -5]) {
			cylinder(h = 10, r = 1.5, $fn=20);
		}
	
		translate([7, 45, -5]) {
			cylinder(h = 10, r = 1.5, $fn=20);
		}
	}
	
	
	difference() {
		rotate([0, a, 0]) {
			translate([-1, 0, -.5]) {
				cube([14, 51, 4]);
			}
		}
		rotate([0, a - 20 ,0]) {
			translate([5, 0, -6.]) {
				cube([13, 51, 4]);
			}
		}
	
		rotate([0, a, 0])
		{
			translate([8.5, 5, 0]) {
				cylinder(h = 10, r = 1.5, $fn=20);
			}
		}
		
		rotate([0, a, 0])
		{
			translate([8.5, 45, 0]) {
				cylinder(h = 10, r = 1.5, $fn=20);
			}
		}
	}
}

translate([0, 0, 0]) brace(angle);
translate([0, 0, 10]) brace(angle);
translate([0, 0, 20]) brace(angle);
translate([0, 0, 30]) brace(angle);
translate([0, 0, 40]) brace(angle);
//translate([0, 0, 50]) brace();

translate([30, 0, 0]) brace(angle);
translate([30, 0, 10]) brace(angle);
translate([30, 0, 20]) brace(angle);
translate([30, 0, 30]) brace(angle);
translate([30, 0, 40]) brace(angle);
//translate([30, 0, 50]) brace();

translate([60, 0, 0]) brace2(angle2);
translate([60, 0, 10]) brace2(angle2);
translate([60, 0, 20]) brace2(angle2);
translate([60, 0, 30]) brace2(angle2);

translate([90, 0, 0]) brace2(angle2);
translate([90, 0, 10]) brace2(angle2);
translate([90, 0, 20]) brace2(angle2);
translate([90, 0, 30]) brace2(angle2);



	
