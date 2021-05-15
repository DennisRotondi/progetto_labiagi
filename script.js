var waypoints = {
    "stanza1" : [0,1,1],
    "stanza2" : [0,0,0],
    "stanza3" : [0,0,0],
    "stanza4" : [0,0,0],
    "stanza5" : [0,0,0],
    "stanza6" : [0,0,0]
}

var utente;
var posizione;
var ros;
var dst;

function log(str){
    $("#output").val(str+"\n"+$("#output").val());
}

function setup_ros(){
    return;
    ros = new ROSLIB.Ros({
      url : 'ws://192.168.1.69:9090'
    });
    
    ros.on('connection', () => {
        log('Connected to websocket server.');
    });

    ros.on('error', (error) => {
        log('Error connecting to websocket server: ', error);
    });

    ros.on('close', () => {
        log('Connection to websocket server closed.');
    });
}

$(document).ready(() => {

    $("#persona").on('change', () => {
		$("#welcome").html("Ciao "+$("#persona option:selected").text());
        utente=$("#persona option:selected").attr("value");
        $("#stanza").removeClass("invisibile");
        $("#persona").addClass("invisibile");
        setup_ros(); //mi connetto a ros
    });

    $("#stanza").on('change', () => {
        posizione=$("#stanza option:selected").attr("value");
        $("#controllo").removeClass("invisibile");
        log("sei nella stanza "+posizione);
    });

    $(".stanza").on('click', (event) => {
        dst=waypoints[$(event.target).attr("data-target")]
        log("verso la destinazione "+dst);
    });

});