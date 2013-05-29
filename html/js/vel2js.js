function v2js_announcements(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.announce.length; i1++) {
var a = context.announce[i1];
velocityCount = i1;
t.p('    <h3 class="');
t.p( a.type);
t.p('">');
t.p( a.message);
t.p('</h3>');
}
velocityCount = 0;
return t.toString();
}
function v2js_attacklist(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.occs.length; i1++) {
var occ = context.occs[i1];
velocityCount = i1;
t.p('    <option value="');
t.p( occ.id);
t.p('">');
t.p( occ.name);
t.p('</option>');
}
velocityCount = 0;
t.p('.');
return t.toString();
}
function v2js_critterpane(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.pets.length; i1++) {
var pet = context.pets[i1];
velocityCount = i1;
t.p('<tr class="');
t.p( pet.css-class);
t.p('">    <td><a href="');
t.p('#" onclick="show_pet_owner(');
t.p( pet.id);
t.p(')">');
t.p( pet.name);
t.p('</a></td>    <td><img alt="" src="/game/i/hp-');
t.p( pet.hp);
t.p('.png"/></td>    <td><a id="pet');
t.p( pet.id);
t.p('" onclick="show_pet_target(');
t.p( pet.id);
t.p(')">>></a></td></tr>');
}
velocityCount = 0;
return t.toString();
}
function v2js_equipImprovised(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<form action="equip" method="post">    Select improvised weapon:    <select name="weaponid" id="equipment-list">    ');
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('        ');
if (!( i.equipped ) && i.type != "wearable" && i.type != "armor" && i.type != "weapon") {
t.p('            <option value="');
t.p( i.itemid);
t.p('"s>');
t.p( i.name);
t.p('</option>        ');
}
t.p('    ');
}
velocityCount = 0;
t.p('    </select>    <br/>    <input type="Submit"/></form>');
return t.toString();
}
function v2js_equiplist(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.type == "weapon") {
t.p('        ');
if (i.equipped) {
t.p('            <option value="');
t.p( i.itemid);
t.p('" selected="true">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>        ');
}
else {
t.p('            <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>        ');
}
t.p('    ');
}
}
velocityCount = 0;
t.p('.');
return t.toString();
}
function v2js_inventory(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.equipped) {
t.p('        <tr>            ');
if (i.type == "weapon" || i.type == "armor") {
t.p('                <td>');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</td>            ');
}
else {
t.p('                <td>');
t.p( i.name);
t.p('</td>            ');
}
t.p('            <td>1</td><td>');
t.p( i.wt);
t.p('</td><td>            <a href="unequip?weaponid=');
t.p( i.itemid);
t.p('" >Unequip</a>        </td></tr>    ');
}
}
velocityCount = 0;
var lastItem = -1;
var lastDisplayName = "Fred";
var count = 1;
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.equipped) {
t.p('    ');
}
else {
t.p('        ');
t.p('        ');
if (i.type == "weapon" || i.type == "armor") {
var displayName = ( ( ( ( ( i.name + " (" ) + i.condition ) + ") (" ) + i.ammoleft ) + ")" );
t.p('        ');
}
else {
var displayName = i.name;
t.p('        ');
}
t.p('        ');
t.p('        ');
if (lastItem == -1) {
lastItem = i;
lastDisplayName = displayName;
t.p('        ');
t.p('        ');
}
else {
if (lastDisplayName == displayName) {
count = ( count + 1 );
t.p('        ');
}
else {
var wt = ( lastItem.wt * count );
t.p('            <tr>                <td>');
t.p( lastDisplayName);
t.p('</td>                <td>');
t.p( count);
t.p('</td>                <td>');
t.p( wt);
t.p('</td><td>                ');
if (lastItem.type == "food") {
t.p('                    <a href="');
t.p('#" onclick="eat(');
t.p( lastItem.itemid);
t.p(')">Eat</a>                ');
}
else {
if (lastItem.type == "booze") {
t.p('                    <a href="');
t.p('#" onclick="drink(');
t.p( lastItem.itemid);
t.p(')">Drink</a>                ');
}
else {
if (lastItem.type == "weapon" || lastItem.type == "armor" || lastItem.type == "wearable") {
t.p('                    <a href="equip?weaponid=');
t.p( lastItem.itemid);
t.p('" >Equip</a>                ');
}
else {
if (lastItem.typeid == 49 && context.location.allowrecharage == "t") {
t.p('                    ');
t.p('                    <a href="');
t.p('#" onclick="recharge(');
t.p( lastItem.itemid);
t.p(')" >Recharge</a>                ');
}
}
}
}
t.p('            </td></tr>            ');
lastItem = i;
lastDisplayName = displayName;
count = 1;
t.p('        ');
}
}
t.p('    ');
}
}
velocityCount = 0;
var wt = ( lastItem.wt * count );
if (lastDisplayName != "Fred") {
t.p('    <tr>    <td>');
t.p( lastDisplayName);
t.p('</td>    <td>');
t.p( count);
t.p('</td>    <td>');
t.p( wt);
t.p('</td><td>    ');
if (lastItem.type == "food") {
t.p('    <a href="');
t.p('#" onclick="eat(');
t.p( lastItem.itemid);
t.p(')">Eat</a>    ');
}
else {
if (lastItem.type == "booze") {
t.p('    <a href="');
t.p('#" onclick="drink(');
t.p( lastItem.itemid);
t.p(')">Drink</a>    ');
}
else {
if (lastItem.type == "weapon" || lastItem.type == "armor" || lastItem.type == "wearable") {
t.p('    <a href="equip?weaponid=');
t.p( lastItem.itemid);
t.p('" >Equip</a>    ');
}
else {
if (lastItem.typeid == 49 && context.location.allowrecharage == "t") {
t.p('    ');
t.p('    <a href="');
t.p('#" onclick="recharge(');
t.p( lastItem.itemid);
t.p(')" >Recharge</a>    ');
}
}
}
}
t.p('    </td></tr>');
}
return t.toString();
}
function v2js_inventoryManagement(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<form>    <input type="hidden" id="src" value="');
t.p( context.stats.altid);
t.p('" />    <select id="dest">        <option value="-1">Drop</option>        <option value="');
t.p( context.location.locid);
t.p('">Place on Ground</option>        ');
if (context.occs) {
t.p('            ');
for (var i2=0;  i2<context.occs.length; i2++) {
var occ = context.occs[i2];
velocityCount = i2;
t.p('                <option value="');
t.p( occ.id);
t.p('">Give to ');
t.p( occ.name);
t.p('</option>            ');
}
velocityCount = i1;
t.p('        ');
}
t.p('        <option>Put in locker...</option>        <option>Put in faction safe</option>    </select>    <br/>    <select style="float:left;" name="itemid" id="inv-list" size="10" multiple="true">    ');
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('        ');
if (i.equipped) {
t.p('            <option value="');
t.p( i.itemid);
t.p('" disabled="true">');
t.p( i.name);
t.p(' (equipped)</option>        ');
}
else {
t.p('            ');
if (i.type == "weapon" || i.type == "armor") {
t.p('                <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>            ');
}
else {
t.p('                <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p('</option>            ');
}
t.p('        ');
}
t.p('    ');
}
velocityCount = 0;
t.p('    </select> * Ctrl+click (Command+click for Mac users) to select multiple items to operate on at once.</form>');
return t.toString();
}
function v2js_inventory_old(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.equipped) {
t.p('        <tr>            ');
if (i.type == "weapon" || i.type == "armor") {
t.p('                <td>');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</td>            ');
}
else {
t.p('                <td>');
t.p( i.name);
t.p('</td>            ');
}
t.p('            <td>');
t.p( i.wt);
t.p('</td><td>            <a href="unequip?weaponid=');
t.p( i.itemid);
t.p('" >Unequip</a>        </td></tr>    ');
}
}
velocityCount = 0;
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.equipped) {
t.p('    ');
}
else {
t.p('        <tr>            ');
if (i.type == "weapon" || i.type == "armor") {
t.p('                <td>');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</td>            ');
}
else {
t.p('                <td>');
t.p( i.name);
t.p('</td>            ');
}
t.p('            <td>');
t.p( i.wt);
t.p('</td><td>            ');
if (i.type == "food") {
t.p('                <a href="');
t.p('#" onclick="eat(');
t.p( i.itemid);
t.p(')">Eat</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a>            ');
}
else {
if (i.type == "booze") {
t.p('                <a href="');
t.p('#" onclick="drink(');
t.p( i.itemid);
t.p(')">Drink</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a>            ');
}
else {
if (i.type == "weapon" || i.type == "armor" || i.type == "wearable") {
t.p('                <a href="equip?weaponid=');
t.p( i.itemid);
t.p('" >Equip</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a>            ');
}
else {
if (i.typeid == 49 && context.location.allowrecharage == "t") {
t.p('                ');
t.p('                <a href="');
t.p('#" onclick="recharge(');
t.p( i.itemid);
t.p(')" >Recharge</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a>            ');
}
else {
t.p('                <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a></td>            ');
}
}
}
}
t.p('        </td></tr>    ');
}
}
velocityCount = 0;
return t.toString();
}
function v2js_itempane(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.ground.length; i1++) {
var item = context.ground[i1];
velocityCount = i1;
t.p('<tr>    <td>');
t.p( item.name);
t.p('</td>    <td><a href="');
t.p('#" onclick="doTransfer(');
t.p( item.itemid);
t.p(',');
t.p( context.location.locid);
t.p(',');
t.p( context.stats.altid);
t.p(')">Pick up</a> | <a href="');
t.p('#" onclick="alert(\'Not implemented yet\');">Shoot</a></td></tr>');
}
velocityCount = 0;
return t.toString();
}
function v2js_locationDescription(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
if (context.location.name) {
t.p('    <strong>You are located in ');
t.p( context.location.name);
t.p(', a ');
t.p( context.location.type);
t.p(' at (');
t.p( context.location.x);
t.p(', ');
t.p( context.location.y);
t.p(') on level ');
t.p( context.location.level);
t.p(' of ');
t.p( context.location.station);
t.p(' station</strong>');
}
else {
t.p('    <strong>You are located in a ');
t.p( context.location.type);
t.p(' at (');
t.p( context.location.x);
t.p(', ');
t.p( context.location.y);
t.p(') on level ');
t.p( context.location.level);
t.p(' of ');
t.p( context.location.station);
t.p(' station</strong>');
}
if (context.location.description) {
t.p('    <p>');
t.p( context.location.description);
t.p('</p>');
}
if (context.location.chalk) {
t.p('    <p>Someone has written <i>');
t.p( context.location.chalk);
t.p('</i> on the wall</p>');
}
else {
if (context.location.draw) {
t.p('    <p>Someone has drawn a picture of ');
t.p( context.location.draw);
t.p(' on the wall.</p>');
}
else {
if (context.location.scrawl) {
t.p('    <p>Someone has crudely scrawled a message here.  You can barely make out <i>');
t.p( context.location.scrawl);
t.p('</i>.</p>');
}
}
}
t.p('<p><input type="button" onclick="dosearch(1);" value="Search (1 AP)"/>  <input type="button" value="Search 5 times (5 AP)" onclick="dosearch(5);"/> <input type="button" onclick="chalkWall();" value="Write on wall (1 AP)"/></p>');
return t.toString();
}
function v2js_locationSummary(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('Located at (');
t.p( context.x);
t.p(', ');
t.p( context.y);
t.p(') on level ');
t.p( context.level);
t.p(' of ');
t.p( context.station);
t.p(' station<br/>Named ');
t.p( context.name);
t.p(', it is a ');
t.p( context.type);
t.p('<br/><br/><u>Characters here</u><ul>');
for (var i1=0;  i1<context.occs.length; i1++) {
var o = context.occs[i1];
velocityCount = i1;
t.p('    <li><a href="../viewCharacter.jsp?id=');
t.p( o.id);
t.p('">');
t.p( o.name);
t.p('</a> (L');
t.p( o.level);
t.p(')</li>');
}
velocityCount = 0;
t.p('</ul><u>Critters here</u><ul>');
for (var i1=0;  i1<context.pets.length; i1++) {
var p = context.pets[i1];
velocityCount = i1;
t.p('    ');
t.p('    <li><a href="viewCritter.jsp?id=');
t.p( p.id);
t.p('">');
t.p( p.name);
t.p('</a> (brood ');
t.p( p.brood);
t.p(')</li>');
}
velocityCount = 0;
t.p('</ul><form action="broadcastLocation">    <input type="hidden" name="locid" value="');
t.p( context.locid);
t.p('">    Send message to this location: <input type="text" name="msg" width="40" value=""/><input type="submit"/>    <br/>Note: message will show up as "etherial"</form>');
return t.toString();
}
function v2js_messages(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.msgs.length; i1++) {
var msg = context.msgs[i1];
velocityCount = i1;
t.p('    <li><span class="read-');
t.p( msg.read);
t.p('"><span class="msgtype');
t.p( msg.type);
t.p('">    ');
if (msg.reps > 1) {
t.p('        ( ');
t.p( msg.reps);
t.p(' times )    ');
}
t.p('    ');
t.p( msg.text);
t.p(' (');
t.p( msg.date);
t.p(')</span></span></li>');
}
velocityCount = 0;
return t.toString();
}
function v2js_occupants(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.occs.length; i1++) {
var occ = context.occs[i1];
velocityCount = i1;
t.p('<tr class="');
t.p( occ.css-class);
t.p('">    <td><a href="/game/viewCharacter.jsp?id=');
t.p( occ.id);
t.p('">');
t.p( occ.name);
t.p('</a></td>    <td>');
t.p( occ.level);
t.p('</td>    <td><img alt="" src="/game/i/hp-');
t.p( occ.hp);
t.p('.png"/></td>    <td><a id="occ');
t.p( occ.id);
t.p('" onclick="showtarget(');
t.p( occ.id);
t.p(')" href="');
t.p('#">>></a></td></tr>');
}
velocityCount = 0;
return t.toString();
}
function v2js_rechargeItem(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
var canRecharge = "f";
var needRecharge = "f";
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.name == "Energy pack") {
canRecharge = "t";
t.p('    ');
}
t.p('    ');
if (i.type == "weapon" || i.type == "armor") {
t.p('        ');
if (i.damagetype == "e" && i.ammoleft < i.capacity) {
needRecharge = "t";
t.p('        ');
}
t.p('    ');
}
t.p('    ');
if (i.type == "weapon" && i.damagetype == "e" && context.stats.firearms > 3 && i.ammoleft < ( i.capacity * 2 )) {
needRecharge = "t";
t.p('    ');
}
}
velocityCount = 0;
if (needRecharge == "t" && canRecharge == "t") {
t.p('    <form method="post" action="');
t.p('#" onsubmit="recharge(');
t.p('$(\'');
t.p('#recharge');
t.p('-itemid\').val()); return false">        <select id="recharge-itemid" name="itemid">            ');
for (var i2=0;  i2<context.inv.length; i2++) {
var i = context.inv[i2];
velocityCount = i2;
t.p('                ');
if (i.type == "weapon" && i.damagetype == "e" && context.stats.firearms > 3 && i.ammoleft < ( i.capacity * 2 ) && i.ammoleft > ( i.capacity - 1 )) {
t.p('                        <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>                ');
}
t.p('                ');
if (i.type == "armor" && i.damagetype == "e" && i.ammoleft < i.capacity) {
t.p('                        <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>                ');
}
t.p('                ');
if (i.type == "weapon" && i.damagetype == "e" && i.ammoleft < i.capacity) {
t.p('                        <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>                ');
}
t.p('            ');
}
velocityCount = i1;
t.p('        </select>        <input type="submit" value="Recharge"/>    </form>');
}
return t.toString();
}
function v2js_repairItem(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
var needRepair = "f";
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('    ');
if (i.type == "weapon" || i.type == "armor") {
t.p('        ');
if (i.condition != "To spec") {
needRepair = "t";
t.p('        ');
}
t.p('    ');
}
}
velocityCount = 0;
if (needRepair == "t") {
t.p('    <form method="post" action="');
t.p('#" onsubmit="repair(');
t.p('$(\'');
t.p('#repair');
t.p('-itemid\').val()); return false">        <select id="repair-itemid" name="itemid">            ');
for (var i2=0;  i2<context.inv.length; i2++) {
var i = context.inv[i2];
velocityCount = i2;
t.p('                 ');
if (i.type == "weapon" || i.type == "armor") {
t.p('                    ');
if (i.condition != "To spec") {
t.p('                        <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</option>                    ');
}
t.p('                ');
}
t.p('            ');
}
velocityCount = i1;
t.p('        </select>        <input type="submit" value="Repair"/>    </form>');
}
return t.toString();
}
function v2js_stats(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<span class="stat_counter hp">HP: ');
t.p( context.stats.hp);
t.p('</span><span class="stat_counter ip">IP: ');
t.p( context.stats.ip);
t.p('</span><span class="stat_counter ap">AP: ');
t.p( context.stats.ap);
t.p('</span><span class="stat_counter effects">');
t.p( context.stats.effects);
t.p('</span>');
return t.toString();
}
function v2js_stats2(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<b>Days alive</b>: ');
t.p( context.stats.daysalive);
t.p('<br/><b>Level</b>: ');
t.p( context.stats.level);
t.p('<br/><b>Unspent CP</b>: ');
t.p( context.stats.cp);
t.p('<br/><span class="stat_counter hp"><b>HP</b>: ');
t.p( context.stats.hp);
t.p('</span><br/><span class="stat_counter ip"><b>IP</b>: ');
t.p( context.stats.ip);
t.p('</span><br/><span class="stat_counter ap"><b>AP</b>: ');
t.p( context.stats.ap);
t.p('</span><br/><span class="stat_counter xp"><b>XP</b>: ');
t.p( context.stats.xp);
t.p('</span><br/><b>Shields/Armor</b>: ');
t.p( context.stats.shields);
t.p('/');
t.p( context.stats.armor);
return t.toString();
}
function v2js_throwItemList(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<form action="throw" method="post">    <input type="hidden" name="target" id="throw-target" value="" />    <select name="missile">        ');
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('            ');
if (!( i.equipped ) && i.size != "l") {
t.p('                <option value="');
t.p( i.itemid);
t.p('">');
t.p( i.name);
t.p('</option>            ');
}
t.p('        ');
}
velocityCount = 0;
t.p('    </select><br/><input type="Submit" value="Throw Item at Target"/></form>');
return t.toString();
}
