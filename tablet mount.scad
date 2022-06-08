include<mbLib.scad>;

res = 0.5;

showRods = true;
showConsol = true;
showTablet = true;
showTransition = true;

stalkAngle = 17;
stalkYCenters = 15;
carbonRodR = 6;
minSkin = 6;


    tabletBlock();
    consolBlock();

if (showTransition == true) transition();
module transition(){
    transBlockR1 = carbonRodR + minSkin;
    transBlockR2 = carbonRodR + minSkin;
    transBlockH = 80;
    transBlockZOS = 60;
    hull() for(i = [-1,1]){
            translate([0,i * stalkYCenters,0]) rotate([0,stalkAngle,0]) translate([0,0,transBlockZOS]) cylinder(h = transBlockH, r1 = transBlockR1, r2 = transBlockR2);
    }
}

module tabletBlock(){
    tabletBlockR1 = carbonRodR + minSkin;
    tabletBlockR2 = carbonRodR + minSkin;
    tabletBlockZOS = 90;
    tabletBlockH = 200 - tabletBlockZOS;
    //bit of a hack to create a 'shadow' block to form a hul with.
    tabletShadowZOS = 180;
    tabletShadowXOS = -60; 
    tabletShadowCenters = stalkYCenters + 7;
    tabletShadowBlockH = tabletBlockH - 30;

    difference(){
        hull() for(i = [-1,1]){
            translate([0,i * stalkYCenters,0]) rotate([0,stalkAngle,0]) translate([0,0,tabletBlockZOS]) cylinder(h = tabletBlockH, r1 = tabletBlockR1, r2 = tabletBlockR2);
            translate([tabletShadowXOS,2 * i * tabletShadowCenters,0]) rotate([0,stalkAngle,0]) translate([0,0,tabletShadowZOS]) cylinder(h = tabletShadowBlockH, r1 = tabletBlockR1, r2 = tabletBlockR2); 
        }
        tablet(200);
        cRods();
    }
}


//Lower block (at the consol)
module consolBlock(){
    consolBlockR1 = carbonRodR + minSkin;
    consolBlockR2 = carbonRodR + minSkin;
    consolBlockH = 60;
    //bit of a hack to create a 'shadow' block to form a hul with.
    consolShadowXOS = -70; 
    consolShadowCenters = stalkYCenters + 10;
    consolShadowBlockH = consolBlockH - 30;

    difference(){
        hull() for(i = [-1,1]){
            qCone(rad1=consolBlockR1,rad2=consolBlockR2,hei=consolBlockH,res=res,os=[0,i * stalkYCenters,0],rot = [0,stalkAngle,0]);
            qCone(rad1=consolBlockR1,rad2=consolBlockR2,hei=consolShadowBlockH,res=res,os=[consolShadowXOS,2 * i * consolShadowCenters,0],rot = [0,stalkAngle,0]);
        }
        consol();
        cRods();
    }
}





//Show the carbon rods
if (showRods == true) cRods();
module cRods(){
    cRodR = carbonRodR;
    cRodL = 160;
    cRodYCLOS = stalkYCenters;
    cRodAngle = stalkAngle;


    for(i = [-1,1]){
        color("pink"){
            qCyl(rad=cRodR,hei=cRodL,res=res,os=[0,i * cRodYCLOS,0],rot=[0,cRodAngle,0]);
        }
    }
}

//
//Consol Pillar
if (showConsol == true) consol();
module consol(){
    consolR1 = 125;
    consolR2 = 110;
    consolH = 100;
    consolOS = [-124,0,-30];
    color("LemonChiffon"){
        qCone(rad1=consolR1,rad2=consolR2,hei=consolH,res=res,os=consolOS);
    }
}


//
//Tablet
if (showTablet == true) tablet();
module tablet(thickness = 8){
    tabletDims = [thickness,245,150];
    tabletOS = [-20,0,95];
    tabletRot = 45;
    color("DimGray") translate(tabletOS) rotate([0,tabletRot,0]) translate([-tabletDims[0]/2,0,tabletDims[2]/2]) cube(size=tabletDims,center=true);
}



/*
module pos(){
    for(y = [5:ySlice:15 - ySlice]){
        rad1 = 2*((y-10)/5)*((y-10)/5) + 6;
        rad2 = 2*(((y + ySlice)-10)/5)*(((y + ySlice)-10)/5) + 6;
        qCone(rad1=rad1,rad2=rad2,hei=ySlice,res=res,os=[0,0,y]);
    }
    for(i = [0:len(radPos1)-1]){
        qCone(rad1=radPos1[i],rad2=radPos1[i+1],hei=hPos1[i+1] - hPos1[i],res=res,os=[0,0,hPos1[i]]);
    }
    
    
}

module neg(){
    for(i = [0:len(radNeg)-1]){
        qCone(rad1=radNeg[i],rad2=radNeg[i+1],hei=hNeg[i+1] - hNeg[i],res=res,os=[0,0,hNeg[i]]);
    }
}

difference(){
    pos();
    neg();
}
*/