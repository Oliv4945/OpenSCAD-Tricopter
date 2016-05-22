// Include needed libraries
include <Variables.scad>;
use <Elements.scad>;

// Set number of facets for arcs
$fn=60;


// Defines if we want a 'printable file' or a view with elements (motors...)
RENDER = 0;
PRINT = 1;
ASSEMBLY = 2;
view = PRINT;


// General design
wallT = 2;
clearance = 0.2;

// Arm
armOD = 10;

// MotorSupports
/*motorOD = 23;
motorScrewOD = 2.1;
motorScrewAlignementD1 = 12;
motorScrewAlignementD2 = 16;
motorAxleOD = 6.2;
armInsideSupport = 20;
feetW = 15;
feetH = 30;
feetT = wallT*2;*/


module motorSupport() {
  supportH = armOD+wallT*2+clearance*2;
  motorCenter = motorOD/2+wallT+clearance+armInsideSupport;
  
  difference() {
    union() {
      // Add - Arm extension
      hull() {
        cylinder( r=supportH/2, h=armInsideSupport+(motorOD+wallT)/2 );
        translate( [-supportH/2, -supportH/4/2, 0] )    // Flat surface to improve printing
          cube( [wallT, supportH/4, armInsideSupport+(motorOD+wallT)/2] );
      }
      // Add - Motor support
      translate( [-supportH/2, 0, motorCenter] )
        rotate( [0, 90, 0] ) cylinder( r=motorOD/2+clearance*2+wallT, h=supportH );
    }
    // Remove - arm - X=0.01 is to avoid removing on same planen
    translate( [0.01, 0, -1] ) cylinder( r=armOD/2+clearance/2, h = armInsideSupport+motorOD/2+1 );
    // Remove - Motor hole
    translate( [-supportH/2+wallT, 0, motorCenter] )
      rotate( [0, 90, 0] ) cylinder( r=motorOD/2+clearance*2, h=supportH );
    // Remove - Motor screws
    translate( [-supportH/2+1, 0, motorCenter] ) rotate( [45, 0, 0] ) rotate( [0, 90, 0] ) {
      for( i = [90, 270] ) {
        rotate( [0, 0, i] ) translate( [motorScrewAlignementD1/2, 0, 0] )
        cylinder( r=motorScrewOD/2+clearance, h=wallT+2, center=true );
      }
      for( i = [0, 180] ) {
        rotate( [0, 0, i] ) translate( [motorScrewAlignementD2/2, 0, 0] )
        cylinder( r=motorScrewOD/2+clearance, h=wallT+2, center=true );
      }
    }
    // Remove - Wire insertion
    translate( [-armOD/2, -wallT/2, -1] )
      cube( [armOD+wallT+2, wallT, armInsideSupport*2] );
    // Remove - Motor axle
    translate( [-supportH+1, 0, motorCenter] ) rotate( [0, 90, 0] )
      cylinder( r=motorAxleOD/2+clearance, h=supportH+2 );
  }
}

module feet() {
  angle = 8;
  holeOD = 3;

  difference() {
    cube( [feetW, feetT, feetH] );
    translate( [-feetW*2, -1, 0] ) rotate( [0, angle, 0] )
      cube( [feetW*2*cos(angle), feetT*2, feetH*2] );
    translate( [feetW, -1, 0] ) rotate( [0, -angle, 0] )
      cube( [feetW*2*cos(angle), feetT*2, feetH*2] );
  }
}


module motorScrews() {
  motorScrewAlignementD = motorScrewAlignementD1;
  union() {
    translate( [motorScrewAlignementD/2, 0, -1 ] )
      cylinder( r=motorScrewOD/2+clearance, h=wallT+2 );
    translate( [-motorScrewAlignementD/2, 0, -1 ] )
      cylinder( r=motorScrewOD/2+clearance, h=wallT+2 );
  }
}

module motorSupportFeet() {
  difference() {
    union() {
      // Add - Support plate
      cylinder( r=motorOD/2, h=wallT );
      translate( [feetT/2, -feetW/2, wallT] ) 
        rotate( [ 0, 0, 90] ) feet( wallT=wallT, feetT=feetT, feetH=feetH );
    }
    // Remove - Motor screws
    motorScrews();
    // Remove - Feet decoration
    resize( [feetT+2, feetW-feetT*2, feetH-feetT*2] )
      translate( [feetT/2, -feetW/2, wallT+feetT] ) rotate( [ 0, 0, 90] ) feet( feetT=feetT );
  }
}

module feetPropSaver() {
  difference() {
    union() {
      // Add - Motor feet
      motorSupportFeet();
      // Add - Structure
      for( i = [0 : 360/8 : 360] ) {
        translate( [0, 0, wallT/2] ) rotate( [90, 0, i] )
          cylinder( h=propOD/2.5, r=wallT/2 );
      // Add - Structure's circle
     translate( [0, 0, wallT/2] ) rotate_extrude( convexity = 10, $fn = 60 )
       translate([propOD/2.5, 0, 0])
         circle( r=wallT/2 );
      }
    }
    // Remove - motor screws
    motorScrews();
  }
}


if ( view == PRINT ) {
  translate( [0, 0, (armOD+wallT*2+clearance*2)/2] )
    rotate( [ 0, 270, 180] ) motorSupport();
  !translate( [-20, 0, 0] ) motorSupportFeet();
  translate( [0, propOD/1.5, 0] ) feetPropSaver();
} 
if ( ( view == RENDER) || ( view == ASSEMBLY) ) {
  translate( [0, 0, 0] ) rotate( [ 0, 270, 180] ) motorSupport();
  translate( [motorOD/2+wallT+armInsideSupport, 0, -(armOD+wallT*2+clearance*2)/2+wallT] )
    rotate( [ 0, 0, 90] ) motorDYS_BE1806();
  translate( [motorOD/2+wallT+armInsideSupport, 0, -(armOD+wallT*2+clearance*2)/2] )
    rotate( [ 180, 0, 90] ) motorSupportFeet();
}


