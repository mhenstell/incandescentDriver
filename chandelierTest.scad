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

ring(maxRadius, 0, 52); // 13 elements
ring(maxRadius - (ringWidth * 1.75), -10, 40); // 47.665 10 elements
ring(maxRadius - (ringWidth * 3.5), -25, 28); // 34.33 8 elements
ring(maxRadius - (ringWidth * 5.4), -40, 16); // 19.852 6 elements
//ring(maxRadius - (ringWidth * 6), -55, 15);