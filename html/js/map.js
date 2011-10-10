//{{{ on page ready
var myLayout; // init global vars
var base_url="/game/";
var map_url = base_url + "map/index.jsp";
var poll_url = base_url + "poll";


$(document).ready( function() {

    myLayout = $('#wholeEnchilada').layout({
        // RESIZE Accordion widget when panes resize
        // west__onresize:		function () { $("#accordion1").accordion("resize"); },
        //east__onresize:		function () { $("#accordion").accordion("resize"); },
        east:  {initClosed: false, slideTrigger_open: "click", size: 300 },
        west: { size: 320, resizable: false },
        north:  {initClosed: true }
    });

        // ACCORDION - in the East pane - in a 'content-div'
    $("#accordion").accordion({
        //fillSpace: true,
        active: 1,
        collapsible: true,
        autoHeight: false,
        navigation: true
    });

    $("#west-sections, #center-sections").addClass("ui-accordion ui-widget ui-helper-reset")
    .find("h6")
        .addClass("ui-accordion-header ui-helper-reset ui-accordion-header-active ui-state-active ui-corner-top")
        .prepend('<span class="ui-icon ui-icon-triangle-1-s"/>')
        .click(function() {
            $(this).toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
            .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e ui-icon-triangle-1-s")
            .end().next().toggleClass("ui-accordion-content-active").toggle();
            return false;
        })
        .next().addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active").css('display', 'block');

    $(".start-closed").click();


    // Close the popup menu upon clicking a link.
    $('.pop_menu > p > a').click(function() {
        $('.pop').removeClass('active');
    });

    // assumption is on polling, we do $(document).trigger('POLL_COMPLETE', <json data>);
    $(document).bind('POLL_COMPLETE', function(e, data){
        window.lastPoll = data;
		checkForReload(data);
		updateMessagePane(data);
		updateOccupantPane(data);
		updatePetPane(data);
		updateInventory(data);
		updateAnnouncements(data);
		updateStats(data);
		updateStats2(data);
		updateLocation(data);
		updateActions(data);
		updateItemPane(data);
		updateItemInventoryDialog(data);
		updateEquipImprovisedDialog(data);
	});

    // setInterval( "poll()", 10000);


    // Inventory management Dialog
    $('#inv-mgmt-dlg').dialog({
        autoOpen: false,
        width: 400,
        buttons: {
            "Cancel": function() {
                $(this).dialog("close");
            },
            "Submit": function() {
                var str= "src=" + $("#src").val() + "&dest=" + $("#dest").val();
                $("#inv-list :selected").each(function () {
                    str += "&itemid=" + $(this).val();
                });
                $.getJSON('transferItem?' +  str, function(json){
                    $(document).trigger('POLL_COMPLETE', json)
                });
            }
        }
    });

    $('#equip-improvised').dialog({
        autoOpen: false,
        width: 400
    });    //set popup menu

    $('#dialog').dialog({
        autoOpen: false,
        width: 600,
        buttons: {
            "Cancel": function() {
                $(this).dialog("close");
            }
        }
    });

    $.pop();

}); //}}}

//{{{ GUI updates
function checkForReload( data )
{
    if( data.reload )
    {
        window.location=map_url;
    }
    if( data.stats && data.stats.reload )
    {
        window.location=map_url;
    }
}


function poll()
{
    $("#poll-indicator").show();
    $.getJSON(poll_url, function(json){
        $(document).trigger('POLL_COMPLETE', json);
		$("#poll-indicator").hide();
    });
}


function updateMessagePane(data)
{
    if(data.msgs)
    {
        $("#msg-box").html(v2js_messages(data));
        $("#amessages").scrollTop($("#amessages").prop("scrollHeight"));
    }
}

function updateOccupantPane(data)
{
    /* if(data.occs)
    {
        $('#occ-pane').html("");
        $.each(data.occs, function(i, item){
            $('#occ-pane').append( item.name );
        });
    } */
    if(data.occs)
    {
        $('#occ-pane').html( v2js_occupants(data) );
        $('#attacklist').html( v2js_attacklist(data) );
    }
    else
    {
        $('#occ-pane').html("");
        $('#attacklist').html("");
        $('#att-box').html("");
    }
}

function updatePetPane(data)
{
    if(data.pets)
    {
        $('#pet-pane').html( v2js_critterpane(data) );
    }
    else
    {
        $('#pet-pane').html("");
        $('#att-pet-box').html("");
    }
}

function updateInventory(data)
{
    if(data.inv)
    {
        $("#inv-body").html( v2js_inventory(data) );
        $("#equiplist").html( v2js_equiplist(data) );
    }
    else
    {
        $("#inv-body").html( "" );
        $("#equiplist").html( "" );
    }
}

function updateAnnouncements(data)
{
    if(data.announce)
    {
        $('#announcements').html(v2js_announcements(data));
    }
    else
    {
        $('#announcements').html("");
    }
}

function updateStats(data)
{
    if(data.stats)
    {
        $('#stats-area').html(v2js_stats(data));
    }
}

function updateStats2(data)
{
    if(data.stats)
    {
        $('#stats-area2').html(v2js_stats2(data));
    }
}

function updateLocation(data)
{
    if(data.location)
    {
        $('#basic-description').html(v2js_locationDescription(data));
    }
}

function updateActions(data)
{
    // recharging and repair areas
    if(data.inv)
    {
        $("#recharge-item").html( v2js_rechargeItem(data) );
        $("#repair-item").html( v2js_repairItem(data) );
    }
    else
    {
        $("#recharge-item").html( "" );
        $("#repair-item").html( "" );
    }
}

function updateItemPane(data)
{
    if(data.ground)
    {
        $('#item-pane').html( v2js_itempane(data) );
    }
    else
    {
        $('#item-pane').html("");
    }
}

function updateItemInventoryDialog(data)
{
    if(data.inv)
    {
        $('#inv-mgmt-dlg').html( v2js_inventoryManagement(data) );
    }
    else
    {
        $('#inv-mgmt-dlg').html("");
    }
}

function updateEquipImprovisedDialog(data)
{
    if(data.inv)
    {
        $('#equip-improvised').html( v2js_equipImprovised(data) );
    }
    else
    {
        $('#equip-improvised').html("");
    }
}

//}}}

//{{{ Actions


function drop( itemid )
{
    var url = "drop?itemid=" + itemid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function eat( itemid )
{
    var url = "eat?itemid=" + itemid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function drink( itemid )
{
    var url = "drink?itemid=" + itemid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function dosearch( reps )
{
    var url = "search?count=" + reps;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function attack( targetid )
{
    var url = "attack?target=alt" + targetid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function attack_pet( targetid )
{
    var url = "attack?target=pet" + targetid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function showtarget(id)
{
    for (var occ_index=0;  occ_index<window.lastPoll.occs.length; occ_index++)
    {
        var occ = window.lastPoll.occs[occ_index];
        if( occ.id == id )
        {
            var attLink = "<a href=\"#\" onclick=\"attack(" + occ.id + ")\">Attack " + occ.name + "</a>";
            $("#att-box").html(attLink);
        }
    }
    //show = "#desc-" + id;
    // $("#att-box").html($(show).html());
};

function show_pet_target(id)
{
    show = "#pet-desc-" + id;
    $("#att-pet-box").html($(show).html());
};


function recharge(id)
{
    var url = "recharge?itemid=" + id;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function repair(id)
{
    var url = "repair?itemid=" + id;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function doTransfer( itemid, src, dest )
{
    var url = "transferItem?itemid=" + itemid + "&src=" + src + "&dest=" + dest;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}
function chalkWall()
{
    resource = "http://127.0.0.1:8080/game/map/chalk.jsp"; //base_url + "map/chalk.jsp";
    $('#dialog').load(resource, function() {
        $('#dialog').dialog('open');
    });
    return false;
}
//}}}
// :collapseFolds=0:folding=explicit:
