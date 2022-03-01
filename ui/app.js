////////////////////////////////////////////////////////////////////////////////
///////////////////////////////   AFFICHAGE    /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

$(function () {
    // FERMETURE DU MENU
    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            $.post('http://cst_location-ui/close', JSON.stringify({}));
        }
    });
    // AFFICHAGE DU MENU
    $(document).ready(function () {
        window.addEventListener('message', function (event) {
            var item = event.data;
            if (item.display == true) {
                $('.container').css('display', 'block');
            } else if (item.display == false) {
                $('.container').css('display', 'none');
            }
        });
    });
});


////////////////////////////////////////////////////////////////////////////////
////////////////////////////   CONFIGURATION    ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// LISTE DES ARMES
var vehicles_list = {
    blista: {
        name: 'blista',
        label: 'Blista',
        price: '500',
        picture: 'img/blista.png'
    },

    bmx: {
        name: 'bmx',
        label: 'Bmx',
        price: '250',
        picture: 'img/bmx.png'
    },

    asbo: {
        name: 'asbo',
        label: 'Asbo',
        price: '450',
        picture: 'img/asbo.png'
    },

    brioso: {
        name: 'brioso',
        label: 'Brioso',
        price: '350',
        picture: 'img/brioso.png'
    },

    club: {
        name: 'club',
        label: 'Club',
        price: '350',
        picture: 'img/club.jpg'
    },

    panto: {
        name: 'panto',
        label: 'Panto',
        price: '350',
        picture: 'img/panto.png'
    },
}


////////////////////////////////////////////////////////////////////////////////
///////////////////////   AFFICHER TOUT LES ITEMS    ///////////////////////////
////////////////////////////////////////////////////////////////////////////////

function show_vehicles_list() {
    $('#vehicles_list').empty();
    $.each(vehicles_list, function (key, value) {
        $('#vehicles_list').append(
            '<div style="background-image: url(' + value.picture + ');" class="item" id="' + value.name + '">' +
            // '<img src="' + value.picture + '" class="item_picture">' +
            '<div class="detail-content"><div class="item_label">' + value.label + '</div>' +
            '<div class="item_price">' + value.price + '$</div>' +
            '<div id="' + value.name + '" class="item_buy ">Acheter</div></div>' +
            '</div>'
        );
    });
}

show_vehicles_list();


////////////////////////////////////////////////////////////////////////////////
/////////////////////////////   BUY VEHICLE    /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

function buy_item(name) {
    $.post('http://cst_location-ui/cst_location-ui:buy', JSON.stringify(name));
}

// ACHAT D'UN IEM PAR LE CLIQUE SUR LE BOUTON
$(document).on('click', '.item_buy', function () {
    buy_item(vehicles_list[$(this).attr('id')]);
});

// Copyright (c) 2022 COSSART - LazyDev //
