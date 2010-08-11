--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: jchoyt
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO jchoyt;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alt; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE alt (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    ap integer DEFAULT 50,
    apmax integer DEFAULT 50,
    ip integer DEFAULT 0,
    cp integer DEFAULT 0,
    hp integer DEFAULT 50,
    hpmax integer DEFAULT 50,
    location integer,
    speciality integer,
    username character varying(50),
    xp integer DEFAULT 0 NOT NULL,
    factionid integer,
    equippedweapon integer,
    station integer,
    level integer DEFAULT 1 NOT NULL,
    autoreload boolean DEFAULT true,
    ticksalive integer DEFAULT 1,
    lasthurtby integer,
    race integer DEFAULT 1
);


ALTER TABLE public.alt OWNER TO jchoyt;

--
-- Name: alt_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE alt_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.alt_id_seq OWNER TO jchoyt;

--
-- Name: alt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE alt_id_seq OWNED BY alt.id;


--
-- Name: badge; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE badge (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.badge OWNER TO jchoyt;

--
-- Name: badge_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE badge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.badge_id_seq OWNER TO jchoyt;

--
-- Name: badge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE badge_id_seq OWNED BY badge.id;


--
-- Name: badgeawarded; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE badgeawarded (
    charid integer NOT NULL,
    badgeid integer NOT NULL
);


ALTER TABLE public.badgeawarded OWNER TO jchoyt;

--
-- Name: faction; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE faction (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.faction OWNER TO jchoyt;

--
-- Name: faction_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE faction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.faction_id_seq OWNER TO jchoyt;

--
-- Name: faction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE faction_id_seq OWNED BY faction.id;


--
-- Name: item; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE item (
    itemid integer NOT NULL,
    typeid integer,
    locid integer,
    ammoleft integer,
    capacitymod integer,
    condition integer,
    equipped boolean DEFAULT false,
    hidden boolean DEFAULT false
);


ALTER TABLE public.item OWNER TO jchoyt;

--
-- Name: item_itemid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE item_itemid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.item_itemid_seq OWNER TO jchoyt;

--
-- Name: item_itemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE item_itemid_seq OWNED BY item.itemid;


--
-- Name: itemtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE itemtype (
    typeid integer NOT NULL,
    weight integer,
    name character varying(255),
    type character varying(50),
    accuracy integer DEFAULT 25,
    damage integer DEFAULT 1,
    capacity integer DEFAULT 1,
    consumable boolean DEFAULT true,
    damagetype character(1) DEFAULT 'e'::bpchar,
    usesammo boolean DEFAULT false,
    size text DEFAULT 'small'::text
);


ALTER TABLE public.itemtype OWNER TO jchoyt;

--
-- Name: itemtype_typeid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE itemtype_typeid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.itemtype_typeid_seq OWNER TO jchoyt;

--
-- Name: itemtype_typeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE itemtype_typeid_seq OWNED BY itemtype.typeid;


--
-- Name: location; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE location (
    id integer NOT NULL,
    typeid integer,
    station integer,
    level integer,
    x integer,
    y integer,
    name character varying(50),
    description text
);


ALTER TABLE public.location OWNER TO jchoyt;

--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE location_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.location_id_seq OWNER TO jchoyt;

--
-- Name: location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE location_id_seq OWNED BY location.id;


--
-- Name: locationtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE locationtype (
    typeid integer NOT NULL,
    name character varying(50),
    cssname character varying(12),
    searchrate double precision DEFAULT 0.2 NOT NULL
);


ALTER TABLE public.locationtype OWNER TO jchoyt;

--
-- Name: locationtype_typeid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE locationtype_typeid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.locationtype_typeid_seq OWNER TO jchoyt;

--
-- Name: locationtype_typeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE locationtype_typeid_seq OWNED BY locationtype.typeid;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE messages (
    messageid integer NOT NULL,
    messagedate timestamp without time zone DEFAULT now(),
    message text,
    read boolean DEFAULT false,
    type integer DEFAULT 0,
    altid integer
);


ALTER TABLE public.messages OWNER TO jchoyt;

--
-- Name: messages_messageid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE messages_messageid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.messages_messageid_seq OWNER TO jchoyt;

--
-- Name: messages_messageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE messages_messageid_seq OWNED BY messages.messageid;


--
-- Name: player; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE player (
    username character varying(50) NOT NULL,
    password character varying(100),
    emailaddress text,
    timezone integer DEFAULT 0,
    credits integer DEFAULT 0,
    maxslots integer DEFAULT 2,
    accesslevel integer DEFAULT 1
);


ALTER TABLE public.player OWNER TO jchoyt;

--
-- Name: playermessages; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE playermessages (
    charid integer NOT NULL,
    messageid integer NOT NULL
);


ALTER TABLE public.playermessages OWNER TO jchoyt;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE roles (
    rolename character varying(20) NOT NULL
);


ALTER TABLE public.roles OWNER TO jchoyt;

--
-- Name: searchodds; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE searchodds (
    locationtype integer,
    odds double precision,
    return integer
);


ALTER TABLE public.searchodds OWNER TO jchoyt;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE skill (
    id integer NOT NULL,
    name character varying(50),
    maxlevel integer
);


ALTER TABLE public.skill OWNER TO jchoyt;

--
-- Name: skill_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.skill_id_seq OWNER TO jchoyt;

--
-- Name: skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE skill_id_seq OWNED BY skill.id;


--
-- Name: skillbought; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE skillbought (
    charid integer NOT NULL,
    skillid integer NOT NULL
);


ALTER TABLE public.skillbought OWNER TO jchoyt;

--
-- Name: station; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE station (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.station OWNER TO jchoyt;

--
-- Name: station_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.station_id_seq OWNER TO jchoyt;

--
-- Name: station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE station_id_seq OWNED BY station.id;


--
-- Name: stats; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE stats (
    altid integer,
    statid integer,
    count integer
);


ALTER TABLE public.stats OWNER TO jchoyt;

--
-- Name: statstype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE statstype (
    statid integer NOT NULL,
    statname text
);


ALTER TABLE public.statstype OWNER TO jchoyt;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE user_roles (
    username character varying(20) NOT NULL,
    rolename character varying(20) NOT NULL
);


ALTER TABLE public.user_roles OWNER TO jchoyt;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE alt ALTER COLUMN id SET DEFAULT nextval('alt_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE badge ALTER COLUMN id SET DEFAULT nextval('badge_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE faction ALTER COLUMN id SET DEFAULT nextval('faction_id_seq'::regclass);


--
-- Name: itemid; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE item ALTER COLUMN itemid SET DEFAULT nextval('item_itemid_seq'::regclass);


--
-- Name: typeid; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE itemtype ALTER COLUMN typeid SET DEFAULT nextval('itemtype_typeid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE location ALTER COLUMN id SET DEFAULT nextval('location_id_seq'::regclass);


--
-- Name: typeid; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE locationtype ALTER COLUMN typeid SET DEFAULT nextval('locationtype_typeid_seq'::regclass);


--
-- Name: messageid; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE messages ALTER COLUMN messageid SET DEFAULT nextval('messages_messageid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE skill ALTER COLUMN id SET DEFAULT nextval('skill_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE station ALTER COLUMN id SET DEFAULT nextval('station_id_seq'::regclass);


--
-- Name: alt_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_pkey PRIMARY KEY (id);


--
-- Name: badge_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY badge
    ADD CONSTRAINT badge_pkey PRIMARY KEY (id);


--
-- Name: badgeawarded_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY badgeawarded
    ADD CONSTRAINT badgeawarded_pkey PRIMARY KEY (charid, badgeid);


--
-- Name: faction_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY faction
    ADD CONSTRAINT faction_pkey PRIMARY KEY (id);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (itemid);


--
-- Name: itemtype_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY itemtype
    ADD CONSTRAINT itemtype_pkey PRIMARY KEY (typeid);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: locationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY locationtype
    ADD CONSTRAINT locationtype_pkey PRIMARY KEY (typeid);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (messageid);


--
-- Name: pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY station
    ADD CONSTRAINT pkey PRIMARY KEY (id);


--
-- Name: player_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_pkey PRIMARY KEY (username);


--
-- Name: playermessages_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY playermessages
    ADD CONSTRAINT playermessages_pkey PRIMARY KEY (charid, messageid);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (rolename);


--
-- Name: skill_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (id);


--
-- Name: skillbought_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY skillbought
    ADD CONSTRAINT skillbought_pkey PRIMARY KEY (charid, skillid);


--
-- Name: stype_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY statstype
    ADD CONSTRAINT stype_pkey PRIMARY KEY (statid);


--
-- Name: user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (username, rolename);


--
-- Name: loc; Type: INDEX; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE INDEX loc ON alt USING btree (location);


--
-- Name: locxy; Type: INDEX; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE INDEX locxy ON location USING btree (x, y);


--
-- Name: stat_altid; Type: INDEX; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE INDEX stat_altid ON stats USING btree (altid);


--
-- Name: who; Type: INDEX; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE INDEX who ON messages USING btree (altid);


--
-- Name: enable_player; Type: RULE; Schema: public; Owner: jchoyt
--

CREATE RULE enable_player AS ON INSERT TO player DO INSERT INTO user_roles (username, rolename) VALUES (new.username, 'Player'::character varying);


--
-- Name: alt_equip_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_equip_fkey FOREIGN KEY (equippedweapon) REFERENCES item(itemid);


--
-- Name: alt_factionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_factionid_fkey FOREIGN KEY (factionid) REFERENCES faction(id);


--
-- Name: alt_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_player_fkey FOREIGN KEY (username) REFERENCES player(username);


--
-- Name: badgeawarded_badgeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY badgeawarded
    ADD CONSTRAINT badgeawarded_badgeid_fkey FOREIGN KEY (badgeid) REFERENCES badge(id);


--
-- Name: badgeawarded_charid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY badgeawarded
    ADD CONSTRAINT badgeawarded_charid_fkey FOREIGN KEY (charid) REFERENCES alt(id);


--
-- Name: hurt_ref; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT hurt_ref FOREIGN KEY (lasthurtby) REFERENCES alt(id);


--
-- Name: item_typeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_typeid_fkey FOREIGN KEY (typeid) REFERENCES itemtype(typeid);


--
-- Name: location_typeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_typeid_fkey FOREIGN KEY (typeid) REFERENCES locationtype(typeid);


--
-- Name: messages_alt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_alt_fkey FOREIGN KEY (altid) REFERENCES alt(id);


--
-- Name: playermessages_charid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY playermessages
    ADD CONSTRAINT playermessages_charid_fkey FOREIGN KEY (charid) REFERENCES alt(id);


--
-- Name: playermessages_messageid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY playermessages
    ADD CONSTRAINT playermessages_messageid_fkey FOREIGN KEY (messageid) REFERENCES messages(messageid);


--
-- Name: skillbought_charid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY skillbought
    ADD CONSTRAINT skillbought_charid_fkey FOREIGN KEY (charid) REFERENCES alt(id);


--
-- Name: skillbought_skillid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY skillbought
    ADD CONSTRAINT skillbought_skillid_fkey FOREIGN KEY (skillid) REFERENCES skill(id);


--
-- Name: stat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT stat_fkey FOREIGN KEY (station) REFERENCES station(id);


--
-- Name: stat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY location
    ADD CONSTRAINT stat_fkey FOREIGN KEY (station) REFERENCES station(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

