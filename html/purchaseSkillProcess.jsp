<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*,javax.sql.*" %>

<%
    String altid = WebUtils.getRequiredParameter( request, "altid" );
    String skillid_string = WebUtils.getRequiredParameter( request, "skillid" );
    int skillid = Integer.parseInt( skillid_string );
    Skill s = Skills.getById( skillid );
    InvasionConnection conn = new InvasionConnection();
    String column = "humanskill";
    if( s.getRace().equals( Skill.PSI ) )
        column = "psiskill";
    else if( s.getRace().equals( Skill.MUTATE ) )
        column = "mutateskill";
    String query = "select s.name, a.cp, s.cost <= a.cp as hascp, " +  //boolean - do you have enough CP to buy this?
        "(t.value & a."+ column + " > 0 or s.prerequisite is null ) " +  //boolean do you have the prerequisite skill?
        "as prereq from alt a join skills s on (a."+ column + " & s.value = 0 ) " + //ensures you don't already have it
        "left outer join skills t on s.prerequisite=t.id where a.id=? and s.id=? order by s.name;";

    String name=null;
    boolean hascp = false, prereq = false;
    boolean okToContinue = false;
    ResultSet rs = conn.psExecuteQuery( query, "error", Integer.parseInt( altid ), skillid );
    if( rs.next() )
    {
        hascp = rs.getBoolean("hascp");
        prereq = rs.getBoolean("prereq");
        okToContinue = hascp && prereq;
    }
    DatabaseUtility.close( rs );
    if( !okToContinue )
    {
        conn.close();
        response.sendRedirect("naughty.jsp");
    }
    else
    {
        query = "update alt set " + column + " = " + column + " | ? where id=?";
        conn.psExecuteUpdate( query, "error", s.getValue(), Integer.parseInt( altid ) );
        query = "update alt set cp = cp - ? where id = ?";
        conn.psExecuteUpdate( query, "error", s.getCost(), Integer.parseInt( altid ) );
        conn.close();
        response.sendRedirect("/map/index.jsp");
    }
%>
