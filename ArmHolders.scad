// Include needed libraries
include <Variables.scad>;
use <Elements.scad>;

// Defines if we want a 'printable file' or a view with elements (motors...)
RENDER = 0;
PRINT = 1;
ASSEMBLY = 2;
view = ASSEMBLY;




module armHolderFront() {
  // Generates warning if needed
  if ( (armScrewLength-basePlateT+wallT+armOD/2)>armHolderH/2 ) {
    echo( "WARNING - Screw to long/arm radius to big, or arm holder not height enough" );
  }
  if ( (basePlateT==(wallT+clearance)) ) {
    echo( "WARNING - Front arm stops have same thickness than baase plate, be carrefull with difference function" );
  }
  
  difference() {
    union () {
      // Add - Main body
      roundedBox( [armHolderFrontW, armHolderFrontD, armHolderH], armHolderFrontD/3);
    }
    // Remove - Arm
    translate( [armHolderFrontW/2, -1, armHolderH/2] )
      rotate( [0, 90, 90] ) cylinder( r=armOD/2+clearance/2, h=armInsideSupport+1 );
    // Remove - Hole for wires
    translate( [armHolderFrontW/2, -1, armHolderH/2] )
      rotate( [0, 90, 90] ) cylinder( r=armOD/2-wallT, h=armInsideSupport*2 );
    
    // Remove - Bottom screw
    translate( [armHolderFrontW/2, armHolderFrontD/2, -basePlateT+1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    // Remove - Top screws
    translate( [armHolderFrontW/4, armHolderFrontD/2, armHolderH+basePlateT-armScrewLength-1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    translate( [armHolderFrontW*3/4, armHolderFrontD/2, armHolderH+basePlateT-armScrewLength-1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    // Remove - Bottom nut
    translate( [(armHolderFrontW-armScrewNutW+clearance*2)/2, -armHolderFrontD/2+armScrewNutW/(sqrt(3)/2)/2+clearance, (armScrewLength-basePlateT)-(armScrewNutH+clearance*2)] )
      cube( [armScrewNutW+clearance*2, armHolderFrontD, armScrewNutH+clearance*2] );
    // Remove - Top nuts
    translate( [(armHolderFrontW/4-armScrewNutW/2-clearance), -armHolderFrontD/2+armScrewNutW/(sqrt(3)/2)/2+clearance, armHolderH-(armScrewLength-basePlateT)+clearance] )
      cube( [armScrewNutW+clearance*2, armHolderFrontD, armScrewNutH+clearance*2] );
    translate( [(armHolderFrontW*3/4-armScrewNutW/2-clearance), -armHolderFrontD/2+armScrewNutW/(sqrt(3)/2)/2+clearance, armHolderH-(armScrewLength-basePlateT)+clearance] )
      cube( [armScrewNutW+clearance*2, armHolderFrontD, armScrewNutH+clearance*2] );
  }
}


module armHolderRear() {
  difference() {
    // Add - Main body
    roundedBox( [armHolderRearW, armHolderRearD, armHolderH], armHolderRearD/3);
    // Remove - Bearing holder
    translate( [armHolderRearW/2, -1, armHolderH/2] )
      rotate( [0, 90, 90] ) cylinder( r=armBearingOD/2-armBearingFlange, h=armHolderRearD+2 );
    translate( [armHolderRearW/2, armHolderRearD-armBearingBore-wallT, armHolderH/2] )
      rotate( [0, 90, 90] ) cylinder( r=armBearingOD/2+clearance, h=armHolderRearD+1 );
    // Remove - Screws
    translate( [armHolderRearW/4, armHolderRearD/2, -basePlateT+1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    translate( [armHolderRearW*3/4, armHolderRearD/2, -basePlateT+1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    translate( [armHolderRearW/4, armHolderRearD/2, armHolderH+basePlateT-armScrewLength-1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    translate( [armHolderRearW*3/4, armHolderRearD/2, armHolderH+basePlateT-armScrewLength-1] )
      cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
    // Remove - Nuts
    translate( [armHolderRearW/4-(armScrewNutW+clearance*2)/2, -1, (armScrewLength-basePlateT)-(armScrewNutH+clearance*2)] )
      cube( [armScrewNutW+clearance*2, armHolderRearD+2, armScrewNutH+clearance*2] );
    translate( [armHolderRearW*3/4-(armScrewNutW+clearance*2)/2, -1, (armScrewLength-basePlateT)-(armScrewNutH+clearance*2)] )
      cube( [armScrewNutW+clearance*2, armHolderRearD+2, armScrewNutH+clearance*2] );
    translate( [armHolderRearW/4-(armScrewNutW+clearance*2)/2, -1, armHolderH-(armScrewLength-basePlateT)+clearance] )
      cube( [armScrewNutW+clearance*2, armHolderRearD+2, armScrewNutH+clearance*2] );
    translate( [armHolderRearW*3/4-(armScrewNutW+clearance*2)/2, -1, armHolderH-(armScrewLength-basePlateT)+clearance] )
      cube( [armScrewNutW+clearance*2, armHolderRearD+2, armScrewNutH+clearance*2] );
    // Remove - Arm servo's zip tie
    translate( [armHolderRearW/2-zipTieW/2, -1, armHolderH-zipTieD] )
      cube( [zipTieW, armHolderRearD+2, zipTieD+1] );
  }
}


module armHolderRearFront() {
  difference() {
    armHolderRear();
    // Remove - Battery wires
    translate( [armHolderRearW/5-wallT*1.5, armHolderRearD+1, armHolderH/4] ) rotate( [90, 0, 0] )
    hull() {
      cylinder( r=wallT, h=armHolderRearD+2);
      translate( [wallT*1.5, 0, 0] )
        cylinder( r=wallT, h=armHolderRearD+2);
    }
  }
}

module armHolderRearRear() {
  difference() {
    armHolderRear();
    // Remove - Battery wires
    translate( [armHolderRearW*4/5, armHolderRearD+1, armHolderH/4] ) rotate( [90, 0, 0] )
    hull() {
      cylinder( r=wallT, h=armHolderRearD+2);
      translate( [wallT*1.5, 0, 0] )
        cylinder( r=wallT, h=armHolderRearD+2);
    }
  }
}

module armBearingsSeparator() {
  difference() {
    union() {
      // Add - main body
      translate( [0, (armOD-armBearingID)/2, 0] ) 
        cylinder( r=armBearingID/2, h=armBearingBore );
      translate( [0, 0, armBearingBore] ) 
        cylinder( r=armOD/2, h=armBearingsSeparatorLength+clearance+wallT*2 );
      translate( [0, (armOD-armBearingID)/2, armBearingBore+armBearingsSeparatorLength+clearance+wallT*2] ) 
        cylinder( r=armBearingID/2, h=armBearingBore );
      // Add - Improve printability & piano wire body
      hull() {
        translate( [armOD/2+wallT*3, armOD/2-wallT, wallT*2+armBearingBore] )
          cylinder( r=wallT, h=armBearingsSeparatorLength/3 );
        translate( [-armOD/2-wallT*6, armOD/2-wallT, wallT*2+armBearingBore] )
          cylinder( r=wallT, h=armBearingsSeparatorLength/3 );
      }
      // Add - Inner of carbon tube
      translate( [0, (armOD-armID)/2, -armBearingBore*4] ) 
        cylinder( r=armID/2, h=armBearingBore*4 );
    }
    // 8.9
    /*
    // Remove - Arm
    translate( [0, 0, -1] )
      cylinder( r=armOD/2+clearance/2, h=armBearingsSeparatorLength+wallT*2+2 );
    // Remove - Screws
    translate( [armOD/2+wallT*2, -wallT*2-1, armBearingsSeparatorLength/3/2+wallT*2] )
      rotate( [270, 0, 0] ) cylinder( r=armScrewOD/2, h=wallT*4+2 );
    translate( [-(armOD/2+wallT*2), -wallT*2-1, armBearingsSeparatorLength/3/2+wallT*2] )
      rotate( [270, 0, 0] ) cylinder( r=armScrewOD/2, h=wallT*4+2 );
    // Remove - Nuts
    translate( [armOD/2+wallT*2, -wallT*2-1, armBearingsSeparatorLength/3/2+wallT*2] )
      rotate( [270, 0, 0] ) cylinder( r=(armScrewNutW*sqrt(3)/2+clearance)/2, h=wallT+1, $fn=6 );
    translate( [-(armOD/2+wallT*2), -wallT*2-1, armBearingsSeparatorLength/3/2+wallT*2] )
      rotate( [270, 0, 0] ) cylinder( r=(armScrewNutW*sqrt(3)/2+clearance)/2, h=wallT+1, $fn=6 );
    */
    // Remove - Steel wire
    translate( [-armOD/2-wallT*6, armBearingID/2-wallT, 0] )
      cylinder( r=armYawSteelWireOD/2, h=armBearingsSeparatorLength );
    // Remove - Inside to allow wires
    // Add - Inner of carbon tube
      translate( [0, (armOD-armID)/2, -armBearingBore*4-1] ) 
        cylinder( r=armID/2-wallT/1.5, h=armBearingsSeparatorLength*4 );
  }
}


if ( view == RENDER ) {
  armHolderRearRear();
  translate( [armHolderRearW+20,0 ,0 ] ) armHolderFront();
  translate( [-40, -1, 0] ) //difference() {
    armBearingsSeparator();
    /*translate( [-armBearingsSeparatorLength*1.5, 0, -1 ] )
      cube( [armBearingsSeparatorLength*3, armBearingsSeparatorLength*3, armBearingsSeparatorLength*3] );
  }*/
  /*translate( [-40, 1, 0] ) difference() {
    armBearingsSeparator();
    translate( [-armBearingsSeparatorLength*1.5, -armBearingsSeparatorLength*3, -1 ] )
      cube( [armBearingsSeparatorLength*3, armBearingsSeparatorLength*3, armBearingsSeparatorLength*3] );
  }*/
}
if ( view == PRINT ) {
  union() {
    rotate( [90, 0, 0] ) armHolderRearRear();
    translate( [wallT*2+armHolderRearW, 0 ,0 ] ) rotate( [90, 0, 0] ) armHolderRearFront();
  }
  translate( [0, wallT*2 ,armHolderFrontD ] ) rotate( [270, 0, 0] ) armHolderFront();
  translate( [0, wallT*4+armHolderH ,armHolderFrontD ] ) rotate( [270, 0, 0] ) armHolderFront();
  union() {
  translate( [70, 25, 0] ) rotate( [270, 0, 0] ) difference() {
    armBearingsSeparator();
    translate( [-armBearingsSeparatorLength*1.5, 0, -armBearingsSeparatorLength*1.5 ] )
      cube( [armBearingsSeparatorLength*4, armBearingsSeparatorLength*4, armBearingsSeparatorLength*4] );
  }
  translate( [50, 27, 0] ) rotate( [90, 0, 0] ) difference() {
    armBearingsSeparator();
    translate( [-armBearingsSeparatorLength*1.5, -armBearingsSeparatorLength*4, -armBearingsSeparatorLength*1.5 ] )
      cube( [armBearingsSeparatorLength*4, armBearingsSeparatorLength*4, armBearingsSeparatorLength*4] );
  }
}
}
if ( view == ASSEMBLY ) {
  armHolderRearRear();
  translate( [armHolderRearW, armHolderRearD*2+armBearingsSeparatorLength ,0 ] )
    rotate( [0, 0, 180] ) armHolderRearFront();
  translate( [armHolderRearW/2, wallT, armHolderH/2] )    // Bearings
    rotate( [0, 90, 90] ) color( "LightGrey") {
      hollowCylinder( OD=armBearingOD, ID=armBearingID, length=armBearingBore );
      translate( [0, 0, armBearingsSeparatorLength+wallT*2+armBearingBore] ) 
      hollowCylinder( OD=armBearingOD, ID=armBearingID, length=armBearingBore );
  }
  translate( [armHolderRearW/2, -60, armHolderH/2] ) rotate( [0, 90, 90] )
    color( "DarkSlateGray")  hollowCylinder( OD=armOD, ID=9, length=100 );      // CF rod
  translate( [armHolderRearW/2, wallT+armBearingBore, armHolderH/2] )
    rotate( [270, 0, 0] ) armBearingsSeparator();
  translate( [40, wallT*2 ,armHolderFrontD ] ) rotate( [0, 0, 0] ) armHolderFront();
}