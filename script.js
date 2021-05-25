var waypoints;
//= { 
//     "stanza1" : [58,13,0],
//     "stanza2" : [53,18,0],
//     "stanza3" : [0,0,0],
//     "stanza4" : [0,0,0],
//     "stanza5" : [0,0,0],
//     "stanza6" : [0,0,0]
// }

var websocket; //192.168.1.69:9090 se da altra macchina
var utente;
var stanza_corrente;
var ros;
var stanza_idx;
var pub_obiettivo;
var pub_conferma;
var sub_log;


var stati = {
    disponibile: 0, 
    in_arrivo: 1, //se è in navigazione verso di noi
    attesa_conferma: 2, //è nella stanza corrente e devo confermarne l'arrivo
    non_disponibile: 3, //se è in navigazione non verso di noi
    disp_corrente: 4
};

var stato; //! 0 significa che non sei il destinatario di status non disponibile



function log(str){
    $("#output").val(str+"\n"+$("#output").val());
}

function update_status(stato_msg){
    log(stato_msg.commento);
    if(stato_msg.stato == stati.disponibile){
        stato = (stato_msg.stanza_target == stanza_corrente) ? stati.disp_corrente : stati.disponibile;
    }
    else if(stato_msg.stato == stati.attesa_conferma){
        stato = (stato_msg.stanza_target == stanza_corrente) ? stati.attesa_conferma : stati.non_disponibile;
    }
    else{ //è in navigazione
        if(stato_msg.stanza_target == stanza_corrente){
            stato=stati.in_arrivo;
            log("Il robot sta arrivando da te.");
        }
        else{
            stato=stati.non_disponibile;
        }
    }
    
    //update in base al pub
    handler_status();
}

function set_stato(new_stato){
    stato=new_stato;
    handler_status();
}

function handler_buttons(to_disable, to_enable){
    $(to_disable).prop("disabled",true);
    $(to_enable).prop("disabled",false);
}

function handler_status(){
    // log("stato "+stato);
    switch (stato){
        case stati.non_disponibile:
            handler_buttons($(".btn"),$(""));
            break;
            case stati.in_arrivo:
                handler_buttons($(".btn"),$(""));
                break;
                case stati.disp_corrente:
                    handler_buttons($(".btn"),$(".stanza"));
                    break;
                    case stati.disponibile:
                        handler_buttons($(".btn"),$("#chiama"));
            break;
            case stati.attesa_conferma:
                handler_buttons($(".btn"),$("#conferma"));   
    }
}

function chiudi_connessione(){
    stato=stati.non_disponibile;
    handler_status();
}

function setup_ros(){
    
    ros = new ROSLIB.Ros({
        url : websocket
    });
    
    ros.on('connection', () => {
        log('Connessione con il robot stabilita.');
    });
    
    ros.on('error', (error) => {
        log('Errore di connessione con il robot.', error);
        chiudi_connessione()
    });
    
    ros.on('close', () => {
        log('La connessione con il robot è stata interrotta.');
        chiudi_connessione()
    });
    
    pub_obiettivo = new ROSLIB.Topic({
        ros : ros,
        name : '/obiettivo',
        messageType : 'dr_ped/Obiettivo'
    });
    
    pub_conferma = new ROSLIB.Topic({
        ros : ros,
        name : '/conferma_dr_ped',
        messageType : 'std_msgs/String'
    });
    //conferma_dr_ped
    sub_log = new ROSLIB.Topic({
        ros : ros,
        name : '/logger_web',
        messageType : 'dr_ped/Stato'
    });
    
    sub_log.subscribe(function(stato_msg) {
        update_status(stato_msg);
    });
    
}

function send_obiettivo(stanza_obiet){
    var dst = waypoints[stanza_obiet];
    log("Inviata richiesta per la destinazione: "+stanza_obiet+" [ "+dst+" ]");
    var obiet = new ROSLIB.Message({
        sender : utente,
        id_stanza: stanza_obiet,
        x : dst[0],
        y : dst[1],
        theta : dst[2]
    });
    set_stato(stati.in_arrivo);
    pub_obiettivo.publish(obiet);
}

$(document).ready(() => {
    
    $("#login").on('click', () => {
        var nome = $("#nome").val();
        var pw = $("#password").val();
        if(!nome || !pw ){
            alert("inserisci nome e pw");
            return;
        }
        $("#welcome").html("Ciao "+nome);
        utente=nome+":"+pw;
        // $("#stanza").removeClass("invisibile");
        $("#carica_mappa").removeClass("invisibile");
        $("#persona").addClass("invisibile");
    });
    
    $("#input_mappa").on('change', () => {
        
        console.log($("#input_mappa")[0].files[0]);
        if ($("#input_mappa")[0].files.length>0) {

            var myFile = $("#input_mappa")[0].files[0];
            var reader = new FileReader();
            
            reader.onload = function(e) {
                waypoints = JSON.parse(e.target.result);
                for (key in waypoints){
                    $('#luogo').append("<option value= " + key +" > " + key +" </option>");
                    var bottone = $("<button type='button' class='stanza btn btn-outline-primary' data-target=" + key +">" + key +"</button>");
                    $('#stanze').append(bottone);
                }
                $(".stanza").on('click', (event) => {
                    console.log(event.target);
                    stanza_idx = $(event.target).attr("data-target");
                    send_obiettivo(stanza_idx);
                });
                $("#carica_mappa").addClass("invisibile");
                $("#stanza").removeClass("invisibile");
                set_stato(stati.non_disponibile);
                websocket="ws://"+location.hostname+":9090"; //per avere url in base a quello della macchina su cui si usa
                
                setup_ros(); //mi connetto a ros
                
            };
        
            reader.readAsBinaryString(myFile); 
        };
    });
    
    $("#stanza").on('change', () => {
        set_stato(stati.non_disponibile);
        stanza_corrente=$("#stanza option:selected").attr("value");
        // console.log(stanza_corrente);
        $("#controllo").removeClass("invisibile");
        log("Locazione corrente: "+stanza_corrente);
    });
    
    $("#conferma").on('click', (event) => {
        var conferma = new ROSLIB.Message({
            data : "conferma"
        });
        pub_conferma.publish(conferma);
    });

    $("#chiama").on('click', (event) => {
        send_obiettivo(stanza_corrente);
    });

});