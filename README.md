# OpenSCAD-Tricopter
A fully customizable 3D printed tricopter designed thanks to [OpenSCAD](http://www.openscad.org).  
The code is not cristal clear as it was my first "big" project in order to try OpenSCAD for such things, but all parameters can be changed in the file `Variables.scad`, I try to add warnings in the log for illogical values but always check after modifications. Also, the rod length will be displayed in the log too.

The tricopter works well but the documentation is a work in progress. If needed ask me ;-)

# Files
There is 4 categories
 * Helpers
  * Elements.scad => Contains all elements usefull for design (batteries, ESC, receiver, etc)
  * CCC3DBox.scad => A CC3D case I grabbed [here](http://www.thingiverse.com/thing:95644). Not tested, I only used it for design
 * Assembly.scad => Assembly file, calculates required carbon rod length
 * Variables.scad => All parameters should be tunned here
 * And files with pieces to print
  * ArmHolders.scad
  * BasePlates.scad
  * MotorSupport.scad

# Parts to print
 * armBearingsSeparator_1.stl => 1
 * armBearingsSeparator_2.stl => 1
 * armHolderFront.stl => 2
 * armHolderRearFront.stl => 1
 * armHolderRearRear.stl => 1
 * basePlateLow.stl => 1
 * basePlateMiddle.stl => 1
 * basePlateServo.stl => 1
 * batteryHolder.stl => 1
 * ESCHolder.stl => 2
 * feetPropSaver.stl => Optionnal
 * motorSupport.stl => 3
 * motorSupportFeet.stl => Optionnal

# Parts to buy
 * 3 Motors - 1806 about 2300 kv. I used DYS BE1806-2300kv
 * 3 ESC -  12A. I used [12A Afro ESC](https://www.hobbyking.com/hobbyking/store/%5F%5F62955%5F%5FAfro%5FESC%5F12Amp%5FBEC%5FUltraLite%5FMultirotor%5FESC%5FV3%5FSimonK%5FFirmware%5FUK%5FWarehouse%5F.html)
 * 5030 propellers. Whatever you find, clockwise and anti-clockwise
 * 1 servo motor, the [TGY-9025](https://www.hobbyking.com/hobbyking/store/%5F%5F31879%5F%5FTurnigy%5F8482%5FTGY%5F9025MG%5FMG%5FServo%5F1%5F8kg%5F0%5F09sec%5F11g%5FUK%5FWarehouse%5F.html) works fine and I design the support for it.
 * 10mm OD holow carbon fiber tube - about 35 cm. I used [this one](https://www.hobbyking.com/hobbyking/store/%5F%5F26195%5F%5FCarbon%5FFiber%5FTube%5Fhollow%5F10x750mm%5FUK%5FWarehouse%5F.html)
 * Batteries - 3S from 1.3Ah to 2.2Ah. [This battery](https://www.hobbyking.com/hobbyking/store/%5F%5F32111%5F%5FZIPPY%5FCompact%5F1300mAh%5F3S%5F25C%5FLipo%5FPack%5FUK%5FWarehouse%5F.html) is great, 2.2A works too but it is a bit heavy
 * 1 micro receiver. I use FrSky D4R-II 2.4G 4CH ACCST Telemetry flashed in 8 channels CPPM.
 * 1 flight controller. I used a cheap [CC3D](http://www.openpilot.org/products/openpilot-coptercontrol-platform)
 * 2 bearings - size 10x15x4 mm. Mine are 9.8 inner mm instead of 10, that is why I do not put carbon rod inside but designed a part.
 * Optionnal
  * Video for FPV
   * Holder for a [Sony 600 TVL](http://www.surveilzone.com/fpv/fpv-camera/sony-super-had-ccd-600tvl-fpv-ir-block-camera-2.8mm-lens)
   * Video transmitter
  * Bluetooth to ease configuration, especially if you but the USB port behind the servo like me (Not recommended :p)

Screws are all 3 mm, mainly 6 an 8 mm long (TBC). You can use metal screws but nylon will save weight, and especially act as fuses. It works well !

# Others
There are coments in code to help to understand, but from time to time some names are not explicits. If you change them PR are welcome !  
Thank to the [Brocopter](http://www.thingiverse.com/thing:413639) for some inspiration, especially to add some tape on the rods in order to adjust the motor support.
