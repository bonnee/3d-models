// Model resolution
$fn = 60;

// Cell diameter
batDia=18.8; // [18.8:18650, 21.8:21700, 26.8:26650]

// Spacing between cells
batSpacing = 2.0; // [0.0:0.1:10]
borderWidth = 2.0; // [0.5:0.1:10]

// Total part height
partHeight = 8.0; // [3.0:0.1:15]

// Columns
bankColumns = 5;

// Columns
bankRows = 2; 

// Metal strip slot width
stripWidth = 8.0; // [2:0.1:10]

// Metal strip slot height
stripHeight = 1.5; // [0.5:0.1:3]

// Lip that stops the battery from falling through the piece
batStopLip = 3; // [2:0.1:5]

// Drill holes in-between cells to ease cable management
holes = true;

// Corner fillets follow cell curve
filletFollowsCell = true;

// Corner fillet radius. Ignored if above checkbox is ticked
cornerFilletRadius = 3.0; // [0:0.1:16]

cornerRadius = filletFollowsCell ? (batDia/2+borderWidth) : cornerFilletRadius;


difference() {
    // Create the grid and cells first
    translate ([-batDia/2-borderWidth, -batDia/2-borderWidth,-.5])
        rcube([bankRows*(batDia+batSpacing)+borderWidth*2-batSpacing, bankColumns*(batDia+batSpacing)+borderWidth*2-batSpacing, partHeight], cornerRadius);    

    union() {
        translate ([0,0,stripHeight/2]) rectangular_array(rows=bankRows, cols=bankColumns, distance=batDia+batSpacing) cylinder(h=partHeight, r=batDia/2);
        translate ([0,0,-stripHeight/2]) rectangular_array(rows=bankRows, cols=bankColumns, distance=batDia+batSpacing) cylinder(h=partHeight, r=batDia/2-batStopLip);

        rectangular_array(rows=bankRows,
                          cols=bankColumns,
                          distance=batDia+batSpacing)
        cube([batDia+batSpacing+borderWidth, stripWidth, stripHeight], true);
            
        rectangular_array(rows=bankRows,
                          cols=bankColumns,
                          distance=batDia+batSpacing)
        cube([stripWidth, batDia+batSpacing+borderWidth, stripHeight], true);
    }
    
    if(holes && (bankRows > 1 && bankColumns > 1)) {
    for (i = [0:bankRows - 2])
      for (j = [0:bankColumns - 2])
            translate([(batDia/2+batSpacing/2)+i*(batDia+batSpacing), (batDia/2+batSpacing/2)+j*(batDia+batSpacing), -stripHeight])
                buco(partHeight+stripHeight, batDia/2, batSpacing);
  }
}

module buco(h, batR, batS) {
    cylinder(h=h, r=(batR)*(sqrt(2)-1)+(batS*(sqrt(2)/2-1)));
}
 
module rectangular_array(rows, cols, distance) {
    for ( i= [0:1:rows-1])  {
        for ( j= [0:1:cols-1]) {
            translate([distance*i,distance*j,0,]) 
            children();
        }
    }
}

module rcube(size, radius) {
    if (radius > 0) {
        hull() {
            translate([radius, radius]) cylinder(r = radius, h = size[2]);
            translate([size[0] - radius, radius]) cylinder(r = radius, h = size[2]);
            translate([size[0] - radius, size[1] - radius]) cylinder(r = radius, h = size[2]);
            translate([radius, size[1] - radius]) cylinder(r = radius, h = size[2]);
        }
    } else {
        cube(size);
    }
}
