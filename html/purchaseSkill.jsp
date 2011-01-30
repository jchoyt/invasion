<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*, invasion.dataobjects.*, invasion.util.*, java.sql.*,javax.sql.*" %>

<%
    String altid = WebUtils.getRequiredParameter( request, "altid" );
    String skillid_string = WebUtils.getRequiredParameter( request, "skillid" );
    int skillid = Integer.parseInt( skillid_string );
    Skill s = Skills.getById( skillid );
    InvasionConnection conn = null;
    try
    {
        conn = new InvasionConnection();
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
        int cp = 0;
        boolean hascp = false, prereq = false;
        boolean okToContinue = false;
        ResultSet rs = conn.psExecuteQuery( query, "error", Integer.parseInt( altid ), skillid );
        if( rs.next() )
        {
            hascp = rs.getBoolean("hascp");
            prereq = rs.getBoolean("prereq");
            okToContinue = hascp && prereq;
            cp = rs.getInt("cp");
            name = rs.getString("name");
        }
        else
        {
            out.write("You already have that skill.");
        }
        StringBuilder ret = new StringBuilder(  );
        if( !hascp )
            ret.append( "You do not have enough CP to purchase " + name + ".  You need " + (s.getCost() -cp) + " more CP.<br/>" );
        if( !prereq )
            ret.append( "You have not purchased the required prerequisite skill for " + name + "." );
        if( !okToContinue )
        {
            out.write(ret.toString());
        }
        else
        {
            %>
                <form action="purchaseSkillProcess.jsp" method="post">
                    <input type="hidden" name="altid" value="<%=altid%>" />
                    <input type="hidden" name="skillid" value="<%=skillid%>" />
                    Purchasing <%=name%> will cost <%=s.getCost()%> CP.  Are you sure?
                    <br/>
                    <input type="Submit" value="Purchase Skill"/>
                </form>

            <%
        }
    }
    catch(Exception e)
    { e.printStackTrace();}
    finally
    {
        DatabaseUtility.close( rs );
        conn.close();
    }

%>
