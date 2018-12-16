module vescScrewMount(x=0,y=0) {
    translate([x,y,0])
        difference() {
        cylinder(10,3.5,2.5, $fn=50);
        translate([0,0,-1])cylinder(13,vescScrew,vescScrew, $fn=50);
    };
}


bikeBolt = 3.8;
bikeBoltOffset = bikeBolt/2;
bikeConWidth = 32;
bikeConLength = 78.5;

vescScrew = 1.48;
vescMountWidth = 35.5;
vescMountLength = 65.0-1.44-1.705;
vescTopWidth = 14.55;
vescTopOffset = (vescMountWidth-vescTopWidth)/2;

caseWidth = 70;
caseLength = 130;
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
    translate([caseRounding,-caseOpening,caseRounding]) cube([caseWidth,caseLength+caseRounding+caseOpening,caseHeight]);
    
    translate([((caseWidth-bikeConWidth)/2)+caseRounding,((caseLength-bikeConLength)/2)+caseRounding,0]){
    //bikeBolt holes
    translate([bikeBoltOffset,bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    translate([bikeConWidth-bikeBoltOffset,bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    translate([bikeBoltOffset,bikeConLength-bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    translate([bikeConWidth-bikeBoltOffset,bikeConLength-bikeBoltOffset,-1])cylinder(10,d1=bikeBolt,d2=bikeBolt, $fn=50);
    }
    
}

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
translate([((caseWidth-vescMountWidth)/2)+caseRounding,((caseLength-vescMountLength)/2)+caseRounding,0])

union() {
    cube([vescMountWidth,vescMountLength,1]);
    
    //
    vescScrewMount(vescScrew, vescScrew);
    vescScrewMount(vescMountWidth-vescScrew,vescScrew);
    
    vescScrewMount(vescScrew+vescTopOffset,vescMountLength-vescScrew);
    vescScrewMount(vescMountWidth-vescScrew-vescTopOffset,vescMountLength-vescScrew);
    

    

}
