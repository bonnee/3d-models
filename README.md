# 3D Models

Collection of self-designed 3D models made for FDM 3D-printing.

## Usage
The included makefile takes care of building this file. It can also generate STL models from [SolveSpace](https://solvespace.com) and [FreeCAD](https://www.freecadweb.org/) project sources.

- `make` to generate all
- `make readme` to generate this file
- `make freecad` to export FreeCAD projects to STL meshes
- `make solvespace` to export SolveSpace projects to STL meshes
- `make clean` to clean all.

## Table of contents
### [3018_emergency_stop](./CNC_3018_pro/3018_emergency_stop/)
# 3018 Pro emergency button
Emergency stop button that resets the mainboard when pressed. Based around an old computer power button (model Solteam PS3-22SP) with a satisfying click.
![Emergency button placement](button.png)

Font is comic sans because why not.
### [3018_power_supply_holder](./CNC_3018_pro/3018_power_supply_holder/)
# 3018 Pro power supply holder
Simple bracket to hold the multi-voltage power supply that came with the machine.
### [3018_pro_electronics_case](./CNC_3018_pro/3018_pro_electronics_case/)
# 3018 Pro electronics case
Electronics enclosure for the GRBL board. No additional screws or hardware needed. Fully encloses the electronics to protect from debris. Also supports a 40mm fan for cooling the stepper drivers.

### [3018_x_stop_creality](./CNC_3018_pro/3018_x_stop_creality/)
# CNC 3018 Pro X end stop
End stop support using an unused Z end stop microswitch from a Creality Ender 5.

### [CNC_3018_pro](./CNC_3018_pro/)
# CNC 3018 Pro
Additions and modifications to my CNC 3018 Pro kit.
### [MRX-108_knobs](./MRX-108_knobs/)
Knobs designed to fit [MRX-108](https://www.mouser.it/datasheet/2/295/MRpowerLevel-22799.pdf) rotary switches.
### [W3230_thermostat](./W3230_thermostat/)
Model of a cheap [W3230](http://sahel.rs/media/sah/techdocs/w3230-manual.pdf) temperature controller

### [alps_keychain](./alps_keychain/)
A keychain for Alps/Matias keyswitches. [Thingiverse link](https://www.thingiverse.com/thing:4214306)
### [am2302_esp01_box](./am2302_esp01_box/)
Box to fit a ESP-01 microcontroller and a DHT22 AM2302 temperature/humidity sensor.
### [bafang_connector_cap](./bafang_connector_cap/)
An end cap for bafang male connectors. [Thingiverse link](https://www.thingiverse.com/thing:4347127)
### [chromebook_for_work_feet](./chromebook_for_work_feet/)
Back feet replacement for Acer Chromebook 14 For Work. [Thingiverse link](https://www.thingiverse.com/thing:4346295)
### [curtain_hook](./curtain_hook/)
Window-screwable hook to hold curtains. [Thingiverse link](https://www.thingiverse.com/thing:4222626)
### [dishwasher_salt_cap_tool](./dishwasher_salt_cap_tool/)
Salt cap removal tool for NEFF/Siemens dishwashers. [Thingiverse link](https://www.thingiverse.com/thing:4305524)
### [drip_catcher](./drip_catcher/)
Catches hand sanitizer drips from automatic dispensers
### [ender5_cable_bracket](./ender5_cable_bracket/)
A bracket to retain the carriage cables on an Ender 5
### [ender5_filament_sensor_holder](./ender5_filament_sensor_holder/)
A bracket to hold [this](https://www.thingiverse.com/thing:3063430) filament runout sensor. [Thingiverse link](https://www.thingiverse.com/thing:4251291)
### [ender5_tool_holder](./ender5_tool_holder/)
Remix of [@TrigoKlei](https://www.thingiverse.com/thing:3655629)'s Ender 5 tool holder with the addition of a tweezers holder. [Thingiverse link](https://www.thingiverse.com/thing:4222592)
### [hi-tek_mx_adapter](./hi-tek_mx_adapter/)
Hi-Tek High Profile/Stackpole keycap to Cherry MX-style adapter.

Tested with Hi-Tek keycaps on Kailh Box switches.
### [ikea_dagotto_antislip](./ikea_dagotto_antislip/)
IKEA Dagotto footrest anti-slip for original rubber feet.

This piece prevents the original rubber feet from sliding along the metal frame of the footrest. It is kept in place via the peg that inserts into the frame hole.

Inspired by [this](https://www.thingiverse.com/thing:2716418) thingiverse design.
### [ikea_drawer_organizers](./ikea_drawer_organizers/)
IKEA plastic drawer unit organizers

Organizers I designed to fit inside the drawers of a discontinued IKEA plastic drawer unit on casters.

I printed them with vase mode.
### [lamp_bracket](./lamp_bracket/)
Bracket to hold recessed spotlights in a constrained space
### [lithophane_candle](./lithophane_candle/)
Lithophane tealight holder

Design inspired by [this](https://www.thingiverse.com/thing:4682260).
I used [itslitho](https://tool.itslitho.com/CreateModel) to generate lithophanes with the following settings:
- Shape: Arc
- Height: 100 mm (shouldn't matter as long as it's equal between all images)
- Crop: enabled
- Width: 70 mm
- Andle: 90 Deg (90 Deg for 4 pictures, 60 Deg for 6, etc..)
- Max Thick: 3.2 mm

- Frame: Frame
- Thickness: 3 mm
- Depth: 4 mm

Design is parametric and can be easily tweaked to fit pictures with different diameters and thicknesses.
### [logitech_z407_dial_back](./logitech_z407_dial_back/)
Replacement plate for the volume dial of Logitech's Z407 speaker set.
### [palmrest_monitor_holder](./palmrest_monitor_holder/)
Palmrest holder bracket designed to fit behind a Samsung U28D590 monitor
### [precision_screwdriver](./precision_screwdriver/)
Mini precision screwdriver with integrated 14 bit holder. Based around a 6.35mm x 115mm magnetic screw bit extender.

The whole assembly is a pressure fit, so tolerances are important.
[Thingiverse link](https://www.thingiverse.com/thing:4441645)
### [precision_screwdriver_v2](./precision_screwdriver_v2/)
Mini precision screwdriver handle with integrated 16 bit holder. Based around a 4mm x 115mm magnetic screw bit extender and 5mm x 2mm disc magnets.

Inspired by [my previous attempt](/precision_screwdriver) and work from [Fjederhaek](https://www.thingiverse.com/thing:4399253).

#### Parts
- 8x 5x2mm round magnets
- 1x magnetic screw bit extender 115~150mm total length (shorter is better)

#### Assembly
Magnets should stay in place without glue.
Use a rubber mallet to insert the bit extender in the handle
### [samsung_monitor_riser](./samsung_monitor_riser/)
35mm risers for Samsung monitors with crappy T-shaped fixed stand
### [scr_4000w](./scr_4000w/)
Model of a [cheap noname](https://www.amazon.it/gp/product/B07P7N5JHK/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1) 4000W SCR AC Voltage Regulator.

[Terminal block] (https://grabcad.com/library/terminal-block-9-52mm-pitch-4-s-four-4-1) by Michael Gräf.
### [shelly](./shelly/)
3D models of various [Shelly](https://shelly.cloud/) products. Useful to make enclosures/addons.
### [shelly_box](./shelly_box/)
Small box with integrated [Shelly 1](https://shelly.cloud/products/shelly-1-smart-home-automation-relay/) holder
### [shower_shelf_holder](./shower_shelf_holder/)
Recreation of a bracket used to hold a shelf in a shower
### [skadis_box_shelf](./skadis_box_shelf/)
Shelf for IKEA SKÅDIS pegboard to hold [this](https://www.thingiverse.com/thing:3726336) box and retain stackability.

Original CAD file by [Wolfgang Villing](https://www.thingiverse.com/ringel_1/designs). [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode)
### [skadis_boxv5_holder](./skadis_boxv5_holder/)
Stackable Box V5 holder for IKEA SKÅDIS Pegboard

Redesign of [@mhson](https://www.thingiverse.com/thing:2535294)'s stackable box holder to accomodate for the wider wall-thickness of [@ringel_1](https://www.thingiverse.com/thing:3726336)'s stackable box remix.
[Thingiverse link](https://www.thingiverse.com/thing:4703995)
### [skadis_jumper](./skadis_jumper/)
IKEA SKÅDIS jumper wire organizer
### [super_struts_compression_tab](./super_struts_compression_tab/)
Adds the compressive design of [this model](https://www.thingiverse.com/thing:4128533) to the original [super struts](https://www.thingiverse.com/thing:3479330) without reprinting the whole thing.
### [table_hook](./table_hook/)
Hook that clamps on the legs of a [Frezza Pop Easy](https://www.frezza.com/en/products/pop-easy-desk/) desk.

### [table_join_clamp](./table_join_clamp/)
Clamp to join two [Frezza Pop Easy](https://www.frezza.com/en/products/pop-easy-desk/) desks.

### [tablet_tradmill](./tablet_tradmill/)
Nexus 7 (2013) tablet holder. Designed to be glued on a treadmill with double-sided tape.
### [tektronix_tds220_power](./tektronix_tds220_power/)
Tektronix TDS 220 Oscilloscope Power button replacement.
### [toorx_brx300_mount](./toorx_brx300_mount/)
Mounting insert for Toorx BRX300 exercise bike. [Thingiverse link](https://www.thingiverse.com/thing:4236508)
### [wall_mount_panel_clamping_system](./wall_mount_panel_clamping_system/)
Adjustable wall-mount clamps for 10mm thick panels. `bottom` is the bottom bracket, while `base` and `slider` make the top bracket assembly that is adjustable with a M4x30 screw. [Thingiverse link](https://www.thingiverse.com/thing:4362476)
### [yeelight_headphone_holder](./yeelight_headphone_holder/)
Simple headphone holder for Yeelight Mi LED Desk Lamp. No tools or modifications to the lamp are required. [Thingiverse link](https://www.thingiverse.com/thing:4656491)
