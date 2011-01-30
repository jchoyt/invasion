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
t.p('<tr>    <td><a href="/viewOwner.jsp?id=');
t.p( pet.id);
t.p('">');
t.p( pet.name);
t.p('</a></td>    <td><img alt="" src="/i/hp-');
t.p( pet.hp);
t.p('.png"/></td>    <td><a href="');
t.p('#" onclick="show_pet_target(');
t.p( pet.id);
t.p(')">>></a><span style="display:none" id="pet-desc-');
t.p( pet.id);
t.p('"><a href="');
t.p('#" onclick="attack_pet(');
t.p( pet.id);
t.p(')">Attack ');
t.p( pet.name);
t.p('</a></span></td></tr>');
}
velocityCount = 0;
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
t.p('<tr>    ');
if (i.type == "weapon" || i.type == "armor") {
t.p('        <td>');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</td>    ');
}
else {
t.p('        <td>');
t.p( i.name);
t.p('</td>    ');
}
t.p('    <td>');
t.p( i.wt);
t.p('</td>    ');
if (i.type == "food") {
t.p('    <td><a href="');
t.p('#" onclick="eat(');
t.p( i.itemid);
t.p(')">Eat</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a></td>    ');
}
else {
if (i.type == "booze") {
t.p('    <td><a href="');
t.p('#" onclick="drink(');
t.p( i.itemid);
t.p(')">Drink</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a></td>    ');
}
else {
if (i.type == "weapon") {
t.p('        ');
if (i.equipped) {
t.p('            <td><a href="unequip.jsp?weaponid=');
t.p( i.itemid);
t.p('" >Unequip</a></td>        ');
}
else {
t.p('            <td><a href="equip.jsp?weaponid=');
t.p( i.itemid);
t.p('" >Equip</a> | <a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a></td>        ');
}
t.p('    ');
}
else {
t.p('    <td><a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a></td>    ');
}
}
}
t.p('</tr>');
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
t.p('<p>');
t.p( context.location.description);
t.p('</p>');
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
for (var i1=0;  i1<context.chars.length; i1++) {
var o = context.chars[i1];
velocityCount = i1;
t.p('    <li>');
t.p( o.name);
t.p(' (L');
t.p( o.level);
t.p(')</li>');
}
velocityCount = 0;
t.p('</ul><u>Critters here</u><ul>');
for (var i1=0;  i1<context.critters.length; i1++) {
var o = context.critters[i1];
velocityCount = i1;
t.p('    <li>');
t.p( o.type);
t.p(' named ');
t.p( o.name);
t.p(' in brood ');
t.p( o.brood);
t.p(' (owned by ');
t.p( o.owner);
t.p(')');
}
velocityCount = 0;
t.p('</ul><form action="sendMessageLocation.jsp">    <input type="hidden" name="locid" value="');
t.p( context.locid);
t.p('">    Send message to this location: <input type="text" name="msg" width="40" value="This doesn\'t work yet"/><input type="submit"/></form>');
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
t.p(' ( ');
t.p( msg.date);
t.p(' )</span></span></li>');
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
t.p('<tr>    <td><a href="/viewCharacter.jsp?id=');
t.p( occ.id);
t.p('">');
t.p( occ.name);
t.p('</a></td>    <td>');
t.p( occ.level);
t.p('</td>    <td><img alt="" src="/i/hp-');
t.p( occ.hp);
t.p('.png"/></td>    <td><a href="');
t.p('#" onclick="showtarget(');
t.p( occ.id);
t.p(')">>></a><span style="display:none" id="desc-');
t.p( occ.id);
t.p('"><a href="');
t.p('#" onclick="attack(');
t.p( occ.id);
t.p(')">Attack ');
t.p( occ.name);
t.p('</a></span></td></tr>');
}
velocityCount = 0;
return t.toString();
}
function v2js_stats(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<span class="hp">HP: ');
t.p( context.stats.hp);
t.p('</span><span class="ip">IP: ');
t.p( context.stats.ip);
t.p('</span><span class="ap">AP: ');
t.p( context.stats.ap);
t.p('</span>');
return t.toString();
}
function v2js_stats2(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
var da = ( context.stats.ticksalive / 96 );
t.p('<b>Days alive</b>: ');
t.p( da);
t.p('<br/><b>Level</b>: ');
t.p( context.stats.level);
t.p('<br/><b>Unspent CP</b>: ');
t.p( context.stats.cp);
t.p(' <a href="/purchaseSkills.jsp">Purchase Skills</a><br/><span class="hp"><b>HP</b>: ');
t.p( context.stats.hp);
t.p('</span><br/><span class="ip"><b>IP</b>: ');
t.p( context.stats.ip);
t.p('</span><br/><span class="ap"><b>AP</b>: ');
t.p( context.stats.ap);
t.p('</span><br/><span class="xp"><b>XP</b>: ');
t.p( context.stats.xp);
t.p('</span>');
return t.toString();
}
