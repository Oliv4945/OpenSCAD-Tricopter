// Include needed libraries
include <Variables.scad>;
include <Elements.scad>;
include <MotorSupport.scad>;
include <ArmHolders.scad>;
include <BasePlates.scad>;

// Defines if we want a 'printable file' or a view with elements (motors...)
view = -1;
// Define if the front arms are folded
viewFoldedArms = FALSE;

 
module armFrontL( armLength = 100 ) {
	union() {
		translate( [armHolderFrontD, 0, 0] ) rotate( [0, 0, 90] ) armHolderFront();
  	translate( [armHolderFrontD-armInsideSupport, armHolderFrontW/2, armHolderH/2] ) rotate( [0, 90, 0] )
    	color( "DarkSlateGray") hollowCylinder( OD=armOD, ID=armID, length = armLength );
		translate( [armHolderFrontD-armInsideSupport+armLength-armInsideSupport, armHolderFrontW/2, armHolderH/2] )
    	rotate( [ 0, 270, 180] ) motorSupport( armInsideSupport=armInsideSupport );
  	
		translate( [armHolderFrontD-armInsideSupport+armLength+clearance+wallT+motorOD/2, armHolderFrontW/2, -7.5+wallT+armHolderH/2] )
    	rotate( [ 0, 0, 0] ) motorDYS_BE1806();
  	translate( [armHolderFrontD-armInsideSupport+armLength+clearance+wallT+motorOD/2, armHolderFrontW/2, -7.5+armHolderH/2] )
    	rotate( [ 180, 0, 90] ) motorSupportFeet();
  	
	}
}

module armFrontR( armLength = 100 ) {
	union() {
		translate( [armHolderFrontD, armHolderFrontW, 0] ) rotate( [0, 0, 90] ) mirror( [1, 0, 0] ) armHolderFront();
  	translate( [armHolderFrontD-armInsideSupport, armHolderFrontW/2, armHolderH/2] ) rotate( [0, 90, 0] )
    	color( "DarkSlateGray") hollowCylinder( OD=armOD, ID=armID, length = armLength );
		translate( [armHolderFrontD-armInsideSupport+armLength-armInsideSupport, armHolderFrontW/2, armHolderH/2] )
    	rotate( [ 0, 270, 180] ) motorSupport( armInsideSupport=armInsideSupport );
  	
		translate( [armHolderFrontD-armInsideSupport+armLength+clearance+wallT+motorOD/2, armHolderFrontW/2, -7.5+wallT+armHolderH/2] )
    	rotate( [ 0, 0, 0] ) motorDYS_BE1806();
  	translate( [armHolderFrontD-armInsideSupport+armLength+clearance+wallT+motorOD/2, armHolderFrontW/2, -7.5+armHolderH/2] )
    	rotate( [ 180, 0, 90] ) motorSupportFeet();
  	
	}
}
module armFrontAssembly() {
  // Left
  translate( [0,
							basePlateArmHolderFrontPivotD,
							basePlateT]
            )
		rotate( [0, 0, 180-armFrontAngle+viewFoldedArms*armFrontAngleFolded] )
      translate( [-armHolderFrontD/2, -armHolderFrontW/2, 0] ) armFrontL( armLengthFront );
  // Right
  translate( [basePlateW,
							basePlateArmHolderFrontPivotD,
							basePlateT]
            )
		rotate( [0, 0, armFrontAngle-viewFoldedArms*armFrontAngleFolded ] )
      translate( [-armHolderFrontD/2, -armHolderFrontW/2, 0] ) armFrontR( armLengthFront );
}

module armRearAssembly() {
 armHolderRearFront();
  translate( [armHolderRearW, armHolderRearD*2+armBearingsSeparatorLength ,0 ] )
    rotate( [0, 0, 180] ) armHolderRearRear();
  translate( [armHolderRearW/2, wallT, armHolderH/2] )    // Bearings
    rotate( [0, 90, 90] ) color( "LightGrey") {
      hollowCylinder( OD=armBearingOD, ID=armBearingID, length=armBearingBore );
      translate( [0, 0, armBearingsSeparatorLength+wallT*2+armBearingBore] ) 
      hollowCylinder( OD=armBearingOD, ID=armBearingID, length=armBearingBore );
  }
  translate( [armHolderRearW/2, -armLengthRear+(armHolderRearD*2+armBearingsSeparatorLength), armHolderH/2] ) rotate( [0, 90, 90] )
    color( "DarkSlateGray")  hollowCylinder( OD=armOD, ID=9, length=armLengthRear );      // CF rod
  translate( [armHolderRearW/2, wallT+armBearingBore, armHolderH/2] )
    rotate( [270, 0, 0] ) armBearingsSeparator();
  translate( [armHolderRearW/2,
              -armLengthRear+(armHolderRearD*2+armBearingsSeparatorLength)+armInsideSupport,
              armHolderH/2
            ] )
    	rotate( [ 0, 270, 90] ) motorSupport( armInsideSupport=armInsideSupport );
  translate( [armHolderRearW/2, -armLengthRear+(armHolderRearD*2+armBearingsSeparatorLength)-motorOD/2-wallT-clearance, -7.5+wallT+armHolderH/2] )
    motorDYS_BE1806();
}

module all() {
  echo( "Front arm length (mm): ", armLengthFront );
  echo( "Rear arm length (mm): ", armLengthRear );
  if ( (pivotToMotorLength-armHolderFrontW/2)<propW/2 ) {
    echo( "<b>WARNING</b> - Front - Props to wide or motor circle diameter to small" );
  }
  if ( abs((CC3DCenterX-armMotorCircleD/2))<propW/2 ) {
    echo( "<b>WARNING</b> - Rear - Props to wide or motor circle diameter to small" );
  }
  
  armFrontAssembly();
	translate( [basePlateW/2-armHolderRearW/2, basePlateW/2-basePlateW/8-armHolderRearD/2, basePlateT] ) armRearAssembly();
  basePlateLow();
  translate( [0, 0, basePlateT+armHolderH] ) basePlateMiddle();
  // ESC
  translate( [35, basePlateW/2+armBearingsSeparatorLength+armHolderRearD+wallT*19+ESCH, basePlateT+6] ) 
    rotate( [0, -90, 90] ) ESCAfro12A();
  translate( [35, basePlateW/2+armBearingsSeparatorLength+armHolderRearD+wallT*8, basePlateT+6] ) 
    rotate( [0, -90, 90] ) ESCAfro12A();
  translate( [35, basePlateW/2+armBearingsSeparatorLength+armHolderRearD+wallT*6+ESCH*2, basePlateT+6] )
    rotate( [0, -90, 90] ) ESCAfro12A();
  // ESC Holders
  translate( [wallT*2, basePlateW/2+armBearingsSeparatorLength+7*wallT+armHolderRearD/2+ESCH, basePlateT] ) ESCHolder();
  translate( [wallT*2, basePlateW/2+armBearingsSeparatorLength+15*wallT+armHolderRearD/2+ESCH*3, basePlateT] ) ESCHolder();
  // CC3D
  translate( [ basePlateW/2-40/2, 
               basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD+wallT*2, 
               basePlateT*2+armHolderH  ] )
    color( "darkgreen" ) CC3DBox();
  // Receiver
  translate( [basePlateW/2-40/2,
              basePlateW/2+armBearingsSeparatorLength+16*wallT+armHolderRearD/2+ESCH*4,
              basePlateT+wallT*2
            ] )
    rotate( [90, 0, 0] ) receiverFrSkyD4RII();
  // Base plate servo
  translate( [0, 0, basePlateT*2+armHolderH] ) basePlateServo();
  // Servo
  translate( [ armServoH+basePlateW/2-wallT*6,
            armServoW+basePlateW/2-basePlateW/8+armHolderRearD+wallT-(armServoW-armServoD/2)+armServoArmD, 
            basePlateT*2+armHolderH+armScrewHeadH+clearance
          ] )
    rotate( [90, 0, 270] ) color( "DodgerBlue") 
      servo( size=[armServoW, armServoD, armServoH]  );
  // Props
  %translate( [-pivotToMotorLength*cos(armFrontAngle), basePlateArmHolderFrontPivotD+pivotToMotorLength*sin(armFrontAngle), armHolderH+basePlateT] )
    color( "orange", 0.1 ) circle( r=propW/2 );
  %translate( [basePlateW+pivotToMotorLength*cos(armFrontAngle), basePlateArmHolderFrontPivotD+pivotToMotorLength*sin(armFrontAngle), armHolderH+basePlateT] )
    color( "orange", 0.1 ) circle( r=propW/2 );
  %translate( [basePlateW/2, CC3DCenterX-armMotorCircleD/2, armHolderH+basePlateT] )
    color( "orange", 0.1 ) circle( r=propW/2 );
  // Camera
  translate( [basePlateW/2, basePlateD-cameraH*1.4, basePlateT+cameraSize/2] ) 
    rotate( [-90, 0, 0] ) sony600TVL();
  // Lipo
  translate( [(basePlateW-lipoD)/2, (basePlateD-lipoW)/2, 0] )
    rotate( [0, 180, -90] ) lipo();
  // Lipo holder
  translate( [-((basePlateW+armHolderFrontW/2)-(lipoD+wallT*2))/4, 
              basePlateD-armHolderFrontW/3,
              0 ] )
    rotate( [0, 180, 180] ) batteryHolder();
  }


all();


//CC3D();

//motorSupport();

