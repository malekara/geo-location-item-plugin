function setPlaceHolder(pType,pItem,pResultItem) {
    console.log(pType);
    if (pType=='1') {
    $('#'+pItem).attr('placeholder','DD.DDDD');
    }
    else if (pType=='2') {
    $('#'+pItem).attr('placeholder','DDDDDD');
    }
    else if (pType=='3') {
        $('#'+pItem).attr('placeholder','DDDDDDD');
        }
    checkCoordinate(pType,pItem,pResultItem);
    }	
    
    function checkCoordinate(pType,pCoor,pItem,pResultItem) {
    var reg;
    var regAshari= new RegExp("^([0-8]?[0-9])(\\.[0-9]+)?$");
    var regUtmY= new RegExp("^[0-9]{6}$");
    var regUtmX= new RegExp("^[0-9]{7}$");
    
    if  (pType=='0') {reg=regAshari;}
    else if  (pType=='1') { 
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