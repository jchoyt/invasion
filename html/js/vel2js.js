function v2js_inventory(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.inv.length; i1++) {
var i = context.inv[i1];
velocityCount = i1;
t.p('<tr>    ');
if (i.type == "weapon" || i.type == "armor") {
t.p('    <td>');
t.p( i.name);
t.p(' (');
t.p( i.condition);
t.p(') (');
t.p( i.ammoleft);
t.p(')</td>    ');
}
else {
t.p('    <td>');
t.p( i.name);
t.p('</td>    ');
}
t.p('    ');
t.p('    <td>1</td>    ');
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
t.p('    <td><a href="');
t.p('#" onclick="drop(');
t.p( i.itemid);
t.p(');">Drop</a></td>    ');
}
}
t.p('</tr>');
}
velocityCount = 0;
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
t.p('"><span class="');
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
t.p('#" onmouseover="" onmouseout="">>></a></td></tr>');
}
velocityCount = 0;
return t.toString();
}
