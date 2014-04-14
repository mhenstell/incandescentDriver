// Dimensions are in CM

maxRadius = 61; // 4 feet
ringWidth = 7.62; // 3 inches
ringHeight = 1.27; // 0.5 inches
bulbDiameter = 3.02; // 1.1875 inches
bulbFacets = 20;

module ring(radius, z, numBulbs) {

	translate([0, 0, z]) {
		difference() {
			cylinder(ringHeight, radius, radius, 0);
				translate([0, 0, -5 / 2]) {
					cylinder(5, radius - ringWidth, radius - ringWidth);
			}
		}
		
		for ( i = [0 : numBulbs - 1] ) 
		{	
			translate([(cos((360 / numBulbs) * i) * (radius - (radius - (radius - ringWidth)) / 2)), (sin((360 / numBulbs) * i) * (radius - (radius - (radius - ringWidth)) / 2)), -(bulbDiameter / 4)]) {
				sphere(d = bulbDiameter, $fn = bulbFacets);
			}
		}
	}
}

ring(maxRadius, 0, 95);
ring(maxRadius - (ringWidth * 1.5), -10, 70);
ring(maxRadius - (ringWidth * 3), -25, 50);
ring(maxRadius - (ringWidth * 4.5), -40, 30);
ring(maxRadius - (ringWidth * 6), -55, 15);