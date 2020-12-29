/*
 *  Copyright 2010 Jeffrey Hoyt.  All rights reserved.
 */
package invasion.dataobjects;
// Generated Oct 20, 2009 4:47:37 PM by Hibernate Tools 3.2.4.GA


import java.util.HashSet;
import java.util.Set;

/**
 * Badge generated by hbm2java
 */
public class Badge  implements java.io.Serializable {


     private int id;
     private String name;
     private Set<Alt> alts = new HashSet<Alt>(0);

    public Badge() {
    }


    public Badge(int id) {
        this.id = id;
    }
    public Badge(int id, String name, Set<Alt> alts) {
       this.id = id;
       this.name = name;
       this.alts = alts;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public Set<Alt> getAlts() {
        return this.alts;
    }

    public void setAlts(Set<Alt> alts) {
        this.alts = alts;
    }




}


