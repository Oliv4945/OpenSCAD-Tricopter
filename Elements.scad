$fn=60;

include <variables.scad>

motorDiameter = 23.6;

module hollowCylinder( OD, ID, length ) {
  difference() {
    cylinder( r=OD/2, h=length );
    translate( [0, 0, -1] ) cylinder( r=ID/2, h=length+2 );
  }
}

// From http://svn.clifford.at/openscad/trunk/libraries/shapes.scad
module roundedBox(size, radius) {
	translate( size/2 ) union() {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
          y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
}


module CC3DBox() {
  cube( [40, 40, 20] );
}

module motorZmr1804() {
	
	difference() {
		color ( [0.25,0.25,0.25, 1] ) union() {
			cylinder( r1= 17/2, r2=motorDiameter/2, h=3);
			translate( [0,0,3] ) cylinder( r=motorDiameter/2, h=9.1);
			translate( [0,0,-1] ) cylinder( r=2/2, h=1);
			translate( [0,0,12.1] ) cylinder( r=7/2, h=1);
			translate( [0,0,13.1] ) cylinder( r=5/2, h=5.9 );
			translate( [0,0,19] ) cylinder( r1=11/2, r2=3/2, h=9 );
		};
		for( i = [45, 135, 225, 315] ) {
			rotate( [0,0,i] )
			translate([12.4/2, 0, 0])
			cylinder( r=2/2, h=4, center=true );
		};
	};
}

module motorDYS_BE1806() {
  // http://new.banggood.com/fr/DYS-BE1806-2300KV-Brushless-Motor-Black-Edition-for-Multicopters-p-946416.html?currency=EUR
	motorOD_DYS = 23;
  difference() {
		color ( [0.25, 0.25, 0.25, 1] ) union() {
			translate( [0, 0, 0] ) cylinder( r=motorOD_DYS/2, h=18.5-2);
			translate( [0, 0, 18.5-2] ) cylinder( r1=motorOD_DYS/2, r2=15/2, h=2);
			translate( [0,0,18.5] ) cylinder( r=7/2, h=1);
			translate( [0,0,18.5+1] ) cylinder( r=2/2, h=5.9 );
			translate( [0,0,15.5+1+5.9] ) cylinder( r1=11/2, r2=3/2, h=9 );
		};
		for( i = [0, 180] ) {
			rotate( [0, 0, i] )
			translate( [12/2, 0, 0] )
			cylinder( r=2/2, h=4, center=true );
		};
    for( i = [90, 270] ) {
			rotate( [0, 0, i] )
			translate( [16/2, 0, 0] )
			cylinder( r=2/2, h=4, center=true );
		};
	};
}


module propeller() {
	union() {
		color( "orange" ) difference() {
			union() {
				cylinder( r=8/2, h=4 );
				for( i = [0, 120, 240] ) {
					rotate( [30,0,i] )
					cube( [120,4,1] );
				};
			};
			cylinder( r=5/2, h=20, center=true);
			difference() {
				cylinder( r=propOD, h=20, center=true);
				cylinder( r=propOD/2, h=22, center=true);
			}
		
		};
		color( "orange", 0.1) cylinder(r=propOD/2, h=3 );
	};
}

module lipo() {
	color( "darkgreen" ) union() {
    cube( [lipoW, lipoD, lipoH] );
    translate( [-7, 0, 0] ) cube( [7, 10, 5] );
  }
}

module receiverFrSkyD4RII() {
  color( "maroon" ) cube( [40, 25, 6] );
}


module CC3D() {
	difference() {
		cube( [36,36,5] );
		translate( [2.75,2.75,0] ) cylinder( r=3/2, h=20, center=true);
		translate( [30.5+2.75,2.75,0] ) cylinder( r=3/2, h=20, center=true);
		translate( [30.5+2.75,30.5+2.75,0] ) cylinder( r=3/2, h=20, center=true);
		translate( [2.75,30.5+2.75,0] ) cylinder( r=3/2, h=20, center=true);
	};
}

module ESCAfro12A() {
  color("darkgreen") rotate( [0, 0, 90] )
    translate( [0, -20, 0] )cube( [25, 20, 6] );
}

module servo( size ) {
  union() {
    cube( size );
    translate( [armServoW/2-armServoEarW/2, 0, armServoEarH] ) cube( [armServoEarW, armServoD, armServoEarT] );
    translate( [armServoD/2, armServoD/2, armServoH] ) cylinder( r=armServoD/4, h=armServoRotorH );
  }
}

module sony600TVL() {
  PCBSize = 32;
  PCBHeight = 1.6;
  BaseSize = 17;
  BaseH = 8.1;
  BaseOD = 4.9;
  BaseEar = 3.5;
  CylinderOD1 = 15.4;
  CylinderH1 = 8.25;
  CylinderOD2 = 11.8;
  CylinderH2 = 4.9;
  CylinderOD3 = 14;
  CylinderH3 = 3.5;
  CapacitorOD = 3.9;
  CapacitorH = 10;
  mountingHolesOD = 2.1;
  mountingHolesShift = 14;
  
  union() {
    // PCB
    difference() {
      translate( [0, 0, PCBHeight/2] ) color( "DarkSlateGrey" )
        cube( [PCBSize, PCBSize, PCBHeight], center = true );
      translate( [ mountingHolesShift, mountingHolesShift, 0] )
        cylinder( r=mountingHolesOD/2, h=PCBHeight+2, center = true );
      translate( [ mountingHolesShift, -mountingHolesShift, 0] )
        cylinder( r=mountingHolesOD/2, h=PCBHeight+2, center = true );
      translate( [ -mountingHolesShift, mountingHolesShift, 0] )
        cylinder( r=mountingHolesOD/2, h=PCBHeight+2, center = true );
      translate( [ -mountingHolesShift, -mountingHolesShift, 0] )
        cylinder( r=mountingHolesOD/2, h=PCBHeight+2, center = true );
    }
    color( "DimGrey" ) {
      // Base
      translate( [0, 0, PCBHeight+BaseH/2] )      // Cube
        cube( [BaseSize, BaseSize, BaseH], center = true );
      translate( [0, 0, PCBHeight+BaseH/2] )      // Ear
        cube( [BaseSize+(BaseEar-BaseOD/2)*2, BaseOD, BaseH], center = true );
      translate( [(BaseSize+BaseOD-BaseEar)/2, 0, PCBHeight+BaseH/2] )    // Ear Cylinder
        cylinder( r=BaseOD/2, h=BaseH, center = true );
      translate( [-(BaseSize+BaseOD-BaseEar)/2, 0, PCBHeight+BaseH/2] )    // Ear Cylinder
        cylinder( r=BaseOD/2, h=BaseH, center = true );
      // Stage 1
      translate( [0, 0, PCBHeight+BaseH+CylinderH1/2] )
        cylinder( r=CylinderOD1/2, h=CylinderH1, center = true );
      // Stage 2
      translate( [0, 0, PCBHeight+BaseH+CylinderH1+CylinderH2/2] )
        cylinder( r=CylinderOD2/2, h=CylinderH2, center = true );
      // Stage 3
      translate( [0, 0, PCBHeight+BaseH+CylinderH1+CylinderH2+CylinderH3/2] )
        cylinder( r=CylinderOD3/2, h=CylinderH3, center = true );
    }
    // Capacitor
    translate( [ 11.5, -4.8, PCBHeight+1+CapacitorH/2] ) color ( "GhostWhite" )
      cylinder( r=CapacitorOD/2, h=CapacitorH, center = true );
  }
}


// motorZmr1804();
// propeller();
// lipo2200_25C();
// CC3D();
// sony600TVL();
