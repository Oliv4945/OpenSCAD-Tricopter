// Set number of facets for arcs
$fn=60;

// General constants
TRUE = 1;
FALSE = 0;

// General design
wallT = 2;
clearance = 0.2;

// MotorSupports
motorOD = 24;
motorScrewOD = 2.1;
motorScrewAlignementD1 = 12;
motorScrewAlignementD2 = 16;
motorAxleOD = 6.2;
armInsideSupport = 15;
feetW = 15;
feetH = 30;
feetT = wallT*2;

// Rear holder bearing
armBearingID = 9.8;
armBearingOD = 15;
armBearingBore = 4;
armBearingFlange = 0.4;

// Arm
armOD = 10;
armID = 8.9;
armInsideSupport = 15;
armHolderH = 32.5;
armHolderFrontW = 30;
armHolderFrontD = armInsideSupport+2*wallT;
armHolderRearD = armBearingBore+2*wallT;
armHolderRearW = 40;
armBearingsSeparatorLength = 20;
armYawSteelWireOD = 0.9;
armFrontAngle = -3;
armFrontAngleFolded = 103;
armServoH = 21.7;
armServoD = 12.2;
armServoW = 23.1;
armServoRotorH = 29-armServoH;
armServoEarH = 16.5;
armServoEarT = 5;
armServoEarW = 32;
armServoArmD = 12; // from center of the servo mount
armMotorCircleD = 285;


// Screw
armScrewOD = 3;
armScrewLength = 8;
armScrewNutW = 5.5;
armScrewNutH = 2.6;
armScrewHeadOD = 5.8;
armScrewHeadH = 2.6;

// basePlates
basePlateW = 50;
basePlateD = 160;
basePlateT = wallT*1.5;
basePlateArmHolderFrontPivotD = basePlateD-armHolderFrontW/2;

// Zip tie - Include clearance
zipTieW = 5;
zipTieD = 3;

// Prop
propW = 5*25.4;
propOD = 127;

// Vibration Damping balls
vibDampingH = 12.7;
vibDampingODL = 8;
vibDampingODS = 6;
vibDampingMainbodyH = 8;

// Camera
cameraSize = 32;
cameraH = 26.4;
cameraPCBH = 1.6;
cameraSupportSize = 3.5;
cameraSupportD = cameraPCBH+wallT*2+clearance*2;

// ESC
ESCH = 6;

// Lipo
lipoW = 107;
lipoD = 34;
lipoH = 24;

// CC3D
CC3DBox = 39.3;

// Arm length
CC3DCenterX = basePlateW/2-basePlateW/8+armBearingsSeparatorLength+2*wallT+armHolderRearD+wallT*2+CC3DBox/2;
CC3DCenterY = basePlateW/2;
CC3DCenterToPivotModule = sqrt( (basePlateArmHolderFrontPivotD-CC3DCenterX)*(basePlateArmHolderFrontPivotD-CC3DCenterX)+(basePlateW/2)*(basePlateW/2));
angleCC3DCenterPivotMotor = acos( (basePlateArmHolderFrontPivotD-CC3DCenterX)/CC3DCenterToPivotModule )+armFrontAngle+90;
pivotToMotorLength = sqrt(armMotorCircleD/2*armMotorCircleD/2-CC3DCenterToPivotModule*CC3DCenterToPivotModule*sin(angleCC3DCenterPivotMotor)*sin(angleCC3DCenterPivotMotor))+CC3DCenterToPivotModule*cos(angleCC3DCenterPivotMotor);
armLengthFront = pivotToMotorLength+armInsideSupport-armHolderFrontD/2-motorOD/2-clearance;
armLengthRear = armMotorCircleD/2-40/2-2*wallT-motorOD/2-clearance;