var waypoints = {
    "stanza1" : [58,13,0],
    "stanza2" : [53,18,0],
    "stanza3" : [0,0,0],
    "stanza4" : [0,0,0],
    "stanza5" : [0,0,0],
    "stanza6" : [0,0,0]
}

var utente;
var posizione;
var ros;
var dst;
var pub_obiettivo;
var sub_log;

function log(str){
    $("#output").val(str+"\n"+$("#output").val());
}

function setup_ros(){

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

    pub_obiettivo = new ROSLIB.Topic({
        ros : ros,
        name : '/obiettivo',
        messageType : 'dr_ped/Obiettivo'
    });

    sub_log = new ROSLIB.Topic({
        ros : ros,
        name : '/logger_web',
        messageType : 'std_msgs/String'
      });
    
    sub_log.subscribe(function(message) {
        log(message.data);
    });

}

$(document).ready(() => {

    $("#persona").on('change', () => {
		$("#welcome").html("Ciao "+$("#persona option:selected").text());
        utente=parseInt($("#persona option:selected").attr("value"));
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
        var obiet = new ROSLIB.Message({
            sender : utente,
            x : dst[0],
            y : dst[1],
            theta : dst[2]
        });
        pub_obiettivo.publish(obiet);
    });

});