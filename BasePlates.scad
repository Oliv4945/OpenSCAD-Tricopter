// Include needed libraries
include <Variables.scad>;
use <Elements.scad>;

// Set number of facets for arcs
$fn=60;

// Defines if we want a 'printable file' or a view with elements (motors...)
RENDER = 0;
PRINT = 1;
ASSEMBLY = 2;
view = ASSEMBLY;


module batteryHolder() {
  batteryHolderD = armHolderFrontW/3;
  lipoHolderWOffset = ((basePlateW+armHolderFrontW/2)-(lipoD+wallT*2))/2;
  difference() {
    union() {
      // Add - Bottom
        cube( [basePlateW+armHolderFrontW/2, batteryHolderD, wallT] );
      // Add - Main cube
      translate( [lipoHolderWOffset, 0, 0] )
        cube( [lipoD+wallT*2, batteryHolderD, lipoH+wallT] );
    }
    // Remove - Battery
    translate( [lipoHolderWOffset+wallT, wallT, -1] )
      cube( [lipoD, batteryHolderD, lipoH+1] );
    // Remove - Screw hole
    translate( [lipoHolderWOffset/2, batteryHolderD/2, -1] )
      cylinder( r=armScrewOD/2+clearance, h=wallT+2 );
    translate( [basePlateW+lipoHolderWOffset/2, batteryHolderD/2, -1] )
      cylinder( r=armScrewOD/2+clearance, h=wallT+2 );
  }
}


module cameraSupport() {
  difference() {
    cube( [ cameraSupportSize+wallT, cameraSupportD, cameraSupportSize] );
    translate( [wallT, wallT+clearance, -1] )
      cube( [ cameraSupportSize, cameraPCBH, cameraSupportSize+2] );
  }
}

module ESCHolder() {
  difference() {
    cube( [ basePlateW-4*wallT, wallT, armHolderH-clearance*2] );
    translate( [wallT*2, -1, -1] )
      cube( [basePlateW-8*wallT, wallT+2, wallT*2+1] );
    translate( [wallT*2, -1, armHolderH-wallT*2] )
      cube( [basePlateW-8*wallT, wallT+2, wallT*2+1] );
  }
}

module ESCHolderSupport() {
  difference() {
    cube( [ wallT*2+clearance, wallT*3+clearance*2, wallT*1.5] );
    translate( [wallT, wallT+clearance, -1] )
      cube( [ wallT+clearance+1, wallT+clearance, wallT*1.5+2] );
  }
}

module basePlateServo() {
  // /!\ Be carefull with this module; Its reference is not x=0;y=0 but its definitive place
  difference() {
    translate( [basePlateW/2-wallT*6-wallT-clearance,
                basePlateW/2-basePlateW/8+armHolderRearD+wallT-(armServoW-armServoD/2)+armServoArmD-wallT-clearance,
                0
             ] )
      difference() {
        union() {
          // Add - Main body
          cube( [armServoH+wallT*2+clearance*2, armServoW+wallT*2+clearance*2, armScrewHeadH+clearance] );
          // Add - Walls to block servo
          translate( [0, 0, armScrewHeadH+clearance] )
            cube( [armServoH+wallT*2+clearance*2, wallT, armServoD*2/3] );
          translate( [0, 0, armScrewHeadH+clearance] )
            cube( [wallT, armServoW+wallT*2+clearance*2, wallT] );
          translate( [0, armServoW+wallT*2+clearance*2-wallT, armScrewHeadH+clearance] )
            cube( [armServoH+wallT*2+clearance*2, wallT, armServoD*2/3] );
          translate( [armServoH+wallT*2+clearance*2-wallT, 0, armScrewHeadH+clearance] )
            cube( [wallT, armServoW+wallT*2+clearance*2, armServoD*2/3] );
        }
        // Remove - Servo ears
        translate( [wallT+armServoH-armServoEarH-armServoEarT, -1, armScrewHeadH+clearance-0.01] )
            cube( [armServoEarT+clearance*2, wallT+2, armServoD] );
        translate( [wallT+armServoH-armServoEarH-armServoEarT, -1+armServoW+wallT*2+clearance*2-wallT, armScrewHeadH+clearance-0.01] )
            cube( [armServoEarT+clearance*2, wallT+2, armServoD] ); 
      }
    // Remove - Arm holder rear screws
    translate( [basePlateW/2-armHolderRearW/2+armHolderRearW/4, basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD/2, -1] )
      cylinder( r=armScrewHeadOD/2+clearance, h=armScrewHeadH+armServoD*2/3+clearance+2 );
    translate( [basePlateW/2-armHolderRearW/2+armHolderRearW*3/4, basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD/2, -1] )
      cylinder( r=armScrewHeadOD/2+clearance, h=armScrewHeadH+armServoD*2/3+clearance+2 );
  }
}


module basePlateLow() {
  difference() {
    union() {
      // Add - Base plate
      basePlate();
      // Add - Camera holders
      translate( [basePlateW/2-cameraSize/2-clearance-wallT, basePlateD-cameraH*1.4-clearance-wallT, basePlateT] )
        cameraSupport();
      translate( [basePlateW/2+cameraSize/2+clearance+wallT, basePlateD-cameraH*1.4-clearance-wallT+cameraSupportD, basePlateT] )
        rotate( [0, 0, 180] ) cameraSupport();
      // Add servo support holders
      translate( [wallT-clearance, basePlateW/2+armBearingsSeparatorLength+7*wallT+armHolderRearD/2+ESCH-wallT-clearance, basePlateT ] )
        ESCHolderSupport();
      translate( [wallT-clearance, basePlateW/2+armBearingsSeparatorLength+15*wallT+armHolderRearD/2+ESCH*3-wallT-clearance, basePlateT ] )
        ESCHolderSupport();
      translate( [basePlateW-wallT+clearance, basePlateW/2+armBearingsSeparatorLength+15*wallT+armHolderRearD/2+ESCH*3+wallT*2+clearance, basePlateT ] )
        rotate( [0, 0, 180] ) ESCHolderSupport();
      translate( [basePlateW-wallT+clearance, basePlateW/2+armBearingsSeparatorLength+7*wallT+armHolderRearD/2+ESCH+wallT*2+clearance, basePlateT ] )
        rotate( [0, 0, 180] ) ESCHolderSupport();
    }
    // Remove - Arm holder front screws
    translate( [0, basePlateArmHolderFrontPivotD, -1] )
      cylinder( r=armScrewOD/2+clearance, h=basePlateT+2 );
    translate( [basePlateW, basePlateArmHolderFrontPivotD, -1] )
      cylinder( r=armScrewOD/2+clearance, h=basePlateT+2 );
  }
}

module basePlateMiddle() {
  difference() {
    union() {
      // Add - Base plate
      basePlate();
      // Add - Camera supports
      translate( [basePlateW/2-cameraSize/2-clearance-wallT, basePlateD-cameraH*1.4-clearance-wallT, -cameraSupportSize] )
        cameraSupport();
      translate( [basePlateW/2+cameraSize/2+clearance+wallT, basePlateD-cameraH*1.4-clearance-wallT+cameraSupportD, -cameraSupportSize] )
        rotate( [0, 0, 180] ) cameraSupport();
    // Add servo support holders
    translate( [wallT-clearance, basePlateW/2+armBearingsSeparatorLength+7*wallT+armHolderRearD/2+ESCH-wallT-clearance, -wallT ] )
      ESCHolderSupport();
    translate( [wallT-clearance, basePlateW/2+armBearingsSeparatorLength+15*wallT+armHolderRearD/2+ESCH*3-wallT-clearance, -wallT ] )
      ESCHolderSupport();
    translate( [basePlateW-wallT+clearance, basePlateW/2+armBearingsSeparatorLength+15*wallT+armHolderRearD/2+ESCH*3+wallT*2+clearance, -wallT ] )
      rotate( [0, 0, 180] ) ESCHolderSupport();
    translate( [basePlateW-wallT+clearance, basePlateW/2+armBearingsSeparatorLength+7*wallT+armHolderRearD/2+ESCH+wallT*2+clearance, -wallT ] )
      rotate( [0, 0, 180] ) ESCHolderSupport();
    }
    // Remove - Arm holder front screw - Left
    translate( [0,
							basePlateArmHolderFrontPivotD,
							0]
            )
		rotate( [0, 0, 180-armFrontAngle] )
      translate( [0, -armHolderFrontW/4, -1] ) {
        cylinder( r=armScrewOD/2+clearance, h=armScrewLength+2 );
        translate( [0, armHolderFrontW/2, 0] )
          cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
      }
    // Remove - Arm holder front screw - Right
    translate( [basePlateW,
							basePlateArmHolderFrontPivotD,
							0]
            )
		rotate( [0, 0, armFrontAngle] )
      translate( [0, -armHolderFrontW/4, -1] ) {
        cylinder( r=armScrewOD/2+clearance, h=armScrewLength+2 );
        translate( [0, armHolderFrontW/2, 0] )
          cylinder( r=armScrewOD/2+clearance, h=armScrewLength+1 );
      }
    // Remove - Servo zip tie
    translate( [(basePlateW-zipTieW)/2,
                  basePlateW/2-basePlateW/8+armHolderRearD+wallT-(armServoW-armServoD/2)+armServoArmD-wallT-clearance-zipTieD,
                  -1
                ] ) cube( [zipTieW, zipTieD, basePlateT+2] );
    translate( [(basePlateW-zipTieW)/2,
                  basePlateW/2-basePlateW/8+armHolderRearD+wallT-(armServoW-armServoD/2)+armServoArmD-wallT-clearance+armServoW+clearance*2+wallT*2,
                  -1
                ] ) cube( [zipTieW, zipTieD, basePlateT+2] );
    // Remove - Servo hinge
    translate( [-1, basePlateW/2-wallT, -1] ) 
      cube( [basePlateW/2-wallT*6-wallT-clearance+1, armServoW, basePlateT+2] );
    // Remove - Video emitter zip ties
    translate( [armHolderFrontW/2-zipTieW/2, basePlateD-cameraH*1.4-clearance-wallT+cameraSupportD, -1] )
      cube( [zipTieW, zipTieD, basePlateT+2] );
    translate( [basePlateW-armHolderFrontW/2-zipTieW/2, basePlateD-cameraH*1.4-clearance-wallT+cameraSupportD, -1] )
      cube( [zipTieW, zipTieD, basePlateT+2] );
    // Remove - Draw CC3D Area
    translate( [ basePlateW/2-CC3DBox/2, 
               basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD+wallT*2, 
               basePlateT-clearance*2 ] )
                difference() {
                  cube( [CC3DBox, CC3DBox, CC3DBox] );
                  translate( [wallT/2, wallT/2,-1] ) cube( [CC3DBox-wallT, CC3DBox-wallT, CC3DBox+2] );
                }
  }
}

module basePlate() {
  // Generates warning if needed
  if ( basePlateW<armHolderRearW ) {
    echo( "WARNING - Base plate width is lower than rear arm holder" );
  }
  
  difference() {
    // Main body
    union() {
      // Add - Main plates
      hull() {
        translate( [basePlateW/2, basePlateW/2, 0] ) cylinder( r=basePlateW/2, h=basePlateT );
        translate( [basePlateW/2, basePlateD-basePlateW/2-basePlateW/8, 0] )
          cylinder( r=basePlateW/2, h=basePlateT );
      }
      // Add - Front holder plates
      translate( [basePlateW, basePlateD-armHolderFrontW/2, 0] )
        cylinder( r=armHolderFrontW/2, h=basePlateT );
      translate( [0, basePlateD-armHolderFrontW/2, 0] )
        cylinder( r=armHolderFrontW/2, h=basePlateT );
    }
    // Remove - Arm holder rear screws
    translate( [basePlateW/2-armHolderRearW/2+armHolderRearW/4, basePlateW/2-basePlateW/8, -1] )
      cylinder( r=armScrewOD/2+clearance, h=basePlateT+2 );
    translate( [basePlateW/2-armHolderRearW/2+armHolderRearW*3/4, basePlateW/2-basePlateW/8, -1] )
      cylinder( r=armScrewOD/2+clearance, h=basePlateT+2 );
    translate( [basePlateW/2-armHolderRearW/2+armHolderRearW/4, basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD/2, -1] )
      cylinder( r=armScrewOD/2+clearance, h=basePlateT+2 );
    translate( [basePlateW/2-armHolderRearW/2+armHolderRearW*3/4, basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD/2, -1] )
      cylinder( r=armScrewOD/2+clearance, h=basePlateT+2 );
  }
}



if ( view == RENDER ) {
  basePlateLow();
  translate( [basePlateW*1.5+10, 0, 0] ) basePlateMiddle();
  translate( [-armServoH*2, 0, 0] ) basePlateServo();
  translate( [0, -wallT*2, 0] ) ESCHolder();
  translate( [basePlateW, -wallT*2, 0] ) ESCHolder();
  translate( [basePlateW*1.25, basePlateW*1.5, 0] )
    rotate( [0, 0, 270] ) batteryHolder();
}
if ( view == PRINT ) {
  basePlateLow();
  translate( [basePlateW*1.5, basePlateD, 0] ) 
    rotate( [180, 0, 0] ) basePlateMiddle();
  translate( [-wallT*6, basePlateD-wallT*6, 0] ) basePlateServo();
  translate( [basePlateW-wallT*6, basePlateD+wallT*2, 0] ) 
    rotate( [90, 0, 90] ) ESCHolder();
  translate( [basePlateW-wallT*4+armHolderH, basePlateD+wallT*2, 0] ) 
    rotate( [90, 0, 90] ) ESCHolder();
  translate( [basePlateW*2.5+wallT*2, armHolderFrontW+wallT*2, 0] )
    rotate( [90, 0, 90] ) batteryHolder();
}
if ( view == ASSEMBLY ) {
  basePlateLow();
  translate( [0, 0, basePlateT+armHolderH] ) basePlateMiddle();
  translate( [0, 0, armHolderH+basePlateT*2] ) basePlateServo();
  translate( [wallT*2, basePlateW/2+armBearingsSeparatorLength+3*wallT+armHolderRearD/2+ESCH, basePlateT] )
    ESCHolder();
  translate( [wallT*2, basePlateW/2+armBearingsSeparatorLength+5*wallT+armHolderRearD/2+ESCH*3, basePlateT] )
    ESCHolder();
  translate( [-((basePlateW+armHolderFrontW/2)-(lipoD+wallT*2))/4, 
              basePlateD-armHolderFrontW/3,
              0 ] )
    rotate( [0, 180, 180] ) batteryHolder();
}
