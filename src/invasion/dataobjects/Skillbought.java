package invasion.dataobjects;
// Generated Oct 18, 2009 2:11:39 AM by Hibernate Tools 3.2.4.GA



/**
 * Skillbought generated by hbm2java
 */
public class Skillbought  implements java.io.Serializable {


     private int skill;
     private Alt alt;

    public Skillbought() {
    }


    public int getSkill() {
        return this.skill;
    }

    public void setSkill(int skill) {
        this.skill = skill;
    }
    public Alt getCharacter() {
        return this.alt;
    }

    public void setCharacter(Alt alt) {
        this.alt = alt;
    }




}


