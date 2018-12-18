module vescScrewMount(x=0,y=0) {
    translate([x,y,0])
        difference() {
        cylinder(10,3.5,2.5, $fn=50);
        translate([0,0,-1])cylinder(13,vescScrew,vescScrew, $fn=50);
    };
}

module arduinoScrewMount(x=0,y=0) {
    translate([x,y,0])
        difference() {
        cylinder(7,2.5,1.5, $fn=50);
        translate([0,0,-1])cylinder(10,arduinoScrew,arduinoScrew, $fn=50);
    };
}

module cornerPost(x=0,y=0) {
    translate([x,y,0])
        difference() {
        cylinder(40,5,5, $fn=50);
        
    };
}

module cornerScrew(x=0,y=0) {
    translate([x,y,33])
    union() {
        cylinder(13,vescScrew,vescScrew, $fn=50);
        translate([0,0,10])cylinder(3,vescScrew*2,vescScrew*2, $fn=50);
    }
}

caseBottom = true;

bikeBolt = 3.8;
bikeBoltOffset = bikeBolt/2;
bikeConWidth = 32;
bikeConLength = 78.5;

vescScrew = 1.48;
vescMountWidth = 35.5;
vescMountLength = 65.0-1.44-1.705;
vescTopWidth = 14.55;
vescTopOffset = (vescMountWidth-vescTopWidth)/2;

arduinoMountWidth = 36;
arduinoMountLength = 56;
arduinoScrew = 0.95;

caseWidth = 63;
caseLength = 110;
caseHeight = 40;
caseOpening = 5;

caseRounding = 3;

difference() {
    translate([caseRounding,caseRounding,caseRounding])
    minkowski() {
        union() {
            cube([caseWidth,caseLength,caseHeight]);
            
     
        }
        sphere(caseRounding,$fn=50);
    };
    //interior cutout
//    translate([caseRounding,-caseOpening,caseRounding]) cube([caseWidth,caseLength+caseRounding+caseOpening,caseHeight]);
    translate([caseRounding,caseRounding,caseRounding])
    difference() {
        cube([caseWidth,caseLength,caseHeight]);
        cornerPost(0,0);
        cornerPost(caseWidth,0);
        cornerPost(caseWidth, caseLength);
        cornerPost(0, caseLength);
    }
    translate([((caseWidth-bikeConWidth)/2)+caseRounding,((caseLength-bikeConLength)/2)+caseRounding,0]){
    //bikeBolt holes
    translate([bikeBoltOffset,bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    translate([bikeConWidth-bikeBoltOffset,bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    translate([bikeBoltOffset,bikeConLength-bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    translate([bikeConWidth-bikeBoltOffset,bikeConLength-bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    }
    
    cornerScrew(4,4);
    cornerScrew(caseWidth+2,4);
    cornerScrew(caseWidth+2, caseLength+2);
    cornerScrew(4, caseLength+2);
    
    if (caseBottom) {
        translate([-1,-1,42])
        cube([caseWidth*1.5,caseLength*1.5,caseHeight*1.5]);
    } else {
        translate([-1,-1,0]) 
        cube([caseWidth*1.5,caseLength*1.5,caseHeight+2.8]);
    }    
    
    //bldc wire cutout
    translate([((caseWidth-30)/2)+caseRounding,-5,caseRounding+3]) cube([30,20,10]);
    
    //power wire cutout
    translate([((caseWidth-30)/2)+caseRounding,caseLength-5,13]) cube([30,20,10]);
    
    //vesc usb cutout
    translate([-1,((caseLength-vescMountLength)/2)+caseRounding+17+8,13]) 
    cube([30,13,9]);
}


if (caseBottom) {
    //bike mount
    translate([((caseWidth-bikeConWidth)/2)+caseRounding,((caseLength-bikeConLength)/2)+caseRounding,0])
    difference() {
    union() {
        cube([bikeConWidth,bikeConLength,1]);
        
        //bikeBolt mounts
        translate([bikeBoltOffset,bikeBoltOffset,0])cylinder(5,d1=8,d2=6, $fn=50);
    translate([bikeConWidth-bikeBoltOffset,bikeBoltOffset,0])cylinder(5,d1=8,d2=6, $fn=50);
    translate([bikeBoltOffset,bikeConLength-bikeBoltOffset,0])cylinder(5,d1=8,d2=6, $fn=50);
    translate([bikeConWidth-bikeBoltOffset,bikeConLength-bikeBoltOffset,0])cylinder(5,d1=8,d2=6, $fn=50);
    }

    translate([bikeBoltOffset,bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
        translate([bikeConWidth-bikeBoltOffset,bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
        translate([bikeBoltOffset,bikeConLength-bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
        translate([bikeConWidth-bikeBoltOffset,bikeConLength-bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);

    }

    //vesc mount
    translate([((caseWidth-vescMountWidth)/2)+caseRounding,((caseLength-vescMountLength)/2)+caseRounding+17,caseRounding])

    union() {
        //cube([vescMountWidth,vescMountLength,1]);
        
        //
        vescScrewMount(vescScrew, vescScrew);
        vescScrewMount(vescMountWidth-vescScrew,vescScrew);
        
        vescScrewMount(vescScrew+vescTopOffset,vescMountLength-vescScrew);
        vescScrewMount(vescMountWidth-vescScrew-vescTopOffset,vescMountLength-vescScrew);
    }
} else {
//arduino mount
    //translate([69,0,0]) {
//
//    translate([0,0,-43]) {
    
//        translate([((caseWidth-arduinoMountWidth)/2)+caseRounding,((caseLength-arduinoMountLength)/2)+caseRounding,caseRounding])
    translate([((caseWidth-arduinoMountWidth)/2)+caseRounding + arduinoMountWidth,8,46]) {
        rotate([0,180,0]) {
        union() {
            cube([arduinoMountWidth,arduinoMountLength,1]);
            
            //
            arduinoScrewMount(arduinoScrew, arduinoScrew);
            arduinoScrewMount(arduinoMountWidth-arduinoScrew,arduinoScrew);
            
            arduinoScrewMount(arduinoScrew,arduinoMountLength-arduinoScrew);
            arduinoScrewMount(arduinoMountWidth-arduinoScrew,arduinoMountLength-arduinoScrew);
        }
    
    }}
}