<div class="cssfly">
    <ul>
        <li><a href="#">Menu</a>
            <ul>
                <li><a href="${base}index.jsp">Character List</a></li>
                <li><a href="${base}map/index.jsp">Game Map</a></li>
                <li><a href="${base}factions.jsp">Faction List</a></li>
                <li><a href="#" onclick="alert('No uber map yet');">Uber Map</a></li>
                <li><a href="http://soulcubes.com/PlayerGuide.html" target="_blank">Documentation</a></li>
                <li><a href="http://soulcubes.com/boards" target="_blank" >Forums</a></li>
                <li><a href="http://soulcubes.com/issues" target="_blank" >Report an Issue</a></li>
                <%
                    if( request.isUserInRole("Admin") )
                    {
                      %><li><a href="${base}admin">Admin area</a></li><%
                    }
                %>
                <li><a href="${base}logout">Log out</a></li>
            </ul>
        </li> <!-- end "Home" list item -->
    </ul>
</div>

