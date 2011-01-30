<%@ page import="invasion.util.*,java.sql.*" %><%@
    taglib prefix="tags" tagdir="/WEB-INF/tags" %><%
    String searchString = WebUtils.getOptionalParameter(request, "searchString", "");
%>
<html>
    <head>
        <link type="text/css" href="${css}/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${css}/main.css" rel="stylesheet" />
        <link type="text/css" href="${css}/jquery.cluetip.css" rel="stylesheet" />
        <script type="text/javascript" src="${js}/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="${js}/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript" src="${js}/jquery.cluetip.js"></script>
        <title>Admin Item List</title>
    </head>
    <body>
        <jsp:include page="navigation.jsp"/>
        <center>
            <% String query = "select name , type , weight, size, accuracy , damage , capacity , consumable, damagetype, usesammo, typeid || ',' || name || ',' ||  type || ',' || weight  || ',' || size || ',' || accuracy || ',' || damage || ',' || capacity || ',' || consumable|| ',' || damagetype|| ',' || usesammo  as EditString from itemtype";
                InvasionConnection conn = null;
                try
                {
                    conn = new InvasionConnection();
                    ResultSet rs = conn.executeQuery( query );
                    DatabaseUtility.genericTable(rs, out);
                    rs.close();
            %>
            <hr/>
            <div class="descbox" style="width:400px;">
                <form action="itemEdit.jsp">
                <h3>Edit Item</h3>
                    Modified editstring<sup>1</sup>: <input type="text" name="newvalues"/><br/>
                    (e.g., 37,Vodka,booze,1,s,15,1d3,1,true,p,false)<br/>
                    <input type="submit"/>
                </form>
            </div>
            <br/>
            <div class="descbox" style="width:400px;">
                <form action="itemAdd.jsp">
                <h3>Add Item</h3>
                    New item values<sup>2</sup>: <input type="text" name="newvalues"/><br/>
                    (e.g., Spiced Rum,booze,1,s,15,1d3,1,true,p,false)<br/>
                    <input type="submit"/>
                </form>
            </div>
        </center>
        <div class="notes"><sup>1</sup> To edit an existing item, copy it's "editstring" from the table above into the text box provided, changing what you would like to change.  Remember this will take effect immediately across the every station.  Do <b>not</b> change the first field (itemid) or you will be editing a <i>different</i> item.  Please make a note what you changed and why.  Ideally this should be discussed with at least a couple other station masters before you change anything.<br/>
        <sup>2</sup> To create a new item, build an "editstring" similar to that found for items above <i>but without the itmeid field</i>.  The database will assign that when the item is added.  Below are definitions and things to remember:<ul>
            <li>name: Name of the item to be added</li>
            <li>type: Generic type if item.  Current types are  armor, weapon, tool, booze, ammo, and food.  You can add new categories, but don't be overly promiscious about it.   Too many is not a good thing.</li>
            <li>weight:  Similar to NW and bobwar weight.  Too many and you will be overencumbered.  50 seems to work well for those games so that'll be my starting position.  Since shields and armor will be so important later, that may be increased.</li>
            <li>size: Somewhat independent of weight.  Valid sizes are s, m, and l for small, medium, and large.  Please do not spell the words out.</li>
            <li>accuracy:  The accuracy when used as a weapon.  This is the base accuracy and will be great improvements from skills.  This has nothing to do with anything an item might do if a "Use" were to be pressed (e.g., drinking booze, healing, bullhorns, etc.).  Those effects will be handled in code. </li>
            <li>damage:  Similar to accuracy, the damage when used as a weapon.  Damage values are expressed as a random amout specified as if die were rolled and a flat value optionally added on.  3d3 would be 3 random rolls of a 3-sided die and would end up with values from 3 to 9 with a values between 5 and 7 (inclusive) being the much more likely than 3 or 9.  Note that a die roll of 1d7+2 would also result in a range of possible values between 3 and 9, however every number is equally likely.  If you don't understand why this is so, ask me and I'll give examples...it's critical you understand this.</li>
            <li>capacity: Mostly for guns - the maximum number of shots for the weapon.</li>
            <li>consumable: for small non-weapon objects, will they be lost when used as a weapon?  Also for delicate things like shields where jarring them may stop them from working.</li>
            <li>damagetype: 'e' for energy or 'p' for physical.  These are the only two damage types.  Shields block energy damage and armor blocks physical</li>
            <li>usesamm: is this a weapon that must be reloaded?  't' for true or 'f' for false</li>
            </ul>
        </div>
    </body>
<html><%
    }
    catch(Exception e)
    { e.printStackTrace();}
    finally
    { conn.close(); }
%>
