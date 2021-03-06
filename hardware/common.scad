/*--------------------------------------------------------------------------*
* Sizes and common routines for the CNC parts
*---------------------------------------------------------------------------*
* 13-Jul-2014 ShaneG
*
* First set of definitions using the components I have to experiment with.
*--------------------------------------------------------------------------*/

//---------------------------------------------------------------------------
// Common definitions
//---------------------------------------------------------------------------

RESOLUTION  = 0.1; // Resolution of your printer

PANEL_DEPTH = 4.0; // The prefered size of any shell material

BOLT_SIZE = 4.5; // Diameter of connecting bolts (M4)

GUIDE_ROD_DIAMETER = 12.50;

//---------------------------------------------------------------------------
// Limit switch dimensions (using Jaycar components)
//---------------------------------------------------------------------------

LIMIT_SWITCH_WIDTH   = 6.00;
LIMIT_SWITCH_HEIGHT  = 6.00;
LIMIT_SWITCH_DEPTH   = 13.00;
LIMIT_SWITCH_SWITCH  = 18.00; // Depth that the switch extends to
LIMIT_SWITCH_TRIGGER = 12.00; // Height at which the switch starts to trigger

//---------------------------------------------------------------------------
// Bearing dimensions (using a 608 ball bearing - available from skate shops)
//---------------------------------------------------------------------------

BEARING_DIAMETER       = 22.00;
BEARING_INNER_DIAMETER = 14.00;
BEARING_HEIGHT         = 7.00;

//---------------------------------------------------------------------------
// Stepper motor dimensions
//---------------------------------------------------------------------------

MOTOR_DEPTH          = 43;
MOTOR_WIDTH          = 43;
MOTOR_HEIGHT         = 40;
MOTOR_SHAFT_DIAMETER = 5.00;
MOTOR_SHAFT_LENGTH   = 25.00;
MOTOR_SHAFT_BOUNDARY = 22.00;

//---------------------------------------------------------------------------
// Nuts
//---------------------------------------------------------------------------

/* Hex Nut
**
** Dimensios for a hex nut. The 'outer' diameter (ie: straight side to
** parallel straight side) of the nut does not seem very consistent -
** measurements indicate a 0.5mm range of error across nuts.
*/

NUT_OUTER_DIAMETER = 13.00;
NUT_INNER_DIAMETER = 8.50;  // Enough room for the bore and thread
NUT_HEIGHT         = 6;

NUT4_OUTER_DIAMETER = 8.5;
NUT4_INNER_DIAMETER = 4.5;
NUT4_HEIGHT         = 4.0;

/** Create a hexagon.
 *
 * The 'length' parameter specifies the distance from the center of the
 * hexagon to the center of one of the six straight edges. The 'depth'
 * parameter specifies the size in the Z axis. The resulting object
 * is centered on the origin.
 */
module hexagon(length, depth = 2) {
  width = 2 * length * tan(30);
  union() {
    cube(size = [ length * 2, width, depth ], center = true);
    rotate(a = [ 0, 0, 60 ]) {
      cube(size = [ length * 2, width, depth ], center = true);
      }
    rotate(a = [ 0, 0, -60 ]) {
      cube(size = [ length * 2, width, depth ], center = true);
      }
    }
  }

/** Create a hex nut object
 *
 * This function creates a hex nut (centered on the origin) that contains a
 * hole through the center.
 */
module hexnut(depth = NUT_HEIGHT) {
  difference() {
    hexagon(NUT_OUTER_DIAMETER / 2, depth);
    cylinder(h = 2 * depth, r = NUT_INNER_DIAMETER / 2, center = true, $fs = RESOLUTION);
    }
  }

/** Create a negative hex nut object
 *
 * This function creates a hex nut (centered on the origin) that can be subtracted
 * from another shape to allow a hole for the nut to fit into.
 */
module hexnut_negative(depth = NUT_HEIGHT, spindle = NUT_HEIGHT) {
  union() {
    hexagon(NUT_OUTER_DIAMETER / 2, depth);
    cylinder(h = max(2 * depth, spindle), r = NUT_INNER_DIAMETER / 2, center = true, $fs = RESOLUTION);
    }
  }

/** Create a negative hex nut object
 *
 * This function creates a hex nut (centered on the origin) that can be subtracted
 * from another shape to allow a hole for the nut to fit into.
 */
module hexnut4_negative(depth = NUT4_HEIGHT, spindle = NUT4_HEIGHT) {
  union() {
    hexagon(NUT4_OUTER_DIAMETER / 2, depth);
    cylinder(h = max(2 * depth, spindle), r = NUT4_INNER_DIAMETER / 2, center = true, $fs = RESOLUTION);
    }
  }

//--- Distance from bed (or base) to the center point of the threaded rod and
//    guide rods.

BED_TO_MOUNT = PANEL_DEPTH + (MOTOR_DEPTH / 2);

//---------------------------------------------------------------------------
// Sizing for the stepper to rod link component. Needed as common because a
// couple of components require it to determine their sizing
//---------------------------------------------------------------------------

LINK_DIAMETER = NUT_OUTER_DIAMETER * 2;
LINK_LENGTH   = MOTOR_SHAFT_LENGTH + (3 * NUT_HEIGHT);

