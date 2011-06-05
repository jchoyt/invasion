//{{{ on page ready
var myLayout; // init global vars
$(document).ready( function() {

    myLayout = $('body').layout({
        // RESIZE Accordion widget when panes resize
        // west__onresize:		function () { $("#accordion1").accordion("resize"); },
        //east__onresize:		function () { $("#accordion").accordion("resize"); },
        east:  {initClosed: false, slideTrigger_open: "click", size: 350 },
        west: { size: 320, resizable: false },
        north:  {initClosed: true }
    });

        // ACCORDION - in the East pane - in a 'content-div'
    $("#accordion").accordion({
        //fillSpace: true,
        active: 1,
        collapsible: true,
        autoHeight: false
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

    // assumption is on polling, we do $(document).trigger('POLL_COMPLETE', <json data>);
    $(document).bind('POLL_COMPLETE', function(e, data){ 
		checkForReload(data);
		updateMessagePane(data);
		updateOccupantPane(data);
		updatePetPane(data);
		updateInventory(data);
		updateAnnouncements(data);
		updateStats(data);
		updateStats2(data);
		updateLocation(data);
	});

    // setInterval( "poll()", 10000);

    //set popup menu
    $.pop();

}); //}}}

//{{{ GUI updates
function checkForReload( data )
{
    if( data.reload )
    {
        window.location="/map/index.jsp";
    }
    if( data.stats.reload )
    {
        window.location="/map/index.jsp";
    }
}


function poll()
{
    $("#poll-indicator").show();
    $.getJSON("/poll", function(json){
        $(document).trigger('POLL_COMPLETE', json);
		$("#poll-indicator").hide();
    });
}


function updateMessagePane(data)
{
    if(data.msgs)
    {
        $("#msg-box").html(v2js_messages(data));
        $("#amessages").scrollTop($("#amessages").attr("scrollHeight"));
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
    var url = "attack?target=" + targetid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function attack_pet( targetid )
{
    var url = "attackPet?target=" + targetid;
    $.getJSON(url, function(json){
        $(document).trigger('POLL_COMPLETE', json)
    });
}

function showtarget(id)
{
    show = "#desc-" + id;
    $("#att-box").html($(show).html());
};

function show_pet_target(id)
{
    show = "#pet-desc-" + id;
    $("#att-pet-box").html($(show).html());
};

//}}}
// :collapseFolds=0:folding=explicit:
