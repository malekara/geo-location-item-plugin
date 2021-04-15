function setPlaceHolder(pType) {
console.log(pType);
if (pType=='0') {
$('#P5_Y1_UTM').attr('placeholder','DD.DDDD');
$('#P5_X1_UTM').attr('placeholder','DD.DDDD');
}
else if (pType=='1') {
$('#P5_Y1_UTM').attr('placeholder','DDDDDD');
$('#P5_X1_UTM').attr('placeholder','DDDDDDD');
}
checkCoordinate($v('P5_Y1_UTM'),$('#P5_Y1_UTM'));
checkCoordinate($v('P5_X1_UTM'),$('#P5_X1_UTM'));
}	

function checkCoordinate(pCoor,gpsItem) {
var reg;
var regAshari= new RegExp("^([0-8]?[0-9])(\\.[0-9]+)?$");
var regUtmY= new RegExp("^[0-9]{6}$");
var regUtmX= new RegExp("^[0-9]{7}$");

if  ($v('P5_COORDINATE_TYPE')=='0') {reg=regAshari;}
else if  ($v('P5_COORDINATE_TYPE')=='1') { 
if ($(gpsItem).attr('id')=='P5_Y1_UTM') {
    reg=regUtmY; }
else {reg=regUtmX;} 

}

if( reg.exec(pCoor) ) {
    console.log(pCoor + ' --- '+ reg.exec(pCoor));
$s('P5_GPS_FLAG',1);
    if ($(gpsItem).attr('id')=='P5_X1_UTM') {
         $('#check-gps-x').html('<img src="#WORKSPACE_IMAGES#yes.png"  class="yesno-img" alt="yes" width="20" height="20">');
    } 
    if ($(gpsItem).attr('id')=='P5_Y1_UTM') {
        $('#check-gps-y').html('<img src="#WORKSPACE_IMAGES#yes.png" class="yesno-img" alt="yes" width="20" height="20">');
    }


    
console.log('ok');
} else {
        console.log(pCoor + ' --- '+ reg.exec(pCoor));

console.log('no');
$s('P5_GPS_FLAG',0);
if ($(gpsItem).attr('id')=='P5_X1_UTM') {
    $('#check-gps-x').html('<img src="#WORKSPACE_IMAGES#no.png"  class="yesno-img" alt="yes" width="20" height="20">');
} 
if ($(gpsItem).attr('id')=='P5_Y1_UTM') {
   $('#check-gps-y').html('<img src="#WORKSPACE_IMAGES#no.png"  class="yesno-img"  alt="yes" width="20" height="20">');
}
}
if (pCoor =='') {$(gpsItem).next().text('');
}
}