//todo in futuro il setup di stanza e relative posizioni si può fare attraverso json
//todo selezionando la mappa sulla quale si sta operando
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

var stati = {
    non_disponibile: 0,
    in_arrivo: 1,
    disponibile: 2,
    stanza_corrente: 3 //è nella stanza corrente solo se ne confermo l'arrivo
};

var stato=stati.non_disponibile; //! 0 significa che non sei il destinatario di status non disponibile


function log(str){
    $("#output").val(str+"\n"+$("#output").val());
}

function update_status(){
    //todo se si dirige nella mia stanza in arrivo e posso confermare
    //todo se si dirige in un'altra stanza non disponibile

    //update in base al pub
    enable_action();
}

function handler_buttons(to_disable, to_enable){
    $(to_disable).prop("disabled",true);
    $(to_enable).prop("disabled",false);
}

function enable_action(){
    console.log(stato);
    switch (stato){
        case stati.non_disponibile:
            handler_buttons($(".btn"),$(""))
            break;
        case stati.in_arrivo:
            handler_buttons($(".btn"),$("#conferma"))
            break;
        case stati.disponibile:
            handler_buttons($(".btn"),$("#chiama"))
            break;
        case stati.stanza_corrente:
            handler_buttons($(".btn"),$(".stanza"))   
    }
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
    //todo serve chiedere un servizio / sottoscriversi allo status del robot per capire dove si dirige e se è arrivato (eventuale msg)
    //todo si sblocca solo dopo che qualcuno ha confermato o è scattato il timeout, il robot torna da dove
    //todo è partito

}

$(document).ready(() => {
    update_status();
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