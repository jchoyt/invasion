--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: cleareffectsondeath(); Type: FUNCTION; Schema: public; Owner: jchoyt
--

CREATE FUNCTION cleareffectsondeath() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.location=-57005 THEN
    DELETE FROM effects WHERE altid=NEW.id;
END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.cleareffectsondeath() OWNER TO jchoyt;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actionlog; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE actionlog (
    actor integer,
    action integer,
    subject integer,
    ts bigint NOT NULL
);


ALTER TABLE public.actionlog OWNER TO jchoyt;

--
-- Name: alt_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE alt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alt_id_seq OWNER TO jchoyt;

--
-- Name: alt; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE alt (
    id integer DEFAULT nextval('alt_id_seq'::regclass) NOT NULL,
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
    factionid integer DEFAULT (-1),
    station integer,
    level integer DEFAULT 1 NOT NULL,
    autoreload boolean DEFAULT true,
    ticksalive integer DEFAULT 1,
    lasthurtby integer,
    race integer DEFAULT 1,
    humanskill bigint DEFAULT 0,
    tohuskill bigint DEFAULT 0,
    tikkunskill bigint DEFAULT 0,
    gender character(1) DEFAULT 'f'::bpchar,
    equippedarmor integer,
    equippedshield integer,
    factionrank integer DEFAULT (-1),
    createdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.alt OWNER TO jchoyt;

--
-- Name: badge_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE badge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.badge_id_seq OWNER TO jchoyt;

--
-- Name: badge; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE badge (
    id integer DEFAULT nextval('badge_id_seq'::regclass) NOT NULL,
    name character varying(255)
);


ALTER TABLE public.badge OWNER TO jchoyt;

--
-- Name: badgeawarded; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE badgeawarded (
    charid integer NOT NULL,
    badgeid integer NOT NULL
);


ALTER TABLE public.badgeawarded OWNER TO jchoyt;

--
-- Name: brood_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE brood_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brood_id_seq OWNER TO jchoyt;

--
-- Name: brood; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE brood (
    id integer DEFAULT nextval('brood_id_seq'::regclass) NOT NULL,
    owner integer DEFAULT (-1),
    goal_survive integer,
    goal_protect integer,
    goal_killpsi integer,
    goal_killmut integer,
    goal_killhuman integer,
    location integer DEFAULT (-1),
    type integer
);


ALTER TABLE public.brood OWNER TO jchoyt;

--
-- Name: critters_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE critters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.critters_id_seq OWNER TO jchoyt;

--
-- Name: critters; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE critters (
    id integer DEFAULT nextval('critters_id_seq'::regclass) NOT NULL,
    ap integer,
    hp integer,
    description text,
    lasthurtby integer,
    typeid integer,
    name text,
    armor integer DEFAULT 50,
    shield integer DEFAULT 0,
    brood integer
);


ALTER TABLE public.critters OWNER TO jchoyt;

--
-- Name: crittertype_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE crittertype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crittertype_id_seq OWNER TO jchoyt;

--
-- Name: crittertype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE crittertype (
    id integer DEFAULT nextval('crittertype_id_seq'::regclass) NOT NULL,
    name text,
    class text,
    apmax integer DEFAULT 60,
    hpmax integer DEFAULT 40,
    armormax integer DEFAULT 50,
    shieldmax integer DEFAULT 0,
    cost integer DEFAULT 20,
    maintenancecost integer DEFAULT 10
);


ALTER TABLE public.crittertype OWNER TO jchoyt;

--
-- Name: effects; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE effects (
    altid integer,
    effectid integer,
    duration integer
);


ALTER TABLE public.effects OWNER TO jchoyt;

--
-- Name: effecttype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE effecttype (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.effecttype OWNER TO jchoyt;

--
-- Name: effecttype_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE effecttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.effecttype_id_seq OWNER TO jchoyt;

--
-- Name: effecttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE effecttype_id_seq OWNED BY effecttype.id;


--
-- Name: faction_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE faction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faction_id_seq OWNER TO jchoyt;

--
-- Name: factioninvites; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE factioninvites (
    inviter integer,
    invitee integer,
    faction integer,
    message text,
    issued timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.factioninvites OWNER TO jchoyt;

--
-- Name: factions; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE factions (
    id integer DEFAULT nextval('faction_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    shloc integer DEFAULT (-1),
    level integer DEFAULT 0,
    type integer DEFAULT 1,
    prestige integer DEFAULT 0,
    ammenities bigint DEFAULT 0,
    open boolean DEFAULT true,
    station integer NOT NULL,
    cansetsh bigint DEFAULT 0,
    description text,
    createdby integer,
    createdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.factions OWNER TO jchoyt;

--
-- Name: flagscaptured; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE flagscaptured (
    holder integer,
    owner integer
);


ALTER TABLE public.flagscaptured OWNER TO jchoyt;

--
-- Name: item_itemid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE item_itemid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_itemid_seq OWNER TO jchoyt;

--
-- Name: item; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE item (
    itemid integer DEFAULT nextval('item_itemid_seq'::regclass) NOT NULL,
    typeid integer,
    locid integer,
    ammoleft integer,
    condition integer,
    equipped boolean DEFAULT false,
    hidden boolean DEFAULT false
);


ALTER TABLE public.item OWNER TO jchoyt;

--
-- Name: itemmod; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE itemmod (
    id integer NOT NULL,
    itemid integer,
    type integer
);


ALTER TABLE public.itemmod OWNER TO jchoyt;

--
-- Name: itemmod_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE itemmod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemmod_id_seq OWNER TO jchoyt;

--
-- Name: itemmod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE itemmod_id_seq OWNED BY itemmod.id;


--
-- Name: itemtype_typeid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE itemtype_typeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemtype_typeid_seq OWNER TO jchoyt;

--
-- Name: itemtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE itemtype (
    typeid integer DEFAULT nextval('itemtype_typeid_seq'::regclass) NOT NULL,
    weight integer,
    name character varying(255),
    type character varying(50),
    accuracy integer DEFAULT 25,
    damage character varying(10) DEFAULT 1,
    capacity integer DEFAULT 1,
    consumable boolean DEFAULT true,
    damagetype character(1) DEFAULT 'e'::bpchar,
    usesammo boolean DEFAULT false,
    size character(1) DEFAULT 'small'::text
);


ALTER TABLE public.itemtype OWNER TO jchoyt;

--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_id_seq OWNER TO jchoyt;

--
-- Name: location; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE location (
    id integer DEFAULT nextval('location_id_seq'::regclass) NOT NULL,
    typeid integer,
    station integer,
    level integer,
    x integer,
    y integer,
    name character varying(50),
    description text,
    message text,
    messagetype character varying(15) DEFAULT NULL::character varying,
    hackamount integer DEFAULT 0,
    hackedby integer DEFAULT 0
);


ALTER TABLE public.location OWNER TO jchoyt;

--
-- Name: locationdescriptions; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE locationdescriptions (
    typeid integer,
    description text,
    id integer NOT NULL
);


ALTER TABLE public.locationdescriptions OWNER TO jchoyt;

--
-- Name: locationdescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE locationdescriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locationdescriptions_id_seq OWNER TO jchoyt;

--
-- Name: locationdescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE locationdescriptions_id_seq OWNED BY locationdescriptions.id;


--
-- Name: locationtype_typeid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE locationtype_typeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locationtype_typeid_seq OWNER TO jchoyt;

--
-- Name: locationtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE locationtype (
    typeid integer DEFAULT nextval('locationtype_typeid_seq'::regclass) NOT NULL,
    name character varying(50),
    cssname character varying(12),
    searchrate double precision DEFAULT 0.2 NOT NULL
);


ALTER TABLE public.locationtype OWNER TO jchoyt;

--
-- Name: locker; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE locker (
    id integer NOT NULL,
    location integer,
    number integer,
    combination character varying(10),
    owner integer,
    lastused timestamp without time zone DEFAULT now() NOT NULL,
    open boolean DEFAULT true NOT NULL
);


ALTER TABLE public.locker OWNER TO jchoyt;

--
-- Name: locker_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE locker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locker_id_seq OWNER TO jchoyt;

--
-- Name: locker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE locker_id_seq OWNED BY locker.id;


--
-- Name: messages_messageid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE messages_messageid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_messageid_seq OWNER TO jchoyt;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE messages (
    messageid integer DEFAULT nextval('messages_messageid_seq'::regclass) NOT NULL,
    messagedate timestamp without time zone DEFAULT now(),
    message text DEFAULT ''::text NOT NULL,
    read boolean DEFAULT false,
    type integer DEFAULT 0,
    altid integer
);


ALTER TABLE public.messages OWNER TO jchoyt;

--
-- Name: modtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE modtype (
    id integer NOT NULL,
    effect text,
    amount double precision,
    type character(1),
    fault boolean DEFAULT false
);


ALTER TABLE public.modtype OWNER TO jchoyt;

--
-- Name: modtype_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE modtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modtype_id_seq OWNER TO jchoyt;

--
-- Name: modtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE modtype_id_seq OWNED BY modtype.id;


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
-- Name: politics; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE politics (
    setter integer,
    target integer,
    setting integer
);


ALTER TABLE public.politics OWNER TO jchoyt;

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
    odds integer,
    return integer,
    id integer NOT NULL
);


ALTER TABLE public.searchodds OWNER TO jchoyt;

--
-- Name: searchodds_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE searchodds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.searchodds_id_seq OWNER TO jchoyt;

--
-- Name: searchodds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE searchodds_id_seq OWNED BY searchodds.id;


--
-- Name: skill_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skill_id_seq OWNER TO jchoyt;

--
-- Name: skills; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE skills (
    id integer NOT NULL,
    name character varying(50),
    value bigint,
    race text,
    prerequisite integer,
    cost integer DEFAULT 10,
    helplink text
);


ALTER TABLE public.skills OWNER TO jchoyt;

--
-- Name: skill_id_seq1; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE skill_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skill_id_seq1 OWNER TO jchoyt;

--
-- Name: skill_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: jchoyt
--

ALTER SEQUENCE skill_id_seq1 OWNED BY skills.id;


--
-- Name: station_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.station_id_seq OWNER TO jchoyt;

--
-- Name: station; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE station (
    id integer DEFAULT nextval('station_id_seq'::regclass) NOT NULL,
    name text,
    owner character varying(50)
);


ALTER TABLE public.station OWNER TO jchoyt;

--
-- Name: stats; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE stats (
    altid integer,
    statid integer,
    count integer DEFAULT 0 NOT NULL
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

ALTER TABLE ONLY effecttype ALTER COLUMN id SET DEFAULT nextval('effecttype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY itemmod ALTER COLUMN id SET DEFAULT nextval('itemmod_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY locationdescriptions ALTER COLUMN id SET DEFAULT nextval('locationdescriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY locker ALTER COLUMN id SET DEFAULT nextval('locker_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY modtype ALTER COLUMN id SET DEFAULT nextval('modtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY searchodds ALTER COLUMN id SET DEFAULT nextval('searchodds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY skills ALTER COLUMN id SET DEFAULT nextval('skill_id_seq1'::regclass);


--
-- Name: actionlog_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY actionlog
    ADD CONSTRAINT actionlog_pkey PRIMARY KEY (ts);


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
-- Name: brood_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY brood
    ADD CONSTRAINT brood_pkey PRIMARY KEY (id);


--
-- Name: critters_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY critters
    ADD CONSTRAINT critters_pkey PRIMARY KEY (id);


--
-- Name: crittertype_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY crittertype
    ADD CONSTRAINT crittertype_pkey PRIMARY KEY (id);


--
-- Name: effecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY effecttype
    ADD CONSTRAINT effecttype_pkey PRIMARY KEY (id);


--
-- Name: faction_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY factions
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
-- Name: modtype_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY modtype
    ADD CONSTRAINT modtype_pkey PRIMARY KEY (id);


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
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (rolename);


--
-- Name: skill_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY skills
    ADD CONSTRAINT skill_pkey PRIMARY KEY (id);


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
-- Name: pkey_effects; Type: INDEX; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE INDEX pkey_effects ON effects USING btree (altid);


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

CREATE RULE enable_player AS
    ON INSERT TO player DO  INSERT INTO user_roles (username, rolename)
  VALUES (new.username, 'Player'::character varying);


--
-- Name: cleareffectsondeath; Type: TRIGGER; Schema: public; Owner: jchoyt
--

CREATE TRIGGER cleareffectsondeath AFTER UPDATE ON alt FOR EACH ROW EXECUTE PROCEDURE cleareffectsondeath();


--
-- Name: alt_factionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_factionid_fkey FOREIGN KEY (factionid) REFERENCES factions(id);


--
-- Name: alt_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_player_fkey FOREIGN KEY (username) REFERENCES player(username);


--
-- Name: altid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY effects
    ADD CONSTRAINT altid_fkey FOREIGN KEY (altid) REFERENCES alt(id);


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
-- Name: captured_holder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY flagscaptured
    ADD CONSTRAINT captured_holder_fkey FOREIGN KEY (holder) REFERENCES factions(id);


--
-- Name: captured_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY flagscaptured
    ADD CONSTRAINT captured_owner_fkey FOREIGN KEY (owner) REFERENCES factions(id);


--
-- Name: critters_typeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY critters
    ADD CONSTRAINT critters_typeid_fkey FOREIGN KEY (typeid) REFERENCES crittertype(id);


--
-- Name: effectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY effects
    ADD CONSTRAINT effectid_fkey FOREIGN KEY (effectid) REFERENCES effecttype(id);


--
-- Name: factions_shloc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY factions
    ADD CONSTRAINT factions_shloc_fkey FOREIGN KEY (shloc) REFERENCES location(id);


--
-- Name: hurt_ref; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT hurt_ref FOREIGN KEY (lasthurtby) REFERENCES alt(id);


--
-- Name: invites_faction_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY factioninvites
    ADD CONSTRAINT invites_faction_fkey FOREIGN KEY (faction) REFERENCES factions(id);


--
-- Name: invites_invitee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY factioninvites
    ADD CONSTRAINT invites_invitee_fkey FOREIGN KEY (invitee) REFERENCES alt(id);


--
-- Name: invites_inviter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY factioninvites
    ADD CONSTRAINT invites_inviter_fkey FOREIGN KEY (inviter) REFERENCES alt(id);


--
-- Name: item_typeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_typeid_fkey FOREIGN KEY (typeid) REFERENCES itemtype(typeid);


--
-- Name: itemmod_itemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY itemmod
    ADD CONSTRAINT itemmod_itemid_fkey FOREIGN KEY (itemid) REFERENCES item(itemid) ON DELETE CASCADE;


--
-- Name: itemmod_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY itemmod
    ADD CONSTRAINT itemmod_type_fkey FOREIGN KEY (type) REFERENCES modtype(id);


--
-- Name: loc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY brood
    ADD CONSTRAINT loc_fkey FOREIGN KEY (location) REFERENCES location(id);


--
-- Name: location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT location_fkey FOREIGN KEY (location) REFERENCES location(id);


--
-- Name: location_typeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_typeid_fkey FOREIGN KEY (typeid) REFERENCES locationtype(typeid);


--
-- Name: locker_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY locker
    ADD CONSTRAINT locker_location_fkey FOREIGN KEY (location) REFERENCES location(id);


--
-- Name: locker_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY locker
    ADD CONSTRAINT locker_owner_fkey FOREIGN KEY (owner) REFERENCES alt(id);


--
-- Name: messages_alt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_alt_fkey FOREIGN KEY (altid) REFERENCES alt(id);


--
-- Name: owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY brood
    ADD CONSTRAINT owner_fkey FOREIGN KEY (owner) REFERENCES alt(id);


--
-- Name: owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY station
    ADD CONSTRAINT owner_fkey FOREIGN KEY (owner) REFERENCES player(username);


--
-- Name: politics_setter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY politics
    ADD CONSTRAINT politics_setter_fkey FOREIGN KEY (setter) REFERENCES factions(id);


--
-- Name: politics_target_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY politics
    ADD CONSTRAINT politics_target_fkey FOREIGN KEY (target) REFERENCES factions(id);


--
-- Name: skill_prerequisite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY skills
    ADD CONSTRAINT skill_prerequisite_fkey FOREIGN KEY (prerequisite) REFERENCES skills(id);


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
-- Name: actionlog; Type: ACL; Schema: public; Owner: jchoyt
--

REVOKE ALL ON TABLE actionlog FROM PUBLIC;
REVOKE ALL ON TABLE actionlog FROM jchoyt;
GRANT ALL ON TABLE actionlog TO jchoyt;


--
-- PostgreSQL database dump complete
--

