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
    lasthurtby integer
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
-- Name: alt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('alt_id_seq', 13, true);


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
-- Name: badge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('badge_id_seq', 1, false);


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
-- Name: faction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('faction_id_seq', 1, false);


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
-- Name: item_itemid_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('item_itemid_seq', 713, true);


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
    damagetype character(1) DEFAULT 'e'::bpchar
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
-- Name: itemtype_typeid_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('itemtype_typeid_seq', 50, true);


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
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('location_id_seq', 1031211, true);


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
-- Name: locationtype_typeid_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('locationtype_typeid_seq', 53, true);


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
-- Name: messages_messageid_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('messages_messageid_seq', 3592, true);


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
-- Name: skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('skill_id_seq', 1, false);


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
-- Name: station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jchoyt
--

SELECT pg_catalog.setval('station_id_seq', 1, false);


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
-- Data for Name: alt; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY alt (id, name, ap, apmax, ip, cp, hp, hpmax, location, speciality, username, xp, factionid, equippedweapon, station, level, autoreload, ticksalive, lasthurtby) FROM stdin;
8	Test	50	50	0	0	0	50	1006434	4	Purveyor	0	\N	\N	0	1	t	0	\N
13	asdf2	-500	50	0	0	50	50	1002293	1	Purveyor	0	\N	\N	\N	1	t	173	\N
2	A lonely kitten	-392	50	0	0	0	50	1002269	0	Purveyor	0	\N	\N	0	1	t	173	\N
1	Uncle Purvy	158	50	0	100	100	50	1002269	2	Purveyor	1337	\N	10	0	1	t	173	\N
9	Test2	50	50	0	0	50	50	1002269	0	Purveyor	0	\N	465	\N	1	t	173	\N
10	Test3	50	50	0	0	50	50	1002269	4	Purveyor	0	\N	339	\N	1	t	173	\N
12	asdf	50	50	0	0	50	50	1002269	2	Purveyor	0	\N	711	\N	1	t	173	\N
\.


--
-- Data for Name: badge; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY badge (id, name) FROM stdin;
\.


--
-- Data for Name: badgeawarded; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY badgeawarded (charid, badgeid) FROM stdin;
\.


--
-- Data for Name: faction; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY faction (id, name) FROM stdin;
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY item (itemid, typeid, locid, ammoleft, capacitymod, condition, equipped, hidden) FROM stdin;
339	27	10	5	0	4	f	f
10	26	0	0	0	3	f	f
11	28	0	0	0	2	f	f
12	28	0	1	0	0	f	f
13	28	0	4	0	0	f	f
14	28	0	6	0	2	f	f
15	28	0	2	0	2	f	f
16	28	0	8	0	4	f	f
17	26	0	1	0	4	f	f
18	26	0	4	0	1	f	f
19	28	0	9	0	1	f	f
20	28	0	5	0	2	f	f
21	28	0	4	0	2	f	f
22	28	0	3	0	3	f	f
23	28	0	4	0	1	f	f
24	28	0	2	0	0	f	f
25	26	0	0	0	2	f	f
26	26	0	9	0	4	f	f
27	28	0	9	0	2	f	f
28	28	0	2	0	0	f	f
29	28	0	7	0	0	f	f
30	28	0	3	0	2	f	f
31	28	0	8	0	3	f	f
32	28	0	7	0	1	f	f
33	26	0	8	0	3	f	f
34	26	0	0	0	3	f	f
35	28	0	6	0	3	f	f
36	28	0	6	0	2	f	f
37	28	0	8	0	3	f	f
38	28	0	4	0	0	f	f
39	28	0	0	0	4	f	f
40	28	0	7	0	1	f	f
41	26	0	1	0	3	f	f
42	26	0	8	0	3	f	f
43	28	0	2	0	2	f	f
44	28	0	5	0	3	f	f
45	28	0	2	0	0	f	f
46	28	0	1	0	4	f	f
47	28	0	3	0	2	f	f
48	28	0	8	0	4	f	f
49	26	0	5	0	0	f	f
50	26	0	0	0	3	f	f
51	28	0	8	0	0	f	f
52	28	0	7	0	1	f	f
53	28	0	0	0	0	f	f
54	28	0	4	0	1	f	f
55	28	0	9	0	4	f	f
56	28	0	6	0	4	f	f
57	26	0	1	0	4	f	f
58	26	0	4	0	1	f	f
59	28	0	8	0	0	f	f
60	28	0	4	0	1	f	f
61	28	0	0	0	2	f	f
62	28	0	7	0	4	f	f
63	28	0	0	0	0	f	f
64	28	0	7	0	1	f	f
65	26	0	9	0	4	f	f
66	26	0	5	0	4	f	f
67	28	0	8	0	3	f	f
68	28	0	1	0	0	f	f
69	28	0	7	0	1	f	f
70	28	0	0	0	1	f	f
71	28	0	5	0	4	f	f
72	28	0	8	0	4	f	f
73	26	0	0	0	2	f	f
74	26	0	6	0	2	f	f
75	28	0	5	0	0	f	f
76	28	0	2	0	3	f	f
77	28	0	0	0	0	f	f
78	28	0	9	0	4	f	f
79	28	0	3	0	4	f	f
80	28	0	8	0	1	f	f
81	26	-1	9	0	2	f	f
82	26	-1	5	0	2	f	f
83	28	-1	4	0	4	f	f
84	28	-1	0	0	0	f	f
85	28	-1	9	0	0	f	f
86	28	-1	0	0	3	f	f
87	28	-1	6	0	4	f	f
88	28	-1	2	0	0	f	f
95	32	1	\N	\N	\N	f	f
640	28	2	2	0	2	f	f
468	26	9	8	0	2	f	f
642	26	2	3	0	1	f	f
696	26	13	2	0	0	f	f
220	27	1	7	0	0	f	f
226	26	1	5	0	3	f	f
470	28	9	1	0	1	f	f
139	28	1	1	0	4	f	f
697	26	2	5	0	4	f	f
698	37	2	8	0	4	f	f
699	37	2	0	0	3	f	f
700	44	2	8	0	3	f	f
701	28	2	1	0	3	f	f
702	37	2	3	0	2	f	f
703	26	10	1	0	0	f	f
707	28	10	9	0	3	f	f
711	26	12	2	0	2	t	f
465	26	9	9	0	2	t	f
475	27	1	9	0	3	f	f
478	27	1	4	0	3	f	f
479	26	1	5	0	0	f	f
480	27	1	5	0	3	f	f
481	26	1	7	0	0	f	f
483	28	1	3	0	2	f	f
484	28	1	6	0	2	f	f
488	28	1	1	0	2	f	f
577	27	1	5	0	1	f	f
\.


--
-- Data for Name: itemtype; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY itemtype (typeid, weight, name, type, accuracy, damage, capacity, consumable, damagetype) FROM stdin;
27	10	Energy rifle	weapon	25	10	3	f	e
26	3	Energy pistol	weapon	25	5	10	f	e
29	4	Flechette pistol	weapon	25	7	10	f	p
30	10	Flechette shotgun	weapon	50	7	3	f	p
31	1	Flechette cartridge	ammo	15	1	1	t	p
32	3	Axe	weapon	25	5	1	f	p
33	1	Switchblade	weapon	25	3	1	f	p
34	3	Sword	weapon	25	6	1	f	p
35	3	Personal shield	armor	5	3	1	t	p
36	15	Riot armor	armor	5	3	1	f	p
37	1	Vodka	booze	15	1	1	t	p
38	1	Spiced Rum	booze	15	1	1	t	p
39	1	Swill	booze	15	1	1	t	p
40	1	Whiskey	booze	15	1	1	t	p
41	1	Peach Schnapps	booze	15	1	1	t	p
42	1	White lightning	booze	15	1	1	t	p
43	1	PDA	tool	15	1	1	t	p
44	1	MRE	food	15	1	1	t	p
45	1	Desiccated meat	food	15	1	1	t	p
46	1	Desiccated vegetables	food	15	1	1	t	p
47	1	Canned goods	food	15	1	1	t	p
48	2	Torch cutter	tool	15	3	1	f	p
49	1	Gas cartridge	ammo	15	1	1	f	p
50	1	Gas cartridge	ammo	15	1	1	f	p
28	2	Energy pack	ammo	15	1	1	t	p
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY location (id, typeid, station, level, x, y, name, description) FROM stdin;
1001220	0	0	1	-1	3	\N	\N
1001221	0	0	1	-1	4	\N	\N
1001281	0	0	1	0	-16	\N	\N
1001282	0	0	1	0	-15	\N	\N
1001283	0	0	1	0	-14	\N	\N
1001284	0	0	1	0	-13	\N	\N
1001285	0	0	1	0	-12	\N	\N
1001286	0	0	1	0	-11	\N	\N
1001287	0	0	1	0	-10	\N	\N
1001288	0	0	1	0	-9	\N	\N
1001289	0	0	1	0	-8	\N	\N
1001290	0	0	1	0	-7	\N	\N
1001291	0	0	1	0	-6	\N	\N
1001292	0	0	1	0	-5	\N	\N
1001293	0	0	1	0	-4	\N	\N
1001294	0	0	1	0	-3	\N	\N
1001295	0	0	1	0	-2	\N	\N
1001296	0	0	1	0	-1	\N	\N
1001297	0	0	1	0	0	\N	\N
1001298	0	0	1	0	1	\N	\N
1001299	0	0	1	0	2	\N	\N
1001300	0	0	1	0	3	\N	\N
1001301	0	0	1	0	4	\N	\N
1001361	0	0	1	1	-16	\N	\N
1001362	0	0	1	1	-15	\N	\N
1001363	0	0	1	1	-14	\N	\N
1001364	0	0	1	1	-13	\N	\N
1001365	0	0	1	1	-12	\N	\N
1001366	0	0	1	1	-11	\N	\N
1002438	4	0	1	14	21	\N	\N
1002451	4	0	1	14	34	\N	\N
1002677	2	0	1	17	20	null	null
1002360	2	0	1	13	23	null	null
1002203	2	0	1	11	26	null	null
1002285	2	0	1	12	28	null	null
1002931	4	0	1	20	34	\N	\N
1003146	2	0	1	23	9	null	null
1002988	2	0	1	21	11	null	null
1002909	2	0	1	20	12	null	null
1002914	2	0	1	20	17	null	null
1003078	2	0	1	22	21	null	null
1002999	2	0	1	21	22	null	null
1002845	2	0	1	19	28	null	null
1002774	2	0	1	18	37	null	null
1003015	2	0	1	21	38	null	null
1003418	2	0	1	26	41	null	null
1003488	2	0	1	27	31	null	null
1003003	2	0	1	21	26		
1002929	15	0	1	20	32	Atalanta's	
1004124	4	0	1	35	27	\N	\N
1004537	0	0	1	40	40	\N	\N
1003223	4	0	1	24	6	North-South Axis	null
1003224	4	0	1	24	7	North-South Axis	null
1003225	4	0	1	24	8	North-South Axis	null
1003226	4	0	1	24	9	North-South Axis	null
1003227	4	0	1	24	10	North-South Axis	null
1003228	4	0	1	24	11	North-South Axis	null
1003229	4	0	1	24	12	North-South Axis	null
1003230	4	0	1	24	13	North-South Axis	null
1003233	4	0	1	24	16	North-South Axis	null
1003234	4	0	1	24	17	North-South Axis	null
1003235	4	0	1	24	18	North-South Axis	null
1003236	4	0	1	24	19	North-South Axis	null
1003237	4	0	1	24	20	North-South Axis	null
1003238	4	0	1	24	21	North-South Axis	null
1003239	4	0	1	24	22	North-South Axis	null
1003240	4	0	1	24	23	North-South Axis	null
1003243	4	0	1	24	26	North-South Axis	null
1003244	4	0	1	24	27	North-South Axis	null
1003245	4	0	1	24	28	North-South Axis	null
1003246	4	0	1	24	29	North-South Axis	null
1003247	4	0	1	24	30	North-South Axis	null
1003248	4	0	1	24	31	North-South Axis	null
1003249	4	0	1	24	32	North-South Axis	null
1003250	4	0	1	24	33	North-South Axis	null
1003253	4	0	1	24	36	North-South Axis	null
1003254	4	0	1	24	37	North-South Axis	null
1003255	4	0	1	24	38	North-South Axis	null
1003256	4	0	1	24	39	North-South Axis	null
1003257	4	0	1	24	40	North-South Axis	null
1003258	4	0	1	24	41	North-South Axis	null
1003259	4	0	1	24	42	North-South Axis	null
1003260	4	0	1	24	43	North-South Axis	null
1004374	2	0	1	38	37	null	null
1003809	2	0	1	31	32	null	null
1003648	2	0	1	29	31	null	null
1003643	2	0	1	29	26	null	null
1003886	2	0	1	32	29	null	null
1004206	2	0	1	36	29	null	null
1003964	2	0	1	33	27	null	null
1003241	8	0	1	24	24	Central Command	North-South Axis
1003242	8	0	1	24	25	Central Command	North-South Axis
1003322	8	0	1	25	25	Central Command	null
1003340	4	0	1	25	43	South-North Axis	null
1003339	4	0	1	25	42	South-North Axis	null
1003338	4	0	1	25	41	South-North Axis	null
1003337	4	0	1	25	40	South-North Axis	null
1003336	4	0	1	25	39	South-North Axis	null
1003335	4	0	1	25	38	South-North Axis	null
1003334	4	0	1	25	37	South-North Axis	null
1003333	4	0	1	25	36	South-North Axis	null
1003330	4	0	1	25	33	South-North Axis	null
1003329	4	0	1	25	32	South-North Axis	null
1003328	4	0	1	25	31	South-North Axis	null
1003327	4	0	1	25	30	South-North Axis	null
1003326	4	0	1	25	29	South-North Axis	null
1003325	4	0	1	25	28	South-North Axis	null
1003324	4	0	1	25	27	South-North Axis	null
1003323	4	0	1	25	26	South-North Axis	null
1003142	0	0	1	23	5	null	null
1003063	0	0	1	22	6	null	null
1002984	0	0	1	21	7	null	null
1002905	0	0	1	20	8	null	null
1003143	4	0	1	23	6	Outer Ring	null
1003162	4	0	1	23	25	West-East Axis	null
1003402	4	0	1	26	25	West-East Axis	null
1003161	4	0	1	23	24	East-West Axis	null
1003160	4	0	1	23	23	North-West Axis	null
1003079	4	0	1	22	22	North-West Axis	null
1002998	4	0	1	21	21	North-West Axis	null
1002917	4	0	1	20	20	North-West Axis	null
1002836	4	0	1	19	19	North-West Axis	null
1002755	4	0	1	18	18	North-West Axis	null
1002593	4	0	1	16	16	North-West Axis	null
1003064	4	0	1	22	7	Outer Ring	null
1002985	4	0	1	21	8	Outer Ring	null
1002906	4	0	1	20	9	Outer Ring	null
1002827	4	0	1	19	10	Outer Ring	null
1002748	4	0	1	18	11	Outer Ring	null
1002669	4	0	1	17	12	Outer Ring	null
1002590	4	0	1	16	13	Outer Ring	null
1002511	4	0	1	15	14	Outer Ring	null
1002432	4	0	1	14	15	Outer Ring	null
1002353	4	0	1	13	16	Outer Ring	null
1002274	4	0	1	12	17	Outer Ring	null
1002195	4	0	1	11	18	Outer Ring	null
1002116	4	0	1	10	19	Outer Ring	null
1003222	10	0	1	24	5	Northern Airlock	North-South Axis
1002187	4	0	1	11	10	Outer Ring	null
1002267	4	0	1	12	10	Outer Ring	null
1002347	4	0	1	13	10	Outer Ring	null
1002427	4	0	1	14	10	Outer Ring	null
1002587	4	0	1	16	10	Outer Ring	null
1002667	4	0	1	17	10	Outer Ring	null
1002747	4	0	1	18	10	Outer Ring	null
1002108	4	0	1	10	11	Outer Ring	null
1002109	4	0	1	10	12	Outer Ring	null
1002110	4	0	1	10	13	Outer Ring	null
1002111	4	0	1	10	14	Outer Ring	null
1002112	4	0	1	10	15	Outer Ring	null
1002113	4	0	1	10	16	Outer Ring	null
1002114	4	0	1	10	17	Outer Ring	null
1002115	4	0	1	10	18	Outer Ring	null
1002037	4	0	1	9	20	Outer Ring	null
1001958	4	0	1	8	21	Outer Ring	null
1001879	4	0	1	7	22	Outer Ring	null
1001800	4	0	1	6	23	Outer Ring	null
1001721	10	0	1	5	24	Western Airlock	null
1001722	10	0	1	5	25	Western Airlock	null
1001720	0	0	1	5	23	null	null
1001799	0	0	1	6	22	null	null
1001878	0	0	1	7	21	null	null
1001957	0	0	1	8	20		
1002507	4	0	1	15	10	Outer Ring	Outer Ring
1003163	4	0	1	23	26	null	null
1003403	4	0	1	26	26	null	null
1003081	4	0	1	22	24	null	null
1003001	4	0	1	21	24	null	null
1002921	4	0	1	20	24	null	null
1002841	4	0	1	19	24	null	null
1002761	4	0	1	18	24	null	null
1002681	4	0	1	17	24	null	null
1002601	4	0	1	16	24	null	null
1002361	4	0	1	13	24	null	null
1002281	4	0	1	12	24	null	null
1002201	4	0	1	11	24	null	null
1002121	4	0	1	10	24	null	null
1002041	4	0	1	9	24	null	null
1001961	4	0	1	8	24	null	null
1001881	4	0	1	7	24	null	null
1001801	4	0	1	6	24	null	null
1001802	4	0	1	6	25	null	null
1001882	4	0	1	7	25	null	null
1001962	4	0	1	8	25	null	null
1002042	4	0	1	9	25	null	null
1002122	4	0	1	10	25	null	null
1002202	4	0	1	11	25	null	null
1002282	4	0	1	12	25	null	null
1002362	4	0	1	13	25	null	null
1002602	4	0	1	16	25	null	null
1002682	4	0	1	17	25	null	null
1002762	4	0	1	18	25	null	null
1002842	4	0	1	19	25	null	null
1002922	4	0	1	20	25	null	null
1003002	4	0	1	21	25	null	null
1003082	4	0	1	22	25	null	null
1001867	0	0	1	7	10	\N	\N
1001868	0	0	1	7	11	\N	\N
1001869	0	0	1	7	12	\N	\N
1002107	4	0	1	10	10		
1001870	0	0	1	7	13	\N	\N
1001871	0	0	1	7	14	\N	\N
1001872	0	0	1	7	15	\N	\N
1001873	0	0	1	7	16	\N	\N
1001874	0	0	1	7	17	\N	\N
1001875	0	0	1	7	18	\N	\N
1001876	0	0	1	7	19	\N	\N
1001947	0	0	1	8	10	\N	\N
1001948	0	0	1	8	11	\N	\N
1001949	0	0	1	8	12	\N	\N
1001950	0	0	1	8	13	\N	\N
1001951	0	0	1	8	14	\N	\N
1001952	0	0	1	8	15	\N	\N
1001953	0	0	1	8	16	\N	\N
1001954	0	0	1	8	17	\N	\N
1001955	0	0	1	8	18	\N	\N
1001956	0	0	1	8	19	\N	\N
1002036	0	0	1	9	19	null	null
1002035	0	0	1	9	18	null	null
1002034	0	0	1	9	17	null	null
1002033	0	0	1	9	16	null	null
1002032	0	0	1	9	15	null	null
1002031	0	0	1	9	14	null	null
1002030	0	0	1	9	13	null	null
1002029	0	0	1	9	12	null	null
1002102	0	0	1	10	5	\N	\N
1002103	0	0	1	10	6	\N	\N
1002104	0	0	1	10	7	\N	\N
1002377	0	0	1	13	40	null	null
1002182	0	0	1	11	5	\N	\N
1002183	0	0	1	11	6	\N	\N
1002184	0	0	1	11	7	\N	\N
1002185	0	0	1	11	8	\N	\N
1002262	0	0	1	12	5	\N	\N
1002263	0	0	1	12	6	\N	\N
1002264	0	0	1	12	7	\N	\N
1002265	0	0	1	12	8	\N	\N
1002342	0	0	1	13	5	\N	\N
1002343	0	0	1	13	6	\N	\N
1002344	0	0	1	13	7	\N	\N
1002345	0	0	1	13	8	\N	\N
1002422	0	0	1	14	5	\N	\N
1002423	0	0	1	14	6	\N	\N
1002424	0	0	1	14	7	\N	\N
1002425	0	0	1	14	8	\N	\N
1002502	0	0	1	15	5	\N	\N
1002503	0	0	1	15	6	\N	\N
1002504	0	0	1	15	7	\N	\N
1002505	0	0	1	15	8	\N	\N
1002582	0	0	1	16	5	\N	\N
1002583	0	0	1	16	6	\N	\N
1002584	0	0	1	16	7	\N	\N
1002585	0	0	1	16	8	\N	\N
1002662	0	0	1	17	5	\N	\N
1002663	0	0	1	17	6	\N	\N
1002664	0	0	1	17	7	\N	\N
1002742	0	0	1	18	5	\N	\N
1002743	0	0	1	18	6	\N	\N
1002744	0	0	1	18	7	\N	\N
1002745	0	0	1	18	8	\N	\N
1002822	0	0	1	19	5	\N	\N
1002823	0	0	1	19	6	\N	\N
1002824	0	0	1	19	7	\N	\N
1002825	0	0	1	19	8	\N	\N
1002826	0	0	1	19	9	null	null
1002266	0	0	1	12	9	null	null
1002346	0	0	1	13	9	null	null
1002426	0	0	1	14	9	null	null
1002506	0	0	1	15	9	null	null
1002586	0	0	1	16	9	null	null
1002665	0	0	1	17	8	null	null
1002666	0	0	1	17	9	null	null
1002746	0	0	1	18	9	null	null
1001862	0	0	1	7	5	\N	\N
1001863	0	0	1	7	6	\N	\N
1001864	0	0	1	7	7	\N	\N
1001865	0	0	1	7	8	\N	\N
1001866	0	0	1	7	9	\N	\N
1001942	0	0	1	8	5	\N	\N
1001943	0	0	1	8	6	\N	\N
1001944	0	0	1	8	7	\N	\N
1001946	0	0	1	8	9	\N	\N
1002022	0	0	1	9	5	\N	\N
1002023	0	0	1	9	6	\N	\N
1002024	0	0	1	9	7	\N	\N
1003482	4	0	1	27	25	\N	\N
1003562	4	0	1	28	25	\N	\N
1003642	4	0	1	29	25	\N	\N
1003722	4	0	1	30	25	\N	\N
1003802	4	0	1	31	25	\N	\N
1003882	4	0	1	32	25	\N	\N
1003962	4	0	1	33	25	\N	\N
1004202	4	0	1	36	25	\N	\N
1004282	4	0	1	37	25	\N	\N
1004362	4	0	1	38	25	\N	\N
1004442	4	0	1	39	25	\N	\N
1004602	4	0	1	41	25	\N	\N
1004682	4	0	1	42	25	\N	\N
1004762	4	0	1	43	25	\N	\N
1004842	10	0	1	44	25	null	null
1004843	0	0	1	44	26	null	null
1004522	4	0	1	40	25	null	null
1003896	4	0	1	32	39	null	null
1004449	4	0	1	39	32	null	null
1004763	4	0	1	43	26	null	null
1004684	4	0	1	42	27	null	null
1004605	4	0	1	41	28	null	null
1004526	4	0	1	40	29	null	null
1004447	4	0	1	39	30	null	null
1004368	4	0	1	38	31	null	null
1004289	4	0	1	37	32	null	null
1004210	4	0	1	36	33	null	null
1004131	4	0	1	35	34	null	null
1004052	4	0	1	34	35	null	null
1003973	4	0	1	33	36	null	null
1003894	4	0	1	32	37	null	null
1003815	4	0	1	31	38	null	null
1003736	4	0	1	30	39	null	null
1003657	4	0	1	29	40	null	null
1003578	4	0	1	28	41	null	null
1003499	4	0	1	27	42	null	null
1003420	4	0	1	26	43	null	null
1003261	10	0	1	24	44	North-South Airlock	North-South Axis
1003341	10	0	1	25	44	South-North Airlock	South-North Axis
1003421	0	0	1	26	44	null	null
1003181	0	0	1	23	44	null	null
1003180	4	0	1	23	43	null	null
1003099	4	0	1	22	42	null	null
1003018	4	0	1	21	41	null	null
1002937	4	0	1	20	40	null	null
1002856	4	0	1	19	39	null	null
1002027	0	0	1	9	10		
1001945	0	0	1	8	8	Observation Deck	Observation Deck
1002105	0	0	1	10	8	Observation Deck	Observation Deck
1002028	0	0	1	9	11		
1002186	0	0	1	11	9		
1002775	4	0	1	18	38	null	null
1002694	4	0	1	17	37	null	null
1002613	4	0	1	16	36	null	null
1002532	4	0	1	15	35	null	null
1002370	4	0	1	13	33	null	null
1002289	4	0	1	12	32	null	null
1002208	4	0	1	11	31	null	null
1002127	4	0	1	10	30	null	null
1002046	4	0	1	9	29	null	null
1001965	4	0	1	8	28	null	null
1001884	4	0	1	7	27	null	null
1001803	4	0	1	6	26	null	null
1001723	0	0	1	5	26	null	null
1003100	0	0	1	22	43	null	null
1003019	0	0	1	21	42	null	null
1002128	4	0	1	10	31	null	null
1002129	4	0	1	10	32	null	null
1002130	4	0	1	10	33	null	null
1002131	4	0	1	10	34	null	null
1002132	4	0	1	10	35	null	null
1002133	4	0	1	10	36	null	null
1002134	4	0	1	10	37	null	null
1002135	4	0	1	10	38	null	null
1002136	4	0	1	10	39	null	null
1002216	4	0	1	11	39	null	null
1002296	4	0	1	12	39	null	null
1002376	4	0	1	13	39	null	null
1002456	4	0	1	14	39	null	null
1002616	4	0	1	16	39	null	null
1002696	4	0	1	17	39	null	null
1002776	4	0	1	18	39	null	null
1002938	0	0	1	20	41	null	null
1002857	0	0	1	19	40	null	null
1002777	0	0	1	18	40	null	null
1002697	0	0	1	17	40	null	null
1002617	0	0	1	16	40	null	null
1002537	0	0	1	15	40	null	null
1002457	0	0	1	14	40	null	null
1002297	0	0	1	12	40	null	null
1002217	0	0	1	11	40	null	null
1002137	0	0	1	10	40	null	null
1002057	0	0	1	9	40	null	null
1002056	0	0	1	9	39	null	null
1002055	0	0	1	9	38	null	null
1002054	0	0	1	9	37	null	null
1002904	0	0	1	20	7	null	null
1002903	0	0	1	20	6	null	null
1002902	0	0	1	20	5	null	null
1002983	0	0	1	21	6	null	null
1003062	0	0	1	22	5	null	null
1006463	4	0	1	28	14	\N	\N
1006493	2	0	1	29	17	null	null
1006528	2	0	1	32	20	null	null
1006523	2	0	1	37	20	null	null
1006454	2	0	1	26	13	null	null
1006582	4	0	1	43	24	\N	\N
1006583	4	0	1	42	24	\N	\N
1006584	4	0	1	41	24	\N	\N
1006585	4	0	1	40	24	\N	\N
1006586	4	0	1	39	24	\N	\N
1006587	4	0	1	38	24	\N	\N
1006588	4	0	1	37	24	\N	\N
1006589	4	0	1	36	24	\N	\N
1006592	4	0	1	33	24	\N	\N
1006593	4	0	1	32	24	\N	\N
1006594	4	0	1	31	24	\N	\N
1006595	4	0	1	30	24	\N	\N
1006596	4	0	1	29	24	\N	\N
1006597	4	0	1	28	24	\N	\N
1006598	4	0	1	27	24	\N	\N
1006599	4	0	1	26	24	\N	\N
1006600	8	0	1	25	24	\N	\N
1006602	0	0	1	44	23	\N	\N
1006603	0	0	1	43	22	\N	\N
1006604	0	0	1	42	21	\N	\N
1006605	0	0	1	41	20	\N	\N
1006607	4	0	1	43	23	\N	\N
1006608	4	0	1	25	23	\N	\N
1006609	4	0	1	26	23	\N	\N
1006610	4	0	1	27	22	\N	\N
1006611	4	0	1	28	21	\N	\N
1006612	4	0	1	29	20	\N	\N
1006613	4	0	1	30	19	\N	\N
1006614	4	0	1	31	18	\N	\N
1006615	4	0	1	33	16	\N	\N
1006617	4	0	1	42	22	\N	\N
1006618	4	0	1	41	21	\N	\N
1006619	4	0	1	40	20	\N	\N
1006620	4	0	1	39	19	\N	\N
1006621	4	0	1	38	18	\N	\N
1006622	4	0	1	37	17	\N	\N
1006623	4	0	1	36	16	\N	\N
1006624	4	0	1	35	15	\N	\N
1006625	4	0	1	34	14	\N	\N
1006626	4	0	1	33	13	\N	\N
1006627	4	0	1	32	12	\N	\N
1006628	4	0	1	31	11	\N	\N
1006629	4	0	1	30	10	\N	\N
1006630	10	0	1	44	24	\N	\N
1006631	4	0	1	39	10	\N	\N
1006632	4	0	1	39	11	\N	\N
1006633	4	0	1	39	12	\N	\N
1006634	4	0	1	39	13	\N	\N
1006635	4	0	1	39	14	\N	\N
1006636	4	0	1	39	16	\N	\N
1006637	4	0	1	39	17	\N	\N
1006638	4	0	1	39	18	\N	\N
1006639	4	0	1	38	10	\N	\N
1006640	4	0	1	37	10	\N	\N
1006641	4	0	1	36	10	\N	\N
1006642	4	0	1	35	10	\N	\N
1006643	4	0	1	34	10	\N	\N
1006644	4	0	1	33	10	\N	\N
1006645	4	0	1	32	10	\N	\N
1006646	4	0	1	31	10	\N	\N
1006647	4	0	1	29	9	\N	\N
1006648	4	0	1	28	8	\N	\N
1006649	4	0	1	27	7	\N	\N
1006650	4	0	1	26	6	\N	\N
1006651	10	0	1	25	5	\N	\N
1006653	0	0	1	26	5	\N	\N
1006654	0	0	1	27	6	\N	\N
1006655	0	0	1	28	7	\N	\N
1006656	0	0	1	29	8	\N	\N
1006657	4	0	1	39	15	\N	\N
1006664	4	0	1	25	22	\N	\N
1006665	4	0	1	25	21	\N	\N
1006666	4	0	1	25	20	\N	\N
1006667	4	0	1	25	19	\N	\N
1006668	4	0	1	25	18	\N	\N
1006669	4	0	1	25	17	\N	\N
1006670	4	0	1	25	16	\N	\N
1006673	4	0	1	25	13	\N	\N
1006674	4	0	1	25	12	\N	\N
1006675	4	0	1	25	11	\N	\N
1006676	4	0	1	25	10	\N	\N
1006677	4	0	1	25	9	\N	\N
1006678	4	0	1	25	8	\N	\N
1006679	4	0	1	25	7	\N	\N
1006680	4	0	1	25	6	\N	\N
1006711	0	0	1	39	7	\N	\N
1006712	0	0	1	38	7	\N	\N
1006713	0	0	1	37	7	\N	\N
1006714	0	0	1	36	7	\N	\N
1006715	0	0	1	35	7	\N	\N
1006716	0	0	1	34	7	\N	\N
1006717	0	0	1	33	7	\N	\N
1006718	0	0	1	32	7	\N	\N
1006719	0	0	1	31	7	\N	\N
1006720	0	0	1	30	7	\N	\N
1006721	0	0	1	39	8	\N	\N
1006722	0	0	1	38	8	\N	\N
1006723	0	0	1	37	8	\N	\N
1006724	0	0	1	36	8	\N	\N
1006725	0	0	1	35	8	\N	\N
1006726	0	0	1	34	8	\N	\N
1006727	0	0	1	33	8	\N	\N
1006728	0	0	1	32	8	\N	\N
1006729	0	0	1	31	8	\N	\N
1006730	0	0	1	30	8	\N	\N
1006731	0	0	1	30	9	\N	\N
1006732	0	0	1	31	9	\N	\N
1006548	2	0	1	27	21	null	null
1006564	2	0	1	28	22	null	null
1006544	2	0	1	32	21	null	null
1006538	2	0	1	38	21	null	null
1006568	2	0	1	40	23	null	null
1006733	0	0	1	32	9	\N	\N
1006734	0	0	1	33	9	\N	\N
1006735	0	0	1	34	9	\N	\N
1006736	0	0	1	35	9	\N	\N
1006737	0	0	1	36	9	\N	\N
1006738	0	0	1	37	9	\N	\N
1006739	0	0	1	38	9	\N	\N
1006740	0	0	1	39	9	\N	\N
1006742	0	0	1	44	10	\N	\N
1006743	0	0	1	43	10	\N	\N
1006744	0	0	1	42	10	\N	\N
1006745	0	0	1	41	10	\N	\N
1006747	0	0	1	44	11	\N	\N
1006748	0	0	1	43	11	\N	\N
1006749	0	0	1	42	11	\N	\N
1006750	0	0	1	41	11	\N	\N
1006752	0	0	1	44	12	\N	\N
1006753	0	0	1	43	12	\N	\N
1006754	0	0	1	42	12	\N	\N
1006755	0	0	1	41	12	\N	\N
1006757	0	0	1	44	13	\N	\N
1006758	0	0	1	43	13	\N	\N
1006759	0	0	1	42	13	\N	\N
1006760	0	0	1	41	13	\N	\N
1006762	0	0	1	44	14	\N	\N
1006763	0	0	1	43	14	\N	\N
1006764	0	0	1	42	14	\N	\N
1006765	0	0	1	41	14	\N	\N
1006767	0	0	1	44	15	\N	\N
1006768	0	0	1	43	15	\N	\N
1006769	0	0	1	42	15	\N	\N
1006770	0	0	1	41	15	\N	\N
1006772	0	0	1	44	16	\N	\N
1006773	0	0	1	43	16	\N	\N
1006774	0	0	1	42	16	\N	\N
1006775	0	0	1	41	16	\N	\N
1006777	0	0	1	44	17	\N	\N
1006778	0	0	1	43	17	\N	\N
1006779	0	0	1	42	17	\N	\N
1006781	0	0	1	44	18	\N	\N
1006782	0	0	1	43	18	\N	\N
1006783	0	0	1	42	18	\N	\N
1006784	0	0	1	41	18	\N	\N
1006786	0	0	1	44	19	\N	\N
1006787	0	0	1	43	19	\N	\N
1006788	0	0	1	42	19	\N	\N
1006789	0	0	1	41	19	\N	\N
1006790	0	0	1	40	19	\N	\N
1006791	0	0	1	40	10	\N	\N
1006792	0	0	1	40	11	\N	\N
1006793	0	0	1	40	12	\N	\N
1006794	0	0	1	40	13	\N	\N
1006795	0	0	1	40	14	\N	\N
1006796	0	0	1	40	15	\N	\N
1006797	0	0	1	40	16	\N	\N
1006798	0	0	1	41	17	\N	\N
1006799	0	0	1	40	17	\N	\N
1006800	0	0	1	40	18	\N	\N
1006820	0	0	1	44	7	\N	\N
1006821	0	0	1	43	7	\N	\N
1006822	0	0	1	42	7	\N	\N
1006823	0	0	1	41	7	\N	\N
1006824	0	0	1	40	7	\N	\N
1006826	0	0	1	44	8	\N	\N
1006827	0	0	1	43	8	\N	\N
1006828	0	0	1	42	8	\N	\N
1006829	0	0	1	41	8	\N	\N
1006830	0	0	1	40	8	\N	\N
1006832	0	0	1	44	9	\N	\N
1006833	0	0	1	43	9	\N	\N
1006834	0	0	1	42	9	\N	\N
1006835	0	0	1	41	9	\N	\N
1006836	0	0	1	40	9	\N	\N
1006837	0	0	1	42	20	\N	\N
1006838	0	0	1	43	20	\N	\N
1006839	0	0	1	44	20	\N	\N
1006840	0	0	1	43	21	\N	\N
1006841	0	0	1	44	22	\N	\N
1001877	0	0	1	7	20	null	null
1001804	0	0	1	6	27	null	null
1002053	0	0	1	9	36	null	null
1002052	0	0	1	9	35	null	null
1002051	0	0	1	9	34	null	null
1002050	0	0	1	9	33	null	null
1002049	0	0	1	9	32	null	null
1002048	0	0	1	9	31	null	null
1002047	0	0	1	9	30	null	null
1001966	0	0	1	8	29	null	null
1001885	0	0	1	7	28	null	null
1003500	0	0	1	27	43	null	null
1003579	0	0	1	28	42	null	null
1003658	0	0	1	29	41	null	null
1003737	0	0	1	30	40	null	null
1003816	4	0	1	31	39	null	null
1003976	4	0	1	33	39	null	null
1004056	4	0	1	34	39	null	null
1004136	4	0	1	35	39	null	null
1004216	4	0	1	36	39	null	null
1004296	4	0	1	37	39	null	null
1004376	4	0	1	38	39	null	null
1004456	4	0	1	39	39	null	null
1004455	4	0	1	39	38	null	null
1004454	4	0	1	39	37	null	null
1004453	4	0	1	39	36	null	null
1004452	4	0	1	39	35	null	null
1004451	4	0	1	39	34	null	null
1004450	4	0	1	39	33	null	null
1004448	4	0	1	39	31	null	null
1003817	0	0	1	31	40	null	null
1004057	0	0	1	34	40	null	null
1004137	0	0	1	35	40	null	null
1004217	0	0	1	36	40	null	null
1004297	0	0	1	37	40	null	null
1004377	0	0	1	38	40	null	null
1004457	0	0	1	39	40	null	null
1004536	0	0	1	40	39	null	null
1004535	0	0	1	40	38	null	null
1004534	0	0	1	40	37	null	null
1004533	0	0	1	40	36	null	null
1004532	0	0	1	40	35	null	null
1004531	0	0	1	40	34	null	null
1004530	0	0	1	40	33	null	null
1004529	0	0	1	40	32	null	null
1004528	0	0	1	40	31	null	null
1004527	0	0	1	40	30	null	null
1004606	0	0	1	41	29	null	null
1004685	0	0	1	42	28	null	null
1004764	0	0	1	43	27	null	null
1002536	4	0	1	15	39	null	null
1002610	4	0	1	16	33	null	null
1002689	4	0	1	17	32	null	null
1002768	4	0	1	18	31	null	null
1002847	4	0	1	19	30	null	null
1002926	4	0	1	20	29	null	null
1003005	4	0	1	21	28	null	null
1003084	4	0	1	22	27	null	null
1003970	4	0	1	33	33	null	null
1003889	4	0	1	32	32	null	null
1003808	4	0	1	31	31	null	null
1003727	4	0	1	30	30	null	null
1003646	4	0	1	29	29	null	null
1003565	4	0	1	28	28	null	null
1003484	4	0	1	27	27	null	null
1002591	4	0	1	16	14	null	null
1002592	4	0	1	16	15	null	null
1002672	4	0	1	17	15	null	null
1002752	4	0	1	18	15	null	null
1002832	4	0	1	19	15	null	null
1002912	4	0	1	20	15	null	null
1002992	4	0	1	21	15	null	null
1003072	4	0	1	22	15	null	null
1003152	4	0	1	23	15	null	null
1006475	4	0	1	26	15	null	null
1006474	4	0	1	27	15	null	null
1006473	4	0	1	28	15	null	null
1006472	4	0	1	29	15	null	null
1006471	4	0	1	30	15	null	null
1006470	4	0	1	31	15	null	null
1006469	4	0	1	32	15	null	null
1006468	4	0	1	33	15	null	null
1006458	4	0	1	33	14	null	null
1006459	4	0	1	32	14	null	null
1006460	4	0	1	31	14	null	null
1006461	4	0	1	30	14	null	null
1006462	4	0	1	29	14	null	null
1006464	4	0	1	27	14	null	null
1006465	4	0	1	26	14	null	null
1003151	4	0	1	23	14	null	null
1003071	4	0	1	22	14	null	null
1002991	4	0	1	21	14	null	null
1002911	4	0	1	20	14	null	null
1002831	4	0	1	19	14	null	null
1002751	4	0	1	18	14	null	null
1002671	4	0	1	17	14	null	null
1002440	4	0	1	14	23	null	null
1002520	4	0	1	15	23	null	null
1002439	4	0	1	14	22	null	null
1002519	4	0	1	15	22	null	null
1002518	4	0	1	15	21	null	null
1002437	4	0	1	14	20	null	null
1002436	4	0	1	14	19	null	null
1002435	4	0	1	14	18	null	null
1002434	4	0	1	14	17	null	null
1002433	4	0	1	14	16	null	null
1002517	4	0	1	15	20	null	null
1002516	4	0	1	15	19	null	null
1002515	4	0	1	15	18	null	null
1002514	4	0	1	15	17	null	null
1002513	4	0	1	15	16	null	null
1002443	4	0	1	14	26	null	null
1002523	4	0	1	15	26	null	null
1002450	4	0	1	14	33	null	null
1002530	4	0	1	15	33	null	null
1002529	4	0	1	15	32	null	null
1002449	4	0	1	14	32	null	null
1002448	4	0	1	14	31	null	null
1002528	4	0	1	15	31	null	null
1002447	4	0	1	14	30	null	null
1002527	4	0	1	15	30	null	null
1002446	4	0	1	14	29	null	null
1002526	4	0	1	15	29	null	null
1002445	4	0	1	14	28	null	null
1002525	4	0	1	15	28	null	null
1002444	4	0	1	14	27	null	null
1002524	4	0	1	15	27	null	null
1002441	8	0	1	14	24	null	null
1002521	8	0	1	15	24	null	null
1002442	8	0	1	14	25	null	null
1002522	8	0	1	15	25	null	null
1002674	4	0	1	17	17	null	null
1006591	8	0	1	34	24	null	null
1006590	8	0	1	35	24	null	null
1004042	8	0	1	34	25	null	null
1004122	8	0	1	35	25	null	null
1006574	4	0	1	34	23	null	null
1006573	4	0	1	35	23	null	null
1006558	4	0	1	34	22	null	null
1006557	4	0	1	35	22	null	null
1006542	4	0	1	34	21	null	null
1006541	4	0	1	35	21	null	null
1006526	4	0	1	34	20	null	null
1006525	4	0	1	35	20	null	null
1006512	4	0	1	34	19	null	null
1006511	4	0	1	35	19	null	null
1006500	4	0	1	34	18	null	null
1006499	4	0	1	35	18	null	null
1006488	4	0	1	34	17	null	null
1006487	4	0	1	35	17	null	null
1006478	4	0	1	34	16	null	null
1006477	4	0	1	35	16	null	null
1006616	8	0	1	34	15	null	null
1003231	8	0	1	24	14	North-South Axis	North-South Axis
1006672	8	0	1	25	14	null	null
1003232	8	0	1	24	15	North-South Axis	North-South Axis
1006671	8	0	1	25	15	null	null
1002531	8	0	1	15	34	null	null
1003251	8	0	1	24	34	North-South Axis	North-South Axis
1003331	8	0	1	25	34	South-North Axis	South-North Axis
1002982	0	0	1	21	5	null	null
1003252	8	0	1	24	35	North-South Axis	North-South Axis
1003332	8	0	1	25	35	South-North Axis	South-North Axis
1003172	4	0	1	23	35	null	null
1003092	4	0	1	22	35	null	null
1003012	4	0	1	21	35	null	null
1002932	4	0	1	20	35	null	null
1002852	4	0	1	19	35	null	null
1002772	4	0	1	18	35	null	null
1002692	4	0	1	17	35	null	null
1002612	4	0	1	16	35	null	null
1002611	4	0	1	16	34	null	null
1002691	4	0	1	17	34	null	null
1002771	4	0	1	18	34	null	null
1002851	4	0	1	19	34	null	null
1003011	4	0	1	21	34	null	null
1003091	4	0	1	22	34	null	null
1003171	4	0	1	23	34	null	null
1003412	4	0	1	26	35	null	null
1003492	4	0	1	27	35	null	null
1003572	4	0	1	28	35	null	null
1003652	4	0	1	29	35	null	null
1003732	4	0	1	30	35	null	null
1003812	4	0	1	31	35	null	null
1003892	4	0	1	32	35	null	null
1003972	4	0	1	33	35	null	null
1004051	8	0	1	34	34	null	null
1003971	4	0	1	33	34	null	null
1003891	4	0	1	32	34	null	null
1003811	4	0	1	31	34	null	null
1003731	4	0	1	30	34	null	null
1003651	4	0	1	29	34	null	null
1003571	4	0	1	28	34	null	null
1003491	4	0	1	27	34	null	null
1003411	4	0	1	26	34	null	null
1004050	4	0	1	34	33	null	null
1004049	4	0	1	34	32	null	null
1004130	4	0	1	35	33	null	null
1004129	4	0	1	35	32	null	null
1004048	4	0	1	34	31	null	null
1004128	4	0	1	35	31	null	null
1004047	4	0	1	34	30	null	null
1004127	4	0	1	35	30	null	null
1004046	4	0	1	34	29	null	null
1004126	4	0	1	35	29	null	null
1004045	4	0	1	34	28	null	null
1004125	4	0	1	35	28	null	null
1004044	4	0	1	34	27	null	null
1004043	4	0	1	34	26	null	null
1004123	4	0	1	35	26	null	null
1006490	4	0	1	32	17	null	null
1000039	0	0	1	-16	22	\N	\N
1000040	0	0	1	-16	23	\N	\N
1000041	0	0	1	-16	24	\N	\N
1000042	0	0	1	-16	25	\N	\N
1000043	0	0	1	-16	26	\N	\N
1000044	0	0	1	-16	27	\N	\N
1000119	0	0	1	-15	22	\N	\N
1000120	0	0	1	-15	23	\N	\N
1000121	0	0	1	-15	24	\N	\N
1000122	0	0	1	-15	25	\N	\N
1000123	0	0	1	-15	26	\N	\N
1000124	0	0	1	-15	27	\N	\N
1000199	0	0	1	-14	22	\N	\N
1000200	0	0	1	-14	23	\N	\N
1000201	0	0	1	-14	24	\N	\N
1000202	0	0	1	-14	25	\N	\N
1000203	0	0	1	-14	26	\N	\N
1000204	0	0	1	-14	27	\N	\N
1000279	0	0	1	-13	22	\N	\N
1000280	0	0	1	-13	23	\N	\N
1000281	0	0	1	-13	24	\N	\N
1000282	0	0	1	-13	25	\N	\N
1000283	0	0	1	-13	26	\N	\N
1000284	0	0	1	-13	27	\N	\N
1000359	0	0	1	-12	22	\N	\N
1000360	0	0	1	-12	23	\N	\N
1000361	0	0	1	-12	24	\N	\N
1000362	0	0	1	-12	25	\N	\N
1000363	0	0	1	-12	26	\N	\N
1000364	0	0	1	-12	27	\N	\N
1000439	0	0	1	-11	22	\N	\N
1000440	0	0	1	-11	23	\N	\N
1000441	0	0	1	-11	24	\N	\N
1000442	0	0	1	-11	25	\N	\N
1000443	0	0	1	-11	26	\N	\N
1000444	0	0	1	-11	27	\N	\N
1000519	0	0	1	-10	22	\N	\N
1000520	0	0	1	-10	23	\N	\N
1000521	0	0	1	-10	24	\N	\N
1000522	0	0	1	-10	25	\N	\N
1000523	0	0	1	-10	26	\N	\N
1000524	0	0	1	-10	27	\N	\N
1000599	0	0	1	-9	22	\N	\N
1000600	0	0	1	-9	23	\N	\N
1000601	0	0	1	-9	24	\N	\N
1000602	0	0	1	-9	25	\N	\N
1000603	0	0	1	-9	26	\N	\N
1000604	0	0	1	-9	27	\N	\N
1000679	0	0	1	-8	22	\N	\N
1000680	0	0	1	-8	23	\N	\N
1000681	0	0	1	-8	24	\N	\N
1000682	0	0	1	-8	25	\N	\N
1000683	0	0	1	-8	26	\N	\N
1000684	0	0	1	-8	27	\N	\N
1000759	0	0	1	-7	22	\N	\N
1000760	0	0	1	-7	23	\N	\N
1000761	0	0	1	-7	24	\N	\N
1000762	0	0	1	-7	25	\N	\N
1000763	0	0	1	-7	26	\N	\N
1000764	0	0	1	-7	27	\N	\N
1000839	0	0	1	-6	22	\N	\N
1000840	0	0	1	-6	23	\N	\N
1000841	0	0	1	-6	24	\N	\N
1000842	0	0	1	-6	25	\N	\N
1000843	0	0	1	-6	26	\N	\N
1000844	0	0	1	-6	27	\N	\N
1000919	0	0	1	-5	22	\N	\N
1000920	0	0	1	-5	23	\N	\N
1000921	0	0	1	-5	24	\N	\N
1000922	0	0	1	-5	25	\N	\N
1000923	0	0	1	-5	26	\N	\N
1000924	0	0	1	-5	27	\N	\N
1000999	0	0	1	-4	22	\N	\N
1001000	0	0	1	-4	23	\N	\N
1001001	0	0	1	-4	24	\N	\N
1001002	0	0	1	-4	25	\N	\N
1001003	0	0	1	-4	26	\N	\N
1001004	0	0	1	-4	27	\N	\N
1001079	0	0	1	-3	22	\N	\N
1001080	0	0	1	-3	23	\N	\N
1001081	0	0	1	-3	24	\N	\N
1001082	0	0	1	-3	25	\N	\N
1001083	0	0	1	-3	26	\N	\N
1001084	0	0	1	-3	27	\N	\N
1001159	0	0	1	-2	22	\N	\N
1001160	0	0	1	-2	23	\N	\N
1001161	0	0	1	-2	24	\N	\N
1001162	0	0	1	-2	25	\N	\N
1001163	0	0	1	-2	26	\N	\N
1001164	0	0	1	-2	27	\N	\N
1001239	0	0	1	-1	22	\N	\N
1001240	0	0	1	-1	23	\N	\N
1001241	0	0	1	-1	24	\N	\N
1001242	0	0	1	-1	25	\N	\N
1001243	0	0	1	-1	26	\N	\N
1001244	0	0	1	-1	27	\N	\N
1001319	0	0	1	0	22	\N	\N
1001320	0	0	1	0	23	\N	\N
1001321	0	0	1	0	24	\N	\N
1001322	0	0	1	0	25	\N	\N
1001323	0	0	1	0	26	\N	\N
1001324	0	0	1	0	27	\N	\N
1001399	0	0	1	1	22	\N	\N
1001400	0	0	1	1	23	\N	\N
1001401	0	0	1	1	24	\N	\N
1001402	0	0	1	1	25	\N	\N
1001403	0	0	1	1	26	\N	\N
1001404	0	0	1	1	27	\N	\N
1001479	0	0	1	2	22	\N	\N
1001480	0	0	1	2	23	\N	\N
1001482	0	0	1	2	25	\N	\N
1001483	0	0	1	2	26	\N	\N
1001484	0	0	1	2	27	\N	\N
1001559	0	0	1	3	22	\N	\N
1001560	0	0	1	3	23	\N	\N
1001561	0	0	1	3	24	\N	\N
1001562	0	0	1	3	25	\N	\N
1001563	0	0	1	3	26	\N	\N
1001564	0	0	1	3	27	\N	\N
1001639	0	0	1	4	22	\N	\N
1001640	0	0	1	4	23	\N	\N
1001643	0	0	1	4	26	\N	\N
1001644	0	0	1	4	27	\N	\N
1001481	0	0	1	2	24	Western Airlock	null
1001641	0	0	1	4	24	null	null
1001642	0	0	1	4	25	null	null
1004924	0	0	1	45	27	\N	\N
1005001	0	0	1	46	24	\N	\N
1005002	0	0	1	46	25	\N	\N
1005003	0	0	1	46	26	\N	\N
1005004	0	0	1	46	27	\N	\N
1005081	0	0	1	47	24	\N	\N
1005082	0	0	1	47	25	\N	\N
1005083	0	0	1	47	26	\N	\N
1005084	0	0	1	47	27	\N	\N
1005161	0	0	1	48	24	\N	\N
1005162	0	0	1	48	25	\N	\N
1005163	0	0	1	48	26	\N	\N
1005164	0	0	1	48	27	\N	\N
1005241	0	0	1	49	24	\N	\N
1005242	0	0	1	49	25	\N	\N
1005243	0	0	1	49	26	\N	\N
1005244	0	0	1	49	27	\N	\N
1005321	0	0	1	50	24	\N	\N
1005322	0	0	1	50	25	\N	\N
1005323	0	0	1	50	26	\N	\N
1005324	0	0	1	50	27	\N	\N
1005401	0	0	1	51	24	\N	\N
1005402	0	0	1	51	25	\N	\N
1005403	0	0	1	51	26	\N	\N
1005404	0	0	1	51	27	\N	\N
1005481	0	0	1	52	24	\N	\N
1005482	0	0	1	52	25	\N	\N
1005483	0	0	1	52	26	\N	\N
1005484	0	0	1	52	27	\N	\N
1005561	0	0	1	53	24	\N	\N
1005562	0	0	1	53	25	\N	\N
1005563	0	0	1	53	26	\N	\N
1005564	0	0	1	53	27	\N	\N
1005641	0	0	1	54	24	\N	\N
1005642	0	0	1	54	25	\N	\N
1005643	0	0	1	54	26	\N	\N
1005644	0	0	1	54	27	\N	\N
1005721	0	0	1	55	24	\N	\N
1005722	0	0	1	55	25	\N	\N
1005723	0	0	1	55	26	\N	\N
1005724	0	0	1	55	27	\N	\N
1005801	0	0	1	56	24	\N	\N
1005802	0	0	1	56	25	\N	\N
1005803	0	0	1	56	26	\N	\N
1005804	0	0	1	56	27	\N	\N
1005881	0	0	1	57	24	\N	\N
1005882	0	0	1	57	25	\N	\N
1005883	0	0	1	57	26	\N	\N
1005884	0	0	1	57	27	\N	\N
1005961	0	0	1	58	24	\N	\N
1005962	0	0	1	58	25	\N	\N
1005963	0	0	1	58	26	\N	\N
1005964	0	0	1	58	27	\N	\N
1006041	0	0	1	59	24	\N	\N
1006042	0	0	1	59	25	\N	\N
1006043	0	0	1	59	26	\N	\N
1006044	0	0	1	59	27	\N	\N
1006121	0	0	1	60	24	\N	\N
1006122	0	0	1	60	25	\N	\N
1006123	0	0	1	60	26	\N	\N
1006124	0	0	1	60	27	\N	\N
1006201	0	0	1	61	24	\N	\N
1006202	0	0	1	61	25	\N	\N
1006203	0	0	1	61	26	\N	\N
1006204	0	0	1	61	27	\N	\N
1006281	0	0	1	62	24	\N	\N
1006282	0	0	1	62	25	\N	\N
1006283	0	0	1	62	26	\N	\N
1006284	0	0	1	62	27	\N	\N
1006361	0	0	1	63	24	\N	\N
1006362	0	0	1	63	25	\N	\N
1006363	0	0	1	63	26	\N	\N
1006364	0	0	1	63	27	\N	\N
1004922	0	0	1	45	25	null	null
1004923	0	0	1	45	26	null	null
1004984	0	0	1	46	7	\N	\N
1004985	0	0	1	46	8	\N	\N
1004986	0	0	1	46	9	\N	\N
1004987	0	0	1	46	10	\N	\N
1004988	0	0	1	46	11	\N	\N
1004989	0	0	1	46	12	\N	\N
1004990	0	0	1	46	13	\N	\N
1004991	0	0	1	46	14	\N	\N
1004992	0	0	1	46	15	\N	\N
1004993	0	0	1	46	16	\N	\N
1004994	0	0	1	46	17	\N	\N
1004995	0	0	1	46	18	\N	\N
1004996	0	0	1	46	19	\N	\N
1004997	0	0	1	46	20	\N	\N
1004998	0	0	1	46	21	\N	\N
1004999	0	0	1	46	22	\N	\N
1005000	0	0	1	46	23	\N	\N
1005064	0	0	1	47	7	\N	\N
1005065	0	0	1	47	8	\N	\N
1005066	0	0	1	47	9	\N	\N
1005067	0	0	1	47	10	\N	\N
1005068	0	0	1	47	11	\N	\N
1005069	0	0	1	47	12	\N	\N
1005070	0	0	1	47	13	\N	\N
1005071	0	0	1	47	14	\N	\N
1005072	0	0	1	47	15	\N	\N
1005073	0	0	1	47	16	\N	\N
1005074	0	0	1	47	17	\N	\N
1005075	0	0	1	47	18	\N	\N
1005076	0	0	1	47	19	\N	\N
1005077	0	0	1	47	20	\N	\N
1005078	0	0	1	47	21	\N	\N
1005079	0	0	1	47	22	\N	\N
1005080	0	0	1	47	23	\N	\N
1005144	0	0	1	48	7	\N	\N
1005145	0	0	1	48	8	\N	\N
1005146	0	0	1	48	9	\N	\N
1005147	0	0	1	48	10	\N	\N
1005148	0	0	1	48	11	\N	\N
1005149	0	0	1	48	12	\N	\N
1005150	0	0	1	48	13	\N	\N
1005151	0	0	1	48	14	\N	\N
1005152	0	0	1	48	15	\N	\N
1005153	0	0	1	48	16	\N	\N
1005154	0	0	1	48	17	\N	\N
1005155	0	0	1	48	18	\N	\N
1005156	0	0	1	48	19	\N	\N
1005157	0	0	1	48	20	\N	\N
1005158	0	0	1	48	21	\N	\N
1005159	0	0	1	48	22	\N	\N
1005160	0	0	1	48	23	\N	\N
1005224	0	0	1	49	7	\N	\N
1005225	0	0	1	49	8	\N	\N
1005226	0	0	1	49	9	\N	\N
1005227	0	0	1	49	10	\N	\N
1005228	0	0	1	49	11	\N	\N
1005229	0	0	1	49	12	\N	\N
1005230	0	0	1	49	13	\N	\N
1005231	0	0	1	49	14	\N	\N
1005232	0	0	1	49	15	\N	\N
1005233	0	0	1	49	16	\N	\N
1005234	0	0	1	49	17	\N	\N
1005235	0	0	1	49	18	\N	\N
1005236	0	0	1	49	19	\N	\N
1005237	0	0	1	49	20	\N	\N
1005238	0	0	1	49	21	\N	\N
1005239	0	0	1	49	22	\N	\N
1005240	0	0	1	49	23	\N	\N
1005304	0	0	1	50	7	\N	\N
1005305	0	0	1	50	8	\N	\N
1005306	0	0	1	50	9	\N	\N
1005307	0	0	1	50	10	\N	\N
1005308	0	0	1	50	11	\N	\N
1005309	0	0	1	50	12	\N	\N
1005310	0	0	1	50	13	\N	\N
1005311	0	0	1	50	14	\N	\N
1005312	0	0	1	50	15	\N	\N
1005313	0	0	1	50	16	\N	\N
1005314	0	0	1	50	17	\N	\N
1005315	0	0	1	50	18	\N	\N
1005316	0	0	1	50	19	\N	\N
1005317	0	0	1	50	20	\N	\N
1005318	0	0	1	50	21	\N	\N
1005319	0	0	1	50	22	\N	\N
1005320	0	0	1	50	23	\N	\N
1005384	0	0	1	51	7	\N	\N
1005385	0	0	1	51	8	\N	\N
1005386	0	0	1	51	9	\N	\N
1005387	0	0	1	51	10	\N	\N
1005388	0	0	1	51	11	\N	\N
1005389	0	0	1	51	12	\N	\N
1005390	0	0	1	51	13	\N	\N
1005391	0	0	1	51	14	\N	\N
1005392	0	0	1	51	15	\N	\N
1005393	0	0	1	51	16	\N	\N
1005394	0	0	1	51	17	\N	\N
1005395	0	0	1	51	18	\N	\N
1005396	0	0	1	51	19	\N	\N
1005397	0	0	1	51	20	\N	\N
1005398	0	0	1	51	21	\N	\N
1005399	0	0	1	51	22	\N	\N
1005400	0	0	1	51	23	\N	\N
1005464	0	0	1	52	7	\N	\N
1005465	0	0	1	52	8	\N	\N
1005466	0	0	1	52	9	\N	\N
1005467	0	0	1	52	10	\N	\N
1005468	0	0	1	52	11	\N	\N
1005469	0	0	1	52	12	\N	\N
1005470	0	0	1	52	13	\N	\N
1005471	0	0	1	52	14	\N	\N
1005472	0	0	1	52	15	\N	\N
1005473	0	0	1	52	16	\N	\N
1005474	0	0	1	52	17	\N	\N
1005475	0	0	1	52	18	\N	\N
1005476	0	0	1	52	19	\N	\N
1005477	0	0	1	52	20	\N	\N
1005478	0	0	1	52	21	\N	\N
1005479	0	0	1	52	22	\N	\N
1005480	0	0	1	52	23	\N	\N
1005544	0	0	1	53	7	\N	\N
1005545	0	0	1	53	8	\N	\N
1005546	0	0	1	53	9	\N	\N
1005547	0	0	1	53	10	\N	\N
1005548	0	0	1	53	11	\N	\N
1005549	0	0	1	53	12	\N	\N
1005550	0	0	1	53	13	\N	\N
1005551	0	0	1	53	14	\N	\N
1005552	0	0	1	53	15	\N	\N
1005553	0	0	1	53	16	\N	\N
1005554	0	0	1	53	17	\N	\N
1005555	0	0	1	53	18	\N	\N
1005556	0	0	1	53	19	\N	\N
1005557	0	0	1	53	20	\N	\N
1005558	0	0	1	53	21	\N	\N
1005559	0	0	1	53	22	\N	\N
1005560	0	0	1	53	23	\N	\N
1005624	0	0	1	54	7	\N	\N
1005625	0	0	1	54	8	\N	\N
1005626	0	0	1	54	9	\N	\N
1005627	0	0	1	54	10	\N	\N
1005628	0	0	1	54	11	\N	\N
1005629	0	0	1	54	12	\N	\N
1005630	0	0	1	54	13	\N	\N
1005631	0	0	1	54	14	\N	\N
1005632	0	0	1	54	15	\N	\N
1005633	0	0	1	54	16	\N	\N
1005634	0	0	1	54	17	\N	\N
1005635	0	0	1	54	18	\N	\N
1005636	0	0	1	54	19	\N	\N
1005637	0	0	1	54	20	\N	\N
1005638	0	0	1	54	21	\N	\N
1005639	0	0	1	54	22	\N	\N
1005640	0	0	1	54	23	\N	\N
1005704	0	0	1	55	7	\N	\N
1005705	0	0	1	55	8	\N	\N
1005706	0	0	1	55	9	\N	\N
1005707	0	0	1	55	10	\N	\N
1005708	0	0	1	55	11	\N	\N
1005709	0	0	1	55	12	\N	\N
1005710	0	0	1	55	13	\N	\N
1005711	0	0	1	55	14	\N	\N
1005712	0	0	1	55	15	\N	\N
1005713	0	0	1	55	16	\N	\N
1005714	0	0	1	55	17	\N	\N
1005715	0	0	1	55	18	\N	\N
1005716	0	0	1	55	19	\N	\N
1005717	0	0	1	55	20	\N	\N
1005718	0	0	1	55	21	\N	\N
1005719	0	0	1	55	22	\N	\N
1005720	0	0	1	55	23	\N	\N
1005784	0	0	1	56	7	\N	\N
1005785	0	0	1	56	8	\N	\N
1005786	0	0	1	56	9	\N	\N
1005787	0	0	1	56	10	\N	\N
1005788	0	0	1	56	11	\N	\N
1005789	0	0	1	56	12	\N	\N
1005790	0	0	1	56	13	\N	\N
1005791	0	0	1	56	14	\N	\N
1005792	0	0	1	56	15	\N	\N
1005793	0	0	1	56	16	\N	\N
1005794	0	0	1	56	17	\N	\N
1005795	0	0	1	56	18	\N	\N
1005796	0	0	1	56	19	\N	\N
1005797	0	0	1	56	20	\N	\N
1005798	0	0	1	56	21	\N	\N
1005799	0	0	1	56	22	\N	\N
1005800	0	0	1	56	23	\N	\N
1005864	0	0	1	57	7	\N	\N
1005865	0	0	1	57	8	\N	\N
1005866	0	0	1	57	9	\N	\N
1005867	0	0	1	57	10	\N	\N
1005868	0	0	1	57	11	\N	\N
1005869	0	0	1	57	12	\N	\N
1005870	0	0	1	57	13	\N	\N
1005871	0	0	1	57	14	\N	\N
1005872	0	0	1	57	15	\N	\N
1005873	0	0	1	57	16	\N	\N
1005874	0	0	1	57	17	\N	\N
1005875	0	0	1	57	18	\N	\N
1005876	0	0	1	57	19	\N	\N
1005877	0	0	1	57	20	\N	\N
1005878	0	0	1	57	21	\N	\N
1005879	0	0	1	57	22	\N	\N
1005880	0	0	1	57	23	\N	\N
1005944	0	0	1	58	7	\N	\N
1005945	0	0	1	58	8	\N	\N
1005946	0	0	1	58	9	\N	\N
1005947	0	0	1	58	10	\N	\N
1005948	0	0	1	58	11	\N	\N
1005949	0	0	1	58	12	\N	\N
1005950	0	0	1	58	13	\N	\N
1005951	0	0	1	58	14	\N	\N
1005952	0	0	1	58	15	\N	\N
1005953	0	0	1	58	16	\N	\N
1005954	0	0	1	58	17	\N	\N
1005955	0	0	1	58	18	\N	\N
1005956	0	0	1	58	19	\N	\N
1005957	0	0	1	58	20	\N	\N
1005958	0	0	1	58	21	\N	\N
1005959	0	0	1	58	22	\N	\N
1005960	0	0	1	58	23	\N	\N
1006024	0	0	1	59	7	\N	\N
1006025	0	0	1	59	8	\N	\N
1006026	0	0	1	59	9	\N	\N
1006027	0	0	1	59	10	\N	\N
1006028	0	0	1	59	11	\N	\N
1006029	0	0	1	59	12	\N	\N
1006030	0	0	1	59	13	\N	\N
1006031	0	0	1	59	14	\N	\N
1006032	0	0	1	59	15	\N	\N
1006033	0	0	1	59	16	\N	\N
1006034	0	0	1	59	17	\N	\N
1006035	0	0	1	59	18	\N	\N
1006036	0	0	1	59	19	\N	\N
1006037	0	0	1	59	20	\N	\N
1006038	0	0	1	59	21	\N	\N
1006039	0	0	1	59	22	\N	\N
1006040	0	0	1	59	23	\N	\N
1006104	0	0	1	60	7	\N	\N
1006105	0	0	1	60	8	\N	\N
1006106	0	0	1	60	9	\N	\N
1006107	0	0	1	60	10	\N	\N
1006108	0	0	1	60	11	\N	\N
1006109	0	0	1	60	12	\N	\N
1006110	0	0	1	60	13	\N	\N
1006111	0	0	1	60	14	\N	\N
1006112	0	0	1	60	15	\N	\N
1006113	0	0	1	60	16	\N	\N
1006114	0	0	1	60	17	\N	\N
1006115	0	0	1	60	18	\N	\N
1006116	0	0	1	60	19	\N	\N
1006117	0	0	1	60	20	\N	\N
1006118	0	0	1	60	21	\N	\N
1006119	0	0	1	60	22	\N	\N
1006120	0	0	1	60	23	\N	\N
1006184	0	0	1	61	7	\N	\N
1006185	0	0	1	61	8	\N	\N
1006186	0	0	1	61	9	\N	\N
1006187	0	0	1	61	10	\N	\N
1006188	0	0	1	61	11	\N	\N
1006189	0	0	1	61	12	\N	\N
1006190	0	0	1	61	13	\N	\N
1006191	0	0	1	61	14	\N	\N
1006192	0	0	1	61	15	\N	\N
1006193	0	0	1	61	16	\N	\N
1006194	0	0	1	61	17	\N	\N
1006195	0	0	1	61	18	\N	\N
1006196	0	0	1	61	19	\N	\N
1006197	0	0	1	61	20	\N	\N
1006198	0	0	1	61	21	\N	\N
1006199	0	0	1	61	22	\N	\N
1006200	0	0	1	61	23	\N	\N
1006264	0	0	1	62	7	\N	\N
1006265	0	0	1	62	8	\N	\N
1006266	0	0	1	62	9	\N	\N
1006267	0	0	1	62	10	\N	\N
1006268	0	0	1	62	11	\N	\N
1006269	0	0	1	62	12	\N	\N
1006270	0	0	1	62	13	\N	\N
1006271	0	0	1	62	14	\N	\N
1006272	0	0	1	62	15	\N	\N
1006273	0	0	1	62	16	\N	\N
1006274	0	0	1	62	17	\N	\N
1006275	0	0	1	62	18	\N	\N
1006276	0	0	1	62	19	\N	\N
1006277	0	0	1	62	20	\N	\N
1006278	0	0	1	62	21	\N	\N
1006279	0	0	1	62	22	\N	\N
1006280	0	0	1	62	23	\N	\N
1006344	0	0	1	63	7	\N	\N
1006345	0	0	1	63	8	\N	\N
1006346	0	0	1	63	9	\N	\N
1006347	0	0	1	63	10	\N	\N
1006348	0	0	1	63	11	\N	\N
1006349	0	0	1	63	12	\N	\N
1006350	0	0	1	63	13	\N	\N
1006351	0	0	1	63	14	\N	\N
1006352	0	0	1	63	15	\N	\N
1006353	0	0	1	63	16	\N	\N
1006354	0	0	1	63	17	\N	\N
1006355	0	0	1	63	18	\N	\N
1006356	0	0	1	63	19	\N	\N
1006357	0	0	1	63	20	\N	\N
1006358	0	0	1	63	21	\N	\N
1006359	0	0	1	63	22	\N	\N
1006360	0	0	1	63	23	\N	\N
1006520	0	0	1	45	20	\N	\N
1006534	0	0	1	45	21	\N	\N
1006550	0	0	1	45	22	\N	\N
1006601	0	0	1	45	24	\N	\N
1006606	0	0	1	45	23	\N	\N
1006741	0	0	1	45	10	\N	\N
1006746	0	0	1	45	11	\N	\N
1006751	0	0	1	45	12	\N	\N
1006756	0	0	1	45	13	\N	\N
1006761	0	0	1	45	14	\N	\N
1006766	0	0	1	45	15	\N	\N
1006771	0	0	1	45	16	\N	\N
1006776	0	0	1	45	17	\N	\N
1006780	0	0	1	45	18	\N	\N
1006785	0	0	1	45	19	\N	\N
1006819	0	0	1	45	7	\N	\N
1006825	0	0	1	45	8	\N	\N
1006831	0	0	1	45	9	\N	\N
1003102	0	0	1	22	45	\N	\N
1003103	0	0	1	22	46	\N	\N
1003104	0	0	1	22	47	\N	\N
1003105	0	0	1	22	48	\N	\N
1003106	0	0	1	22	49	\N	\N
1003107	0	0	1	22	50	\N	\N
1003108	0	0	1	22	51	\N	\N
1003109	0	0	1	22	52	\N	\N
1003110	0	0	1	22	53	\N	\N
1003111	0	0	1	22	54	\N	\N
1003112	0	0	1	22	55	\N	\N
1003113	0	0	1	22	56	\N	\N
1003114	0	0	1	22	57	\N	\N
1003115	0	0	1	22	58	\N	\N
1003116	0	0	1	22	59	\N	\N
1003117	0	0	1	22	60	\N	\N
1003118	0	0	1	22	61	\N	\N
1003119	0	0	1	22	62	\N	\N
1003120	0	0	1	22	63	\N	\N
1003183	0	0	1	23	46	\N	\N
1003184	0	0	1	23	47	\N	\N
1003185	0	0	1	23	48	\N	\N
1003186	0	0	1	23	49	\N	\N
1003187	0	0	1	23	50	\N	\N
1003188	0	0	1	23	51	\N	\N
1003189	0	0	1	23	52	\N	\N
1003190	0	0	1	23	53	\N	\N
1003191	0	0	1	23	54	\N	\N
1003192	0	0	1	23	55	\N	\N
1003193	0	0	1	23	56	\N	\N
1003194	0	0	1	23	57	\N	\N
1003195	0	0	1	23	58	\N	\N
1003196	0	0	1	23	59	\N	\N
1003197	0	0	1	23	60	\N	\N
1003198	0	0	1	23	61	\N	\N
1003199	0	0	1	23	62	\N	\N
1003200	0	0	1	23	63	\N	\N
1003264	0	0	1	24	47	\N	\N
1003265	0	0	1	24	48	\N	\N
1003266	0	0	1	24	49	\N	\N
1003267	0	0	1	24	50	\N	\N
1003268	0	0	1	24	51	\N	\N
1003269	0	0	1	24	52	\N	\N
1003270	0	0	1	24	53	\N	\N
1003271	0	0	1	24	54	\N	\N
1003272	0	0	1	24	55	\N	\N
1003273	0	0	1	24	56	\N	\N
1003274	0	0	1	24	57	\N	\N
1003275	0	0	1	24	58	\N	\N
1003276	0	0	1	24	59	\N	\N
1003277	0	0	1	24	60	\N	\N
1003278	0	0	1	24	61	\N	\N
1003279	0	0	1	24	62	\N	\N
1003280	0	0	1	24	63	\N	\N
1003344	0	0	1	25	47	\N	\N
1003345	0	0	1	25	48	\N	\N
1003346	0	0	1	25	49	\N	\N
1003347	0	0	1	25	50	\N	\N
1003348	0	0	1	25	51	\N	\N
1003349	0	0	1	25	52	\N	\N
1003350	0	0	1	25	53	\N	\N
1003351	0	0	1	25	54	\N	\N
1003352	0	0	1	25	55	\N	\N
1003353	0	0	1	25	56	\N	\N
1003354	0	0	1	25	57	\N	\N
1003355	0	0	1	25	58	\N	\N
1003356	0	0	1	25	59	\N	\N
1003357	0	0	1	25	60	\N	\N
1003358	0	0	1	25	61	\N	\N
1003359	0	0	1	25	62	\N	\N
1003360	0	0	1	25	63	\N	\N
1003423	0	0	1	26	46	\N	\N
1003424	0	0	1	26	47	\N	\N
1003425	0	0	1	26	48	\N	\N
1003426	0	0	1	26	49	\N	\N
1003427	0	0	1	26	50	\N	\N
1003428	0	0	1	26	51	\N	\N
1003429	0	0	1	26	52	\N	\N
1003430	0	0	1	26	53	\N	\N
1003431	0	0	1	26	54	\N	\N
1003432	0	0	1	26	55	\N	\N
1003433	0	0	1	26	56	\N	\N
1003434	0	0	1	26	57	\N	\N
1003435	0	0	1	26	58	\N	\N
1003436	0	0	1	26	59	\N	\N
1003437	0	0	1	26	60	\N	\N
1003438	0	0	1	26	61	\N	\N
1003439	0	0	1	26	62	\N	\N
1003440	0	0	1	26	63	\N	\N
1003502	0	0	1	27	45	\N	\N
1003503	0	0	1	27	46	\N	\N
1003504	0	0	1	27	47	\N	\N
1003505	0	0	1	27	48	\N	\N
1003506	0	0	1	27	49	\N	\N
1003507	0	0	1	27	50	\N	\N
1003508	0	0	1	27	51	\N	\N
1003509	0	0	1	27	52	\N	\N
1003510	0	0	1	27	53	\N	\N
1003511	0	0	1	27	54	\N	\N
1003512	0	0	1	27	55	\N	\N
1003513	0	0	1	27	56	\N	\N
1003514	0	0	1	27	57	\N	\N
1003515	0	0	1	27	58	\N	\N
1003516	0	0	1	27	59	\N	\N
1003517	0	0	1	27	60	\N	\N
1003518	0	0	1	27	61	\N	\N
1003519	0	0	1	27	62	\N	\N
1003520	0	0	1	27	63	\N	\N
1003422	0	0	1	26	45	null	null
1003182	0	0	1	23	45	null	null
1003263	0	0	1	24	46		
1003343	0	0	1	25	46		
1003262	0	0	1	24	45		
1003342	0	0	1	25	45		
1002881	0	0	1	20	-16	\N	\N
1002882	0	0	1	20	-15	\N	\N
1002883	0	0	1	20	-14	\N	\N
1002884	0	0	1	20	-13	\N	\N
1002885	0	0	1	20	-12	\N	\N
1002886	0	0	1	20	-11	\N	\N
1002887	0	0	1	20	-10	\N	\N
1002888	0	0	1	20	-9	\N	\N
1002889	0	0	1	20	-8	\N	\N
1002890	0	0	1	20	-7	\N	\N
1002891	0	0	1	20	-6	\N	\N
1002892	0	0	1	20	-5	\N	\N
1002893	0	0	1	20	-4	\N	\N
1002894	0	0	1	20	-3	\N	\N
1002895	0	0	1	20	-2	\N	\N
1002896	0	0	1	20	-1	\N	\N
1002897	0	0	1	20	0	\N	\N
1002898	0	0	1	20	1	\N	\N
1002899	0	0	1	20	2	\N	\N
1002961	0	0	1	21	-16	\N	\N
1002962	0	0	1	21	-15	\N	\N
1002963	0	0	1	21	-14	\N	\N
1002964	0	0	1	21	-13	\N	\N
1002965	0	0	1	21	-12	\N	\N
1002966	0	0	1	21	-11	\N	\N
1002967	0	0	1	21	-10	\N	\N
1002968	0	0	1	21	-9	\N	\N
1002969	0	0	1	21	-8	\N	\N
1002970	0	0	1	21	-7	\N	\N
1002971	0	0	1	21	-6	\N	\N
1002972	0	0	1	21	-5	\N	\N
1002973	0	0	1	21	-4	\N	\N
1002974	0	0	1	21	-3	\N	\N
1002975	0	0	1	21	-2	\N	\N
1002976	0	0	1	21	-1	\N	\N
1002977	0	0	1	21	0	\N	\N
1002978	0	0	1	21	1	\N	\N
1002979	0	0	1	21	2	\N	\N
1003041	0	0	1	22	-16	\N	\N
1003042	0	0	1	22	-15	\N	\N
1003043	0	0	1	22	-14	\N	\N
1003044	0	0	1	22	-13	\N	\N
1003045	0	0	1	22	-12	\N	\N
1003046	0	0	1	22	-11	\N	\N
1003047	0	0	1	22	-10	\N	\N
1003048	0	0	1	22	-9	\N	\N
1003049	0	0	1	22	-8	\N	\N
1003050	0	0	1	22	-7	\N	\N
1003051	0	0	1	22	-6	\N	\N
1003052	0	0	1	22	-5	\N	\N
1003053	0	0	1	22	-4	\N	\N
1003054	0	0	1	22	-3	\N	\N
1003055	0	0	1	22	-2	\N	\N
1003056	0	0	1	22	-1	\N	\N
1003057	0	0	1	22	0	\N	\N
1003058	0	0	1	22	1	\N	\N
1003059	0	0	1	22	2	\N	\N
1003121	0	0	1	23	-16	\N	\N
1003122	0	0	1	23	-15	\N	\N
1003123	0	0	1	23	-14	\N	\N
1003124	0	0	1	23	-13	\N	\N
1003125	0	0	1	23	-12	\N	\N
1003126	0	0	1	23	-11	\N	\N
1003127	0	0	1	23	-10	\N	\N
1003128	0	0	1	23	-9	\N	\N
1003129	0	0	1	23	-8	\N	\N
1003130	0	0	1	23	-7	\N	\N
1003131	0	0	1	23	-6	\N	\N
1003132	0	0	1	23	-5	\N	\N
1003133	0	0	1	23	-4	\N	\N
1003134	0	0	1	23	-3	\N	\N
1003135	0	0	1	23	-2	\N	\N
1003136	0	0	1	23	-1	\N	\N
1003137	0	0	1	23	0	\N	\N
1003138	0	0	1	23	1	\N	\N
1003139	0	0	1	23	2	\N	\N
1003201	0	0	1	24	-16	\N	\N
1003202	0	0	1	24	-15	\N	\N
1003203	0	0	1	24	-14	\N	\N
1003204	0	0	1	24	-13	\N	\N
1003205	0	0	1	24	-12	\N	\N
1003206	0	0	1	24	-11	\N	\N
1003207	0	0	1	24	-10	\N	\N
1003208	0	0	1	24	-9	\N	\N
1003209	0	0	1	24	-8	\N	\N
1003210	0	0	1	24	-7	\N	\N
1003211	0	0	1	24	-6	\N	\N
1003212	0	0	1	24	-5	\N	\N
1003213	0	0	1	24	-4	\N	\N
1003214	0	0	1	24	-3	\N	\N
1003215	0	0	1	24	-2	\N	\N
1003216	0	0	1	24	-1	\N	\N
1003217	0	0	1	24	0	\N	\N
1003218	0	0	1	24	1	\N	\N
1003281	0	0	1	25	-16	\N	\N
1003282	0	0	1	25	-15	\N	\N
1003283	0	0	1	25	-14	\N	\N
1003284	0	0	1	25	-13	\N	\N
1003285	0	0	1	25	-12	\N	\N
1003286	0	0	1	25	-11	\N	\N
1003287	0	0	1	25	-10	\N	\N
1003288	0	0	1	25	-9	\N	\N
1003289	0	0	1	25	-8	\N	\N
1003290	0	0	1	25	-7	\N	\N
1003291	0	0	1	25	-6	\N	\N
1003292	0	0	1	25	-5	\N	\N
1003293	0	0	1	25	-4	\N	\N
1003294	0	0	1	25	-3	\N	\N
1003295	0	0	1	25	-2	\N	\N
1003296	0	0	1	25	-1	\N	\N
1003297	0	0	1	25	0	\N	\N
1003298	0	0	1	25	1	\N	\N
1003299	0	0	1	25	2	\N	\N
1003221	0	0	1	24	4		North-South Axis
1003300	0	0	1	25	3	null	null
1003220	0	0	1	24	3	North-South Axis	North-South Axis
1003219	0	0	1	24	2	North Airlock	North Airlock
1003141	0	0	1	23	4	null	null
1002081	0	0	1	10	-16	\N	\N
1002082	0	0	1	10	-15	\N	\N
1002083	0	0	1	10	-14	\N	\N
1002084	0	0	1	10	-13	\N	\N
1002085	0	0	1	10	-12	\N	\N
1002086	0	0	1	10	-11	\N	\N
1002087	0	0	1	10	-10	\N	\N
1002088	0	0	1	10	-9	\N	\N
1002089	0	0	1	10	-8	\N	\N
1002090	0	0	1	10	-7	\N	\N
1002091	0	0	1	10	-6	\N	\N
1002092	0	0	1	10	-5	\N	\N
1002093	0	0	1	10	-4	\N	\N
1002094	0	0	1	10	-3	\N	\N
1002095	0	0	1	10	-2	\N	\N
1002096	0	0	1	10	-1	\N	\N
1002097	0	0	1	10	0	\N	\N
1002098	0	0	1	10	1	\N	\N
1002099	0	0	1	10	2	\N	\N
1002100	0	0	1	10	3	\N	\N
1002101	0	0	1	10	4	\N	\N
1002161	0	0	1	11	-16	\N	\N
1002162	0	0	1	11	-15	\N	\N
1002163	0	0	1	11	-14	\N	\N
1002164	0	0	1	11	-13	\N	\N
1002165	0	0	1	11	-12	\N	\N
1002166	0	0	1	11	-11	\N	\N
1002167	0	0	1	11	-10	\N	\N
1002168	0	0	1	11	-9	\N	\N
1002169	0	0	1	11	-8	\N	\N
1002170	0	0	1	11	-7	\N	\N
1002171	0	0	1	11	-6	\N	\N
1002172	0	0	1	11	-5	\N	\N
1002173	0	0	1	11	-4	\N	\N
1002174	0	0	1	11	-3	\N	\N
1002175	0	0	1	11	-2	\N	\N
1002176	0	0	1	11	-1	\N	\N
1002177	0	0	1	11	0	\N	\N
1002178	0	0	1	11	1	\N	\N
1002179	0	0	1	11	2	\N	\N
1002180	0	0	1	11	3	\N	\N
1002181	0	0	1	11	4	\N	\N
1002241	0	0	1	12	-16	\N	\N
1002242	0	0	1	12	-15	\N	\N
1002243	0	0	1	12	-14	\N	\N
1002244	0	0	1	12	-13	\N	\N
1002245	0	0	1	12	-12	\N	\N
1002246	0	0	1	12	-11	\N	\N
1002247	0	0	1	12	-10	\N	\N
1002248	0	0	1	12	-9	\N	\N
1002249	0	0	1	12	-8	\N	\N
1002250	0	0	1	12	-7	\N	\N
1002251	0	0	1	12	-6	\N	\N
1002252	0	0	1	12	-5	\N	\N
1002253	0	0	1	12	-4	\N	\N
1002254	0	0	1	12	-3	\N	\N
1002255	0	0	1	12	-2	\N	\N
1002256	0	0	1	12	-1	\N	\N
1002257	0	0	1	12	0	\N	\N
1002258	0	0	1	12	1	\N	\N
1002259	0	0	1	12	2	\N	\N
1002260	0	0	1	12	3	\N	\N
1002261	0	0	1	12	4	\N	\N
1002321	0	0	1	13	-16	\N	\N
1002322	0	0	1	13	-15	\N	\N
1002323	0	0	1	13	-14	\N	\N
1002324	0	0	1	13	-13	\N	\N
1002325	0	0	1	13	-12	\N	\N
1002326	0	0	1	13	-11	\N	\N
1002327	0	0	1	13	-10	\N	\N
1002328	0	0	1	13	-9	\N	\N
1002329	0	0	1	13	-8	\N	\N
1002330	0	0	1	13	-7	\N	\N
1002331	0	0	1	13	-6	\N	\N
1002332	0	0	1	13	-5	\N	\N
1002333	0	0	1	13	-4	\N	\N
1002334	0	0	1	13	-3	\N	\N
1002335	0	0	1	13	-2	\N	\N
1002336	0	0	1	13	-1	\N	\N
1002337	0	0	1	13	0	\N	\N
1002338	0	0	1	13	1	\N	\N
1002339	0	0	1	13	2	\N	\N
1002340	0	0	1	13	3	\N	\N
1002341	0	0	1	13	4	\N	\N
1002401	0	0	1	14	-16	\N	\N
1002402	0	0	1	14	-15	\N	\N
1002403	0	0	1	14	-14	\N	\N
1002404	0	0	1	14	-13	\N	\N
1002405	0	0	1	14	-12	\N	\N
1002406	0	0	1	14	-11	\N	\N
1002407	0	0	1	14	-10	\N	\N
1002408	0	0	1	14	-9	\N	\N
1002409	0	0	1	14	-8	\N	\N
1002410	0	0	1	14	-7	\N	\N
1002411	0	0	1	14	-6	\N	\N
1002412	0	0	1	14	-5	\N	\N
1002413	0	0	1	14	-4	\N	\N
1002414	0	0	1	14	-3	\N	\N
1002415	0	0	1	14	-2	\N	\N
1002416	0	0	1	14	-1	\N	\N
1002417	0	0	1	14	0	\N	\N
1002418	0	0	1	14	1	\N	\N
1002419	0	0	1	14	2	\N	\N
1002420	0	0	1	14	3	\N	\N
1002421	0	0	1	14	4	\N	\N
1002481	0	0	1	15	-16	\N	\N
1002482	0	0	1	15	-15	\N	\N
1002483	0	0	1	15	-14	\N	\N
1002484	0	0	1	15	-13	\N	\N
1002485	0	0	1	15	-12	\N	\N
1002486	0	0	1	15	-11	\N	\N
1002487	0	0	1	15	-10	\N	\N
1002488	0	0	1	15	-9	\N	\N
1002489	0	0	1	15	-8	\N	\N
1002490	0	0	1	15	-7	\N	\N
1002491	0	0	1	15	-6	\N	\N
1002492	0	0	1	15	-5	\N	\N
1002493	0	0	1	15	-4	\N	\N
1002494	0	0	1	15	-3	\N	\N
1002495	0	0	1	15	-2	\N	\N
1002496	0	0	1	15	-1	\N	\N
1002497	0	0	1	15	0	\N	\N
1002498	0	0	1	15	1	\N	\N
1002499	0	0	1	15	2	\N	\N
1002500	0	0	1	15	3	\N	\N
1002501	0	0	1	15	4	\N	\N
1002561	0	0	1	16	-16	\N	\N
1002562	0	0	1	16	-15	\N	\N
1002563	0	0	1	16	-14	\N	\N
1002564	0	0	1	16	-13	\N	\N
1002565	0	0	1	16	-12	\N	\N
1002566	0	0	1	16	-11	\N	\N
1002567	0	0	1	16	-10	\N	\N
1002568	0	0	1	16	-9	\N	\N
1002569	0	0	1	16	-8	\N	\N
1002570	0	0	1	16	-7	\N	\N
1002571	0	0	1	16	-6	\N	\N
1002572	0	0	1	16	-5	\N	\N
1002573	0	0	1	16	-4	\N	\N
1002574	0	0	1	16	-3	\N	\N
1002575	0	0	1	16	-2	\N	\N
1002576	0	0	1	16	-1	\N	\N
1002577	0	0	1	16	0	\N	\N
1002578	0	0	1	16	1	\N	\N
1002579	0	0	1	16	2	\N	\N
1002580	0	0	1	16	3	\N	\N
1002581	0	0	1	16	4	\N	\N
1002641	0	0	1	17	-16	\N	\N
1002642	0	0	1	17	-15	\N	\N
1002643	0	0	1	17	-14	\N	\N
1002644	0	0	1	17	-13	\N	\N
1002645	0	0	1	17	-12	\N	\N
1002646	0	0	1	17	-11	\N	\N
1002647	0	0	1	17	-10	\N	\N
1002648	0	0	1	17	-9	\N	\N
1002649	0	0	1	17	-8	\N	\N
1002650	0	0	1	17	-7	\N	\N
1002651	0	0	1	17	-6	\N	\N
1002652	0	0	1	17	-5	\N	\N
1002653	0	0	1	17	-4	\N	\N
1002654	0	0	1	17	-3	\N	\N
1002655	0	0	1	17	-2	\N	\N
1002656	0	0	1	17	-1	\N	\N
1002657	0	0	1	17	0	\N	\N
1002658	0	0	1	17	1	\N	\N
1002659	0	0	1	17	2	\N	\N
1002660	0	0	1	17	3	\N	\N
1002661	0	0	1	17	4	\N	\N
1002721	0	0	1	18	-16	\N	\N
1002722	0	0	1	18	-15	\N	\N
1002723	0	0	1	18	-14	\N	\N
1002724	0	0	1	18	-13	\N	\N
1002725	0	0	1	18	-12	\N	\N
1002726	0	0	1	18	-11	\N	\N
1002727	0	0	1	18	-10	\N	\N
1002728	0	0	1	18	-9	\N	\N
1002729	0	0	1	18	-8	\N	\N
1002730	0	0	1	18	-7	\N	\N
1002731	0	0	1	18	-6	\N	\N
1002732	0	0	1	18	-5	\N	\N
1002733	0	0	1	18	-4	\N	\N
1002734	0	0	1	18	-3	\N	\N
1002735	0	0	1	18	-2	\N	\N
1002736	0	0	1	18	-1	\N	\N
1002737	0	0	1	18	0	\N	\N
1002738	0	0	1	18	1	\N	\N
1002739	0	0	1	18	2	\N	\N
1002741	0	0	1	18	4	\N	\N
1002801	0	0	1	19	-16	\N	\N
1002802	0	0	1	19	-15	\N	\N
1002803	0	0	1	19	-14	\N	\N
1002804	0	0	1	19	-13	\N	\N
1002805	0	0	1	19	-12	\N	\N
1002806	0	0	1	19	-11	\N	\N
1002807	0	0	1	19	-10	\N	\N
1002808	0	0	1	19	-9	\N	\N
1002809	0	0	1	19	-8	\N	\N
1002810	0	0	1	19	-7	\N	\N
1002811	0	0	1	19	-6	\N	\N
1002812	0	0	1	19	-5	\N	\N
1002813	0	0	1	19	-4	\N	\N
1002814	0	0	1	19	-3	\N	\N
1002815	0	0	1	19	-2	\N	\N
1002816	0	0	1	19	-1	\N	\N
1002817	0	0	1	19	0	\N	\N
1002818	0	0	1	19	1	\N	\N
1002819	0	0	1	19	2	\N	\N
1002820	0	0	1	19	3	\N	\N
1002821	0	0	1	19	4	\N	\N
1002740	0	0	1	18	3	null	null
1001841	0	0	1	7	-16	\N	\N
1001842	0	0	1	7	-15	\N	\N
1001843	0	0	1	7	-14	\N	\N
1001844	0	0	1	7	-13	\N	\N
1001845	0	0	1	7	-12	\N	\N
1001846	0	0	1	7	-11	\N	\N
1001847	0	0	1	7	-10	\N	\N
1001848	0	0	1	7	-9	\N	\N
1001849	0	0	1	7	-8	\N	\N
1001850	0	0	1	7	-7	\N	\N
1001851	0	0	1	7	-6	\N	\N
1001852	0	0	1	7	-5	\N	\N
1001853	0	0	1	7	-4	\N	\N
1001854	0	0	1	7	-3	\N	\N
1001855	0	0	1	7	-2	\N	\N
1001856	0	0	1	7	-1	\N	\N
1001857	0	0	1	7	0	\N	\N
1001858	0	0	1	7	1	\N	\N
1001859	0	0	1	7	2	\N	\N
1001860	0	0	1	7	3	\N	\N
1001861	0	0	1	7	4	\N	\N
1001921	0	0	1	8	-16	\N	\N
1001922	0	0	1	8	-15	\N	\N
1001923	0	0	1	8	-14	\N	\N
1001924	0	0	1	8	-13	\N	\N
1001925	0	0	1	8	-12	\N	\N
1001926	0	0	1	8	-11	\N	\N
1001927	0	0	1	8	-10	\N	\N
1001928	0	0	1	8	-9	\N	\N
1001929	0	0	1	8	-8	\N	\N
1001930	0	0	1	8	-7	\N	\N
1001931	0	0	1	8	-6	\N	\N
1001932	0	0	1	8	-5	\N	\N
1001933	0	0	1	8	-4	\N	\N
1001934	0	0	1	8	-3	\N	\N
1001935	0	0	1	8	-2	\N	\N
1001936	0	0	1	8	-1	\N	\N
1001937	0	0	1	8	0	\N	\N
1001938	0	0	1	8	1	\N	\N
1001939	0	0	1	8	2	\N	\N
1001940	0	0	1	8	3	\N	\N
1001941	0	0	1	8	4	\N	\N
1002001	0	0	1	9	-16	\N	\N
1002002	0	0	1	9	-15	\N	\N
1002003	0	0	1	9	-14	\N	\N
1002004	0	0	1	9	-13	\N	\N
1002005	0	0	1	9	-12	\N	\N
1002006	0	0	1	9	-11	\N	\N
1002007	0	0	1	9	-10	\N	\N
1002008	0	0	1	9	-9	\N	\N
1002009	0	0	1	9	-8	\N	\N
1002010	0	0	1	9	-7	\N	\N
1002011	0	0	1	9	-6	\N	\N
1002012	0	0	1	9	-5	\N	\N
1002013	0	0	1	9	-4	\N	\N
1002014	0	0	1	9	-3	\N	\N
1002015	0	0	1	9	-2	\N	\N
1002016	0	0	1	9	-1	\N	\N
1002017	0	0	1	9	0	\N	\N
1002018	0	0	1	9	1	\N	\N
1002019	0	0	1	9	2	\N	\N
1002020	0	0	1	9	3	\N	\N
1002021	0	0	1	9	4	\N	\N
1003361	0	0	1	26	-16	\N	\N
1003362	0	0	1	26	-15	\N	\N
1003363	0	0	1	26	-14	\N	\N
1003364	0	0	1	26	-13	\N	\N
1003365	0	0	1	26	-12	\N	\N
1003366	0	0	1	26	-11	\N	\N
1003367	0	0	1	26	-10	\N	\N
1003368	0	0	1	26	-9	\N	\N
1003369	0	0	1	26	-8	\N	\N
1003370	0	0	1	26	-7	\N	\N
1003371	0	0	1	26	-6	\N	\N
1003372	0	0	1	26	-5	\N	\N
1003373	0	0	1	26	-4	\N	\N
1003374	0	0	1	26	-3	\N	\N
1003375	0	0	1	26	-2	\N	\N
1003376	0	0	1	26	-1	\N	\N
1003377	0	0	1	26	0	\N	\N
1003378	0	0	1	26	1	\N	\N
1003379	0	0	1	26	2	\N	\N
1003380	0	0	1	26	3	\N	\N
1003441	0	0	1	27	-16	\N	\N
1003442	0	0	1	27	-15	\N	\N
1003443	0	0	1	27	-14	\N	\N
1003444	0	0	1	27	-13	\N	\N
1003445	0	0	1	27	-12	\N	\N
1003446	0	0	1	27	-11	\N	\N
1003447	0	0	1	27	-10	\N	\N
1003448	0	0	1	27	-9	\N	\N
1003449	0	0	1	27	-8	\N	\N
1003450	0	0	1	27	-7	\N	\N
1003451	0	0	1	27	-6	\N	\N
1003452	0	0	1	27	-5	\N	\N
1003453	0	0	1	27	-4	\N	\N
1003454	0	0	1	27	-3	\N	\N
1003455	0	0	1	27	-2	\N	\N
1003456	0	0	1	27	-1	\N	\N
1003457	0	0	1	27	0	\N	\N
1003458	0	0	1	27	1	\N	\N
1003459	0	0	1	27	2	\N	\N
1003460	0	0	1	27	3	\N	\N
1006403	0	0	1	27	4	\N	\N
1006404	0	0	1	26	4	\N	\N
1006652	0	0	1	25	4	\N	\N
1003140	0	0	1	23	3	null	null
1003060	0	0	1	22	3	null	null
1003061	0	0	1	22	4	null	null
1002980	0	0	1	21	3	null	null
1002900	0	0	1	20	3	null	null
1002901	0	0	1	20	4	null	null
1002981	0	0	1	21	4	null	null
1006405	0	0	1	29	5	\N	\N
1006406	0	0	1	28	5	\N	\N
1006408	0	0	1	29	6	\N	\N
1006409	0	0	1	28	6	\N	\N
1006691	0	0	1	39	5	\N	\N
1006692	0	0	1	38	5	\N	\N
1006693	0	0	1	37	5	\N	\N
1006694	0	0	1	36	5	\N	\N
1006695	0	0	1	35	5	\N	\N
1006696	0	0	1	34	5	\N	\N
1006697	0	0	1	33	5	\N	\N
1006698	0	0	1	32	5	\N	\N
1006699	0	0	1	31	5	\N	\N
1006700	0	0	1	30	5	\N	\N
1006701	0	0	1	39	6	\N	\N
1006702	0	0	1	38	6	\N	\N
1006703	0	0	1	37	6	\N	\N
1006704	0	0	1	36	6	\N	\N
1006705	0	0	1	35	6	\N	\N
1006706	0	0	1	34	6	\N	\N
1006707	0	0	1	33	6	\N	\N
1006708	0	0	1	32	6	\N	\N
1006709	0	0	1	31	6	\N	\N
1006710	0	0	1	30	6	\N	\N
1006808	0	0	1	44	5	\N	\N
1006809	0	0	1	43	5	\N	\N
1006810	0	0	1	42	5	\N	\N
1006811	0	0	1	41	5	\N	\N
1006812	0	0	1	40	5	\N	\N
1006814	0	0	1	44	6	\N	\N
1006815	0	0	1	43	6	\N	\N
1006816	0	0	1	42	6	\N	\N
1006817	0	0	1	41	6	\N	\N
1006818	0	0	1	40	6	\N	\N
1004982	0	0	1	46	5	\N	\N
1004983	0	0	1	46	6	\N	\N
1005062	0	0	1	47	5	\N	\N
1005063	0	0	1	47	6	\N	\N
1005142	0	0	1	48	5	\N	\N
1005143	0	0	1	48	6	\N	\N
1005222	0	0	1	49	5	\N	\N
1005223	0	0	1	49	6	\N	\N
1005302	0	0	1	50	5	\N	\N
1005303	0	0	1	50	6	\N	\N
1005382	0	0	1	51	5	\N	\N
1005383	0	0	1	51	6	\N	\N
1005462	0	0	1	52	5	\N	\N
1005463	0	0	1	52	6	\N	\N
1005542	0	0	1	53	5	\N	\N
1005543	0	0	1	53	6	\N	\N
1005622	0	0	1	54	5	\N	\N
1005623	0	0	1	54	6	\N	\N
1005702	0	0	1	55	5	\N	\N
1005703	0	0	1	55	6	\N	\N
1005782	0	0	1	56	5	\N	\N
1005783	0	0	1	56	6	\N	\N
1005862	0	0	1	57	5	\N	\N
1005863	0	0	1	57	6	\N	\N
1005942	0	0	1	58	5	\N	\N
1005943	0	0	1	58	6	\N	\N
1006022	0	0	1	59	5	\N	\N
1006023	0	0	1	59	6	\N	\N
1006102	0	0	1	60	5	\N	\N
1006103	0	0	1	60	6	\N	\N
1006182	0	0	1	61	5	\N	\N
1006183	0	0	1	61	6	\N	\N
1006262	0	0	1	62	5	\N	\N
1006263	0	0	1	62	6	\N	\N
1006342	0	0	1	63	5	\N	\N
1006343	0	0	1	63	6	\N	\N
1006807	0	0	1	45	5	\N	\N
1006813	0	0	1	45	6	\N	\N
1003521	0	0	1	28	-16	\N	\N
1003522	0	0	1	28	-15	\N	\N
1003523	0	0	1	28	-14	\N	\N
1003524	0	0	1	28	-13	\N	\N
1003525	0	0	1	28	-12	\N	\N
1003526	0	0	1	28	-11	\N	\N
1003527	0	0	1	28	-10	\N	\N
1003528	0	0	1	28	-9	\N	\N
1003529	0	0	1	28	-8	\N	\N
1003530	0	0	1	28	-7	\N	\N
1003531	0	0	1	28	-6	\N	\N
1003532	0	0	1	28	-5	\N	\N
1003533	0	0	1	28	-4	\N	\N
1003534	0	0	1	28	-3	\N	\N
1003535	0	0	1	28	-2	\N	\N
1003536	0	0	1	28	-1	\N	\N
1003537	0	0	1	28	0	\N	\N
1003538	0	0	1	28	1	\N	\N
1003539	0	0	1	28	2	\N	\N
1003540	0	0	1	28	3	\N	\N
1003601	0	0	1	29	-16	\N	\N
1003602	0	0	1	29	-15	\N	\N
1003603	0	0	1	29	-14	\N	\N
1003604	0	0	1	29	-13	\N	\N
1003605	0	0	1	29	-12	\N	\N
1003606	0	0	1	29	-11	\N	\N
1003607	0	0	1	29	-10	\N	\N
1003608	0	0	1	29	-9	\N	\N
1003609	0	0	1	29	-8	\N	\N
1003610	0	0	1	29	-7	\N	\N
1003611	0	0	1	29	-6	\N	\N
1003612	0	0	1	29	-5	\N	\N
1003613	0	0	1	29	-4	\N	\N
1003614	0	0	1	29	-3	\N	\N
1003615	0	0	1	29	-2	\N	\N
1003616	0	0	1	29	-1	\N	\N
1003617	0	0	1	29	0	\N	\N
1003618	0	0	1	29	1	\N	\N
1003619	0	0	1	29	2	\N	\N
1003620	0	0	1	29	3	\N	\N
1003681	0	0	1	30	-16	\N	\N
1003682	0	0	1	30	-15	\N	\N
1003683	0	0	1	30	-14	\N	\N
1003684	0	0	1	30	-13	\N	\N
1003685	0	0	1	30	-12	\N	\N
1003686	0	0	1	30	-11	\N	\N
1003687	0	0	1	30	-10	\N	\N
1003688	0	0	1	30	-9	\N	\N
1003689	0	0	1	30	-8	\N	\N
1003690	0	0	1	30	-7	\N	\N
1003691	0	0	1	30	-6	\N	\N
1003692	0	0	1	30	-5	\N	\N
1003693	0	0	1	30	-4	\N	\N
1003694	0	0	1	30	-3	\N	\N
1003695	0	0	1	30	-2	\N	\N
1003696	0	0	1	30	-1	\N	\N
1003697	0	0	1	30	0	\N	\N
1003698	0	0	1	30	1	\N	\N
1003699	0	0	1	30	2	\N	\N
1003700	0	0	1	30	3	\N	\N
1003761	0	0	1	31	-16	\N	\N
1003762	0	0	1	31	-15	\N	\N
1003763	0	0	1	31	-14	\N	\N
1003764	0	0	1	31	-13	\N	\N
1003765	0	0	1	31	-12	\N	\N
1003766	0	0	1	31	-11	\N	\N
1003767	0	0	1	31	-10	\N	\N
1003768	0	0	1	31	-9	\N	\N
1003769	0	0	1	31	-8	\N	\N
1003770	0	0	1	31	-7	\N	\N
1003771	0	0	1	31	-6	\N	\N
1003772	0	0	1	31	-5	\N	\N
1003773	0	0	1	31	-4	\N	\N
1003774	0	0	1	31	-3	\N	\N
1003775	0	0	1	31	-2	\N	\N
1003776	0	0	1	31	-1	\N	\N
1003777	0	0	1	31	0	\N	\N
1003778	0	0	1	31	1	\N	\N
1003779	0	0	1	31	2	\N	\N
1003780	0	0	1	31	3	\N	\N
1003841	0	0	1	32	-16	\N	\N
1003842	0	0	1	32	-15	\N	\N
1003843	0	0	1	32	-14	\N	\N
1003844	0	0	1	32	-13	\N	\N
1003845	0	0	1	32	-12	\N	\N
1003846	0	0	1	32	-11	\N	\N
1003847	0	0	1	32	-10	\N	\N
1003848	0	0	1	32	-9	\N	\N
1003849	0	0	1	32	-8	\N	\N
1003850	0	0	1	32	-7	\N	\N
1003851	0	0	1	32	-6	\N	\N
1003852	0	0	1	32	-5	\N	\N
1003853	0	0	1	32	-4	\N	\N
1003854	0	0	1	32	-3	\N	\N
1003855	0	0	1	32	-2	\N	\N
1003856	0	0	1	32	-1	\N	\N
1003857	0	0	1	32	0	\N	\N
1003858	0	0	1	32	1	\N	\N
1003859	0	0	1	32	2	\N	\N
1003860	0	0	1	32	3	\N	\N
1003921	0	0	1	33	-16	\N	\N
1003922	0	0	1	33	-15	\N	\N
1003923	0	0	1	33	-14	\N	\N
1003924	0	0	1	33	-13	\N	\N
1003925	0	0	1	33	-12	\N	\N
1003926	0	0	1	33	-11	\N	\N
1003927	0	0	1	33	-10	\N	\N
1003928	0	0	1	33	-9	\N	\N
1003929	0	0	1	33	-8	\N	\N
1003930	0	0	1	33	-7	\N	\N
1003931	0	0	1	33	-6	\N	\N
1003932	0	0	1	33	-5	\N	\N
1003933	0	0	1	33	-4	\N	\N
1003934	0	0	1	33	-3	\N	\N
1003935	0	0	1	33	-2	\N	\N
1003936	0	0	1	33	-1	\N	\N
1003937	0	0	1	33	0	\N	\N
1003938	0	0	1	33	1	\N	\N
1003939	0	0	1	33	2	\N	\N
1003940	0	0	1	33	3	\N	\N
1004001	0	0	1	34	-16	\N	\N
1004002	0	0	1	34	-15	\N	\N
1004003	0	0	1	34	-14	\N	\N
1004004	0	0	1	34	-13	\N	\N
1004005	0	0	1	34	-12	\N	\N
1004006	0	0	1	34	-11	\N	\N
1004007	0	0	1	34	-10	\N	\N
1004008	0	0	1	34	-9	\N	\N
1004009	0	0	1	34	-8	\N	\N
1004010	0	0	1	34	-7	\N	\N
1004011	0	0	1	34	-6	\N	\N
1004012	0	0	1	34	-5	\N	\N
1004013	0	0	1	34	-4	\N	\N
1004014	0	0	1	34	-3	\N	\N
1004015	0	0	1	34	-2	\N	\N
1004016	0	0	1	34	-1	\N	\N
1004017	0	0	1	34	0	\N	\N
1004018	0	0	1	34	1	\N	\N
1004019	0	0	1	34	2	\N	\N
1004020	0	0	1	34	3	\N	\N
1004081	0	0	1	35	-16	\N	\N
1004082	0	0	1	35	-15	\N	\N
1004083	0	0	1	35	-14	\N	\N
1004084	0	0	1	35	-13	\N	\N
1004085	0	0	1	35	-12	\N	\N
1004086	0	0	1	35	-11	\N	\N
1004087	0	0	1	35	-10	\N	\N
1004088	0	0	1	35	-9	\N	\N
1004089	0	0	1	35	-8	\N	\N
1004090	0	0	1	35	-7	\N	\N
1004091	0	0	1	35	-6	\N	\N
1004092	0	0	1	35	-5	\N	\N
1004093	0	0	1	35	-4	\N	\N
1004094	0	0	1	35	-3	\N	\N
1004095	0	0	1	35	-2	\N	\N
1004096	0	0	1	35	-1	\N	\N
1004097	0	0	1	35	0	\N	\N
1004098	0	0	1	35	1	\N	\N
1004099	0	0	1	35	2	\N	\N
1004100	0	0	1	35	3	\N	\N
1004161	0	0	1	36	-16	\N	\N
1004162	0	0	1	36	-15	\N	\N
1004163	0	0	1	36	-14	\N	\N
1004164	0	0	1	36	-13	\N	\N
1004165	0	0	1	36	-12	\N	\N
1004166	0	0	1	36	-11	\N	\N
1004167	0	0	1	36	-10	\N	\N
1004168	0	0	1	36	-9	\N	\N
1004169	0	0	1	36	-8	\N	\N
1004170	0	0	1	36	-7	\N	\N
1004171	0	0	1	36	-6	\N	\N
1004172	0	0	1	36	-5	\N	\N
1004173	0	0	1	36	-4	\N	\N
1004174	0	0	1	36	-3	\N	\N
1004175	0	0	1	36	-2	\N	\N
1004176	0	0	1	36	-1	\N	\N
1004177	0	0	1	36	0	\N	\N
1004178	0	0	1	36	1	\N	\N
1004179	0	0	1	36	2	\N	\N
1004180	0	0	1	36	3	\N	\N
1004241	0	0	1	37	-16	\N	\N
1004242	0	0	1	37	-15	\N	\N
1004243	0	0	1	37	-14	\N	\N
1004244	0	0	1	37	-13	\N	\N
1004245	0	0	1	37	-12	\N	\N
1004246	0	0	1	37	-11	\N	\N
1004247	0	0	1	37	-10	\N	\N
1004248	0	0	1	37	-9	\N	\N
1004249	0	0	1	37	-8	\N	\N
1004250	0	0	1	37	-7	\N	\N
1004251	0	0	1	37	-6	\N	\N
1004252	0	0	1	37	-5	\N	\N
1004253	0	0	1	37	-4	\N	\N
1004254	0	0	1	37	-3	\N	\N
1004255	0	0	1	37	-2	\N	\N
1004256	0	0	1	37	-1	\N	\N
1004257	0	0	1	37	0	\N	\N
1004258	0	0	1	37	1	\N	\N
1004259	0	0	1	37	2	\N	\N
1004260	0	0	1	37	3	\N	\N
1004321	0	0	1	38	-16	\N	\N
1004322	0	0	1	38	-15	\N	\N
1004323	0	0	1	38	-14	\N	\N
1004324	0	0	1	38	-13	\N	\N
1004325	0	0	1	38	-12	\N	\N
1004326	0	0	1	38	-11	\N	\N
1004327	0	0	1	38	-10	\N	\N
1004328	0	0	1	38	-9	\N	\N
1004329	0	0	1	38	-8	\N	\N
1004330	0	0	1	38	-7	\N	\N
1004331	0	0	1	38	-6	\N	\N
1004332	0	0	1	38	-5	\N	\N
1004333	0	0	1	38	-4	\N	\N
1004334	0	0	1	38	-3	\N	\N
1004335	0	0	1	38	-2	\N	\N
1004336	0	0	1	38	-1	\N	\N
1004337	0	0	1	38	0	\N	\N
1004338	0	0	1	38	1	\N	\N
1004339	0	0	1	38	2	\N	\N
1004340	0	0	1	38	3	\N	\N
1004401	0	0	1	39	-16	\N	\N
1004402	0	0	1	39	-15	\N	\N
1004403	0	0	1	39	-14	\N	\N
1004404	0	0	1	39	-13	\N	\N
1004405	0	0	1	39	-12	\N	\N
1004406	0	0	1	39	-11	\N	\N
1004407	0	0	1	39	-10	\N	\N
1004408	0	0	1	39	-9	\N	\N
1004409	0	0	1	39	-8	\N	\N
1004410	0	0	1	39	-7	\N	\N
1004411	0	0	1	39	-6	\N	\N
1004412	0	0	1	39	-5	\N	\N
1004413	0	0	1	39	-4	\N	\N
1004414	0	0	1	39	-3	\N	\N
1004415	0	0	1	39	-2	\N	\N
1004416	0	0	1	39	-1	\N	\N
1004417	0	0	1	39	0	\N	\N
1004418	0	0	1	39	1	\N	\N
1004419	0	0	1	39	2	\N	\N
1004420	0	0	1	39	3	\N	\N
1004481	0	0	1	40	-16	\N	\N
1004482	0	0	1	40	-15	\N	\N
1004483	0	0	1	40	-14	\N	\N
1004484	0	0	1	40	-13	\N	\N
1004485	0	0	1	40	-12	\N	\N
1004486	0	0	1	40	-11	\N	\N
1004487	0	0	1	40	-10	\N	\N
1004488	0	0	1	40	-9	\N	\N
1004489	0	0	1	40	-8	\N	\N
1004490	0	0	1	40	-7	\N	\N
1004491	0	0	1	40	-6	\N	\N
1004492	0	0	1	40	-5	\N	\N
1004493	0	0	1	40	-4	\N	\N
1004494	0	0	1	40	-3	\N	\N
1004495	0	0	1	40	-2	\N	\N
1004496	0	0	1	40	-1	\N	\N
1004497	0	0	1	40	0	\N	\N
1004498	0	0	1	40	1	\N	\N
1004499	0	0	1	40	2	\N	\N
1004500	0	0	1	40	3	\N	\N
1004561	0	0	1	41	-16	\N	\N
1004562	0	0	1	41	-15	\N	\N
1004563	0	0	1	41	-14	\N	\N
1004564	0	0	1	41	-13	\N	\N
1004565	0	0	1	41	-12	\N	\N
1004566	0	0	1	41	-11	\N	\N
1004567	0	0	1	41	-10	\N	\N
1004568	0	0	1	41	-9	\N	\N
1004569	0	0	1	41	-8	\N	\N
1004570	0	0	1	41	-7	\N	\N
1004571	0	0	1	41	-6	\N	\N
1004572	0	0	1	41	-5	\N	\N
1004573	0	0	1	41	-4	\N	\N
1004574	0	0	1	41	-3	\N	\N
1004575	0	0	1	41	-2	\N	\N
1004576	0	0	1	41	-1	\N	\N
1004577	0	0	1	41	0	\N	\N
1004578	0	0	1	41	1	\N	\N
1004579	0	0	1	41	2	\N	\N
1004580	0	0	1	41	3	\N	\N
1004641	0	0	1	42	-16	\N	\N
1004642	0	0	1	42	-15	\N	\N
1004643	0	0	1	42	-14	\N	\N
1004644	0	0	1	42	-13	\N	\N
1004645	0	0	1	42	-12	\N	\N
1004646	0	0	1	42	-11	\N	\N
1004647	0	0	1	42	-10	\N	\N
1004648	0	0	1	42	-9	\N	\N
1004649	0	0	1	42	-8	\N	\N
1004650	0	0	1	42	-7	\N	\N
1004651	0	0	1	42	-6	\N	\N
1004652	0	0	1	42	-5	\N	\N
1004653	0	0	1	42	-4	\N	\N
1004654	0	0	1	42	-3	\N	\N
1004655	0	0	1	42	-2	\N	\N
1004656	0	0	1	42	-1	\N	\N
1004657	0	0	1	42	0	\N	\N
1004658	0	0	1	42	1	\N	\N
1004659	0	0	1	42	2	\N	\N
1004660	0	0	1	42	3	\N	\N
1004721	0	0	1	43	-16	\N	\N
1004722	0	0	1	43	-15	\N	\N
1004723	0	0	1	43	-14	\N	\N
1004724	0	0	1	43	-13	\N	\N
1004725	0	0	1	43	-12	\N	\N
1004726	0	0	1	43	-11	\N	\N
1004727	0	0	1	43	-10	\N	\N
1004728	0	0	1	43	-9	\N	\N
1004729	0	0	1	43	-8	\N	\N
1004730	0	0	1	43	-7	\N	\N
1004731	0	0	1	43	-6	\N	\N
1004732	0	0	1	43	-5	\N	\N
1004733	0	0	1	43	-4	\N	\N
1004734	0	0	1	43	-3	\N	\N
1004735	0	0	1	43	-2	\N	\N
1004736	0	0	1	43	-1	\N	\N
1004737	0	0	1	43	0	\N	\N
1004738	0	0	1	43	1	\N	\N
1004739	0	0	1	43	2	\N	\N
1004740	0	0	1	43	3	\N	\N
1004801	0	0	1	44	-16	\N	\N
1004802	0	0	1	44	-15	\N	\N
1004803	0	0	1	44	-14	\N	\N
1004804	0	0	1	44	-13	\N	\N
1004805	0	0	1	44	-12	\N	\N
1004806	0	0	1	44	-11	\N	\N
1004807	0	0	1	44	-10	\N	\N
1004808	0	0	1	44	-9	\N	\N
1004809	0	0	1	44	-8	\N	\N
1004810	0	0	1	44	-7	\N	\N
1004811	0	0	1	44	-6	\N	\N
1004812	0	0	1	44	-5	\N	\N
1004813	0	0	1	44	-4	\N	\N
1004814	0	0	1	44	-3	\N	\N
1004815	0	0	1	44	-2	\N	\N
1004816	0	0	1	44	-1	\N	\N
1004817	0	0	1	44	0	\N	\N
1004818	0	0	1	44	1	\N	\N
1004819	0	0	1	44	2	\N	\N
1004820	0	0	1	44	3	\N	\N
1006401	0	0	1	29	4	\N	\N
1006402	0	0	1	28	4	\N	\N
1006681	0	0	1	39	4	\N	\N
1006682	0	0	1	38	4	\N	\N
1006683	0	0	1	37	4	\N	\N
1006684	0	0	1	36	4	\N	\N
1006685	0	0	1	35	4	\N	\N
1006686	0	0	1	34	4	\N	\N
1006687	0	0	1	33	4	\N	\N
1006688	0	0	1	32	4	\N	\N
1006689	0	0	1	31	4	\N	\N
1006690	0	0	1	30	4	\N	\N
1006802	0	0	1	44	4	\N	\N
1006803	0	0	1	43	4	\N	\N
1006804	0	0	1	42	4	\N	\N
1006805	0	0	1	41	4	\N	\N
1006806	0	0	1	40	4	\N	\N
1004881	0	0	1	45	-16	\N	\N
1004882	0	0	1	45	-15	\N	\N
1004883	0	0	1	45	-14	\N	\N
1004884	0	0	1	45	-13	\N	\N
1004885	0	0	1	45	-12	\N	\N
1004886	0	0	1	45	-11	\N	\N
1004887	0	0	1	45	-10	\N	\N
1004888	0	0	1	45	-9	\N	\N
1004889	0	0	1	45	-8	\N	\N
1004890	0	0	1	45	-7	\N	\N
1004891	0	0	1	45	-6	\N	\N
1004892	0	0	1	45	-5	\N	\N
1004893	0	0	1	45	-4	\N	\N
1004894	0	0	1	45	-3	\N	\N
1004895	0	0	1	45	-2	\N	\N
1004896	0	0	1	45	-1	\N	\N
1004897	0	0	1	45	0	\N	\N
1004898	0	0	1	45	1	\N	\N
1004899	0	0	1	45	2	\N	\N
1004900	0	0	1	45	3	\N	\N
1004961	0	0	1	46	-16	\N	\N
1004962	0	0	1	46	-15	\N	\N
1004963	0	0	1	46	-14	\N	\N
1004964	0	0	1	46	-13	\N	\N
1004965	0	0	1	46	-12	\N	\N
1004966	0	0	1	46	-11	\N	\N
1004967	0	0	1	46	-10	\N	\N
1004968	0	0	1	46	-9	\N	\N
1004969	0	0	1	46	-8	\N	\N
1004970	0	0	1	46	-7	\N	\N
1004971	0	0	1	46	-6	\N	\N
1004972	0	0	1	46	-5	\N	\N
1004973	0	0	1	46	-4	\N	\N
1004974	0	0	1	46	-3	\N	\N
1004975	0	0	1	46	-2	\N	\N
1004976	0	0	1	46	-1	\N	\N
1004977	0	0	1	46	0	\N	\N
1004978	0	0	1	46	1	\N	\N
1004979	0	0	1	46	2	\N	\N
1004980	0	0	1	46	3	\N	\N
1004981	0	0	1	46	4	\N	\N
1005041	0	0	1	47	-16	\N	\N
1005042	0	0	1	47	-15	\N	\N
1005043	0	0	1	47	-14	\N	\N
1005044	0	0	1	47	-13	\N	\N
1005045	0	0	1	47	-12	\N	\N
1005046	0	0	1	47	-11	\N	\N
1005047	0	0	1	47	-10	\N	\N
1005048	0	0	1	47	-9	\N	\N
1005049	0	0	1	47	-8	\N	\N
1005050	0	0	1	47	-7	\N	\N
1005051	0	0	1	47	-6	\N	\N
1005052	0	0	1	47	-5	\N	\N
1005053	0	0	1	47	-4	\N	\N
1005054	0	0	1	47	-3	\N	\N
1005055	0	0	1	47	-2	\N	\N
1005056	0	0	1	47	-1	\N	\N
1005057	0	0	1	47	0	\N	\N
1005058	0	0	1	47	1	\N	\N
1005059	0	0	1	47	2	\N	\N
1005060	0	0	1	47	3	\N	\N
1005061	0	0	1	47	4	\N	\N
1005121	0	0	1	48	-16	\N	\N
1005122	0	0	1	48	-15	\N	\N
1005123	0	0	1	48	-14	\N	\N
1005124	0	0	1	48	-13	\N	\N
1005125	0	0	1	48	-12	\N	\N
1005126	0	0	1	48	-11	\N	\N
1005127	0	0	1	48	-10	\N	\N
1005128	0	0	1	48	-9	\N	\N
1005129	0	0	1	48	-8	\N	\N
1005130	0	0	1	48	-7	\N	\N
1005131	0	0	1	48	-6	\N	\N
1005132	0	0	1	48	-5	\N	\N
1005133	0	0	1	48	-4	\N	\N
1005134	0	0	1	48	-3	\N	\N
1005135	0	0	1	48	-2	\N	\N
1005136	0	0	1	48	-1	\N	\N
1005137	0	0	1	48	0	\N	\N
1005138	0	0	1	48	1	\N	\N
1005139	0	0	1	48	2	\N	\N
1005140	0	0	1	48	3	\N	\N
1005141	0	0	1	48	4	\N	\N
1005201	0	0	1	49	-16	\N	\N
1005202	0	0	1	49	-15	\N	\N
1005203	0	0	1	49	-14	\N	\N
1005204	0	0	1	49	-13	\N	\N
1005205	0	0	1	49	-12	\N	\N
1005206	0	0	1	49	-11	\N	\N
1005207	0	0	1	49	-10	\N	\N
1005208	0	0	1	49	-9	\N	\N
1005209	0	0	1	49	-8	\N	\N
1005210	0	0	1	49	-7	\N	\N
1005211	0	0	1	49	-6	\N	\N
1005212	0	0	1	49	-5	\N	\N
1005213	0	0	1	49	-4	\N	\N
1005214	0	0	1	49	-3	\N	\N
1005215	0	0	1	49	-2	\N	\N
1005216	0	0	1	49	-1	\N	\N
1005217	0	0	1	49	0	\N	\N
1005218	0	0	1	49	1	\N	\N
1005219	0	0	1	49	2	\N	\N
1005220	0	0	1	49	3	\N	\N
1005221	0	0	1	49	4	\N	\N
1005281	0	0	1	50	-16	\N	\N
1005282	0	0	1	50	-15	\N	\N
1005283	0	0	1	50	-14	\N	\N
1005284	0	0	1	50	-13	\N	\N
1005285	0	0	1	50	-12	\N	\N
1005286	0	0	1	50	-11	\N	\N
1005287	0	0	1	50	-10	\N	\N
1005288	0	0	1	50	-9	\N	\N
1005289	0	0	1	50	-8	\N	\N
1005290	0	0	1	50	-7	\N	\N
1005291	0	0	1	50	-6	\N	\N
1005292	0	0	1	50	-5	\N	\N
1005293	0	0	1	50	-4	\N	\N
1005294	0	0	1	50	-3	\N	\N
1005295	0	0	1	50	-2	\N	\N
1005296	0	0	1	50	-1	\N	\N
1005297	0	0	1	50	0	\N	\N
1005298	0	0	1	50	1	\N	\N
1005299	0	0	1	50	2	\N	\N
1005300	0	0	1	50	3	\N	\N
1005301	0	0	1	50	4	\N	\N
1005361	0	0	1	51	-16	\N	\N
1005362	0	0	1	51	-15	\N	\N
1005363	0	0	1	51	-14	\N	\N
1005364	0	0	1	51	-13	\N	\N
1005365	0	0	1	51	-12	\N	\N
1005366	0	0	1	51	-11	\N	\N
1005367	0	0	1	51	-10	\N	\N
1005368	0	0	1	51	-9	\N	\N
1005369	0	0	1	51	-8	\N	\N
1005370	0	0	1	51	-7	\N	\N
1005371	0	0	1	51	-6	\N	\N
1005372	0	0	1	51	-5	\N	\N
1005373	0	0	1	51	-4	\N	\N
1005374	0	0	1	51	-3	\N	\N
1005375	0	0	1	51	-2	\N	\N
1005376	0	0	1	51	-1	\N	\N
1005377	0	0	1	51	0	\N	\N
1005378	0	0	1	51	1	\N	\N
1005379	0	0	1	51	2	\N	\N
1005380	0	0	1	51	3	\N	\N
1005381	0	0	1	51	4	\N	\N
1005441	0	0	1	52	-16	\N	\N
1005442	0	0	1	52	-15	\N	\N
1005443	0	0	1	52	-14	\N	\N
1005444	0	0	1	52	-13	\N	\N
1005445	0	0	1	52	-12	\N	\N
1005446	0	0	1	52	-11	\N	\N
1005447	0	0	1	52	-10	\N	\N
1005448	0	0	1	52	-9	\N	\N
1005449	0	0	1	52	-8	\N	\N
1005450	0	0	1	52	-7	\N	\N
1005451	0	0	1	52	-6	\N	\N
1005452	0	0	1	52	-5	\N	\N
1005453	0	0	1	52	-4	\N	\N
1005454	0	0	1	52	-3	\N	\N
1005455	0	0	1	52	-2	\N	\N
1005456	0	0	1	52	-1	\N	\N
1005457	0	0	1	52	0	\N	\N
1005458	0	0	1	52	1	\N	\N
1005459	0	0	1	52	2	\N	\N
1005460	0	0	1	52	3	\N	\N
1005461	0	0	1	52	4	\N	\N
1005521	0	0	1	53	-16	\N	\N
1005522	0	0	1	53	-15	\N	\N
1005523	0	0	1	53	-14	\N	\N
1005524	0	0	1	53	-13	\N	\N
1005525	0	0	1	53	-12	\N	\N
1005526	0	0	1	53	-11	\N	\N
1005527	0	0	1	53	-10	\N	\N
1005528	0	0	1	53	-9	\N	\N
1005529	0	0	1	53	-8	\N	\N
1005530	0	0	1	53	-7	\N	\N
1005531	0	0	1	53	-6	\N	\N
1005532	0	0	1	53	-5	\N	\N
1005533	0	0	1	53	-4	\N	\N
1005534	0	0	1	53	-3	\N	\N
1005535	0	0	1	53	-2	\N	\N
1005536	0	0	1	53	-1	\N	\N
1005537	0	0	1	53	0	\N	\N
1005538	0	0	1	53	1	\N	\N
1005539	0	0	1	53	2	\N	\N
1005540	0	0	1	53	3	\N	\N
1005541	0	0	1	53	4	\N	\N
1005601	0	0	1	54	-16	\N	\N
1005602	0	0	1	54	-15	\N	\N
1005603	0	0	1	54	-14	\N	\N
1005604	0	0	1	54	-13	\N	\N
1005605	0	0	1	54	-12	\N	\N
1005606	0	0	1	54	-11	\N	\N
1005607	0	0	1	54	-10	\N	\N
1005608	0	0	1	54	-9	\N	\N
1005609	0	0	1	54	-8	\N	\N
1005610	0	0	1	54	-7	\N	\N
1005611	0	0	1	54	-6	\N	\N
1005612	0	0	1	54	-5	\N	\N
1005613	0	0	1	54	-4	\N	\N
1005614	0	0	1	54	-3	\N	\N
1005615	0	0	1	54	-2	\N	\N
1005616	0	0	1	54	-1	\N	\N
1005617	0	0	1	54	0	\N	\N
1005618	0	0	1	54	1	\N	\N
1005619	0	0	1	54	2	\N	\N
1005620	0	0	1	54	3	\N	\N
1005621	0	0	1	54	4	\N	\N
1005681	0	0	1	55	-16	\N	\N
1005682	0	0	1	55	-15	\N	\N
1005683	0	0	1	55	-14	\N	\N
1005684	0	0	1	55	-13	\N	\N
1005685	0	0	1	55	-12	\N	\N
1005686	0	0	1	55	-11	\N	\N
1005687	0	0	1	55	-10	\N	\N
1005688	0	0	1	55	-9	\N	\N
1005689	0	0	1	55	-8	\N	\N
1005690	0	0	1	55	-7	\N	\N
1005691	0	0	1	55	-6	\N	\N
1005692	0	0	1	55	-5	\N	\N
1005693	0	0	1	55	-4	\N	\N
1005694	0	0	1	55	-3	\N	\N
1005695	0	0	1	55	-2	\N	\N
1005696	0	0	1	55	-1	\N	\N
1005697	0	0	1	55	0	\N	\N
1005698	0	0	1	55	1	\N	\N
1005699	0	0	1	55	2	\N	\N
1005700	0	0	1	55	3	\N	\N
1005701	0	0	1	55	4	\N	\N
1005761	0	0	1	56	-16	\N	\N
1005762	0	0	1	56	-15	\N	\N
1005763	0	0	1	56	-14	\N	\N
1005764	0	0	1	56	-13	\N	\N
1005765	0	0	1	56	-12	\N	\N
1005766	0	0	1	56	-11	\N	\N
1005767	0	0	1	56	-10	\N	\N
1005768	0	0	1	56	-9	\N	\N
1005769	0	0	1	56	-8	\N	\N
1005770	0	0	1	56	-7	\N	\N
1005771	0	0	1	56	-6	\N	\N
1005772	0	0	1	56	-5	\N	\N
1005773	0	0	1	56	-4	\N	\N
1005774	0	0	1	56	-3	\N	\N
1005775	0	0	1	56	-2	\N	\N
1005776	0	0	1	56	-1	\N	\N
1005777	0	0	1	56	0	\N	\N
1005778	0	0	1	56	1	\N	\N
1005779	0	0	1	56	2	\N	\N
1005780	0	0	1	56	3	\N	\N
1005781	0	0	1	56	4	\N	\N
1005841	0	0	1	57	-16	\N	\N
1005842	0	0	1	57	-15	\N	\N
1005843	0	0	1	57	-14	\N	\N
1005844	0	0	1	57	-13	\N	\N
1005845	0	0	1	57	-12	\N	\N
1005846	0	0	1	57	-11	\N	\N
1005847	0	0	1	57	-10	\N	\N
1005848	0	0	1	57	-9	\N	\N
1005849	0	0	1	57	-8	\N	\N
1005850	0	0	1	57	-7	\N	\N
1005851	0	0	1	57	-6	\N	\N
1005852	0	0	1	57	-5	\N	\N
1005853	0	0	1	57	-4	\N	\N
1005854	0	0	1	57	-3	\N	\N
1005855	0	0	1	57	-2	\N	\N
1005856	0	0	1	57	-1	\N	\N
1005857	0	0	1	57	0	\N	\N
1005858	0	0	1	57	1	\N	\N
1005859	0	0	1	57	2	\N	\N
1005860	0	0	1	57	3	\N	\N
1005861	0	0	1	57	4	\N	\N
1005921	0	0	1	58	-16	\N	\N
1005922	0	0	1	58	-15	\N	\N
1005923	0	0	1	58	-14	\N	\N
1005924	0	0	1	58	-13	\N	\N
1005925	0	0	1	58	-12	\N	\N
1005926	0	0	1	58	-11	\N	\N
1005927	0	0	1	58	-10	\N	\N
1005928	0	0	1	58	-9	\N	\N
1005929	0	0	1	58	-8	\N	\N
1005930	0	0	1	58	-7	\N	\N
1005931	0	0	1	58	-6	\N	\N
1005932	0	0	1	58	-5	\N	\N
1005933	0	0	1	58	-4	\N	\N
1005934	0	0	1	58	-3	\N	\N
1005935	0	0	1	58	-2	\N	\N
1005936	0	0	1	58	-1	\N	\N
1005937	0	0	1	58	0	\N	\N
1005938	0	0	1	58	1	\N	\N
1005939	0	0	1	58	2	\N	\N
1005940	0	0	1	58	3	\N	\N
1005941	0	0	1	58	4	\N	\N
1006001	0	0	1	59	-16	\N	\N
1006002	0	0	1	59	-15	\N	\N
1006003	0	0	1	59	-14	\N	\N
1006004	0	0	1	59	-13	\N	\N
1006005	0	0	1	59	-12	\N	\N
1006006	0	0	1	59	-11	\N	\N
1006007	0	0	1	59	-10	\N	\N
1006008	0	0	1	59	-9	\N	\N
1006009	0	0	1	59	-8	\N	\N
1006010	0	0	1	59	-7	\N	\N
1006011	0	0	1	59	-6	\N	\N
1006012	0	0	1	59	-5	\N	\N
1006013	0	0	1	59	-4	\N	\N
1006014	0	0	1	59	-3	\N	\N
1006015	0	0	1	59	-2	\N	\N
1006016	0	0	1	59	-1	\N	\N
1006017	0	0	1	59	0	\N	\N
1006018	0	0	1	59	1	\N	\N
1006019	0	0	1	59	2	\N	\N
1006020	0	0	1	59	3	\N	\N
1006021	0	0	1	59	4	\N	\N
1006081	0	0	1	60	-16	\N	\N
1006082	0	0	1	60	-15	\N	\N
1006083	0	0	1	60	-14	\N	\N
1006084	0	0	1	60	-13	\N	\N
1006085	0	0	1	60	-12	\N	\N
1006086	0	0	1	60	-11	\N	\N
1006087	0	0	1	60	-10	\N	\N
1006088	0	0	1	60	-9	\N	\N
1006089	0	0	1	60	-8	\N	\N
1006090	0	0	1	60	-7	\N	\N
1006091	0	0	1	60	-6	\N	\N
1006092	0	0	1	60	-5	\N	\N
1006093	0	0	1	60	-4	\N	\N
1006094	0	0	1	60	-3	\N	\N
1006095	0	0	1	60	-2	\N	\N
1006096	0	0	1	60	-1	\N	\N
1006097	0	0	1	60	0	\N	\N
1006098	0	0	1	60	1	\N	\N
1006099	0	0	1	60	2	\N	\N
1006100	0	0	1	60	3	\N	\N
1006101	0	0	1	60	4	\N	\N
1006161	0	0	1	61	-16	\N	\N
1006162	0	0	1	61	-15	\N	\N
1006163	0	0	1	61	-14	\N	\N
1006164	0	0	1	61	-13	\N	\N
1006165	0	0	1	61	-12	\N	\N
1006166	0	0	1	61	-11	\N	\N
1006167	0	0	1	61	-10	\N	\N
1006168	0	0	1	61	-9	\N	\N
1006169	0	0	1	61	-8	\N	\N
1006170	0	0	1	61	-7	\N	\N
1006171	0	0	1	61	-6	\N	\N
1006172	0	0	1	61	-5	\N	\N
1006173	0	0	1	61	-4	\N	\N
1006174	0	0	1	61	-3	\N	\N
1006175	0	0	1	61	-2	\N	\N
1006176	0	0	1	61	-1	\N	\N
1006177	0	0	1	61	0	\N	\N
1006178	0	0	1	61	1	\N	\N
1006179	0	0	1	61	2	\N	\N
1006180	0	0	1	61	3	\N	\N
1006181	0	0	1	61	4	\N	\N
1006241	0	0	1	62	-16	\N	\N
1006242	0	0	1	62	-15	\N	\N
1006243	0	0	1	62	-14	\N	\N
1006244	0	0	1	62	-13	\N	\N
1006245	0	0	1	62	-12	\N	\N
1006246	0	0	1	62	-11	\N	\N
1006247	0	0	1	62	-10	\N	\N
1006248	0	0	1	62	-9	\N	\N
1006249	0	0	1	62	-8	\N	\N
1006250	0	0	1	62	-7	\N	\N
1006251	0	0	1	62	-6	\N	\N
1006252	0	0	1	62	-5	\N	\N
1006253	0	0	1	62	-4	\N	\N
1006254	0	0	1	62	-3	\N	\N
1006255	0	0	1	62	-2	\N	\N
1006256	0	0	1	62	-1	\N	\N
1006257	0	0	1	62	0	\N	\N
1006258	0	0	1	62	1	\N	\N
1006259	0	0	1	62	2	\N	\N
1006260	0	0	1	62	3	\N	\N
1006261	0	0	1	62	4	\N	\N
1006321	0	0	1	63	-16	\N	\N
1006322	0	0	1	63	-15	\N	\N
1006323	0	0	1	63	-14	\N	\N
1006324	0	0	1	63	-13	\N	\N
1006325	0	0	1	63	-12	\N	\N
1006326	0	0	1	63	-11	\N	\N
1006327	0	0	1	63	-10	\N	\N
1006328	0	0	1	63	-9	\N	\N
1006329	0	0	1	63	-8	\N	\N
1006330	0	0	1	63	-7	\N	\N
1006331	0	0	1	63	-6	\N	\N
1006332	0	0	1	63	-5	\N	\N
1006333	0	0	1	63	-4	\N	\N
1006334	0	0	1	63	-3	\N	\N
1006335	0	0	1	63	-2	\N	\N
1006336	0	0	1	63	-1	\N	\N
1006337	0	0	1	63	0	\N	\N
1006338	0	0	1	63	1	\N	\N
1006339	0	0	1	63	2	\N	\N
1006340	0	0	1	63	3	\N	\N
1006341	0	0	1	63	4	\N	\N
1006801	0	0	1	45	4	\N	\N
1004607	0	0	1	41	30	\N	\N
1004608	0	0	1	41	31	\N	\N
1004609	0	0	1	41	32	\N	\N
1004610	0	0	1	41	33	\N	\N
1004611	0	0	1	41	34	\N	\N
1004612	0	0	1	41	35	\N	\N
1004613	0	0	1	41	36	\N	\N
1004614	0	0	1	41	37	\N	\N
1004615	0	0	1	41	38	\N	\N
1004616	0	0	1	41	39	\N	\N
1004617	0	0	1	41	40	\N	\N
1004687	0	0	1	42	30	\N	\N
1004688	0	0	1	42	31	\N	\N
1004689	0	0	1	42	32	\N	\N
1004690	0	0	1	42	33	\N	\N
1004691	0	0	1	42	34	\N	\N
1004692	0	0	1	42	35	\N	\N
1004693	0	0	1	42	36	\N	\N
1004694	0	0	1	42	37	\N	\N
1004695	0	0	1	42	38	\N	\N
1004696	0	0	1	42	39	\N	\N
1004697	0	0	1	42	40	\N	\N
1004765	0	0	1	43	28	\N	\N
1004766	0	0	1	43	29	\N	\N
1004845	0	0	1	44	28	\N	\N
1004846	0	0	1	44	29	\N	\N
1004925	0	0	1	45	28	\N	\N
1004926	0	0	1	45	29	\N	\N
1005005	0	0	1	46	28	\N	\N
1005006	0	0	1	46	29	\N	\N
1005085	0	0	1	47	28	\N	\N
1005086	0	0	1	47	29	\N	\N
1005165	0	0	1	48	28	\N	\N
1005166	0	0	1	48	29	\N	\N
1005245	0	0	1	49	28	\N	\N
1005246	0	0	1	49	29	\N	\N
1005325	0	0	1	50	28	\N	\N
1005326	0	0	1	50	29	\N	\N
1005405	0	0	1	51	28	\N	\N
1005406	0	0	1	51	29	\N	\N
1005485	0	0	1	52	28	\N	\N
1005486	0	0	1	52	29	\N	\N
1005565	0	0	1	53	28	\N	\N
1005566	0	0	1	53	29	\N	\N
1005645	0	0	1	54	28	\N	\N
1005646	0	0	1	54	29	\N	\N
1005725	0	0	1	55	28	\N	\N
1005726	0	0	1	55	29	\N	\N
1005805	0	0	1	56	28	\N	\N
1005806	0	0	1	56	29	\N	\N
1005885	0	0	1	57	28	\N	\N
1005886	0	0	1	57	29	\N	\N
1005965	0	0	1	58	28	\N	\N
1005966	0	0	1	58	29	\N	\N
1006045	0	0	1	59	28	\N	\N
1006046	0	0	1	59	29	\N	\N
1006125	0	0	1	60	28	\N	\N
1006126	0	0	1	60	29	\N	\N
1006205	0	0	1	61	28	\N	\N
1006206	0	0	1	61	29	\N	\N
1006285	0	0	1	62	28	\N	\N
1006286	0	0	1	62	29	\N	\N
1006365	0	0	1	63	28	\N	\N
1006366	0	0	1	63	29	\N	\N
1004767	0	0	1	43	30	\N	\N
1004768	0	0	1	43	31	\N	\N
1004769	0	0	1	43	32	\N	\N
1004770	0	0	1	43	33	\N	\N
1004771	0	0	1	43	34	\N	\N
1004772	0	0	1	43	35	\N	\N
1004773	0	0	1	43	36	\N	\N
1004774	0	0	1	43	37	\N	\N
1004775	0	0	1	43	38	\N	\N
1004776	0	0	1	43	39	\N	\N
1004777	0	0	1	43	40	\N	\N
1004847	0	0	1	44	30	\N	\N
1004848	0	0	1	44	31	\N	\N
1004849	0	0	1	44	32	\N	\N
1004850	0	0	1	44	33	\N	\N
1004851	0	0	1	44	34	\N	\N
1004852	0	0	1	44	35	\N	\N
1004853	0	0	1	44	36	\N	\N
1004854	0	0	1	44	37	\N	\N
1004855	0	0	1	44	38	\N	\N
1004856	0	0	1	44	39	\N	\N
1004857	0	0	1	44	40	\N	\N
1004927	0	0	1	45	30	\N	\N
1004928	0	0	1	45	31	\N	\N
1004929	0	0	1	45	32	\N	\N
1004930	0	0	1	45	33	\N	\N
1004931	0	0	1	45	34	\N	\N
1004932	0	0	1	45	35	\N	\N
1004933	0	0	1	45	36	\N	\N
1004934	0	0	1	45	37	\N	\N
1004935	0	0	1	45	38	\N	\N
1004936	0	0	1	45	39	\N	\N
1004937	0	0	1	45	40	\N	\N
1005007	0	0	1	46	30	\N	\N
1005008	0	0	1	46	31	\N	\N
1005009	0	0	1	46	32	\N	\N
1005010	0	0	1	46	33	\N	\N
1005011	0	0	1	46	34	\N	\N
1005012	0	0	1	46	35	\N	\N
1005013	0	0	1	46	36	\N	\N
1005014	0	0	1	46	37	\N	\N
1005015	0	0	1	46	38	\N	\N
1005016	0	0	1	46	39	\N	\N
1005017	0	0	1	46	40	\N	\N
1005087	0	0	1	47	30	\N	\N
1005088	0	0	1	47	31	\N	\N
1005089	0	0	1	47	32	\N	\N
1005090	0	0	1	47	33	\N	\N
1005091	0	0	1	47	34	\N	\N
1005092	0	0	1	47	35	\N	\N
1005093	0	0	1	47	36	\N	\N
1005094	0	0	1	47	37	\N	\N
1005095	0	0	1	47	38	\N	\N
1005096	0	0	1	47	39	\N	\N
1005097	0	0	1	47	40	\N	\N
1005167	0	0	1	48	30	\N	\N
1005168	0	0	1	48	31	\N	\N
1005169	0	0	1	48	32	\N	\N
1005170	0	0	1	48	33	\N	\N
1005171	0	0	1	48	34	\N	\N
1005172	0	0	1	48	35	\N	\N
1005173	0	0	1	48	36	\N	\N
1005174	0	0	1	48	37	\N	\N
1005175	0	0	1	48	38	\N	\N
1005176	0	0	1	48	39	\N	\N
1005177	0	0	1	48	40	\N	\N
1005247	0	0	1	49	30	\N	\N
1005248	0	0	1	49	31	\N	\N
1005249	0	0	1	49	32	\N	\N
1005250	0	0	1	49	33	\N	\N
1005251	0	0	1	49	34	\N	\N
1005252	0	0	1	49	35	\N	\N
1005253	0	0	1	49	36	\N	\N
1005254	0	0	1	49	37	\N	\N
1005255	0	0	1	49	38	\N	\N
1005256	0	0	1	49	39	\N	\N
1005257	0	0	1	49	40	\N	\N
1005327	0	0	1	50	30	\N	\N
1005328	0	0	1	50	31	\N	\N
1005329	0	0	1	50	32	\N	\N
1005330	0	0	1	50	33	\N	\N
1005331	0	0	1	50	34	\N	\N
1005332	0	0	1	50	35	\N	\N
1005333	0	0	1	50	36	\N	\N
1005334	0	0	1	50	37	\N	\N
1005335	0	0	1	50	38	\N	\N
1005336	0	0	1	50	39	\N	\N
1005337	0	0	1	50	40	\N	\N
1005407	0	0	1	51	30	\N	\N
1005408	0	0	1	51	31	\N	\N
1005409	0	0	1	51	32	\N	\N
1005410	0	0	1	51	33	\N	\N
1005411	0	0	1	51	34	\N	\N
1005412	0	0	1	51	35	\N	\N
1005413	0	0	1	51	36	\N	\N
1005414	0	0	1	51	37	\N	\N
1005415	0	0	1	51	38	\N	\N
1005416	0	0	1	51	39	\N	\N
1005417	0	0	1	51	40	\N	\N
1005487	0	0	1	52	30	\N	\N
1005488	0	0	1	52	31	\N	\N
1005489	0	0	1	52	32	\N	\N
1005490	0	0	1	52	33	\N	\N
1005491	0	0	1	52	34	\N	\N
1005492	0	0	1	52	35	\N	\N
1005493	0	0	1	52	36	\N	\N
1005494	0	0	1	52	37	\N	\N
1005495	0	0	1	52	38	\N	\N
1005496	0	0	1	52	39	\N	\N
1005497	0	0	1	52	40	\N	\N
1005567	0	0	1	53	30	\N	\N
1005568	0	0	1	53	31	\N	\N
1005569	0	0	1	53	32	\N	\N
1005570	0	0	1	53	33	\N	\N
1005571	0	0	1	53	34	\N	\N
1005572	0	0	1	53	35	\N	\N
1005573	0	0	1	53	36	\N	\N
1005574	0	0	1	53	37	\N	\N
1005575	0	0	1	53	38	\N	\N
1005576	0	0	1	53	39	\N	\N
1005577	0	0	1	53	40	\N	\N
1005647	0	0	1	54	30	\N	\N
1005648	0	0	1	54	31	\N	\N
1005649	0	0	1	54	32	\N	\N
1005650	0	0	1	54	33	\N	\N
1005651	0	0	1	54	34	\N	\N
1005652	0	0	1	54	35	\N	\N
1005653	0	0	1	54	36	\N	\N
1005654	0	0	1	54	37	\N	\N
1005655	0	0	1	54	38	\N	\N
1005656	0	0	1	54	39	\N	\N
1005657	0	0	1	54	40	\N	\N
1005727	0	0	1	55	30	\N	\N
1005728	0	0	1	55	31	\N	\N
1005729	0	0	1	55	32	\N	\N
1005730	0	0	1	55	33	\N	\N
1005731	0	0	1	55	34	\N	\N
1005732	0	0	1	55	35	\N	\N
1005733	0	0	1	55	36	\N	\N
1005734	0	0	1	55	37	\N	\N
1005735	0	0	1	55	38	\N	\N
1005736	0	0	1	55	39	\N	\N
1005737	0	0	1	55	40	\N	\N
1005807	0	0	1	56	30	\N	\N
1005808	0	0	1	56	31	\N	\N
1005809	0	0	1	56	32	\N	\N
1005810	0	0	1	56	33	\N	\N
1005811	0	0	1	56	34	\N	\N
1005812	0	0	1	56	35	\N	\N
1005813	0	0	1	56	36	\N	\N
1005814	0	0	1	56	37	\N	\N
1005815	0	0	1	56	38	\N	\N
1005816	0	0	1	56	39	\N	\N
1005817	0	0	1	56	40	\N	\N
1005887	0	0	1	57	30	\N	\N
1005888	0	0	1	57	31	\N	\N
1005889	0	0	1	57	32	\N	\N
1005890	0	0	1	57	33	\N	\N
1005891	0	0	1	57	34	\N	\N
1005892	0	0	1	57	35	\N	\N
1005893	0	0	1	57	36	\N	\N
1005894	0	0	1	57	37	\N	\N
1005895	0	0	1	57	38	\N	\N
1005896	0	0	1	57	39	\N	\N
1005897	0	0	1	57	40	\N	\N
1005967	0	0	1	58	30	\N	\N
1005968	0	0	1	58	31	\N	\N
1005969	0	0	1	58	32	\N	\N
1005970	0	0	1	58	33	\N	\N
1005971	0	0	1	58	34	\N	\N
1005972	0	0	1	58	35	\N	\N
1005973	0	0	1	58	36	\N	\N
1005974	0	0	1	58	37	\N	\N
1005975	0	0	1	58	38	\N	\N
1005976	0	0	1	58	39	\N	\N
1005977	0	0	1	58	40	\N	\N
1006047	0	0	1	59	30	\N	\N
1006048	0	0	1	59	31	\N	\N
1006049	0	0	1	59	32	\N	\N
1006050	0	0	1	59	33	\N	\N
1006051	0	0	1	59	34	\N	\N
1006052	0	0	1	59	35	\N	\N
1006053	0	0	1	59	36	\N	\N
1006054	0	0	1	59	37	\N	\N
1006055	0	0	1	59	38	\N	\N
1006056	0	0	1	59	39	\N	\N
1006057	0	0	1	59	40	\N	\N
1006127	0	0	1	60	30	\N	\N
1006128	0	0	1	60	31	\N	\N
1006129	0	0	1	60	32	\N	\N
1006130	0	0	1	60	33	\N	\N
1006131	0	0	1	60	34	\N	\N
1006132	0	0	1	60	35	\N	\N
1006133	0	0	1	60	36	\N	\N
1006134	0	0	1	60	37	\N	\N
1006135	0	0	1	60	38	\N	\N
1006136	0	0	1	60	39	\N	\N
1006137	0	0	1	60	40	\N	\N
1006207	0	0	1	61	30	\N	\N
1006208	0	0	1	61	31	\N	\N
1006209	0	0	1	61	32	\N	\N
1006210	0	0	1	61	33	\N	\N
1006211	0	0	1	61	34	\N	\N
1006212	0	0	1	61	35	\N	\N
1006213	0	0	1	61	36	\N	\N
1006214	0	0	1	61	37	\N	\N
1006215	0	0	1	61	38	\N	\N
1006216	0	0	1	61	39	\N	\N
1006217	0	0	1	61	40	\N	\N
1006287	0	0	1	62	30	\N	\N
1006288	0	0	1	62	31	\N	\N
1006289	0	0	1	62	32	\N	\N
1006290	0	0	1	62	33	\N	\N
1006291	0	0	1	62	34	\N	\N
1006292	0	0	1	62	35	\N	\N
1006293	0	0	1	62	36	\N	\N
1006294	0	0	1	62	37	\N	\N
1006295	0	0	1	62	38	\N	\N
1006296	0	0	1	62	39	\N	\N
1006297	0	0	1	62	40	\N	\N
1006367	0	0	1	63	30	\N	\N
1006368	0	0	1	63	31	\N	\N
1006369	0	0	1	63	32	\N	\N
1006370	0	0	1	63	33	\N	\N
1006371	0	0	1	63	34	\N	\N
1006372	0	0	1	63	35	\N	\N
1006373	0	0	1	63	36	\N	\N
1006374	0	0	1	63	37	\N	\N
1006375	0	0	1	63	38	\N	\N
1006376	0	0	1	63	39	\N	\N
1006377	0	0	1	63	40	\N	\N
1003739	0	0	1	30	42	\N	\N
1003818	0	0	1	31	41	\N	\N
1003819	0	0	1	31	42	\N	\N
1003898	0	0	1	32	41	\N	\N
1003899	0	0	1	32	42	\N	\N
1003978	0	0	1	33	41	\N	\N
1003979	0	0	1	33	42	\N	\N
1004058	0	0	1	34	41	\N	\N
1004059	0	0	1	34	42	\N	\N
1004138	0	0	1	35	41	\N	\N
1004139	0	0	1	35	42	\N	\N
1004218	0	0	1	36	41	\N	\N
1004219	0	0	1	36	42	\N	\N
1004298	0	0	1	37	41	\N	\N
1004299	0	0	1	37	42	\N	\N
1004378	0	0	1	38	41	\N	\N
1004379	0	0	1	38	42	\N	\N
1004458	0	0	1	39	41	\N	\N
1004459	0	0	1	39	42	\N	\N
1004538	0	0	1	40	41	\N	\N
1004539	0	0	1	40	42	\N	\N
1003738	0	0	1	30	41	null	null
1004618	0	0	1	41	41	\N	\N
1004619	0	0	1	41	42	\N	\N
1004698	0	0	1	42	41	\N	\N
1004699	0	0	1	42	42	\N	\N
1004778	0	0	1	43	41	\N	\N
1004779	0	0	1	43	42	\N	\N
1004858	0	0	1	44	41	\N	\N
1004859	0	0	1	44	42	\N	\N
1004938	0	0	1	45	41	\N	\N
1004939	0	0	1	45	42	\N	\N
1005018	0	0	1	46	41	\N	\N
1005019	0	0	1	46	42	\N	\N
1005098	0	0	1	47	41	\N	\N
1005099	0	0	1	47	42	\N	\N
1005178	0	0	1	48	41	\N	\N
1005179	0	0	1	48	42	\N	\N
1005258	0	0	1	49	41	\N	\N
1005259	0	0	1	49	42	\N	\N
1005338	0	0	1	50	41	\N	\N
1005339	0	0	1	50	42	\N	\N
1005418	0	0	1	51	41	\N	\N
1005419	0	0	1	51	42	\N	\N
1005498	0	0	1	52	41	\N	\N
1005499	0	0	1	52	42	\N	\N
1005578	0	0	1	53	41	\N	\N
1005579	0	0	1	53	42	\N	\N
1005658	0	0	1	54	41	\N	\N
1005659	0	0	1	54	42	\N	\N
1005738	0	0	1	55	41	\N	\N
1005739	0	0	1	55	42	\N	\N
1005818	0	0	1	56	41	\N	\N
1005819	0	0	1	56	42	\N	\N
1005898	0	0	1	57	41	\N	\N
1005899	0	0	1	57	42	\N	\N
1005978	0	0	1	58	41	\N	\N
1005979	0	0	1	58	42	\N	\N
1006058	0	0	1	59	41	\N	\N
1006059	0	0	1	59	42	\N	\N
1006138	0	0	1	60	41	\N	\N
1006139	0	0	1	60	42	\N	\N
1006218	0	0	1	61	41	\N	\N
1006219	0	0	1	61	42	\N	\N
1006298	0	0	1	62	41	\N	\N
1006299	0	0	1	62	42	\N	\N
1006378	0	0	1	63	41	\N	\N
1006379	0	0	1	63	42	\N	\N
1003581	0	0	1	28	44	\N	\N
1003660	0	0	1	29	43	\N	\N
1003661	0	0	1	29	44	\N	\N
1003580	0	0	1	28	43	null	null
1003582	0	0	1	28	45	\N	\N
1003583	0	0	1	28	46	\N	\N
1003584	0	0	1	28	47	\N	\N
1003585	0	0	1	28	48	\N	\N
1003586	0	0	1	28	49	\N	\N
1003587	0	0	1	28	50	\N	\N
1003588	0	0	1	28	51	\N	\N
1003589	0	0	1	28	52	\N	\N
1003590	0	0	1	28	53	\N	\N
1003591	0	0	1	28	54	\N	\N
1003592	0	0	1	28	55	\N	\N
1003593	0	0	1	28	56	\N	\N
1003594	0	0	1	28	57	\N	\N
1003595	0	0	1	28	58	\N	\N
1003596	0	0	1	28	59	\N	\N
1003597	0	0	1	28	60	\N	\N
1003598	0	0	1	28	61	\N	\N
1003599	0	0	1	28	62	\N	\N
1003600	0	0	1	28	63	\N	\N
1003662	0	0	1	29	45	\N	\N
1003663	0	0	1	29	46	\N	\N
1003664	0	0	1	29	47	\N	\N
1003665	0	0	1	29	48	\N	\N
1003666	0	0	1	29	49	\N	\N
1003667	0	0	1	29	50	\N	\N
1003668	0	0	1	29	51	\N	\N
1003669	0	0	1	29	52	\N	\N
1003670	0	0	1	29	53	\N	\N
1003671	0	0	1	29	54	\N	\N
1003672	0	0	1	29	55	\N	\N
1003673	0	0	1	29	56	\N	\N
1003674	0	0	1	29	57	\N	\N
1003675	0	0	1	29	58	\N	\N
1003676	0	0	1	29	59	\N	\N
1003677	0	0	1	29	60	\N	\N
1003678	0	0	1	29	61	\N	\N
1003679	0	0	1	29	62	\N	\N
1003680	0	0	1	29	63	\N	\N
1003740	0	0	1	30	43	\N	\N
1003741	0	0	1	30	44	\N	\N
1003820	0	0	1	31	43	\N	\N
1003821	0	0	1	31	44	\N	\N
1003900	0	0	1	32	43	\N	\N
1003901	0	0	1	32	44	\N	\N
1003980	0	0	1	33	43	\N	\N
1003981	0	0	1	33	44	\N	\N
1004060	0	0	1	34	43	\N	\N
1004061	0	0	1	34	44	\N	\N
1004140	0	0	1	35	43	\N	\N
1004141	0	0	1	35	44	\N	\N
1004220	0	0	1	36	43	\N	\N
1004221	0	0	1	36	44	\N	\N
1004300	0	0	1	37	43	\N	\N
1004301	0	0	1	37	44	\N	\N
1004380	0	0	1	38	43	\N	\N
1004381	0	0	1	38	44	\N	\N
1004460	0	0	1	39	43	\N	\N
1004461	0	0	1	39	44	\N	\N
1004540	0	0	1	40	43	\N	\N
1004541	0	0	1	40	44	\N	\N
1003742	0	0	1	30	45	\N	\N
1003743	0	0	1	30	46	\N	\N
1003744	0	0	1	30	47	\N	\N
1003745	0	0	1	30	48	\N	\N
1003746	0	0	1	30	49	\N	\N
1003747	0	0	1	30	50	\N	\N
1003748	0	0	1	30	51	\N	\N
1003749	0	0	1	30	52	\N	\N
1003750	0	0	1	30	53	\N	\N
1003751	0	0	1	30	54	\N	\N
1003752	0	0	1	30	55	\N	\N
1003753	0	0	1	30	56	\N	\N
1003754	0	0	1	30	57	\N	\N
1003755	0	0	1	30	58	\N	\N
1003756	0	0	1	30	59	\N	\N
1003757	0	0	1	30	60	\N	\N
1003758	0	0	1	30	61	\N	\N
1003759	0	0	1	30	62	\N	\N
1003760	0	0	1	30	63	\N	\N
1003822	0	0	1	31	45	\N	\N
1003823	0	0	1	31	46	\N	\N
1003824	0	0	1	31	47	\N	\N
1003825	0	0	1	31	48	\N	\N
1003826	0	0	1	31	49	\N	\N
1003827	0	0	1	31	50	\N	\N
1003828	0	0	1	31	51	\N	\N
1003829	0	0	1	31	52	\N	\N
1003830	0	0	1	31	53	\N	\N
1003831	0	0	1	31	54	\N	\N
1003832	0	0	1	31	55	\N	\N
1003833	0	0	1	31	56	\N	\N
1003834	0	0	1	31	57	\N	\N
1003835	0	0	1	31	58	\N	\N
1003836	0	0	1	31	59	\N	\N
1003837	0	0	1	31	60	\N	\N
1003838	0	0	1	31	61	\N	\N
1003839	0	0	1	31	62	\N	\N
1003840	0	0	1	31	63	\N	\N
1003902	0	0	1	32	45	\N	\N
1003903	0	0	1	32	46	\N	\N
1003904	0	0	1	32	47	\N	\N
1003905	0	0	1	32	48	\N	\N
1003906	0	0	1	32	49	\N	\N
1003907	0	0	1	32	50	\N	\N
1003908	0	0	1	32	51	\N	\N
1003909	0	0	1	32	52	\N	\N
1003910	0	0	1	32	53	\N	\N
1003911	0	0	1	32	54	\N	\N
1003912	0	0	1	32	55	\N	\N
1003913	0	0	1	32	56	\N	\N
1003914	0	0	1	32	57	\N	\N
1003915	0	0	1	32	58	\N	\N
1003916	0	0	1	32	59	\N	\N
1003917	0	0	1	32	60	\N	\N
1003918	0	0	1	32	61	\N	\N
1003919	0	0	1	32	62	\N	\N
1003920	0	0	1	32	63	\N	\N
1003982	0	0	1	33	45	\N	\N
1003983	0	0	1	33	46	\N	\N
1003984	0	0	1	33	47	\N	\N
1003985	0	0	1	33	48	\N	\N
1003986	0	0	1	33	49	\N	\N
1003987	0	0	1	33	50	\N	\N
1003988	0	0	1	33	51	\N	\N
1003989	0	0	1	33	52	\N	\N
1003990	0	0	1	33	53	\N	\N
1003991	0	0	1	33	54	\N	\N
1003992	0	0	1	33	55	\N	\N
1003993	0	0	1	33	56	\N	\N
1003994	0	0	1	33	57	\N	\N
1003995	0	0	1	33	58	\N	\N
1003996	0	0	1	33	59	\N	\N
1003997	0	0	1	33	60	\N	\N
1003998	0	0	1	33	61	\N	\N
1003999	0	0	1	33	62	\N	\N
1004000	0	0	1	33	63	\N	\N
1004062	0	0	1	34	45	\N	\N
1004063	0	0	1	34	46	\N	\N
1004064	0	0	1	34	47	\N	\N
1004065	0	0	1	34	48	\N	\N
1004066	0	0	1	34	49	\N	\N
1004067	0	0	1	34	50	\N	\N
1004068	0	0	1	34	51	\N	\N
1004069	0	0	1	34	52	\N	\N
1004070	0	0	1	34	53	\N	\N
1004071	0	0	1	34	54	\N	\N
1004072	0	0	1	34	55	\N	\N
1004073	0	0	1	34	56	\N	\N
1004074	0	0	1	34	57	\N	\N
1004075	0	0	1	34	58	\N	\N
1004076	0	0	1	34	59	\N	\N
1004077	0	0	1	34	60	\N	\N
1004078	0	0	1	34	61	\N	\N
1004079	0	0	1	34	62	\N	\N
1004080	0	0	1	34	63	\N	\N
1004142	0	0	1	35	45	\N	\N
1004143	0	0	1	35	46	\N	\N
1004144	0	0	1	35	47	\N	\N
1004145	0	0	1	35	48	\N	\N
1004146	0	0	1	35	49	\N	\N
1004147	0	0	1	35	50	\N	\N
1004148	0	0	1	35	51	\N	\N
1004149	0	0	1	35	52	\N	\N
1004150	0	0	1	35	53	\N	\N
1004151	0	0	1	35	54	\N	\N
1004152	0	0	1	35	55	\N	\N
1004153	0	0	1	35	56	\N	\N
1004154	0	0	1	35	57	\N	\N
1004155	0	0	1	35	58	\N	\N
1004156	0	0	1	35	59	\N	\N
1004157	0	0	1	35	60	\N	\N
1004158	0	0	1	35	61	\N	\N
1004159	0	0	1	35	62	\N	\N
1004160	0	0	1	35	63	\N	\N
1004222	0	0	1	36	45	\N	\N
1004223	0	0	1	36	46	\N	\N
1004224	0	0	1	36	47	\N	\N
1004225	0	0	1	36	48	\N	\N
1004226	0	0	1	36	49	\N	\N
1004227	0	0	1	36	50	\N	\N
1004228	0	0	1	36	51	\N	\N
1004229	0	0	1	36	52	\N	\N
1004230	0	0	1	36	53	\N	\N
1004231	0	0	1	36	54	\N	\N
1004232	0	0	1	36	55	\N	\N
1004233	0	0	1	36	56	\N	\N
1004234	0	0	1	36	57	\N	\N
1004235	0	0	1	36	58	\N	\N
1004236	0	0	1	36	59	\N	\N
1004237	0	0	1	36	60	\N	\N
1004238	0	0	1	36	61	\N	\N
1004239	0	0	1	36	62	\N	\N
1004240	0	0	1	36	63	\N	\N
1004302	0	0	1	37	45	\N	\N
1004303	0	0	1	37	46	\N	\N
1004304	0	0	1	37	47	\N	\N
1004305	0	0	1	37	48	\N	\N
1004306	0	0	1	37	49	\N	\N
1004307	0	0	1	37	50	\N	\N
1004308	0	0	1	37	51	\N	\N
1004309	0	0	1	37	52	\N	\N
1004310	0	0	1	37	53	\N	\N
1004311	0	0	1	37	54	\N	\N
1004312	0	0	1	37	55	\N	\N
1004313	0	0	1	37	56	\N	\N
1004314	0	0	1	37	57	\N	\N
1004315	0	0	1	37	58	\N	\N
1004316	0	0	1	37	59	\N	\N
1004317	0	0	1	37	60	\N	\N
1004318	0	0	1	37	61	\N	\N
1004319	0	0	1	37	62	\N	\N
1004320	0	0	1	37	63	\N	\N
1004382	0	0	1	38	45	\N	\N
1004383	0	0	1	38	46	\N	\N
1004384	0	0	1	38	47	\N	\N
1004385	0	0	1	38	48	\N	\N
1004386	0	0	1	38	49	\N	\N
1004387	0	0	1	38	50	\N	\N
1004388	0	0	1	38	51	\N	\N
1004389	0	0	1	38	52	\N	\N
1004390	0	0	1	38	53	\N	\N
1004391	0	0	1	38	54	\N	\N
1004392	0	0	1	38	55	\N	\N
1004393	0	0	1	38	56	\N	\N
1004394	0	0	1	38	57	\N	\N
1004395	0	0	1	38	58	\N	\N
1004396	0	0	1	38	59	\N	\N
1004397	0	0	1	38	60	\N	\N
1004398	0	0	1	38	61	\N	\N
1004399	0	0	1	38	62	\N	\N
1004400	0	0	1	38	63	\N	\N
1004462	0	0	1	39	45	\N	\N
1004463	0	0	1	39	46	\N	\N
1004464	0	0	1	39	47	\N	\N
1004465	0	0	1	39	48	\N	\N
1004466	0	0	1	39	49	\N	\N
1004467	0	0	1	39	50	\N	\N
1004468	0	0	1	39	51	\N	\N
1004469	0	0	1	39	52	\N	\N
1004470	0	0	1	39	53	\N	\N
1004471	0	0	1	39	54	\N	\N
1004472	0	0	1	39	55	\N	\N
1004473	0	0	1	39	56	\N	\N
1004474	0	0	1	39	57	\N	\N
1004475	0	0	1	39	58	\N	\N
1004476	0	0	1	39	59	\N	\N
1004477	0	0	1	39	60	\N	\N
1004478	0	0	1	39	61	\N	\N
1004479	0	0	1	39	62	\N	\N
1004480	0	0	1	39	63	\N	\N
1004542	0	0	1	40	45	\N	\N
1004543	0	0	1	40	46	\N	\N
1004544	0	0	1	40	47	\N	\N
1004545	0	0	1	40	48	\N	\N
1004546	0	0	1	40	49	\N	\N
1004547	0	0	1	40	50	\N	\N
1004548	0	0	1	40	51	\N	\N
1004549	0	0	1	40	52	\N	\N
1004550	0	0	1	40	53	\N	\N
1004551	0	0	1	40	54	\N	\N
1004552	0	0	1	40	55	\N	\N
1004553	0	0	1	40	56	\N	\N
1004554	0	0	1	40	57	\N	\N
1004555	0	0	1	40	58	\N	\N
1004556	0	0	1	40	59	\N	\N
1004557	0	0	1	40	60	\N	\N
1004558	0	0	1	40	61	\N	\N
1004559	0	0	1	40	62	\N	\N
1004560	0	0	1	40	63	\N	\N
1004620	0	0	1	41	43	\N	\N
1004621	0	0	1	41	44	\N	\N
1004700	0	0	1	42	43	\N	\N
1004701	0	0	1	42	44	\N	\N
1004622	0	0	1	41	45	\N	\N
1004623	0	0	1	41	46	\N	\N
1004624	0	0	1	41	47	\N	\N
1004625	0	0	1	41	48	\N	\N
1004626	0	0	1	41	49	\N	\N
1004627	0	0	1	41	50	\N	\N
1004628	0	0	1	41	51	\N	\N
1004629	0	0	1	41	52	\N	\N
1004630	0	0	1	41	53	\N	\N
1004631	0	0	1	41	54	\N	\N
1004632	0	0	1	41	55	\N	\N
1004633	0	0	1	41	56	\N	\N
1004634	0	0	1	41	57	\N	\N
1004635	0	0	1	41	58	\N	\N
1004636	0	0	1	41	59	\N	\N
1004637	0	0	1	41	60	\N	\N
1004638	0	0	1	41	61	\N	\N
1004639	0	0	1	41	62	\N	\N
1004640	0	0	1	41	63	\N	\N
1004702	0	0	1	42	45	\N	\N
1004703	0	0	1	42	46	\N	\N
1004704	0	0	1	42	47	\N	\N
1004705	0	0	1	42	48	\N	\N
1004706	0	0	1	42	49	\N	\N
1004707	0	0	1	42	50	\N	\N
1004708	0	0	1	42	51	\N	\N
1004709	0	0	1	42	52	\N	\N
1004710	0	0	1	42	53	\N	\N
1004711	0	0	1	42	54	\N	\N
1004712	0	0	1	42	55	\N	\N
1004713	0	0	1	42	56	\N	\N
1004714	0	0	1	42	57	\N	\N
1004715	0	0	1	42	58	\N	\N
1004716	0	0	1	42	59	\N	\N
1004717	0	0	1	42	60	\N	\N
1004718	0	0	1	42	61	\N	\N
1004719	0	0	1	42	62	\N	\N
1004720	0	0	1	42	63	\N	\N
1004780	0	0	1	43	43	\N	\N
1004781	0	0	1	43	44	\N	\N
1004860	0	0	1	44	43	\N	\N
1004861	0	0	1	44	44	\N	\N
1004940	0	0	1	45	43	\N	\N
1004941	0	0	1	45	44	\N	\N
1005020	0	0	1	46	43	\N	\N
1005021	0	0	1	46	44	\N	\N
1005100	0	0	1	47	43	\N	\N
1005101	0	0	1	47	44	\N	\N
1005180	0	0	1	48	43	\N	\N
1005181	0	0	1	48	44	\N	\N
1005260	0	0	1	49	43	\N	\N
1005261	0	0	1	49	44	\N	\N
1005340	0	0	1	50	43	\N	\N
1005341	0	0	1	50	44	\N	\N
1005420	0	0	1	51	43	\N	\N
1005421	0	0	1	51	44	\N	\N
1005500	0	0	1	52	43	\N	\N
1005501	0	0	1	52	44	\N	\N
1005580	0	0	1	53	43	\N	\N
1005581	0	0	1	53	44	\N	\N
1005660	0	0	1	54	43	\N	\N
1005661	0	0	1	54	44	\N	\N
1005740	0	0	1	55	43	\N	\N
1005741	0	0	1	55	44	\N	\N
1005820	0	0	1	56	43	\N	\N
1005821	0	0	1	56	44	\N	\N
1005900	0	0	1	57	43	\N	\N
1005901	0	0	1	57	44	\N	\N
1005980	0	0	1	58	43	\N	\N
1005981	0	0	1	58	44	\N	\N
1006060	0	0	1	59	43	\N	\N
1006061	0	0	1	59	44	\N	\N
1006140	0	0	1	60	43	\N	\N
1006141	0	0	1	60	44	\N	\N
1006220	0	0	1	61	43	\N	\N
1006221	0	0	1	61	44	\N	\N
1006300	0	0	1	62	43	\N	\N
1006301	0	0	1	62	44	\N	\N
1006380	0	0	1	63	43	\N	\N
1006381	0	0	1	63	44	\N	\N
1004782	0	0	1	43	45	\N	\N
1004783	0	0	1	43	46	\N	\N
1004784	0	0	1	43	47	\N	\N
1004785	0	0	1	43	48	\N	\N
1004786	0	0	1	43	49	\N	\N
1004787	0	0	1	43	50	\N	\N
1004788	0	0	1	43	51	\N	\N
1004789	0	0	1	43	52	\N	\N
1004790	0	0	1	43	53	\N	\N
1004791	0	0	1	43	54	\N	\N
1004792	0	0	1	43	55	\N	\N
1004793	0	0	1	43	56	\N	\N
1004794	0	0	1	43	57	\N	\N
1004795	0	0	1	43	58	\N	\N
1004796	0	0	1	43	59	\N	\N
1004797	0	0	1	43	60	\N	\N
1004798	0	0	1	43	61	\N	\N
1004799	0	0	1	43	62	\N	\N
1004800	0	0	1	43	63	\N	\N
1004862	0	0	1	44	45	\N	\N
1004863	0	0	1	44	46	\N	\N
1004864	0	0	1	44	47	\N	\N
1004865	0	0	1	44	48	\N	\N
1004866	0	0	1	44	49	\N	\N
1004867	0	0	1	44	50	\N	\N
1004868	0	0	1	44	51	\N	\N
1004869	0	0	1	44	52	\N	\N
1004870	0	0	1	44	53	\N	\N
1004871	0	0	1	44	54	\N	\N
1004872	0	0	1	44	55	\N	\N
1004873	0	0	1	44	56	\N	\N
1004874	0	0	1	44	57	\N	\N
1004875	0	0	1	44	58	\N	\N
1004876	0	0	1	44	59	\N	\N
1004877	0	0	1	44	60	\N	\N
1004878	0	0	1	44	61	\N	\N
1004879	0	0	1	44	62	\N	\N
1004880	0	0	1	44	63	\N	\N
1004942	0	0	1	45	45	\N	\N
1004943	0	0	1	45	46	\N	\N
1004944	0	0	1	45	47	\N	\N
1004945	0	0	1	45	48	\N	\N
1004946	0	0	1	45	49	\N	\N
1004947	0	0	1	45	50	\N	\N
1004948	0	0	1	45	51	\N	\N
1004949	0	0	1	45	52	\N	\N
1004950	0	0	1	45	53	\N	\N
1004951	0	0	1	45	54	\N	\N
1004952	0	0	1	45	55	\N	\N
1004953	0	0	1	45	56	\N	\N
1004954	0	0	1	45	57	\N	\N
1004955	0	0	1	45	58	\N	\N
1004956	0	0	1	45	59	\N	\N
1004957	0	0	1	45	60	\N	\N
1004958	0	0	1	45	61	\N	\N
1004959	0	0	1	45	62	\N	\N
1004960	0	0	1	45	63	\N	\N
1005022	0	0	1	46	45	\N	\N
1005023	0	0	1	46	46	\N	\N
1005024	0	0	1	46	47	\N	\N
1005025	0	0	1	46	48	\N	\N
1005026	0	0	1	46	49	\N	\N
1005027	0	0	1	46	50	\N	\N
1005028	0	0	1	46	51	\N	\N
1005029	0	0	1	46	52	\N	\N
1005030	0	0	1	46	53	\N	\N
1005031	0	0	1	46	54	\N	\N
1005032	0	0	1	46	55	\N	\N
1005033	0	0	1	46	56	\N	\N
1005034	0	0	1	46	57	\N	\N
1005035	0	0	1	46	58	\N	\N
1005036	0	0	1	46	59	\N	\N
1005037	0	0	1	46	60	\N	\N
1005038	0	0	1	46	61	\N	\N
1005039	0	0	1	46	62	\N	\N
1005040	0	0	1	46	63	\N	\N
1005102	0	0	1	47	45	\N	\N
1005103	0	0	1	47	46	\N	\N
1005104	0	0	1	47	47	\N	\N
1005105	0	0	1	47	48	\N	\N
1005106	0	0	1	47	49	\N	\N
1005107	0	0	1	47	50	\N	\N
1005108	0	0	1	47	51	\N	\N
1005109	0	0	1	47	52	\N	\N
1005110	0	0	1	47	53	\N	\N
1005111	0	0	1	47	54	\N	\N
1005112	0	0	1	47	55	\N	\N
1005113	0	0	1	47	56	\N	\N
1005114	0	0	1	47	57	\N	\N
1005115	0	0	1	47	58	\N	\N
1005116	0	0	1	47	59	\N	\N
1005117	0	0	1	47	60	\N	\N
1005118	0	0	1	47	61	\N	\N
1005119	0	0	1	47	62	\N	\N
1005120	0	0	1	47	63	\N	\N
1005182	0	0	1	48	45	\N	\N
1005183	0	0	1	48	46	\N	\N
1005184	0	0	1	48	47	\N	\N
1005185	0	0	1	48	48	\N	\N
1005186	0	0	1	48	49	\N	\N
1005187	0	0	1	48	50	\N	\N
1005188	0	0	1	48	51	\N	\N
1005189	0	0	1	48	52	\N	\N
1005190	0	0	1	48	53	\N	\N
1005191	0	0	1	48	54	\N	\N
1005192	0	0	1	48	55	\N	\N
1005193	0	0	1	48	56	\N	\N
1005194	0	0	1	48	57	\N	\N
1005195	0	0	1	48	58	\N	\N
1005196	0	0	1	48	59	\N	\N
1005197	0	0	1	48	60	\N	\N
1005198	0	0	1	48	61	\N	\N
1005199	0	0	1	48	62	\N	\N
1005200	0	0	1	48	63	\N	\N
1005262	0	0	1	49	45	\N	\N
1005263	0	0	1	49	46	\N	\N
1005264	0	0	1	49	47	\N	\N
1005265	0	0	1	49	48	\N	\N
1005266	0	0	1	49	49	\N	\N
1005267	0	0	1	49	50	\N	\N
1005268	0	0	1	49	51	\N	\N
1005269	0	0	1	49	52	\N	\N
1005270	0	0	1	49	53	\N	\N
1005271	0	0	1	49	54	\N	\N
1005272	0	0	1	49	55	\N	\N
1005273	0	0	1	49	56	\N	\N
1005274	0	0	1	49	57	\N	\N
1005275	0	0	1	49	58	\N	\N
1005276	0	0	1	49	59	\N	\N
1005277	0	0	1	49	60	\N	\N
1005278	0	0	1	49	61	\N	\N
1005279	0	0	1	49	62	\N	\N
1005280	0	0	1	49	63	\N	\N
1005342	0	0	1	50	45	\N	\N
1005343	0	0	1	50	46	\N	\N
1005344	0	0	1	50	47	\N	\N
1005345	0	0	1	50	48	\N	\N
1005346	0	0	1	50	49	\N	\N
1005347	0	0	1	50	50	\N	\N
1005348	0	0	1	50	51	\N	\N
1005349	0	0	1	50	52	\N	\N
1005350	0	0	1	50	53	\N	\N
1005351	0	0	1	50	54	\N	\N
1005352	0	0	1	50	55	\N	\N
1005353	0	0	1	50	56	\N	\N
1005354	0	0	1	50	57	\N	\N
1005355	0	0	1	50	58	\N	\N
1005356	0	0	1	50	59	\N	\N
1005357	0	0	1	50	60	\N	\N
1005358	0	0	1	50	61	\N	\N
1005359	0	0	1	50	62	\N	\N
1005360	0	0	1	50	63	\N	\N
1005422	0	0	1	51	45	\N	\N
1005423	0	0	1	51	46	\N	\N
1005424	0	0	1	51	47	\N	\N
1005425	0	0	1	51	48	\N	\N
1005426	0	0	1	51	49	\N	\N
1005427	0	0	1	51	50	\N	\N
1005428	0	0	1	51	51	\N	\N
1005429	0	0	1	51	52	\N	\N
1005430	0	0	1	51	53	\N	\N
1005431	0	0	1	51	54	\N	\N
1005432	0	0	1	51	55	\N	\N
1005433	0	0	1	51	56	\N	\N
1005434	0	0	1	51	57	\N	\N
1005435	0	0	1	51	58	\N	\N
1005436	0	0	1	51	59	\N	\N
1005437	0	0	1	51	60	\N	\N
1005438	0	0	1	51	61	\N	\N
1005439	0	0	1	51	62	\N	\N
1005440	0	0	1	51	63	\N	\N
1005502	0	0	1	52	45	\N	\N
1005503	0	0	1	52	46	\N	\N
1005504	0	0	1	52	47	\N	\N
1005505	0	0	1	52	48	\N	\N
1005506	0	0	1	52	49	\N	\N
1005507	0	0	1	52	50	\N	\N
1005508	0	0	1	52	51	\N	\N
1005509	0	0	1	52	52	\N	\N
1005510	0	0	1	52	53	\N	\N
1005511	0	0	1	52	54	\N	\N
1005512	0	0	1	52	55	\N	\N
1005513	0	0	1	52	56	\N	\N
1005514	0	0	1	52	57	\N	\N
1005515	0	0	1	52	58	\N	\N
1005516	0	0	1	52	59	\N	\N
1005517	0	0	1	52	60	\N	\N
1005518	0	0	1	52	61	\N	\N
1005519	0	0	1	52	62	\N	\N
1005520	0	0	1	52	63	\N	\N
1005582	0	0	1	53	45	\N	\N
1005583	0	0	1	53	46	\N	\N
1005584	0	0	1	53	47	\N	\N
1005585	0	0	1	53	48	\N	\N
1005586	0	0	1	53	49	\N	\N
1005587	0	0	1	53	50	\N	\N
1005588	0	0	1	53	51	\N	\N
1005589	0	0	1	53	52	\N	\N
1005590	0	0	1	53	53	\N	\N
1005591	0	0	1	53	54	\N	\N
1005592	0	0	1	53	55	\N	\N
1005593	0	0	1	53	56	\N	\N
1005594	0	0	1	53	57	\N	\N
1005595	0	0	1	53	58	\N	\N
1005596	0	0	1	53	59	\N	\N
1005597	0	0	1	53	60	\N	\N
1005598	0	0	1	53	61	\N	\N
1005599	0	0	1	53	62	\N	\N
1005600	0	0	1	53	63	\N	\N
1005662	0	0	1	54	45	\N	\N
1005663	0	0	1	54	46	\N	\N
1005664	0	0	1	54	47	\N	\N
1005665	0	0	1	54	48	\N	\N
1005666	0	0	1	54	49	\N	\N
1005667	0	0	1	54	50	\N	\N
1005668	0	0	1	54	51	\N	\N
1005669	0	0	1	54	52	\N	\N
1005670	0	0	1	54	53	\N	\N
1005671	0	0	1	54	54	\N	\N
1005672	0	0	1	54	55	\N	\N
1005673	0	0	1	54	56	\N	\N
1005674	0	0	1	54	57	\N	\N
1005675	0	0	1	54	58	\N	\N
1005676	0	0	1	54	59	\N	\N
1005677	0	0	1	54	60	\N	\N
1005678	0	0	1	54	61	\N	\N
1005679	0	0	1	54	62	\N	\N
1005680	0	0	1	54	63	\N	\N
1005742	0	0	1	55	45	\N	\N
1005743	0	0	1	55	46	\N	\N
1005744	0	0	1	55	47	\N	\N
1005745	0	0	1	55	48	\N	\N
1005746	0	0	1	55	49	\N	\N
1005747	0	0	1	55	50	\N	\N
1005748	0	0	1	55	51	\N	\N
1005749	0	0	1	55	52	\N	\N
1005750	0	0	1	55	53	\N	\N
1005751	0	0	1	55	54	\N	\N
1005752	0	0	1	55	55	\N	\N
1005753	0	0	1	55	56	\N	\N
1005754	0	0	1	55	57	\N	\N
1005755	0	0	1	55	58	\N	\N
1005756	0	0	1	55	59	\N	\N
1005757	0	0	1	55	60	\N	\N
1005758	0	0	1	55	61	\N	\N
1005759	0	0	1	55	62	\N	\N
1005760	0	0	1	55	63	\N	\N
1005822	0	0	1	56	45	\N	\N
1005823	0	0	1	56	46	\N	\N
1005824	0	0	1	56	47	\N	\N
1005825	0	0	1	56	48	\N	\N
1005826	0	0	1	56	49	\N	\N
1005827	0	0	1	56	50	\N	\N
1005828	0	0	1	56	51	\N	\N
1005829	0	0	1	56	52	\N	\N
1005830	0	0	1	56	53	\N	\N
1005831	0	0	1	56	54	\N	\N
1005832	0	0	1	56	55	\N	\N
1005833	0	0	1	56	56	\N	\N
1005834	0	0	1	56	57	\N	\N
1005835	0	0	1	56	58	\N	\N
1005836	0	0	1	56	59	\N	\N
1005837	0	0	1	56	60	\N	\N
1005838	0	0	1	56	61	\N	\N
1005839	0	0	1	56	62	\N	\N
1005840	0	0	1	56	63	\N	\N
1005902	0	0	1	57	45	\N	\N
1005903	0	0	1	57	46	\N	\N
1005904	0	0	1	57	47	\N	\N
1005905	0	0	1	57	48	\N	\N
1005906	0	0	1	57	49	\N	\N
1005907	0	0	1	57	50	\N	\N
1005908	0	0	1	57	51	\N	\N
1005909	0	0	1	57	52	\N	\N
1005910	0	0	1	57	53	\N	\N
1005911	0	0	1	57	54	\N	\N
1005912	0	0	1	57	55	\N	\N
1005913	0	0	1	57	56	\N	\N
1005914	0	0	1	57	57	\N	\N
1005915	0	0	1	57	58	\N	\N
1005916	0	0	1	57	59	\N	\N
1005917	0	0	1	57	60	\N	\N
1005918	0	0	1	57	61	\N	\N
1005919	0	0	1	57	62	\N	\N
1005920	0	0	1	57	63	\N	\N
1005982	0	0	1	58	45	\N	\N
1005983	0	0	1	58	46	\N	\N
1005984	0	0	1	58	47	\N	\N
1005985	0	0	1	58	48	\N	\N
1005986	0	0	1	58	49	\N	\N
1005987	0	0	1	58	50	\N	\N
1005988	0	0	1	58	51	\N	\N
1005989	0	0	1	58	52	\N	\N
1005990	0	0	1	58	53	\N	\N
1005991	0	0	1	58	54	\N	\N
1005992	0	0	1	58	55	\N	\N
1005993	0	0	1	58	56	\N	\N
1005994	0	0	1	58	57	\N	\N
1005995	0	0	1	58	58	\N	\N
1005996	0	0	1	58	59	\N	\N
1005997	0	0	1	58	60	\N	\N
1005998	0	0	1	58	61	\N	\N
1005999	0	0	1	58	62	\N	\N
1006000	0	0	1	58	63	\N	\N
1006062	0	0	1	59	45	\N	\N
1006063	0	0	1	59	46	\N	\N
1006064	0	0	1	59	47	\N	\N
1006065	0	0	1	59	48	\N	\N
1006066	0	0	1	59	49	\N	\N
1006067	0	0	1	59	50	\N	\N
1006068	0	0	1	59	51	\N	\N
1006069	0	0	1	59	52	\N	\N
1006070	0	0	1	59	53	\N	\N
1006071	0	0	1	59	54	\N	\N
1006072	0	0	1	59	55	\N	\N
1006073	0	0	1	59	56	\N	\N
1006074	0	0	1	59	57	\N	\N
1006075	0	0	1	59	58	\N	\N
1006076	0	0	1	59	59	\N	\N
1006077	0	0	1	59	60	\N	\N
1006078	0	0	1	59	61	\N	\N
1006079	0	0	1	59	62	\N	\N
1006080	0	0	1	59	63	\N	\N
1006142	0	0	1	60	45	\N	\N
1006143	0	0	1	60	46	\N	\N
1006144	0	0	1	60	47	\N	\N
1006145	0	0	1	60	48	\N	\N
1006146	0	0	1	60	49	\N	\N
1006147	0	0	1	60	50	\N	\N
1006148	0	0	1	60	51	\N	\N
1006149	0	0	1	60	52	\N	\N
1006150	0	0	1	60	53	\N	\N
1006151	0	0	1	60	54	\N	\N
1006152	0	0	1	60	55	\N	\N
1006153	0	0	1	60	56	\N	\N
1006154	0	0	1	60	57	\N	\N
1006155	0	0	1	60	58	\N	\N
1006156	0	0	1	60	59	\N	\N
1006157	0	0	1	60	60	\N	\N
1006158	0	0	1	60	61	\N	\N
1006159	0	0	1	60	62	\N	\N
1006160	0	0	1	60	63	\N	\N
1006222	0	0	1	61	45	\N	\N
1006223	0	0	1	61	46	\N	\N
1006224	0	0	1	61	47	\N	\N
1006225	0	0	1	61	48	\N	\N
1006226	0	0	1	61	49	\N	\N
1006227	0	0	1	61	50	\N	\N
1006228	0	0	1	61	51	\N	\N
1006229	0	0	1	61	52	\N	\N
1006230	0	0	1	61	53	\N	\N
1006231	0	0	1	61	54	\N	\N
1006232	0	0	1	61	55	\N	\N
1006233	0	0	1	61	56	\N	\N
1006234	0	0	1	61	57	\N	\N
1006235	0	0	1	61	58	\N	\N
1006236	0	0	1	61	59	\N	\N
1006237	0	0	1	61	60	\N	\N
1006238	0	0	1	61	61	\N	\N
1006239	0	0	1	61	62	\N	\N
1006240	0	0	1	61	63	\N	\N
1006302	0	0	1	62	45	\N	\N
1006303	0	0	1	62	46	\N	\N
1006304	0	0	1	62	47	\N	\N
1006305	0	0	1	62	48	\N	\N
1006306	0	0	1	62	49	\N	\N
1006307	0	0	1	62	50	\N	\N
1006308	0	0	1	62	51	\N	\N
1006309	0	0	1	62	52	\N	\N
1006310	0	0	1	62	53	\N	\N
1006311	0	0	1	62	54	\N	\N
1006312	0	0	1	62	55	\N	\N
1006313	0	0	1	62	56	\N	\N
1006314	0	0	1	62	57	\N	\N
1006315	0	0	1	62	58	\N	\N
1006316	0	0	1	62	59	\N	\N
1006317	0	0	1	62	60	\N	\N
1006318	0	0	1	62	61	\N	\N
1006319	0	0	1	62	62	\N	\N
1006320	0	0	1	62	63	\N	\N
1006382	0	0	1	63	45	\N	\N
1006383	0	0	1	63	46	\N	\N
1006384	0	0	1	63	47	\N	\N
1006385	0	0	1	63	48	\N	\N
1006386	0	0	1	63	49	\N	\N
1006387	0	0	1	63	50	\N	\N
1006388	0	0	1	63	51	\N	\N
1006389	0	0	1	63	52	\N	\N
1006390	0	0	1	63	53	\N	\N
1006391	0	0	1	63	54	\N	\N
1006392	0	0	1	63	55	\N	\N
1006393	0	0	1	63	56	\N	\N
1006394	0	0	1	63	57	\N	\N
1006395	0	0	1	63	58	\N	\N
1006396	0	0	1	63	59	\N	\N
1006397	0	0	1	63	60	\N	\N
1006398	0	0	1	63	61	\N	\N
1006399	0	0	1	63	62	\N	\N
1006400	0	0	1	63	63	\N	\N
1002058	0	0	1	9	41	\N	\N
1002059	0	0	1	9	42	\N	\N
1002138	0	0	1	10	41	\N	\N
1002139	0	0	1	10	42	\N	\N
1002218	0	0	1	11	41	\N	\N
1002219	0	0	1	11	42	\N	\N
1002298	0	0	1	12	41	\N	\N
1002299	0	0	1	12	42	\N	\N
1002378	0	0	1	13	41	\N	\N
1002379	0	0	1	13	42	\N	\N
1002458	0	0	1	14	41	\N	\N
1002459	0	0	1	14	42	\N	\N
1002538	0	0	1	15	41	\N	\N
1002539	0	0	1	15	42	\N	\N
1002618	0	0	1	16	41	\N	\N
1002619	0	0	1	16	42	\N	\N
1002698	0	0	1	17	41	\N	\N
1002699	0	0	1	17	42	\N	\N
1002778	0	0	1	18	41	\N	\N
1002779	0	0	1	18	42	\N	\N
1002858	0	0	1	19	41	\N	\N
1002859	0	0	1	19	42	\N	\N
1001887	0	0	1	7	30	\N	\N
1001889	0	0	1	7	32	\N	\N
1001890	0	0	1	7	33	\N	\N
1001891	0	0	1	7	34	\N	\N
1001892	0	0	1	7	35	\N	\N
1001893	0	0	1	7	36	\N	\N
1001894	0	0	1	7	37	\N	\N
1001895	0	0	1	7	38	\N	\N
1001896	0	0	1	7	39	\N	\N
1001897	0	0	1	7	40	\N	\N
1001967	0	0	1	8	30	\N	\N
1001968	0	0	1	8	31	\N	\N
1001969	0	0	1	8	32	\N	\N
1001970	0	0	1	8	33	\N	\N
1001971	0	0	1	8	34	\N	\N
1001972	0	0	1	8	35	\N	\N
1001973	0	0	1	8	36	\N	\N
1001974	0	0	1	8	37	\N	\N
1001975	0	0	1	8	38	\N	\N
1001976	0	0	1	8	39	\N	\N
1001977	0	0	1	8	40	\N	\N
1001898	0	0	1	7	41	\N	\N
1001899	0	0	1	7	42	\N	\N
1001978	0	0	1	8	41	\N	\N
1001979	0	0	1	8	42	\N	\N
1001725	0	0	1	5	28	\N	\N
1001726	0	0	1	5	29	\N	\N
1001805	0	0	1	6	28	\N	\N
1001806	0	0	1	6	29	\N	\N
1000045	0	0	1	-16	28	\N	\N
1000046	0	0	1	-16	29	\N	\N
1000125	0	0	1	-15	28	\N	\N
1000126	0	0	1	-15	29	\N	\N
1000205	0	0	1	-14	28	\N	\N
1000206	0	0	1	-14	29	\N	\N
1000285	0	0	1	-13	28	\N	\N
1000286	0	0	1	-13	29	\N	\N
1000365	0	0	1	-12	28	\N	\N
1000366	0	0	1	-12	29	\N	\N
1000445	0	0	1	-11	28	\N	\N
1000446	0	0	1	-11	29	\N	\N
1000525	0	0	1	-10	28	\N	\N
1000526	0	0	1	-10	29	\N	\N
1000605	0	0	1	-9	28	\N	\N
1000606	0	0	1	-9	29	\N	\N
1000685	0	0	1	-8	28	\N	\N
1000686	0	0	1	-8	29	\N	\N
1000765	0	0	1	-7	28	\N	\N
1000766	0	0	1	-7	29	\N	\N
1000845	0	0	1	-6	28	\N	\N
1000846	0	0	1	-6	29	\N	\N
1000925	0	0	1	-5	28	\N	\N
1000926	0	0	1	-5	29	\N	\N
1001005	0	0	1	-4	28	\N	\N
1001006	0	0	1	-4	29	\N	\N
1001085	0	0	1	-3	28	\N	\N
1001086	0	0	1	-3	29	\N	\N
1001165	0	0	1	-2	28	\N	\N
1001166	0	0	1	-2	29	\N	\N
1001245	0	0	1	-1	28	\N	\N
1001246	0	0	1	-1	29	\N	\N
1001325	0	0	1	0	28	\N	\N
1001326	0	0	1	0	29	\N	\N
1001405	0	0	1	1	28	\N	\N
1001406	0	0	1	1	29	\N	\N
1001485	0	0	1	2	28	\N	\N
1001486	0	0	1	2	29	\N	\N
1001565	0	0	1	3	28	\N	\N
1001566	0	0	1	3	29	\N	\N
1001645	0	0	1	4	28	\N	\N
1001646	0	0	1	4	29	\N	\N
1001727	0	0	1	5	30	\N	\N
1001728	0	0	1	5	31	\N	\N
1001729	0	0	1	5	32	\N	\N
1001730	0	0	1	5	33	\N	\N
1001731	0	0	1	5	34	\N	\N
1001732	0	0	1	5	35	\N	\N
1001733	0	0	1	5	36	\N	\N
1001734	0	0	1	5	37	\N	\N
1001735	0	0	1	5	38	\N	\N
1001736	0	0	1	5	39	\N	\N
1001737	0	0	1	5	40	\N	\N
1001807	0	0	1	6	30	\N	\N
1001808	0	0	1	6	31	\N	\N
1001809	0	0	1	6	32	\N	\N
1001810	0	0	1	6	33	\N	\N
1001811	0	0	1	6	34	\N	\N
1001812	0	0	1	6	35	\N	\N
1001813	0	0	1	6	36	\N	\N
1001814	0	0	1	6	37	\N	\N
1001815	0	0	1	6	38	\N	\N
1001816	0	0	1	6	39	\N	\N
1001817	0	0	1	6	40	\N	\N
1000047	0	0	1	-16	30	\N	\N
1000048	0	0	1	-16	31	\N	\N
1000049	0	0	1	-16	32	\N	\N
1000050	0	0	1	-16	33	\N	\N
1000051	0	0	1	-16	34	\N	\N
1000052	0	0	1	-16	35	\N	\N
1000053	0	0	1	-16	36	\N	\N
1000054	0	0	1	-16	37	\N	\N
1000055	0	0	1	-16	38	\N	\N
1000056	0	0	1	-16	39	\N	\N
1000057	0	0	1	-16	40	\N	\N
1000127	0	0	1	-15	30	\N	\N
1000128	0	0	1	-15	31	\N	\N
1000129	0	0	1	-15	32	\N	\N
1000130	0	0	1	-15	33	\N	\N
1000131	0	0	1	-15	34	\N	\N
1000132	0	0	1	-15	35	\N	\N
1000133	0	0	1	-15	36	\N	\N
1000134	0	0	1	-15	37	\N	\N
1000135	0	0	1	-15	38	\N	\N
1000136	0	0	1	-15	39	\N	\N
1000137	0	0	1	-15	40	\N	\N
1000207	0	0	1	-14	30	\N	\N
1000208	0	0	1	-14	31	\N	\N
1000209	0	0	1	-14	32	\N	\N
1000210	0	0	1	-14	33	\N	\N
1000211	0	0	1	-14	34	\N	\N
1000212	0	0	1	-14	35	\N	\N
1000213	0	0	1	-14	36	\N	\N
1000214	0	0	1	-14	37	\N	\N
1000215	0	0	1	-14	38	\N	\N
1000216	0	0	1	-14	39	\N	\N
1000217	0	0	1	-14	40	\N	\N
1000287	0	0	1	-13	30	\N	\N
1000288	0	0	1	-13	31	\N	\N
1000289	0	0	1	-13	32	\N	\N
1000290	0	0	1	-13	33	\N	\N
1000291	0	0	1	-13	34	\N	\N
1000292	0	0	1	-13	35	\N	\N
1000293	0	0	1	-13	36	\N	\N
1000294	0	0	1	-13	37	\N	\N
1000295	0	0	1	-13	38	\N	\N
1000296	0	0	1	-13	39	\N	\N
1000297	0	0	1	-13	40	\N	\N
1000367	0	0	1	-12	30	\N	\N
1000368	0	0	1	-12	31	\N	\N
1000369	0	0	1	-12	32	\N	\N
1000370	0	0	1	-12	33	\N	\N
1000371	0	0	1	-12	34	\N	\N
1000372	0	0	1	-12	35	\N	\N
1000373	0	0	1	-12	36	\N	\N
1000374	0	0	1	-12	37	\N	\N
1000375	0	0	1	-12	38	\N	\N
1000376	0	0	1	-12	39	\N	\N
1000377	0	0	1	-12	40	\N	\N
1000447	0	0	1	-11	30	\N	\N
1000448	0	0	1	-11	31	\N	\N
1000449	0	0	1	-11	32	\N	\N
1000450	0	0	1	-11	33	\N	\N
1000451	0	0	1	-11	34	\N	\N
1000452	0	0	1	-11	35	\N	\N
1000453	0	0	1	-11	36	\N	\N
1000454	0	0	1	-11	37	\N	\N
1000455	0	0	1	-11	38	\N	\N
1000456	0	0	1	-11	39	\N	\N
1000457	0	0	1	-11	40	\N	\N
1000527	0	0	1	-10	30	\N	\N
1000528	0	0	1	-10	31	\N	\N
1000529	0	0	1	-10	32	\N	\N
1000530	0	0	1	-10	33	\N	\N
1000531	0	0	1	-10	34	\N	\N
1000532	0	0	1	-10	35	\N	\N
1000533	0	0	1	-10	36	\N	\N
1000534	0	0	1	-10	37	\N	\N
1000535	0	0	1	-10	38	\N	\N
1000536	0	0	1	-10	39	\N	\N
1000537	0	0	1	-10	40	\N	\N
1000607	0	0	1	-9	30	\N	\N
1000608	0	0	1	-9	31	\N	\N
1000609	0	0	1	-9	32	\N	\N
1000610	0	0	1	-9	33	\N	\N
1000611	0	0	1	-9	34	\N	\N
1000612	0	0	1	-9	35	\N	\N
1000613	0	0	1	-9	36	\N	\N
1000614	0	0	1	-9	37	\N	\N
1000615	0	0	1	-9	38	\N	\N
1000616	0	0	1	-9	39	\N	\N
1000617	0	0	1	-9	40	\N	\N
1000687	0	0	1	-8	30	\N	\N
1000688	0	0	1	-8	31	\N	\N
1000689	0	0	1	-8	32	\N	\N
1000690	0	0	1	-8	33	\N	\N
1000691	0	0	1	-8	34	\N	\N
1000692	0	0	1	-8	35	\N	\N
1000693	0	0	1	-8	36	\N	\N
1000694	0	0	1	-8	37	\N	\N
1000695	0	0	1	-8	38	\N	\N
1000696	0	0	1	-8	39	\N	\N
1000697	0	0	1	-8	40	\N	\N
1000767	0	0	1	-7	30	\N	\N
1000768	0	0	1	-7	31	\N	\N
1000769	0	0	1	-7	32	\N	\N
1000770	0	0	1	-7	33	\N	\N
1000771	0	0	1	-7	34	\N	\N
1000772	0	0	1	-7	35	\N	\N
1000773	0	0	1	-7	36	\N	\N
1000774	0	0	1	-7	37	\N	\N
1000775	0	0	1	-7	38	\N	\N
1000776	0	0	1	-7	39	\N	\N
1000777	0	0	1	-7	40	\N	\N
1000847	0	0	1	-6	30	\N	\N
1000848	0	0	1	-6	31	\N	\N
1000849	0	0	1	-6	32	\N	\N
1000850	0	0	1	-6	33	\N	\N
1000851	0	0	1	-6	34	\N	\N
1000852	0	0	1	-6	35	\N	\N
1000853	0	0	1	-6	36	\N	\N
1000854	0	0	1	-6	37	\N	\N
1000855	0	0	1	-6	38	\N	\N
1000856	0	0	1	-6	39	\N	\N
1000857	0	0	1	-6	40	\N	\N
1000927	0	0	1	-5	30	\N	\N
1000928	0	0	1	-5	31	\N	\N
1000929	0	0	1	-5	32	\N	\N
1000930	0	0	1	-5	33	\N	\N
1000931	0	0	1	-5	34	\N	\N
1000932	0	0	1	-5	35	\N	\N
1000933	0	0	1	-5	36	\N	\N
1000934	0	0	1	-5	37	\N	\N
1000935	0	0	1	-5	38	\N	\N
1000936	0	0	1	-5	39	\N	\N
1000937	0	0	1	-5	40	\N	\N
1001007	0	0	1	-4	30	\N	\N
1001008	0	0	1	-4	31	\N	\N
1001009	0	0	1	-4	32	\N	\N
1001010	0	0	1	-4	33	\N	\N
1001011	0	0	1	-4	34	\N	\N
1001012	0	0	1	-4	35	\N	\N
1001013	0	0	1	-4	36	\N	\N
1001014	0	0	1	-4	37	\N	\N
1001015	0	0	1	-4	38	\N	\N
1001016	0	0	1	-4	39	\N	\N
1001017	0	0	1	-4	40	\N	\N
1001087	0	0	1	-3	30	\N	\N
1001088	0	0	1	-3	31	\N	\N
1001089	0	0	1	-3	32	\N	\N
1001090	0	0	1	-3	33	\N	\N
1001091	0	0	1	-3	34	\N	\N
1001092	0	0	1	-3	35	\N	\N
1001093	0	0	1	-3	36	\N	\N
1001094	0	0	1	-3	37	\N	\N
1001095	0	0	1	-3	38	\N	\N
1001096	0	0	1	-3	39	\N	\N
1001097	0	0	1	-3	40	\N	\N
1001167	0	0	1	-2	30	\N	\N
1001168	0	0	1	-2	31	\N	\N
1001169	0	0	1	-2	32	\N	\N
1001170	0	0	1	-2	33	\N	\N
1001171	0	0	1	-2	34	\N	\N
1001172	0	0	1	-2	35	\N	\N
1001173	0	0	1	-2	36	\N	\N
1001174	0	0	1	-2	37	\N	\N
1001175	0	0	1	-2	38	\N	\N
1001176	0	0	1	-2	39	\N	\N
1001177	0	0	1	-2	40	\N	\N
1001247	0	0	1	-1	30	\N	\N
1001248	0	0	1	-1	31	\N	\N
1001249	0	0	1	-1	32	\N	\N
1001250	0	0	1	-1	33	\N	\N
1001251	0	0	1	-1	34	\N	\N
1001252	0	0	1	-1	35	\N	\N
1001253	0	0	1	-1	36	\N	\N
1001254	0	0	1	-1	37	\N	\N
1001255	0	0	1	-1	38	\N	\N
1001256	0	0	1	-1	39	\N	\N
1001257	0	0	1	-1	40	\N	\N
1001327	0	0	1	0	30	\N	\N
1001328	0	0	1	0	31	\N	\N
1001329	0	0	1	0	32	\N	\N
1001330	0	0	1	0	33	\N	\N
1001331	0	0	1	0	34	\N	\N
1001332	0	0	1	0	35	\N	\N
1001333	0	0	1	0	36	\N	\N
1001334	0	0	1	0	37	\N	\N
1001335	0	0	1	0	38	\N	\N
1001336	0	0	1	0	39	\N	\N
1001337	0	0	1	0	40	\N	\N
1001407	0	0	1	1	30	\N	\N
1001408	0	0	1	1	31	\N	\N
1001409	0	0	1	1	32	\N	\N
1001410	0	0	1	1	33	\N	\N
1001411	0	0	1	1	34	\N	\N
1001412	0	0	1	1	35	\N	\N
1001413	0	0	1	1	36	\N	\N
1001414	0	0	1	1	37	\N	\N
1001415	0	0	1	1	38	\N	\N
1001416	0	0	1	1	39	\N	\N
1001417	0	0	1	1	40	\N	\N
1001487	0	0	1	2	30	\N	\N
1001488	0	0	1	2	31	\N	\N
1001489	0	0	1	2	32	\N	\N
1001490	0	0	1	2	33	\N	\N
1001491	0	0	1	2	34	\N	\N
1001492	0	0	1	2	35	\N	\N
1001493	0	0	1	2	36	\N	\N
1001494	0	0	1	2	37	\N	\N
1001495	0	0	1	2	38	\N	\N
1001496	0	0	1	2	39	\N	\N
1001497	0	0	1	2	40	\N	\N
1001567	0	0	1	3	30	\N	\N
1001568	0	0	1	3	31	\N	\N
1001569	0	0	1	3	32	\N	\N
1001570	0	0	1	3	33	\N	\N
1001571	0	0	1	3	34	\N	\N
1001572	0	0	1	3	35	\N	\N
1001573	0	0	1	3	36	\N	\N
1001574	0	0	1	3	37	\N	\N
1001575	0	0	1	3	38	\N	\N
1001576	0	0	1	3	39	\N	\N
1001577	0	0	1	3	40	\N	\N
1001647	0	0	1	4	30	\N	\N
1001648	0	0	1	4	31	\N	\N
1001649	0	0	1	4	32	\N	\N
1001650	0	0	1	4	33	\N	\N
1001651	0	0	1	4	34	\N	\N
1001652	0	0	1	4	35	\N	\N
1001653	0	0	1	4	36	\N	\N
1001654	0	0	1	4	37	\N	\N
1001655	0	0	1	4	38	\N	\N
1001656	0	0	1	4	39	\N	\N
1001657	0	0	1	4	40	\N	\N
1001738	0	0	1	5	41	\N	\N
1001739	0	0	1	5	42	\N	\N
1001818	0	0	1	6	41	\N	\N
1001819	0	0	1	6	42	\N	\N
1000058	0	0	1	-16	41	\N	\N
1000059	0	0	1	-16	42	\N	\N
1000138	0	0	1	-15	41	\N	\N
1000139	0	0	1	-15	42	\N	\N
1000218	0	0	1	-14	41	\N	\N
1000219	0	0	1	-14	42	\N	\N
1000298	0	0	1	-13	41	\N	\N
1000299	0	0	1	-13	42	\N	\N
1000378	0	0	1	-12	41	\N	\N
1000379	0	0	1	-12	42	\N	\N
1000458	0	0	1	-11	41	\N	\N
1000459	0	0	1	-11	42	\N	\N
1000538	0	0	1	-10	41	\N	\N
1000539	0	0	1	-10	42	\N	\N
1000618	0	0	1	-9	41	\N	\N
1000619	0	0	1	-9	42	\N	\N
1000698	0	0	1	-8	41	\N	\N
1000699	0	0	1	-8	42	\N	\N
1000778	0	0	1	-7	41	\N	\N
1000779	0	0	1	-7	42	\N	\N
1000858	0	0	1	-6	41	\N	\N
1000859	0	0	1	-6	42	\N	\N
1000938	0	0	1	-5	41	\N	\N
1000939	0	0	1	-5	42	\N	\N
1001018	0	0	1	-4	41	\N	\N
1001019	0	0	1	-4	42	\N	\N
1001098	0	0	1	-3	41	\N	\N
1001099	0	0	1	-3	42	\N	\N
1001178	0	0	1	-2	41	\N	\N
1001179	0	0	1	-2	42	\N	\N
1001258	0	0	1	-1	41	\N	\N
1001259	0	0	1	-1	42	\N	\N
1001338	0	0	1	0	41	\N	\N
1001339	0	0	1	0	42	\N	\N
1001418	0	0	1	1	41	\N	\N
1001419	0	0	1	1	42	\N	\N
1001498	0	0	1	2	41	\N	\N
1001499	0	0	1	2	42	\N	\N
1001578	0	0	1	3	41	\N	\N
1001579	0	0	1	3	42	\N	\N
1001658	0	0	1	4	41	\N	\N
1001659	0	0	1	4	42	\N	\N
1002940	0	0	1	20	43	\N	\N
1002941	0	0	1	20	44	\N	\N
1003020	0	0	1	21	43	\N	\N
1003021	0	0	1	21	44	\N	\N
1002942	0	0	1	20	45	\N	\N
1002943	0	0	1	20	46	\N	\N
1002944	0	0	1	20	47	\N	\N
1002945	0	0	1	20	48	\N	\N
1002946	0	0	1	20	49	\N	\N
1002947	0	0	1	20	50	\N	\N
1002948	0	0	1	20	51	\N	\N
1002949	0	0	1	20	52	\N	\N
1002950	0	0	1	20	53	\N	\N
1002951	0	0	1	20	54	\N	\N
1002952	0	0	1	20	55	\N	\N
1002953	0	0	1	20	56	\N	\N
1002954	0	0	1	20	57	\N	\N
1002955	0	0	1	20	58	\N	\N
1002956	0	0	1	20	59	\N	\N
1002957	0	0	1	20	60	\N	\N
1002958	0	0	1	20	61	\N	\N
1002959	0	0	1	20	62	\N	\N
1002960	0	0	1	20	63	\N	\N
1003022	0	0	1	21	45	\N	\N
1003023	0	0	1	21	46	\N	\N
1003024	0	0	1	21	47	\N	\N
1003025	0	0	1	21	48	\N	\N
1003026	0	0	1	21	49	\N	\N
1003027	0	0	1	21	50	\N	\N
1003028	0	0	1	21	51	\N	\N
1003029	0	0	1	21	52	\N	\N
1003030	0	0	1	21	53	\N	\N
1003031	0	0	1	21	54	\N	\N
1003032	0	0	1	21	55	\N	\N
1003033	0	0	1	21	56	\N	\N
1003034	0	0	1	21	57	\N	\N
1003035	0	0	1	21	58	\N	\N
1003036	0	0	1	21	59	\N	\N
1003037	0	0	1	21	60	\N	\N
1003038	0	0	1	21	61	\N	\N
1003039	0	0	1	21	62	\N	\N
1003040	0	0	1	21	63	\N	\N
1002060	0	0	1	9	43	\N	\N
1002061	0	0	1	9	44	\N	\N
1002140	0	0	1	10	43	\N	\N
1002141	0	0	1	10	44	\N	\N
1002220	0	0	1	11	43	\N	\N
1002221	0	0	1	11	44	\N	\N
1002300	0	0	1	12	43	\N	\N
1002301	0	0	1	12	44	\N	\N
1002380	0	0	1	13	43	\N	\N
1002381	0	0	1	13	44	\N	\N
1002460	0	0	1	14	43	\N	\N
1002461	0	0	1	14	44	\N	\N
1002540	0	0	1	15	43	\N	\N
1002541	0	0	1	15	44	\N	\N
1002620	0	0	1	16	43	\N	\N
1002621	0	0	1	16	44	\N	\N
1002700	0	0	1	17	43	\N	\N
1002701	0	0	1	17	44	\N	\N
1002780	0	0	1	18	43	\N	\N
1002781	0	0	1	18	44	\N	\N
1002860	0	0	1	19	43	\N	\N
1002861	0	0	1	19	44	\N	\N
1002062	0	0	1	9	45	\N	\N
1002063	0	0	1	9	46	\N	\N
1002064	0	0	1	9	47	\N	\N
1002065	0	0	1	9	48	\N	\N
1002066	0	0	1	9	49	\N	\N
1002067	0	0	1	9	50	\N	\N
1002068	0	0	1	9	51	\N	\N
1002069	0	0	1	9	52	\N	\N
1002070	0	0	1	9	53	\N	\N
1002071	0	0	1	9	54	\N	\N
1002072	0	0	1	9	55	\N	\N
1002073	0	0	1	9	56	\N	\N
1002074	0	0	1	9	57	\N	\N
1002075	0	0	1	9	58	\N	\N
1002076	0	0	1	9	59	\N	\N
1002077	0	0	1	9	60	\N	\N
1002078	0	0	1	9	61	\N	\N
1002079	0	0	1	9	62	\N	\N
1002080	0	0	1	9	63	\N	\N
1002142	0	0	1	10	45	\N	\N
1002143	0	0	1	10	46	\N	\N
1002144	0	0	1	10	47	\N	\N
1002145	0	0	1	10	48	\N	\N
1002146	0	0	1	10	49	\N	\N
1002147	0	0	1	10	50	\N	\N
1002148	0	0	1	10	51	\N	\N
1002149	0	0	1	10	52	\N	\N
1002150	0	0	1	10	53	\N	\N
1002151	0	0	1	10	54	\N	\N
1002152	0	0	1	10	55	\N	\N
1002153	0	0	1	10	56	\N	\N
1002154	0	0	1	10	57	\N	\N
1002155	0	0	1	10	58	\N	\N
1002156	0	0	1	10	59	\N	\N
1002157	0	0	1	10	60	\N	\N
1002158	0	0	1	10	61	\N	\N
1002159	0	0	1	10	62	\N	\N
1002160	0	0	1	10	63	\N	\N
1002222	0	0	1	11	45	\N	\N
1002223	0	0	1	11	46	\N	\N
1002224	0	0	1	11	47	\N	\N
1002225	0	0	1	11	48	\N	\N
1002226	0	0	1	11	49	\N	\N
1002227	0	0	1	11	50	\N	\N
1002228	0	0	1	11	51	\N	\N
1002229	0	0	1	11	52	\N	\N
1002230	0	0	1	11	53	\N	\N
1002231	0	0	1	11	54	\N	\N
1002232	0	0	1	11	55	\N	\N
1002233	0	0	1	11	56	\N	\N
1002234	0	0	1	11	57	\N	\N
1002235	0	0	1	11	58	\N	\N
1002236	0	0	1	11	59	\N	\N
1002237	0	0	1	11	60	\N	\N
1002238	0	0	1	11	61	\N	\N
1002239	0	0	1	11	62	\N	\N
1002240	0	0	1	11	63	\N	\N
1002302	0	0	1	12	45	\N	\N
1002303	0	0	1	12	46	\N	\N
1002304	0	0	1	12	47	\N	\N
1002305	0	0	1	12	48	\N	\N
1002306	0	0	1	12	49	\N	\N
1002307	0	0	1	12	50	\N	\N
1002308	0	0	1	12	51	\N	\N
1002309	0	0	1	12	52	\N	\N
1002310	0	0	1	12	53	\N	\N
1002311	0	0	1	12	54	\N	\N
1002312	0	0	1	12	55	\N	\N
1002313	0	0	1	12	56	\N	\N
1002314	0	0	1	12	57	\N	\N
1002315	0	0	1	12	58	\N	\N
1002316	0	0	1	12	59	\N	\N
1002317	0	0	1	12	60	\N	\N
1002318	0	0	1	12	61	\N	\N
1002319	0	0	1	12	62	\N	\N
1002320	0	0	1	12	63	\N	\N
1002382	0	0	1	13	45	\N	\N
1002383	0	0	1	13	46	\N	\N
1002384	0	0	1	13	47	\N	\N
1002385	0	0	1	13	48	\N	\N
1002386	0	0	1	13	49	\N	\N
1002387	0	0	1	13	50	\N	\N
1002388	0	0	1	13	51	\N	\N
1002389	0	0	1	13	52	\N	\N
1002390	0	0	1	13	53	\N	\N
1002391	0	0	1	13	54	\N	\N
1002392	0	0	1	13	55	\N	\N
1002393	0	0	1	13	56	\N	\N
1002394	0	0	1	13	57	\N	\N
1002395	0	0	1	13	58	\N	\N
1002396	0	0	1	13	59	\N	\N
1002397	0	0	1	13	60	\N	\N
1002398	0	0	1	13	61	\N	\N
1002399	0	0	1	13	62	\N	\N
1002400	0	0	1	13	63	\N	\N
1002462	0	0	1	14	45	\N	\N
1002463	0	0	1	14	46	\N	\N
1002464	0	0	1	14	47	\N	\N
1002465	0	0	1	14	48	\N	\N
1002466	0	0	1	14	49	\N	\N
1002467	0	0	1	14	50	\N	\N
1002468	0	0	1	14	51	\N	\N
1002469	0	0	1	14	52	\N	\N
1002470	0	0	1	14	53	\N	\N
1002471	0	0	1	14	54	\N	\N
1002472	0	0	1	14	55	\N	\N
1002473	0	0	1	14	56	\N	\N
1002474	0	0	1	14	57	\N	\N
1002475	0	0	1	14	58	\N	\N
1002476	0	0	1	14	59	\N	\N
1002477	0	0	1	14	60	\N	\N
1002478	0	0	1	14	61	\N	\N
1002479	0	0	1	14	62	\N	\N
1002480	0	0	1	14	63	\N	\N
1002542	0	0	1	15	45	\N	\N
1002543	0	0	1	15	46	\N	\N
1002544	0	0	1	15	47	\N	\N
1002545	0	0	1	15	48	\N	\N
1002546	0	0	1	15	49	\N	\N
1002547	0	0	1	15	50	\N	\N
1002548	0	0	1	15	51	\N	\N
1002549	0	0	1	15	52	\N	\N
1002550	0	0	1	15	53	\N	\N
1002551	0	0	1	15	54	\N	\N
1002552	0	0	1	15	55	\N	\N
1002553	0	0	1	15	56	\N	\N
1002554	0	0	1	15	57	\N	\N
1002555	0	0	1	15	58	\N	\N
1002556	0	0	1	15	59	\N	\N
1002557	0	0	1	15	60	\N	\N
1002558	0	0	1	15	61	\N	\N
1002559	0	0	1	15	62	\N	\N
1002560	0	0	1	15	63	\N	\N
1002622	0	0	1	16	45	\N	\N
1002623	0	0	1	16	46	\N	\N
1002624	0	0	1	16	47	\N	\N
1002625	0	0	1	16	48	\N	\N
1002626	0	0	1	16	49	\N	\N
1002627	0	0	1	16	50	\N	\N
1002628	0	0	1	16	51	\N	\N
1002629	0	0	1	16	52	\N	\N
1002630	0	0	1	16	53	\N	\N
1002631	0	0	1	16	54	\N	\N
1002632	0	0	1	16	55	\N	\N
1002633	0	0	1	16	56	\N	\N
1002634	0	0	1	16	57	\N	\N
1002635	0	0	1	16	58	\N	\N
1002636	0	0	1	16	59	\N	\N
1002637	0	0	1	16	60	\N	\N
1002638	0	0	1	16	61	\N	\N
1002639	0	0	1	16	62	\N	\N
1002640	0	0	1	16	63	\N	\N
1002702	0	0	1	17	45	\N	\N
1002703	0	0	1	17	46	\N	\N
1002704	0	0	1	17	47	\N	\N
1002705	0	0	1	17	48	\N	\N
1002706	0	0	1	17	49	\N	\N
1002707	0	0	1	17	50	\N	\N
1002708	0	0	1	17	51	\N	\N
1002709	0	0	1	17	52	\N	\N
1002710	0	0	1	17	53	\N	\N
1002711	0	0	1	17	54	\N	\N
1002712	0	0	1	17	55	\N	\N
1002713	0	0	1	17	56	\N	\N
1002714	0	0	1	17	57	\N	\N
1002715	0	0	1	17	58	\N	\N
1002716	0	0	1	17	59	\N	\N
1002717	0	0	1	17	60	\N	\N
1002718	0	0	1	17	61	\N	\N
1002719	0	0	1	17	62	\N	\N
1002720	0	0	1	17	63	\N	\N
1002782	0	0	1	18	45	\N	\N
1002783	0	0	1	18	46	\N	\N
1002784	0	0	1	18	47	\N	\N
1002785	0	0	1	18	48	\N	\N
1002786	0	0	1	18	49	\N	\N
1002787	0	0	1	18	50	\N	\N
1002788	0	0	1	18	51	\N	\N
1002789	0	0	1	18	52	\N	\N
1002790	0	0	1	18	53	\N	\N
1002791	0	0	1	18	54	\N	\N
1002792	0	0	1	18	55	\N	\N
1002793	0	0	1	18	56	\N	\N
1002794	0	0	1	18	57	\N	\N
1002795	0	0	1	18	58	\N	\N
1002796	0	0	1	18	59	\N	\N
1002797	0	0	1	18	60	\N	\N
1002798	0	0	1	18	61	\N	\N
1002799	0	0	1	18	62	\N	\N
1002800	0	0	1	18	63	\N	\N
1002862	0	0	1	19	45	\N	\N
1002863	0	0	1	19	46	\N	\N
1002864	0	0	1	19	47	\N	\N
1002865	0	0	1	19	48	\N	\N
1002866	0	0	1	19	49	\N	\N
1002867	0	0	1	19	50	\N	\N
1002868	0	0	1	19	51	\N	\N
1002869	0	0	1	19	52	\N	\N
1002870	0	0	1	19	53	\N	\N
1002871	0	0	1	19	54	\N	\N
1002872	0	0	1	19	55	\N	\N
1002873	0	0	1	19	56	\N	\N
1002874	0	0	1	19	57	\N	\N
1002875	0	0	1	19	58	\N	\N
1002876	0	0	1	19	59	\N	\N
1002877	0	0	1	19	60	\N	\N
1002878	0	0	1	19	61	\N	\N
1002879	0	0	1	19	62	\N	\N
1002880	0	0	1	19	63	\N	\N
1001900	0	0	1	7	43	\N	\N
1001901	0	0	1	7	44	\N	\N
1001980	0	0	1	8	43	\N	\N
1001981	0	0	1	8	44	\N	\N
1001902	0	0	1	7	45	\N	\N
1001903	0	0	1	7	46	\N	\N
1001904	0	0	1	7	47	\N	\N
1001905	0	0	1	7	48	\N	\N
1001906	0	0	1	7	49	\N	\N
1001907	0	0	1	7	50	\N	\N
1001908	0	0	1	7	51	\N	\N
1001909	0	0	1	7	52	\N	\N
1001910	0	0	1	7	53	\N	\N
1001911	0	0	1	7	54	\N	\N
1001912	0	0	1	7	55	\N	\N
1001913	0	0	1	7	56	\N	\N
1001914	0	0	1	7	57	\N	\N
1001915	0	0	1	7	58	\N	\N
1001916	0	0	1	7	59	\N	\N
1001917	0	0	1	7	60	\N	\N
1001918	0	0	1	7	61	\N	\N
1001919	0	0	1	7	62	\N	\N
1001920	0	0	1	7	63	\N	\N
1001982	0	0	1	8	45	\N	\N
1001983	0	0	1	8	46	\N	\N
1001984	0	0	1	8	47	\N	\N
1001985	0	0	1	8	48	\N	\N
1001986	0	0	1	8	49	\N	\N
1001987	0	0	1	8	50	\N	\N
1001988	0	0	1	8	51	\N	\N
1001989	0	0	1	8	52	\N	\N
1001990	0	0	1	8	53	\N	\N
1001991	0	0	1	8	54	\N	\N
1001992	0	0	1	8	55	\N	\N
1001993	0	0	1	8	56	\N	\N
1001994	0	0	1	8	57	\N	\N
1001995	0	0	1	8	58	\N	\N
1001996	0	0	1	8	59	\N	\N
1001997	0	0	1	8	60	\N	\N
1001998	0	0	1	8	61	\N	\N
1001999	0	0	1	8	62	\N	\N
1002000	0	0	1	8	63	\N	\N
1001740	0	0	1	5	43	\N	\N
1001741	0	0	1	5	44	\N	\N
1001820	0	0	1	6	43	\N	\N
1001821	0	0	1	6	44	\N	\N
1000060	0	0	1	-16	43	\N	\N
1000061	0	0	1	-16	44	\N	\N
1000140	0	0	1	-15	43	\N	\N
1000141	0	0	1	-15	44	\N	\N
1000220	0	0	1	-14	43	\N	\N
1000221	0	0	1	-14	44	\N	\N
1000300	0	0	1	-13	43	\N	\N
1000301	0	0	1	-13	44	\N	\N
1000380	0	0	1	-12	43	\N	\N
1000381	0	0	1	-12	44	\N	\N
1000460	0	0	1	-11	43	\N	\N
1000461	0	0	1	-11	44	\N	\N
1000540	0	0	1	-10	43	\N	\N
1000541	0	0	1	-10	44	\N	\N
1000620	0	0	1	-9	43	\N	\N
1000621	0	0	1	-9	44	\N	\N
1000700	0	0	1	-8	43	\N	\N
1000701	0	0	1	-8	44	\N	\N
1000780	0	0	1	-7	43	\N	\N
1000781	0	0	1	-7	44	\N	\N
1000860	0	0	1	-6	43	\N	\N
1000861	0	0	1	-6	44	\N	\N
1000940	0	0	1	-5	43	\N	\N
1000941	0	0	1	-5	44	\N	\N
1001020	0	0	1	-4	43	\N	\N
1001021	0	0	1	-4	44	\N	\N
1001100	0	0	1	-3	43	\N	\N
1001101	0	0	1	-3	44	\N	\N
1001180	0	0	1	-2	43	\N	\N
1001181	0	0	1	-2	44	\N	\N
1001260	0	0	1	-1	43	\N	\N
1001261	0	0	1	-1	44	\N	\N
1001340	0	0	1	0	43	\N	\N
1001341	0	0	1	0	44	\N	\N
1001420	0	0	1	1	43	\N	\N
1001421	0	0	1	1	44	\N	\N
1001500	0	0	1	2	43	\N	\N
1001501	0	0	1	2	44	\N	\N
1001580	0	0	1	3	43	\N	\N
1001581	0	0	1	3	44	\N	\N
1001660	0	0	1	4	43	\N	\N
1001661	0	0	1	4	44	\N	\N
1001742	0	0	1	5	45	\N	\N
1001743	0	0	1	5	46	\N	\N
1001744	0	0	1	5	47	\N	\N
1001745	0	0	1	5	48	\N	\N
1001746	0	0	1	5	49	\N	\N
1001747	0	0	1	5	50	\N	\N
1001748	0	0	1	5	51	\N	\N
1001749	0	0	1	5	52	\N	\N
1001750	0	0	1	5	53	\N	\N
1001751	0	0	1	5	54	\N	\N
1001752	0	0	1	5	55	\N	\N
1001753	0	0	1	5	56	\N	\N
1001754	0	0	1	5	57	\N	\N
1001755	0	0	1	5	58	\N	\N
1001756	0	0	1	5	59	\N	\N
1001757	0	0	1	5	60	\N	\N
1001758	0	0	1	5	61	\N	\N
1001759	0	0	1	5	62	\N	\N
1001760	0	0	1	5	63	\N	\N
1001822	0	0	1	6	45	\N	\N
1001823	0	0	1	6	46	\N	\N
1001824	0	0	1	6	47	\N	\N
1001825	0	0	1	6	48	\N	\N
1001826	0	0	1	6	49	\N	\N
1001827	0	0	1	6	50	\N	\N
1001828	0	0	1	6	51	\N	\N
1001829	0	0	1	6	52	\N	\N
1001830	0	0	1	6	53	\N	\N
1001831	0	0	1	6	54	\N	\N
1001832	0	0	1	6	55	\N	\N
1001833	0	0	1	6	56	\N	\N
1001834	0	0	1	6	57	\N	\N
1001835	0	0	1	6	58	\N	\N
1001836	0	0	1	6	59	\N	\N
1001837	0	0	1	6	60	\N	\N
1001838	0	0	1	6	61	\N	\N
1001839	0	0	1	6	62	\N	\N
1001840	0	0	1	6	63	\N	\N
1000062	0	0	1	-16	45	\N	\N
1000063	0	0	1	-16	46	\N	\N
1000064	0	0	1	-16	47	\N	\N
1000065	0	0	1	-16	48	\N	\N
1000066	0	0	1	-16	49	\N	\N
1000067	0	0	1	-16	50	\N	\N
1000068	0	0	1	-16	51	\N	\N
1000069	0	0	1	-16	52	\N	\N
1000070	0	0	1	-16	53	\N	\N
1000071	0	0	1	-16	54	\N	\N
1000072	0	0	1	-16	55	\N	\N
1000073	0	0	1	-16	56	\N	\N
1000074	0	0	1	-16	57	\N	\N
1000075	0	0	1	-16	58	\N	\N
1000076	0	0	1	-16	59	\N	\N
1000077	0	0	1	-16	60	\N	\N
1000078	0	0	1	-16	61	\N	\N
1000079	0	0	1	-16	62	\N	\N
1000080	0	0	1	-16	63	\N	\N
1000142	0	0	1	-15	45	\N	\N
1000143	0	0	1	-15	46	\N	\N
1000144	0	0	1	-15	47	\N	\N
1000145	0	0	1	-15	48	\N	\N
1000146	0	0	1	-15	49	\N	\N
1000147	0	0	1	-15	50	\N	\N
1000148	0	0	1	-15	51	\N	\N
1000149	0	0	1	-15	52	\N	\N
1000150	0	0	1	-15	53	\N	\N
1000151	0	0	1	-15	54	\N	\N
1000152	0	0	1	-15	55	\N	\N
1000153	0	0	1	-15	56	\N	\N
1000154	0	0	1	-15	57	\N	\N
1000155	0	0	1	-15	58	\N	\N
1000156	0	0	1	-15	59	\N	\N
1000157	0	0	1	-15	60	\N	\N
1000158	0	0	1	-15	61	\N	\N
1000159	0	0	1	-15	62	\N	\N
1000160	0	0	1	-15	63	\N	\N
1000222	0	0	1	-14	45	\N	\N
1000223	0	0	1	-14	46	\N	\N
1000224	0	0	1	-14	47	\N	\N
1000225	0	0	1	-14	48	\N	\N
1000226	0	0	1	-14	49	\N	\N
1000227	0	0	1	-14	50	\N	\N
1000228	0	0	1	-14	51	\N	\N
1000229	0	0	1	-14	52	\N	\N
1000230	0	0	1	-14	53	\N	\N
1000231	0	0	1	-14	54	\N	\N
1000232	0	0	1	-14	55	\N	\N
1000233	0	0	1	-14	56	\N	\N
1000234	0	0	1	-14	57	\N	\N
1000235	0	0	1	-14	58	\N	\N
1000236	0	0	1	-14	59	\N	\N
1000237	0	0	1	-14	60	\N	\N
1000238	0	0	1	-14	61	\N	\N
1000239	0	0	1	-14	62	\N	\N
1000240	0	0	1	-14	63	\N	\N
1000302	0	0	1	-13	45	\N	\N
1000303	0	0	1	-13	46	\N	\N
1000304	0	0	1	-13	47	\N	\N
1000305	0	0	1	-13	48	\N	\N
1000306	0	0	1	-13	49	\N	\N
1000307	0	0	1	-13	50	\N	\N
1000308	0	0	1	-13	51	\N	\N
1000309	0	0	1	-13	52	\N	\N
1000310	0	0	1	-13	53	\N	\N
1000311	0	0	1	-13	54	\N	\N
1000312	0	0	1	-13	55	\N	\N
1000313	0	0	1	-13	56	\N	\N
1000314	0	0	1	-13	57	\N	\N
1000315	0	0	1	-13	58	\N	\N
1000316	0	0	1	-13	59	\N	\N
1000317	0	0	1	-13	60	\N	\N
1000318	0	0	1	-13	61	\N	\N
1000319	0	0	1	-13	62	\N	\N
1000320	0	0	1	-13	63	\N	\N
1000382	0	0	1	-12	45	\N	\N
1000383	0	0	1	-12	46	\N	\N
1000384	0	0	1	-12	47	\N	\N
1000385	0	0	1	-12	48	\N	\N
1000386	0	0	1	-12	49	\N	\N
1000387	0	0	1	-12	50	\N	\N
1000388	0	0	1	-12	51	\N	\N
1000389	0	0	1	-12	52	\N	\N
1000390	0	0	1	-12	53	\N	\N
1000391	0	0	1	-12	54	\N	\N
1000392	0	0	1	-12	55	\N	\N
1000393	0	0	1	-12	56	\N	\N
1000394	0	0	1	-12	57	\N	\N
1000395	0	0	1	-12	58	\N	\N
1000396	0	0	1	-12	59	\N	\N
1000397	0	0	1	-12	60	\N	\N
1000398	0	0	1	-12	61	\N	\N
1000399	0	0	1	-12	62	\N	\N
1000400	0	0	1	-12	63	\N	\N
1000462	0	0	1	-11	45	\N	\N
1000463	0	0	1	-11	46	\N	\N
1000464	0	0	1	-11	47	\N	\N
1000465	0	0	1	-11	48	\N	\N
1000466	0	0	1	-11	49	\N	\N
1000467	0	0	1	-11	50	\N	\N
1000468	0	0	1	-11	51	\N	\N
1000469	0	0	1	-11	52	\N	\N
1000470	0	0	1	-11	53	\N	\N
1000471	0	0	1	-11	54	\N	\N
1000472	0	0	1	-11	55	\N	\N
1000473	0	0	1	-11	56	\N	\N
1000474	0	0	1	-11	57	\N	\N
1000475	0	0	1	-11	58	\N	\N
1000476	0	0	1	-11	59	\N	\N
1000477	0	0	1	-11	60	\N	\N
1000478	0	0	1	-11	61	\N	\N
1000479	0	0	1	-11	62	\N	\N
1000480	0	0	1	-11	63	\N	\N
1000542	0	0	1	-10	45	\N	\N
1000543	0	0	1	-10	46	\N	\N
1000544	0	0	1	-10	47	\N	\N
1000545	0	0	1	-10	48	\N	\N
1000546	0	0	1	-10	49	\N	\N
1000547	0	0	1	-10	50	\N	\N
1000548	0	0	1	-10	51	\N	\N
1000549	0	0	1	-10	52	\N	\N
1000550	0	0	1	-10	53	\N	\N
1000551	0	0	1	-10	54	\N	\N
1000552	0	0	1	-10	55	\N	\N
1000553	0	0	1	-10	56	\N	\N
1000554	0	0	1	-10	57	\N	\N
1000555	0	0	1	-10	58	\N	\N
1000556	0	0	1	-10	59	\N	\N
1000557	0	0	1	-10	60	\N	\N
1000558	0	0	1	-10	61	\N	\N
1000559	0	0	1	-10	62	\N	\N
1000560	0	0	1	-10	63	\N	\N
1000622	0	0	1	-9	45	\N	\N
1000623	0	0	1	-9	46	\N	\N
1000624	0	0	1	-9	47	\N	\N
1000625	0	0	1	-9	48	\N	\N
1000626	0	0	1	-9	49	\N	\N
1000627	0	0	1	-9	50	\N	\N
1000628	0	0	1	-9	51	\N	\N
1000629	0	0	1	-9	52	\N	\N
1000630	0	0	1	-9	53	\N	\N
1000631	0	0	1	-9	54	\N	\N
1000632	0	0	1	-9	55	\N	\N
1000633	0	0	1	-9	56	\N	\N
1000634	0	0	1	-9	57	\N	\N
1000635	0	0	1	-9	58	\N	\N
1000636	0	0	1	-9	59	\N	\N
1000637	0	0	1	-9	60	\N	\N
1000638	0	0	1	-9	61	\N	\N
1000639	0	0	1	-9	62	\N	\N
1000640	0	0	1	-9	63	\N	\N
1000702	0	0	1	-8	45	\N	\N
1000703	0	0	1	-8	46	\N	\N
1000704	0	0	1	-8	47	\N	\N
1000705	0	0	1	-8	48	\N	\N
1000706	0	0	1	-8	49	\N	\N
1000707	0	0	1	-8	50	\N	\N
1000708	0	0	1	-8	51	\N	\N
1000709	0	0	1	-8	52	\N	\N
1000710	0	0	1	-8	53	\N	\N
1000711	0	0	1	-8	54	\N	\N
1000712	0	0	1	-8	55	\N	\N
1000713	0	0	1	-8	56	\N	\N
1000714	0	0	1	-8	57	\N	\N
1000715	0	0	1	-8	58	\N	\N
1000716	0	0	1	-8	59	\N	\N
1000717	0	0	1	-8	60	\N	\N
1000718	0	0	1	-8	61	\N	\N
1000719	0	0	1	-8	62	\N	\N
1000720	0	0	1	-8	63	\N	\N
1000782	0	0	1	-7	45	\N	\N
1000783	0	0	1	-7	46	\N	\N
1000784	0	0	1	-7	47	\N	\N
1000785	0	0	1	-7	48	\N	\N
1000786	0	0	1	-7	49	\N	\N
1000787	0	0	1	-7	50	\N	\N
1000788	0	0	1	-7	51	\N	\N
1000789	0	0	1	-7	52	\N	\N
1000790	0	0	1	-7	53	\N	\N
1000791	0	0	1	-7	54	\N	\N
1000792	0	0	1	-7	55	\N	\N
1000793	0	0	1	-7	56	\N	\N
1000794	0	0	1	-7	57	\N	\N
1000795	0	0	1	-7	58	\N	\N
1000796	0	0	1	-7	59	\N	\N
1000797	0	0	1	-7	60	\N	\N
1000798	0	0	1	-7	61	\N	\N
1000799	0	0	1	-7	62	\N	\N
1000800	0	0	1	-7	63	\N	\N
1000862	0	0	1	-6	45	\N	\N
1000863	0	0	1	-6	46	\N	\N
1000864	0	0	1	-6	47	\N	\N
1000865	0	0	1	-6	48	\N	\N
1000866	0	0	1	-6	49	\N	\N
1000867	0	0	1	-6	50	\N	\N
1000868	0	0	1	-6	51	\N	\N
1000869	0	0	1	-6	52	\N	\N
1000870	0	0	1	-6	53	\N	\N
1000871	0	0	1	-6	54	\N	\N
1000872	0	0	1	-6	55	\N	\N
1000873	0	0	1	-6	56	\N	\N
1000874	0	0	1	-6	57	\N	\N
1000875	0	0	1	-6	58	\N	\N
1000876	0	0	1	-6	59	\N	\N
1000877	0	0	1	-6	60	\N	\N
1000878	0	0	1	-6	61	\N	\N
1000879	0	0	1	-6	62	\N	\N
1000880	0	0	1	-6	63	\N	\N
1000942	0	0	1	-5	45	\N	\N
1000943	0	0	1	-5	46	\N	\N
1000944	0	0	1	-5	47	\N	\N
1000945	0	0	1	-5	48	\N	\N
1000946	0	0	1	-5	49	\N	\N
1000947	0	0	1	-5	50	\N	\N
1000948	0	0	1	-5	51	\N	\N
1000949	0	0	1	-5	52	\N	\N
1000950	0	0	1	-5	53	\N	\N
1000951	0	0	1	-5	54	\N	\N
1000952	0	0	1	-5	55	\N	\N
1000953	0	0	1	-5	56	\N	\N
1000954	0	0	1	-5	57	\N	\N
1000955	0	0	1	-5	58	\N	\N
1000956	0	0	1	-5	59	\N	\N
1000957	0	0	1	-5	60	\N	\N
1000958	0	0	1	-5	61	\N	\N
1000959	0	0	1	-5	62	\N	\N
1000960	0	0	1	-5	63	\N	\N
1001022	0	0	1	-4	45	\N	\N
1001023	0	0	1	-4	46	\N	\N
1001024	0	0	1	-4	47	\N	\N
1001025	0	0	1	-4	48	\N	\N
1001026	0	0	1	-4	49	\N	\N
1001027	0	0	1	-4	50	\N	\N
1001028	0	0	1	-4	51	\N	\N
1001029	0	0	1	-4	52	\N	\N
1001030	0	0	1	-4	53	\N	\N
1001031	0	0	1	-4	54	\N	\N
1001032	0	0	1	-4	55	\N	\N
1001033	0	0	1	-4	56	\N	\N
1001034	0	0	1	-4	57	\N	\N
1001035	0	0	1	-4	58	\N	\N
1001036	0	0	1	-4	59	\N	\N
1001037	0	0	1	-4	60	\N	\N
1001038	0	0	1	-4	61	\N	\N
1001039	0	0	1	-4	62	\N	\N
1001040	0	0	1	-4	63	\N	\N
1001102	0	0	1	-3	45	\N	\N
1001103	0	0	1	-3	46	\N	\N
1001104	0	0	1	-3	47	\N	\N
1001105	0	0	1	-3	48	\N	\N
1001106	0	0	1	-3	49	\N	\N
1001107	0	0	1	-3	50	\N	\N
1001108	0	0	1	-3	51	\N	\N
1001109	0	0	1	-3	52	\N	\N
1001110	0	0	1	-3	53	\N	\N
1001111	0	0	1	-3	54	\N	\N
1001112	0	0	1	-3	55	\N	\N
1001113	0	0	1	-3	56	\N	\N
1001114	0	0	1	-3	57	\N	\N
1001115	0	0	1	-3	58	\N	\N
1001116	0	0	1	-3	59	\N	\N
1001117	0	0	1	-3	60	\N	\N
1001118	0	0	1	-3	61	\N	\N
1001119	0	0	1	-3	62	\N	\N
1001120	0	0	1	-3	63	\N	\N
1001182	0	0	1	-2	45	\N	\N
1001183	0	0	1	-2	46	\N	\N
1001184	0	0	1	-2	47	\N	\N
1001185	0	0	1	-2	48	\N	\N
1001186	0	0	1	-2	49	\N	\N
1001187	0	0	1	-2	50	\N	\N
1001188	0	0	1	-2	51	\N	\N
1001189	0	0	1	-2	52	\N	\N
1001190	0	0	1	-2	53	\N	\N
1001191	0	0	1	-2	54	\N	\N
1001192	0	0	1	-2	55	\N	\N
1001193	0	0	1	-2	56	\N	\N
1001194	0	0	1	-2	57	\N	\N
1001195	0	0	1	-2	58	\N	\N
1001196	0	0	1	-2	59	\N	\N
1001197	0	0	1	-2	60	\N	\N
1001198	0	0	1	-2	61	\N	\N
1001199	0	0	1	-2	62	\N	\N
1001200	0	0	1	-2	63	\N	\N
1001262	0	0	1	-1	45	\N	\N
1001263	0	0	1	-1	46	\N	\N
1001264	0	0	1	-1	47	\N	\N
1001265	0	0	1	-1	48	\N	\N
1001266	0	0	1	-1	49	\N	\N
1001267	0	0	1	-1	50	\N	\N
1001268	0	0	1	-1	51	\N	\N
1001269	0	0	1	-1	52	\N	\N
1001270	0	0	1	-1	53	\N	\N
1001271	0	0	1	-1	54	\N	\N
1001272	0	0	1	-1	55	\N	\N
1001273	0	0	1	-1	56	\N	\N
1001274	0	0	1	-1	57	\N	\N
1001275	0	0	1	-1	58	\N	\N
1001276	0	0	1	-1	59	\N	\N
1001277	0	0	1	-1	60	\N	\N
1001278	0	0	1	-1	61	\N	\N
1001279	0	0	1	-1	62	\N	\N
1001280	0	0	1	-1	63	\N	\N
1001342	0	0	1	0	45	\N	\N
1001343	0	0	1	0	46	\N	\N
1001344	0	0	1	0	47	\N	\N
1001345	0	0	1	0	48	\N	\N
1001346	0	0	1	0	49	\N	\N
1001347	0	0	1	0	50	\N	\N
1001348	0	0	1	0	51	\N	\N
1001349	0	0	1	0	52	\N	\N
1001350	0	0	1	0	53	\N	\N
1001351	0	0	1	0	54	\N	\N
1001352	0	0	1	0	55	\N	\N
1001353	0	0	1	0	56	\N	\N
1001354	0	0	1	0	57	\N	\N
1001355	0	0	1	0	58	\N	\N
1001356	0	0	1	0	59	\N	\N
1001357	0	0	1	0	60	\N	\N
1001358	0	0	1	0	61	\N	\N
1001359	0	0	1	0	62	\N	\N
1001360	0	0	1	0	63	\N	\N
1001422	0	0	1	1	45	\N	\N
1001423	0	0	1	1	46	\N	\N
1001424	0	0	1	1	47	\N	\N
1001425	0	0	1	1	48	\N	\N
1001426	0	0	1	1	49	\N	\N
1001427	0	0	1	1	50	\N	\N
1001428	0	0	1	1	51	\N	\N
1001429	0	0	1	1	52	\N	\N
1001430	0	0	1	1	53	\N	\N
1001431	0	0	1	1	54	\N	\N
1001432	0	0	1	1	55	\N	\N
1001433	0	0	1	1	56	\N	\N
1001434	0	0	1	1	57	\N	\N
1001435	0	0	1	1	58	\N	\N
1001436	0	0	1	1	59	\N	\N
1001437	0	0	1	1	60	\N	\N
1001438	0	0	1	1	61	\N	\N
1001439	0	0	1	1	62	\N	\N
1001440	0	0	1	1	63	\N	\N
1001502	0	0	1	2	45	\N	\N
1001503	0	0	1	2	46	\N	\N
1001504	0	0	1	2	47	\N	\N
1001505	0	0	1	2	48	\N	\N
1001506	0	0	1	2	49	\N	\N
1001507	0	0	1	2	50	\N	\N
1001508	0	0	1	2	51	\N	\N
1001509	0	0	1	2	52	\N	\N
1001510	0	0	1	2	53	\N	\N
1001511	0	0	1	2	54	\N	\N
1001512	0	0	1	2	55	\N	\N
1001513	0	0	1	2	56	\N	\N
1001514	0	0	1	2	57	\N	\N
1001515	0	0	1	2	58	\N	\N
1001516	0	0	1	2	59	\N	\N
1001517	0	0	1	2	60	\N	\N
1001518	0	0	1	2	61	\N	\N
1001519	0	0	1	2	62	\N	\N
1001520	0	0	1	2	63	\N	\N
1001582	0	0	1	3	45	\N	\N
1001583	0	0	1	3	46	\N	\N
1001584	0	0	1	3	47	\N	\N
1001585	0	0	1	3	48	\N	\N
1001586	0	0	1	3	49	\N	\N
1001587	0	0	1	3	50	\N	\N
1001588	0	0	1	3	51	\N	\N
1001589	0	0	1	3	52	\N	\N
1001590	0	0	1	3	53	\N	\N
1001591	0	0	1	3	54	\N	\N
1001592	0	0	1	3	55	\N	\N
1001593	0	0	1	3	56	\N	\N
1001594	0	0	1	3	57	\N	\N
1001595	0	0	1	3	58	\N	\N
1001596	0	0	1	3	59	\N	\N
1001597	0	0	1	3	60	\N	\N
1001598	0	0	1	3	61	\N	\N
1001599	0	0	1	3	62	\N	\N
1001600	0	0	1	3	63	\N	\N
1001662	0	0	1	4	45	\N	\N
1001663	0	0	1	4	46	\N	\N
1001664	0	0	1	4	47	\N	\N
1001665	0	0	1	4	48	\N	\N
1001666	0	0	1	4	49	\N	\N
1001667	0	0	1	4	50	\N	\N
1001668	0	0	1	4	51	\N	\N
1001669	0	0	1	4	52	\N	\N
1001670	0	0	1	4	53	\N	\N
1001671	0	0	1	4	54	\N	\N
1001672	0	0	1	4	55	\N	\N
1001673	0	0	1	4	56	\N	\N
1001674	0	0	1	4	57	\N	\N
1001675	0	0	1	4	58	\N	\N
1001676	0	0	1	4	59	\N	\N
1001677	0	0	1	4	60	\N	\N
1001678	0	0	1	4	61	\N	\N
1001679	0	0	1	4	62	\N	\N
1001680	0	0	1	4	63	\N	\N
1001717	0	0	1	5	20	\N	\N
1001718	0	0	1	5	21	\N	\N
1001797	0	0	1	6	20	\N	\N
1001798	0	0	1	6	21	\N	\N
1001707	0	0	1	5	10	\N	\N
1001708	0	0	1	5	11	\N	\N
1001709	0	0	1	5	12	\N	\N
1001710	0	0	1	5	13	\N	\N
1001711	0	0	1	5	14	\N	\N
1001712	0	0	1	5	15	\N	\N
1001713	0	0	1	5	16	\N	\N
1001714	0	0	1	5	17	\N	\N
1001715	0	0	1	5	18	\N	\N
1001716	0	0	1	5	19	\N	\N
1001787	0	0	1	6	10	\N	\N
1001788	0	0	1	6	11	\N	\N
1001789	0	0	1	6	12	\N	\N
1001790	0	0	1	6	13	\N	\N
1001791	0	0	1	6	14	\N	\N
1001792	0	0	1	6	15	\N	\N
1001793	0	0	1	6	16	\N	\N
1001794	0	0	1	6	17	\N	\N
1001795	0	0	1	6	18	\N	\N
1001796	0	0	1	6	19	\N	\N
1001702	0	0	1	5	5	\N	\N
1001703	0	0	1	5	6	\N	\N
1001704	0	0	1	5	7	\N	\N
1001705	0	0	1	5	8	\N	\N
1001706	0	0	1	5	9	\N	\N
1001782	0	0	1	6	5	\N	\N
1001783	0	0	1	6	6	\N	\N
1001784	0	0	1	6	7	\N	\N
1001785	0	0	1	6	8	\N	\N
1001786	0	0	1	6	9	\N	\N
1000037	0	0	1	-16	20	\N	\N
1000038	0	0	1	-16	21	\N	\N
1000117	0	0	1	-15	20	\N	\N
1000118	0	0	1	-15	21	\N	\N
1000197	0	0	1	-14	20	\N	\N
1000198	0	0	1	-14	21	\N	\N
1000277	0	0	1	-13	20	\N	\N
1000278	0	0	1	-13	21	\N	\N
1000357	0	0	1	-12	20	\N	\N
1000358	0	0	1	-12	21	\N	\N
1000437	0	0	1	-11	20	\N	\N
1000438	0	0	1	-11	21	\N	\N
1000517	0	0	1	-10	20	\N	\N
1000518	0	0	1	-10	21	\N	\N
1000597	0	0	1	-9	20	\N	\N
1000598	0	0	1	-9	21	\N	\N
1000677	0	0	1	-8	20	\N	\N
1000678	0	0	1	-8	21	\N	\N
1000757	0	0	1	-7	20	\N	\N
1000758	0	0	1	-7	21	\N	\N
1000837	0	0	1	-6	20	\N	\N
1000838	0	0	1	-6	21	\N	\N
1000917	0	0	1	-5	20	\N	\N
1000918	0	0	1	-5	21	\N	\N
1000997	0	0	1	-4	20	\N	\N
1000998	0	0	1	-4	21	\N	\N
1001077	0	0	1	-3	20	\N	\N
1001078	0	0	1	-3	21	\N	\N
1001157	0	0	1	-2	20	\N	\N
1001158	0	0	1	-2	21	\N	\N
1001237	0	0	1	-1	20	\N	\N
1001238	0	0	1	-1	21	\N	\N
1001317	0	0	1	0	20	\N	\N
1001318	0	0	1	0	21	\N	\N
1001397	0	0	1	1	20	\N	\N
1001398	0	0	1	1	21	\N	\N
1001477	0	0	1	2	20	\N	\N
1001478	0	0	1	2	21	\N	\N
1001557	0	0	1	3	20	\N	\N
1001558	0	0	1	3	21	\N	\N
1001637	0	0	1	4	20	\N	\N
1001638	0	0	1	4	21	\N	\N
1000027	0	0	1	-16	10	\N	\N
1000028	0	0	1	-16	11	\N	\N
1000029	0	0	1	-16	12	\N	\N
1000030	0	0	1	-16	13	\N	\N
1000031	0	0	1	-16	14	\N	\N
1000032	0	0	1	-16	15	\N	\N
1000033	0	0	1	-16	16	\N	\N
1000034	0	0	1	-16	17	\N	\N
1000035	0	0	1	-16	18	\N	\N
1000036	0	0	1	-16	19	\N	\N
1000107	0	0	1	-15	10	\N	\N
1000108	0	0	1	-15	11	\N	\N
1000109	0	0	1	-15	12	\N	\N
1000110	0	0	1	-15	13	\N	\N
1000111	0	0	1	-15	14	\N	\N
1000112	0	0	1	-15	15	\N	\N
1000113	0	0	1	-15	16	\N	\N
1000114	0	0	1	-15	17	\N	\N
1000115	0	0	1	-15	18	\N	\N
1000116	0	0	1	-15	19	\N	\N
1000187	0	0	1	-14	10	\N	\N
1000188	0	0	1	-14	11	\N	\N
1000189	0	0	1	-14	12	\N	\N
1000190	0	0	1	-14	13	\N	\N
1000191	0	0	1	-14	14	\N	\N
1000192	0	0	1	-14	15	\N	\N
1000193	0	0	1	-14	16	\N	\N
1000194	0	0	1	-14	17	\N	\N
1000195	0	0	1	-14	18	\N	\N
1000196	0	0	1	-14	19	\N	\N
1000267	0	0	1	-13	10	\N	\N
1000268	0	0	1	-13	11	\N	\N
1000269	0	0	1	-13	12	\N	\N
1000270	0	0	1	-13	13	\N	\N
1000271	0	0	1	-13	14	\N	\N
1000272	0	0	1	-13	15	\N	\N
1000273	0	0	1	-13	16	\N	\N
1000274	0	0	1	-13	17	\N	\N
1000275	0	0	1	-13	18	\N	\N
1000276	0	0	1	-13	19	\N	\N
1000347	0	0	1	-12	10	\N	\N
1000348	0	0	1	-12	11	\N	\N
1000349	0	0	1	-12	12	\N	\N
1000350	0	0	1	-12	13	\N	\N
1000351	0	0	1	-12	14	\N	\N
1000352	0	0	1	-12	15	\N	\N
1000353	0	0	1	-12	16	\N	\N
1000354	0	0	1	-12	17	\N	\N
1000355	0	0	1	-12	18	\N	\N
1000356	0	0	1	-12	19	\N	\N
1000427	0	0	1	-11	10	\N	\N
1000428	0	0	1	-11	11	\N	\N
1000429	0	0	1	-11	12	\N	\N
1000430	0	0	1	-11	13	\N	\N
1000431	0	0	1	-11	14	\N	\N
1000432	0	0	1	-11	15	\N	\N
1000433	0	0	1	-11	16	\N	\N
1000434	0	0	1	-11	17	\N	\N
1000435	0	0	1	-11	18	\N	\N
1000436	0	0	1	-11	19	\N	\N
1000507	0	0	1	-10	10	\N	\N
1000508	0	0	1	-10	11	\N	\N
1000509	0	0	1	-10	12	\N	\N
1000510	0	0	1	-10	13	\N	\N
1000511	0	0	1	-10	14	\N	\N
1000512	0	0	1	-10	15	\N	\N
1000513	0	0	1	-10	16	\N	\N
1000514	0	0	1	-10	17	\N	\N
1000515	0	0	1	-10	18	\N	\N
1000516	0	0	1	-10	19	\N	\N
1000587	0	0	1	-9	10	\N	\N
1000588	0	0	1	-9	11	\N	\N
1000589	0	0	1	-9	12	\N	\N
1000590	0	0	1	-9	13	\N	\N
1000591	0	0	1	-9	14	\N	\N
1000592	0	0	1	-9	15	\N	\N
1000593	0	0	1	-9	16	\N	\N
1000594	0	0	1	-9	17	\N	\N
1000595	0	0	1	-9	18	\N	\N
1000596	0	0	1	-9	19	\N	\N
1000667	0	0	1	-8	10	\N	\N
1000668	0	0	1	-8	11	\N	\N
1000669	0	0	1	-8	12	\N	\N
1000670	0	0	1	-8	13	\N	\N
1000671	0	0	1	-8	14	\N	\N
1000672	0	0	1	-8	15	\N	\N
1000673	0	0	1	-8	16	\N	\N
1000674	0	0	1	-8	17	\N	\N
1000675	0	0	1	-8	18	\N	\N
1000676	0	0	1	-8	19	\N	\N
1000747	0	0	1	-7	10	\N	\N
1000748	0	0	1	-7	11	\N	\N
1000749	0	0	1	-7	12	\N	\N
1000750	0	0	1	-7	13	\N	\N
1000751	0	0	1	-7	14	\N	\N
1000752	0	0	1	-7	15	\N	\N
1000753	0	0	1	-7	16	\N	\N
1000754	0	0	1	-7	17	\N	\N
1000755	0	0	1	-7	18	\N	\N
1000756	0	0	1	-7	19	\N	\N
1000827	0	0	1	-6	10	\N	\N
1000828	0	0	1	-6	11	\N	\N
1000829	0	0	1	-6	12	\N	\N
1000830	0	0	1	-6	13	\N	\N
1000831	0	0	1	-6	14	\N	\N
1000832	0	0	1	-6	15	\N	\N
1000833	0	0	1	-6	16	\N	\N
1000834	0	0	1	-6	17	\N	\N
1000835	0	0	1	-6	18	\N	\N
1000836	0	0	1	-6	19	\N	\N
1000907	0	0	1	-5	10	\N	\N
1000908	0	0	1	-5	11	\N	\N
1000909	0	0	1	-5	12	\N	\N
1000910	0	0	1	-5	13	\N	\N
1000911	0	0	1	-5	14	\N	\N
1000912	0	0	1	-5	15	\N	\N
1000913	0	0	1	-5	16	\N	\N
1000914	0	0	1	-5	17	\N	\N
1000915	0	0	1	-5	18	\N	\N
1000916	0	0	1	-5	19	\N	\N
1000987	0	0	1	-4	10	\N	\N
1000988	0	0	1	-4	11	\N	\N
1000989	0	0	1	-4	12	\N	\N
1000990	0	0	1	-4	13	\N	\N
1000991	0	0	1	-4	14	\N	\N
1000992	0	0	1	-4	15	\N	\N
1000993	0	0	1	-4	16	\N	\N
1000994	0	0	1	-4	17	\N	\N
1000995	0	0	1	-4	18	\N	\N
1000996	0	0	1	-4	19	\N	\N
1001067	0	0	1	-3	10	\N	\N
1001068	0	0	1	-3	11	\N	\N
1001069	0	0	1	-3	12	\N	\N
1001070	0	0	1	-3	13	\N	\N
1001071	0	0	1	-3	14	\N	\N
1001072	0	0	1	-3	15	\N	\N
1001073	0	0	1	-3	16	\N	\N
1001074	0	0	1	-3	17	\N	\N
1001075	0	0	1	-3	18	\N	\N
1001076	0	0	1	-3	19	\N	\N
1001147	0	0	1	-2	10	\N	\N
1001148	0	0	1	-2	11	\N	\N
1001149	0	0	1	-2	12	\N	\N
1001150	0	0	1	-2	13	\N	\N
1001151	0	0	1	-2	14	\N	\N
1001152	0	0	1	-2	15	\N	\N
1001153	0	0	1	-2	16	\N	\N
1001154	0	0	1	-2	17	\N	\N
1001155	0	0	1	-2	18	\N	\N
1001156	0	0	1	-2	19	\N	\N
1001227	0	0	1	-1	10	\N	\N
1001228	0	0	1	-1	11	\N	\N
1001229	0	0	1	-1	12	\N	\N
1001230	0	0	1	-1	13	\N	\N
1001231	0	0	1	-1	14	\N	\N
1001232	0	0	1	-1	15	\N	\N
1001233	0	0	1	-1	16	\N	\N
1001234	0	0	1	-1	17	\N	\N
1001235	0	0	1	-1	18	\N	\N
1001236	0	0	1	-1	19	\N	\N
1001307	0	0	1	0	10	\N	\N
1001308	0	0	1	0	11	\N	\N
1001309	0	0	1	0	12	\N	\N
1001310	0	0	1	0	13	\N	\N
1001311	0	0	1	0	14	\N	\N
1001312	0	0	1	0	15	\N	\N
1001313	0	0	1	0	16	\N	\N
1001314	0	0	1	0	17	\N	\N
1001315	0	0	1	0	18	\N	\N
1001316	0	0	1	0	19	\N	\N
1001387	0	0	1	1	10	\N	\N
1001388	0	0	1	1	11	\N	\N
1001389	0	0	1	1	12	\N	\N
1001390	0	0	1	1	13	\N	\N
1001391	0	0	1	1	14	\N	\N
1001392	0	0	1	1	15	\N	\N
1001393	0	0	1	1	16	\N	\N
1001394	0	0	1	1	17	\N	\N
1001395	0	0	1	1	18	\N	\N
1001396	0	0	1	1	19	\N	\N
1001467	0	0	1	2	10	\N	\N
1001468	0	0	1	2	11	\N	\N
1001469	0	0	1	2	12	\N	\N
1001470	0	0	1	2	13	\N	\N
1001471	0	0	1	2	14	\N	\N
1001472	0	0	1	2	15	\N	\N
1001473	0	0	1	2	16	\N	\N
1001474	0	0	1	2	17	\N	\N
1001475	0	0	1	2	18	\N	\N
1001476	0	0	1	2	19	\N	\N
1001547	0	0	1	3	10	\N	\N
1001548	0	0	1	3	11	\N	\N
1001549	0	0	1	3	12	\N	\N
1001550	0	0	1	3	13	\N	\N
1001551	0	0	1	3	14	\N	\N
1001552	0	0	1	3	15	\N	\N
1001553	0	0	1	3	16	\N	\N
1001554	0	0	1	3	17	\N	\N
1001555	0	0	1	3	18	\N	\N
1001556	0	0	1	3	19	\N	\N
1001627	0	0	1	4	10	\N	\N
1001628	0	0	1	4	11	\N	\N
1001629	0	0	1	4	12	\N	\N
1001630	0	0	1	4	13	\N	\N
1001631	0	0	1	4	14	\N	\N
1001632	0	0	1	4	15	\N	\N
1001633	0	0	1	4	16	\N	\N
1001634	0	0	1	4	17	\N	\N
1001635	0	0	1	4	18	\N	\N
1001636	0	0	1	4	19	\N	\N
1000022	0	0	1	-16	5	\N	\N
1000023	0	0	1	-16	6	\N	\N
1000024	0	0	1	-16	7	\N	\N
1000025	0	0	1	-16	8	\N	\N
1000026	0	0	1	-16	9	\N	\N
1000102	0	0	1	-15	5	\N	\N
1000103	0	0	1	-15	6	\N	\N
1000104	0	0	1	-15	7	\N	\N
1000105	0	0	1	-15	8	\N	\N
1000106	0	0	1	-15	9	\N	\N
1000182	0	0	1	-14	5	\N	\N
1000183	0	0	1	-14	6	\N	\N
1000184	0	0	1	-14	7	\N	\N
1000185	0	0	1	-14	8	\N	\N
1000186	0	0	1	-14	9	\N	\N
1000262	0	0	1	-13	5	\N	\N
1000263	0	0	1	-13	6	\N	\N
1000264	0	0	1	-13	7	\N	\N
1000265	0	0	1	-13	8	\N	\N
1000266	0	0	1	-13	9	\N	\N
1000342	0	0	1	-12	5	\N	\N
1000343	0	0	1	-12	6	\N	\N
1000344	0	0	1	-12	7	\N	\N
1000345	0	0	1	-12	8	\N	\N
1000346	0	0	1	-12	9	\N	\N
1000422	0	0	1	-11	5	\N	\N
1000423	0	0	1	-11	6	\N	\N
1000424	0	0	1	-11	7	\N	\N
1000425	0	0	1	-11	8	\N	\N
1000426	0	0	1	-11	9	\N	\N
1000502	0	0	1	-10	5	\N	\N
1000503	0	0	1	-10	6	\N	\N
1000504	0	0	1	-10	7	\N	\N
1000505	0	0	1	-10	8	\N	\N
1000506	0	0	1	-10	9	\N	\N
1000582	0	0	1	-9	5	\N	\N
1000583	0	0	1	-9	6	\N	\N
1000584	0	0	1	-9	7	\N	\N
1000585	0	0	1	-9	8	\N	\N
1000586	0	0	1	-9	9	\N	\N
1000662	0	0	1	-8	5	\N	\N
1000663	0	0	1	-8	6	\N	\N
1000664	0	0	1	-8	7	\N	\N
1000665	0	0	1	-8	8	\N	\N
1000666	0	0	1	-8	9	\N	\N
1000742	0	0	1	-7	5	\N	\N
1000743	0	0	1	-7	6	\N	\N
1000744	0	0	1	-7	7	\N	\N
1000745	0	0	1	-7	8	\N	\N
1000746	0	0	1	-7	9	\N	\N
1000822	0	0	1	-6	5	\N	\N
1000823	0	0	1	-6	6	\N	\N
1000824	0	0	1	-6	7	\N	\N
1000825	0	0	1	-6	8	\N	\N
1000826	0	0	1	-6	9	\N	\N
1000902	0	0	1	-5	5	\N	\N
1000903	0	0	1	-5	6	\N	\N
1000904	0	0	1	-5	7	\N	\N
1000905	0	0	1	-5	8	\N	\N
1000906	0	0	1	-5	9	\N	\N
1000982	0	0	1	-4	5	\N	\N
1000983	0	0	1	-4	6	\N	\N
1000984	0	0	1	-4	7	\N	\N
1000985	0	0	1	-4	8	\N	\N
1000986	0	0	1	-4	9	\N	\N
1001062	0	0	1	-3	5	\N	\N
1001063	0	0	1	-3	6	\N	\N
1001064	0	0	1	-3	7	\N	\N
1001065	0	0	1	-3	8	\N	\N
1001066	0	0	1	-3	9	\N	\N
1001142	0	0	1	-2	5	\N	\N
1001143	0	0	1	-2	6	\N	\N
1001144	0	0	1	-2	7	\N	\N
1001145	0	0	1	-2	8	\N	\N
1001146	0	0	1	-2	9	\N	\N
1001222	0	0	1	-1	5	\N	\N
1001223	0	0	1	-1	6	\N	\N
1001224	0	0	1	-1	7	\N	\N
1001225	0	0	1	-1	8	\N	\N
1001226	0	0	1	-1	9	\N	\N
1001302	0	0	1	0	5	\N	\N
1001303	0	0	1	0	6	\N	\N
1001304	0	0	1	0	7	\N	\N
1001305	0	0	1	0	8	\N	\N
1001306	0	0	1	0	9	\N	\N
1001382	0	0	1	1	5	\N	\N
1001383	0	0	1	1	6	\N	\N
1001384	0	0	1	1	7	\N	\N
1001385	0	0	1	1	8	\N	\N
1001386	0	0	1	1	9	\N	\N
1001462	0	0	1	2	5	\N	\N
1001463	0	0	1	2	6	\N	\N
1001464	0	0	1	2	7	\N	\N
1001465	0	0	1	2	8	\N	\N
1001466	0	0	1	2	9	\N	\N
1001542	0	0	1	3	5	\N	\N
1001543	0	0	1	3	6	\N	\N
1001544	0	0	1	3	7	\N	\N
1001545	0	0	1	3	8	\N	\N
1001546	0	0	1	3	9	\N	\N
1001622	0	0	1	4	5	\N	\N
1001623	0	0	1	4	6	\N	\N
1001624	0	0	1	4	7	\N	\N
1001625	0	0	1	4	8	\N	\N
1001626	0	0	1	4	9	\N	\N
1001681	0	0	1	5	-16	\N	\N
1001682	0	0	1	5	-15	\N	\N
1001683	0	0	1	5	-14	\N	\N
1001684	0	0	1	5	-13	\N	\N
1001685	0	0	1	5	-12	\N	\N
1001686	0	0	1	5	-11	\N	\N
1001687	0	0	1	5	-10	\N	\N
1001688	0	0	1	5	-9	\N	\N
1001689	0	0	1	5	-8	\N	\N
1001690	0	0	1	5	-7	\N	\N
1001691	0	0	1	5	-6	\N	\N
1001692	0	0	1	5	-5	\N	\N
1001693	0	0	1	5	-4	\N	\N
1001694	0	0	1	5	-3	\N	\N
1001695	0	0	1	5	-2	\N	\N
1001696	0	0	1	5	-1	\N	\N
1001697	0	0	1	5	0	\N	\N
1001698	0	0	1	5	1	\N	\N
1001699	0	0	1	5	2	\N	\N
1001700	0	0	1	5	3	\N	\N
1001701	0	0	1	5	4	\N	\N
1001761	0	0	1	6	-16	\N	\N
1001762	0	0	1	6	-15	\N	\N
1001763	0	0	1	6	-14	\N	\N
1001764	0	0	1	6	-13	\N	\N
1001765	0	0	1	6	-12	\N	\N
1001766	0	0	1	6	-11	\N	\N
1001767	0	0	1	6	-10	\N	\N
1001768	0	0	1	6	-9	\N	\N
1001769	0	0	1	6	-8	\N	\N
1001770	0	0	1	6	-7	\N	\N
1001771	0	0	1	6	-6	\N	\N
1001772	0	0	1	6	-5	\N	\N
1001773	0	0	1	6	-4	\N	\N
1001774	0	0	1	6	-3	\N	\N
1001775	0	0	1	6	-2	\N	\N
1001776	0	0	1	6	-1	\N	\N
1001777	0	0	1	6	0	\N	\N
1001778	0	0	1	6	1	\N	\N
1001779	0	0	1	6	2	\N	\N
1001780	0	0	1	6	3	\N	\N
1001781	0	0	1	6	4	\N	\N
1000001	0	0	1	-16	-16	\N	\N
1000002	0	0	1	-16	-15	\N	\N
1000003	0	0	1	-16	-14	\N	\N
1000004	0	0	1	-16	-13	\N	\N
1000005	0	0	1	-16	-12	\N	\N
1000006	0	0	1	-16	-11	\N	\N
1000007	0	0	1	-16	-10	\N	\N
1000008	0	0	1	-16	-9	\N	\N
1000009	0	0	1	-16	-8	\N	\N
1000010	0	0	1	-16	-7	\N	\N
1000011	0	0	1	-16	-6	\N	\N
1000012	0	0	1	-16	-5	\N	\N
1000013	0	0	1	-16	-4	\N	\N
1000014	0	0	1	-16	-3	\N	\N
1000015	0	0	1	-16	-2	\N	\N
1000016	0	0	1	-16	-1	\N	\N
1000017	0	0	1	-16	0	\N	\N
1000018	0	0	1	-16	1	\N	\N
1000019	0	0	1	-16	2	\N	\N
1000020	0	0	1	-16	3	\N	\N
1000021	0	0	1	-16	4	\N	\N
1000081	0	0	1	-15	-16	\N	\N
1000082	0	0	1	-15	-15	\N	\N
1000083	0	0	1	-15	-14	\N	\N
1000084	0	0	1	-15	-13	\N	\N
1000085	0	0	1	-15	-12	\N	\N
1000086	0	0	1	-15	-11	\N	\N
1000087	0	0	1	-15	-10	\N	\N
1000088	0	0	1	-15	-9	\N	\N
1000089	0	0	1	-15	-8	\N	\N
1000090	0	0	1	-15	-7	\N	\N
1000091	0	0	1	-15	-6	\N	\N
1000092	0	0	1	-15	-5	\N	\N
1000093	0	0	1	-15	-4	\N	\N
1000094	0	0	1	-15	-3	\N	\N
1000095	0	0	1	-15	-2	\N	\N
1000096	0	0	1	-15	-1	\N	\N
1000097	0	0	1	-15	0	\N	\N
1000098	0	0	1	-15	1	\N	\N
1000099	0	0	1	-15	2	\N	\N
1000100	0	0	1	-15	3	\N	\N
1000101	0	0	1	-15	4	\N	\N
1000161	0	0	1	-14	-16	\N	\N
1000162	0	0	1	-14	-15	\N	\N
1000163	0	0	1	-14	-14	\N	\N
1000164	0	0	1	-14	-13	\N	\N
1000165	0	0	1	-14	-12	\N	\N
1000166	0	0	1	-14	-11	\N	\N
1000167	0	0	1	-14	-10	\N	\N
1000168	0	0	1	-14	-9	\N	\N
1000169	0	0	1	-14	-8	\N	\N
1000170	0	0	1	-14	-7	\N	\N
1000171	0	0	1	-14	-6	\N	\N
1000172	0	0	1	-14	-5	\N	\N
1000173	0	0	1	-14	-4	\N	\N
1000174	0	0	1	-14	-3	\N	\N
1000175	0	0	1	-14	-2	\N	\N
1000176	0	0	1	-14	-1	\N	\N
1000177	0	0	1	-14	0	\N	\N
1000178	0	0	1	-14	1	\N	\N
1000179	0	0	1	-14	2	\N	\N
1000180	0	0	1	-14	3	\N	\N
1000181	0	0	1	-14	4	\N	\N
1000241	0	0	1	-13	-16	\N	\N
1000242	0	0	1	-13	-15	\N	\N
1000243	0	0	1	-13	-14	\N	\N
1000244	0	0	1	-13	-13	\N	\N
1000245	0	0	1	-13	-12	\N	\N
1000246	0	0	1	-13	-11	\N	\N
1000247	0	0	1	-13	-10	\N	\N
1000248	0	0	1	-13	-9	\N	\N
1000249	0	0	1	-13	-8	\N	\N
1000250	0	0	1	-13	-7	\N	\N
1000251	0	0	1	-13	-6	\N	\N
1000252	0	0	1	-13	-5	\N	\N
1000253	0	0	1	-13	-4	\N	\N
1000254	0	0	1	-13	-3	\N	\N
1000255	0	0	1	-13	-2	\N	\N
1000256	0	0	1	-13	-1	\N	\N
1000257	0	0	1	-13	0	\N	\N
1000258	0	0	1	-13	1	\N	\N
1000259	0	0	1	-13	2	\N	\N
1000260	0	0	1	-13	3	\N	\N
1000261	0	0	1	-13	4	\N	\N
1000321	0	0	1	-12	-16	\N	\N
1000322	0	0	1	-12	-15	\N	\N
1000323	0	0	1	-12	-14	\N	\N
1000324	0	0	1	-12	-13	\N	\N
1000325	0	0	1	-12	-12	\N	\N
1000326	0	0	1	-12	-11	\N	\N
1000327	0	0	1	-12	-10	\N	\N
1000328	0	0	1	-12	-9	\N	\N
1000329	0	0	1	-12	-8	\N	\N
1000330	0	0	1	-12	-7	\N	\N
1000331	0	0	1	-12	-6	\N	\N
1000332	0	0	1	-12	-5	\N	\N
1000333	0	0	1	-12	-4	\N	\N
1000334	0	0	1	-12	-3	\N	\N
1000335	0	0	1	-12	-2	\N	\N
1000336	0	0	1	-12	-1	\N	\N
1000337	0	0	1	-12	0	\N	\N
1000338	0	0	1	-12	1	\N	\N
1000339	0	0	1	-12	2	\N	\N
1000340	0	0	1	-12	3	\N	\N
1000341	0	0	1	-12	4	\N	\N
1000401	0	0	1	-11	-16	\N	\N
1000402	0	0	1	-11	-15	\N	\N
1000403	0	0	1	-11	-14	\N	\N
1000404	0	0	1	-11	-13	\N	\N
1000405	0	0	1	-11	-12	\N	\N
1000406	0	0	1	-11	-11	\N	\N
1000407	0	0	1	-11	-10	\N	\N
1000408	0	0	1	-11	-9	\N	\N
1000409	0	0	1	-11	-8	\N	\N
1000410	0	0	1	-11	-7	\N	\N
1000411	0	0	1	-11	-6	\N	\N
1000412	0	0	1	-11	-5	\N	\N
1000413	0	0	1	-11	-4	\N	\N
1000414	0	0	1	-11	-3	\N	\N
1000415	0	0	1	-11	-2	\N	\N
1000416	0	0	1	-11	-1	\N	\N
1000417	0	0	1	-11	0	\N	\N
1000418	0	0	1	-11	1	\N	\N
1000419	0	0	1	-11	2	\N	\N
1000420	0	0	1	-11	3	\N	\N
1000421	0	0	1	-11	4	\N	\N
1000481	0	0	1	-10	-16	\N	\N
1000482	0	0	1	-10	-15	\N	\N
1000483	0	0	1	-10	-14	\N	\N
1000484	0	0	1	-10	-13	\N	\N
1000485	0	0	1	-10	-12	\N	\N
1000486	0	0	1	-10	-11	\N	\N
1000487	0	0	1	-10	-10	\N	\N
1000488	0	0	1	-10	-9	\N	\N
1000489	0	0	1	-10	-8	\N	\N
1000490	0	0	1	-10	-7	\N	\N
1000491	0	0	1	-10	-6	\N	\N
1000492	0	0	1	-10	-5	\N	\N
1000493	0	0	1	-10	-4	\N	\N
1000494	0	0	1	-10	-3	\N	\N
1000495	0	0	1	-10	-2	\N	\N
1000496	0	0	1	-10	-1	\N	\N
1000497	0	0	1	-10	0	\N	\N
1000498	0	0	1	-10	1	\N	\N
1000499	0	0	1	-10	2	\N	\N
1000500	0	0	1	-10	3	\N	\N
1000501	0	0	1	-10	4	\N	\N
1000561	0	0	1	-9	-16	\N	\N
1000562	0	0	1	-9	-15	\N	\N
1000563	0	0	1	-9	-14	\N	\N
1000564	0	0	1	-9	-13	\N	\N
1000565	0	0	1	-9	-12	\N	\N
1000566	0	0	1	-9	-11	\N	\N
1000567	0	0	1	-9	-10	\N	\N
1000568	0	0	1	-9	-9	\N	\N
1000569	0	0	1	-9	-8	\N	\N
1000570	0	0	1	-9	-7	\N	\N
1000571	0	0	1	-9	-6	\N	\N
1000572	0	0	1	-9	-5	\N	\N
1000573	0	0	1	-9	-4	\N	\N
1000574	0	0	1	-9	-3	\N	\N
1000575	0	0	1	-9	-2	\N	\N
1000576	0	0	1	-9	-1	\N	\N
1000577	0	0	1	-9	0	\N	\N
1000578	0	0	1	-9	1	\N	\N
1000579	0	0	1	-9	2	\N	\N
1000580	0	0	1	-9	3	\N	\N
1000581	0	0	1	-9	4	\N	\N
1000641	0	0	1	-8	-16	\N	\N
1000642	0	0	1	-8	-15	\N	\N
1000643	0	0	1	-8	-14	\N	\N
1000644	0	0	1	-8	-13	\N	\N
1000645	0	0	1	-8	-12	\N	\N
1000646	0	0	1	-8	-11	\N	\N
1000647	0	0	1	-8	-10	\N	\N
1000648	0	0	1	-8	-9	\N	\N
1000649	0	0	1	-8	-8	\N	\N
1000650	0	0	1	-8	-7	\N	\N
1000651	0	0	1	-8	-6	\N	\N
1000652	0	0	1	-8	-5	\N	\N
1000653	0	0	1	-8	-4	\N	\N
1000654	0	0	1	-8	-3	\N	\N
1000655	0	0	1	-8	-2	\N	\N
1000656	0	0	1	-8	-1	\N	\N
1000657	0	0	1	-8	0	\N	\N
1000658	0	0	1	-8	1	\N	\N
1000659	0	0	1	-8	2	\N	\N
1000660	0	0	1	-8	3	\N	\N
1000661	0	0	1	-8	4	\N	\N
1000721	0	0	1	-7	-16	\N	\N
1000722	0	0	1	-7	-15	\N	\N
1000723	0	0	1	-7	-14	\N	\N
1000724	0	0	1	-7	-13	\N	\N
1000725	0	0	1	-7	-12	\N	\N
1000726	0	0	1	-7	-11	\N	\N
1000727	0	0	1	-7	-10	\N	\N
1000728	0	0	1	-7	-9	\N	\N
1000729	0	0	1	-7	-8	\N	\N
1000730	0	0	1	-7	-7	\N	\N
1000731	0	0	1	-7	-6	\N	\N
1000732	0	0	1	-7	-5	\N	\N
1000733	0	0	1	-7	-4	\N	\N
1000734	0	0	1	-7	-3	\N	\N
1000735	0	0	1	-7	-2	\N	\N
1000736	0	0	1	-7	-1	\N	\N
1000737	0	0	1	-7	0	\N	\N
1000738	0	0	1	-7	1	\N	\N
1000739	0	0	1	-7	2	\N	\N
1000740	0	0	1	-7	3	\N	\N
1000741	0	0	1	-7	4	\N	\N
1000801	0	0	1	-6	-16	\N	\N
1000802	0	0	1	-6	-15	\N	\N
1000803	0	0	1	-6	-14	\N	\N
1000804	0	0	1	-6	-13	\N	\N
1000805	0	0	1	-6	-12	\N	\N
1000806	0	0	1	-6	-11	\N	\N
1000807	0	0	1	-6	-10	\N	\N
1000808	0	0	1	-6	-9	\N	\N
1000809	0	0	1	-6	-8	\N	\N
1000810	0	0	1	-6	-7	\N	\N
1000811	0	0	1	-6	-6	\N	\N
1000812	0	0	1	-6	-5	\N	\N
1000813	0	0	1	-6	-4	\N	\N
1000814	0	0	1	-6	-3	\N	\N
1000815	0	0	1	-6	-2	\N	\N
1000816	0	0	1	-6	-1	\N	\N
1000817	0	0	1	-6	0	\N	\N
1000818	0	0	1	-6	1	\N	\N
1000819	0	0	1	-6	2	\N	\N
1000820	0	0	1	-6	3	\N	\N
1000821	0	0	1	-6	4	\N	\N
1000881	0	0	1	-5	-16	\N	\N
1000882	0	0	1	-5	-15	\N	\N
1000883	0	0	1	-5	-14	\N	\N
1000884	0	0	1	-5	-13	\N	\N
1000885	0	0	1	-5	-12	\N	\N
1000886	0	0	1	-5	-11	\N	\N
1000887	0	0	1	-5	-10	\N	\N
1000888	0	0	1	-5	-9	\N	\N
1000889	0	0	1	-5	-8	\N	\N
1000890	0	0	1	-5	-7	\N	\N
1000891	0	0	1	-5	-6	\N	\N
1000892	0	0	1	-5	-5	\N	\N
1000893	0	0	1	-5	-4	\N	\N
1000894	0	0	1	-5	-3	\N	\N
1000895	0	0	1	-5	-2	\N	\N
1000896	0	0	1	-5	-1	\N	\N
1000897	0	0	1	-5	0	\N	\N
1000898	0	0	1	-5	1	\N	\N
1000899	0	0	1	-5	2	\N	\N
1000900	0	0	1	-5	3	\N	\N
1000901	0	0	1	-5	4	\N	\N
1000961	0	0	1	-4	-16	\N	\N
1000962	0	0	1	-4	-15	\N	\N
1000963	0	0	1	-4	-14	\N	\N
1000964	0	0	1	-4	-13	\N	\N
1000965	0	0	1	-4	-12	\N	\N
1000966	0	0	1	-4	-11	\N	\N
1000967	0	0	1	-4	-10	\N	\N
1000968	0	0	1	-4	-9	\N	\N
1000969	0	0	1	-4	-8	\N	\N
1000970	0	0	1	-4	-7	\N	\N
1000971	0	0	1	-4	-6	\N	\N
1000972	0	0	1	-4	-5	\N	\N
1000973	0	0	1	-4	-4	\N	\N
1000974	0	0	1	-4	-3	\N	\N
1000975	0	0	1	-4	-2	\N	\N
1000976	0	0	1	-4	-1	\N	\N
1000977	0	0	1	-4	0	\N	\N
1000978	0	0	1	-4	1	\N	\N
1000979	0	0	1	-4	2	\N	\N
1000980	0	0	1	-4	3	\N	\N
1000981	0	0	1	-4	4	\N	\N
1001041	0	0	1	-3	-16	\N	\N
1001042	0	0	1	-3	-15	\N	\N
1001043	0	0	1	-3	-14	\N	\N
1001044	0	0	1	-3	-13	\N	\N
1001045	0	0	1	-3	-12	\N	\N
1001046	0	0	1	-3	-11	\N	\N
1001047	0	0	1	-3	-10	\N	\N
1001048	0	0	1	-3	-9	\N	\N
1001049	0	0	1	-3	-8	\N	\N
1001050	0	0	1	-3	-7	\N	\N
1001051	0	0	1	-3	-6	\N	\N
1001052	0	0	1	-3	-5	\N	\N
1001053	0	0	1	-3	-4	\N	\N
1001054	0	0	1	-3	-3	\N	\N
1001055	0	0	1	-3	-2	\N	\N
1001056	0	0	1	-3	-1	\N	\N
1001057	0	0	1	-3	0	\N	\N
1001058	0	0	1	-3	1	\N	\N
1001059	0	0	1	-3	2	\N	\N
1001060	0	0	1	-3	3	\N	\N
1001061	0	0	1	-3	4	\N	\N
1001121	0	0	1	-2	-16	\N	\N
1001122	0	0	1	-2	-15	\N	\N
1001123	0	0	1	-2	-14	\N	\N
1001124	0	0	1	-2	-13	\N	\N
1001125	0	0	1	-2	-12	\N	\N
1001126	0	0	1	-2	-11	\N	\N
1001127	0	0	1	-2	-10	\N	\N
1001128	0	0	1	-2	-9	\N	\N
1001129	0	0	1	-2	-8	\N	\N
1001130	0	0	1	-2	-7	\N	\N
1001131	0	0	1	-2	-6	\N	\N
1001132	0	0	1	-2	-5	\N	\N
1001133	0	0	1	-2	-4	\N	\N
1001134	0	0	1	-2	-3	\N	\N
1001135	0	0	1	-2	-2	\N	\N
1001136	0	0	1	-2	-1	\N	\N
1001137	0	0	1	-2	0	\N	\N
1001138	0	0	1	-2	1	\N	\N
1001139	0	0	1	-2	2	\N	\N
1001140	0	0	1	-2	3	\N	\N
1001141	0	0	1	-2	4	\N	\N
1001201	0	0	1	-1	-16	\N	\N
1001202	0	0	1	-1	-15	\N	\N
1001203	0	0	1	-1	-14	\N	\N
1001204	0	0	1	-1	-13	\N	\N
1001205	0	0	1	-1	-12	\N	\N
1001206	0	0	1	-1	-11	\N	\N
1001207	0	0	1	-1	-10	\N	\N
1001208	0	0	1	-1	-9	\N	\N
1001209	0	0	1	-1	-8	\N	\N
1001210	0	0	1	-1	-7	\N	\N
1001211	0	0	1	-1	-6	\N	\N
1001212	0	0	1	-1	-5	\N	\N
1001213	0	0	1	-1	-4	\N	\N
1001214	0	0	1	-1	-3	\N	\N
1001215	0	0	1	-1	-2	\N	\N
1001216	0	0	1	-1	-1	\N	\N
1001217	0	0	1	-1	0	\N	\N
1001218	0	0	1	-1	1	\N	\N
1001219	0	0	1	-1	2	\N	\N
1001367	0	0	1	1	-10	\N	\N
1001368	0	0	1	1	-9	\N	\N
1001369	0	0	1	1	-8	\N	\N
1001370	0	0	1	1	-7	\N	\N
1001371	0	0	1	1	-6	\N	\N
1001372	0	0	1	1	-5	\N	\N
1001373	0	0	1	1	-4	\N	\N
1001374	0	0	1	1	-3	\N	\N
1001375	0	0	1	1	-2	\N	\N
1001376	0	0	1	1	-1	\N	\N
1001377	0	0	1	1	0	\N	\N
1001378	0	0	1	1	1	\N	\N
1001379	0	0	1	1	2	\N	\N
1001380	0	0	1	1	3	\N	\N
1001381	0	0	1	1	4	\N	\N
1001441	0	0	1	2	-16	\N	\N
1001442	0	0	1	2	-15	\N	\N
1001443	0	0	1	2	-14	\N	\N
1001444	0	0	1	2	-13	\N	\N
1001445	0	0	1	2	-12	\N	\N
1001446	0	0	1	2	-11	\N	\N
1001447	0	0	1	2	-10	\N	\N
1001448	0	0	1	2	-9	\N	\N
1001449	0	0	1	2	-8	\N	\N
1001450	0	0	1	2	-7	\N	\N
1001451	0	0	1	2	-6	\N	\N
1001452	0	0	1	2	-5	\N	\N
1001453	0	0	1	2	-4	\N	\N
1001454	0	0	1	2	-3	\N	\N
1001455	0	0	1	2	-2	\N	\N
1001456	0	0	1	2	-1	\N	\N
1001457	0	0	1	2	0	\N	\N
1001458	0	0	1	2	1	\N	\N
1001459	0	0	1	2	2	\N	\N
1001460	0	0	1	2	3	\N	\N
1001461	0	0	1	2	4	\N	\N
1001521	0	0	1	3	-16	\N	\N
1001522	0	0	1	3	-15	\N	\N
1001523	0	0	1	3	-14	\N	\N
1001524	0	0	1	3	-13	\N	\N
1001525	0	0	1	3	-12	\N	\N
1001526	0	0	1	3	-11	\N	\N
1001527	0	0	1	3	-10	\N	\N
1001528	0	0	1	3	-9	\N	\N
1001529	0	0	1	3	-8	\N	\N
1001530	0	0	1	3	-7	\N	\N
1001531	0	0	1	3	-6	\N	\N
1001532	0	0	1	3	-5	\N	\N
1001533	0	0	1	3	-4	\N	\N
1001534	0	0	1	3	-3	\N	\N
1001535	0	0	1	3	-2	\N	\N
1001536	0	0	1	3	-1	\N	\N
1001537	0	0	1	3	0	\N	\N
1001538	0	0	1	3	1	\N	\N
1001539	0	0	1	3	2	\N	\N
1001540	0	0	1	3	3	\N	\N
1001541	0	0	1	3	4	\N	\N
1001601	0	0	1	4	-16	\N	\N
1001602	0	0	1	4	-15	\N	\N
1001603	0	0	1	4	-14	\N	\N
1001604	0	0	1	4	-13	\N	\N
1001605	0	0	1	4	-12	\N	\N
1001606	0	0	1	4	-11	\N	\N
1001607	0	0	1	4	-10	\N	\N
1001608	0	0	1	4	-9	\N	\N
1001609	0	0	1	4	-8	\N	\N
1001610	0	0	1	4	-7	\N	\N
1001611	0	0	1	4	-6	\N	\N
1001612	0	0	1	4	-5	\N	\N
1001613	0	0	1	4	-4	\N	\N
1001614	0	0	1	4	-3	\N	\N
1001615	0	0	1	4	-2	\N	\N
1001616	0	0	1	4	-1	\N	\N
1001617	0	0	1	4	0	\N	\N
1001618	0	0	1	4	1	\N	\N
1001619	0	0	1	4	2	\N	\N
1001620	0	0	1	4	3	\N	\N
1001621	0	0	1	4	4	\N	\N
1006407	0	0	1	27	5	null	null
1006410	0	0	1	29	7	null	null
1006535	0	0	1	44	21	null	null
1004844	0	0	1	44	27	null	null
1004686	0	0	1	42	29	null	null
1003659	0	0	1	29	42	null	null
1003501	0	0	1	27	44	null	null
1003101	0	0	1	22	44	null	null
1001886	0	0	1	7	29	null	null
1001724	0	0	1	5	27	null	null
1001719	0	0	1	5	22	null	null
1004683	2	0	1	42	26	\N	\N
1001880	2	0	1	7	23	\N	\N
1001883	2	0	1	7	26	\N	\N
1001959	2	0	1	8	22	\N	\N
1001960	2	0	1	8	23	\N	\N
1001963	2	0	1	8	26	\N	\N
1001964	2	0	1	8	27	\N	\N
1002038	2	0	1	9	21	\N	\N
1002039	2	0	1	9	22	\N	\N
1002040	2	0	1	9	23	\N	\N
1002044	2	0	1	9	27	\N	\N
1002117	2	0	1	10	20	\N	\N
1002118	2	0	1	10	21	\N	\N
1002119	2	0	1	10	22	\N	\N
1002120	2	0	1	10	23	\N	\N
1002123	2	0	1	10	26	\N	\N
1002124	2	0	1	10	27	\N	\N
1002125	2	0	1	10	28	\N	\N
1002126	2	0	1	10	29	\N	\N
1002194	2	0	1	11	17	\N	\N
1002196	2	0	1	11	19	\N	\N
1002197	2	0	1	11	20	\N	\N
1002198	2	0	1	11	21	\N	\N
1002200	2	0	1	11	23	\N	\N
1002204	2	0	1	11	27	\N	\N
1002206	2	0	1	11	29	\N	\N
1002207	2	0	1	11	30	\N	\N
1002209	2	0	1	11	32	\N	\N
1002212	2	0	1	11	35	\N	\N
1002213	2	0	1	11	36	\N	\N
1002214	2	0	1	11	37	\N	\N
1002215	2	0	1	11	38	\N	\N
1002268	2	0	1	12	11	\N	\N
1002275	2	0	1	12	18	\N	\N
1002276	2	0	1	12	19	\N	\N
1002277	2	0	1	12	20	\N	\N
1002279	2	0	1	12	22	\N	\N
1002280	2	0	1	12	23	\N	\N
1002283	2	0	1	12	26	\N	\N
1002284	2	0	1	12	27	\N	\N
1002286	2	0	1	12	29	\N	\N
1002287	2	0	1	12	30	\N	\N
1002288	2	0	1	12	31	\N	\N
1002290	2	0	1	12	33	\N	\N
1002291	2	0	1	12	34	\N	\N
1002292	2	0	1	12	35	\N	\N
1002295	2	0	1	12	38	\N	\N
1002348	2	0	1	13	11	\N	\N
1002358	2	0	1	13	21	\N	\N
1002359	2	0	1	13	22	\N	\N
1002363	2	0	1	13	26	\N	\N
1002365	2	0	1	13	28	\N	\N
1002366	2	0	1	13	29	\N	\N
1002367	2	0	1	13	30	\N	\N
1002368	2	0	1	13	31	\N	\N
1002369	2	0	1	13	32	\N	\N
1002371	2	0	1	13	34	\N	\N
1002372	2	0	1	13	35	\N	\N
1002374	2	0	1	13	37	\N	\N
1002375	2	0	1	13	38	\N	\N
1002452	2	0	1	14	35	\N	\N
1002453	2	0	1	14	36	\N	\N
1002454	2	0	1	14	37	\N	\N
1002455	2	0	1	14	38	\N	\N
1002293	8	0	1	12	36	Gamma Command	null
1002043	13	0	1	9	26	Polychrome Peace Park	null
1002508	2	0	1	15	11	\N	\N
1002509	2	0	1	15	12	\N	\N
1002534	2	0	1	15	37	\N	\N
1002535	2	0	1	15	38	\N	\N
1002588	2	0	1	16	11	\N	\N
1002594	2	0	1	16	17	\N	\N
1002595	2	0	1	16	18	\N	\N
1002596	2	0	1	16	19	\N	\N
1002598	2	0	1	16	21	\N	\N
1002599	2	0	1	16	22	\N	\N
1002603	2	0	1	16	26	\N	\N
1002604	2	0	1	16	27	\N	\N
1002605	2	0	1	16	28	\N	\N
1002606	2	0	1	16	29	\N	\N
1002607	2	0	1	16	30	\N	\N
1002608	2	0	1	16	31	\N	\N
1002609	2	0	1	16	32	\N	\N
1002614	2	0	1	16	37	\N	\N
1002615	2	0	1	16	38	\N	\N
1002670	2	0	1	17	13	\N	\N
1002673	2	0	1	17	16	\N	\N
1002675	2	0	1	17	18	\N	\N
1002676	2	0	1	17	19	\N	\N
1002678	2	0	1	17	21	\N	\N
1002679	2	0	1	17	22	\N	\N
1002680	2	0	1	17	23	\N	\N
1002683	2	0	1	17	26	\N	\N
1002684	2	0	1	17	27	\N	\N
1002685	2	0	1	17	28	\N	\N
1002686	2	0	1	17	29	\N	\N
1002688	2	0	1	17	31	\N	\N
1002690	2	0	1	17	33	\N	\N
1002693	2	0	1	17	36	\N	\N
1002695	2	0	1	17	38	\N	\N
1002749	2	0	1	18	12	\N	\N
1002750	2	0	1	18	13	\N	\N
1002753	2	0	1	18	16	\N	\N
1002754	2	0	1	18	17	\N	\N
1002756	2	0	1	18	19	\N	\N
1002757	2	0	1	18	20	\N	\N
1002758	2	0	1	18	21	\N	\N
1002760	2	0	1	18	23	\N	\N
1002763	2	0	1	18	26	\N	\N
1002764	2	0	1	18	27	\N	\N
1002766	2	0	1	18	29	\N	\N
1002767	2	0	1	18	30	\N	\N
1002769	2	0	1	18	32	\N	\N
1002770	2	0	1	18	33	\N	\N
1002773	2	0	1	18	36	\N	\N
1002828	2	0	1	19	11	\N	\N
1002829	2	0	1	19	12	\N	\N
1002830	2	0	1	19	13	\N	\N
1002833	2	0	1	19	16	\N	\N
1002834	2	0	1	19	17	\N	\N
1002835	2	0	1	19	18	\N	\N
1002838	2	0	1	19	21	\N	\N
1002839	2	0	1	19	22	\N	\N
1002840	2	0	1	19	23	\N	\N
1002843	2	0	1	19	26	\N	\N
1002844	2	0	1	19	27	\N	\N
1002846	2	0	1	19	29	\N	\N
1002848	2	0	1	19	31	\N	\N
1002849	2	0	1	19	32	\N	\N
1002850	2	0	1	19	33	\N	\N
1002853	2	0	1	19	36	\N	\N
1002854	2	0	1	19	37	\N	\N
1002855	2	0	1	19	38	\N	\N
1002907	2	0	1	20	10	\N	\N
1002910	2	0	1	20	13	\N	\N
1002913	2	0	1	20	16	\N	\N
1002915	2	0	1	20	18	\N	\N
1002428	2	0	1	14	11		Security Depot
1002918	2	0	1	20	21	\N	\N
1002919	2	0	1	20	22	\N	\N
1002920	2	0	1	20	23	\N	\N
1002923	2	0	1	20	26	\N	\N
1002924	2	0	1	20	27	\N	\N
1002928	2	0	1	20	31	\N	\N
1002930	2	0	1	20	33	\N	\N
1002933	2	0	1	20	36	\N	\N
1002935	2	0	1	20	38	\N	\N
1002986	2	0	1	21	9	\N	\N
1002987	2	0	1	21	10	\N	\N
1002989	2	0	1	21	12	\N	\N
1002990	2	0	1	21	13	\N	\N
1002993	2	0	1	21	16	\N	\N
1002996	2	0	1	21	19	\N	\N
1002997	2	0	1	21	20	\N	\N
1003000	2	0	1	21	23	\N	\N
1003004	2	0	1	21	27	\N	\N
1003006	2	0	1	21	29	\N	\N
1003007	2	0	1	21	30	\N	\N
1003008	2	0	1	21	31	\N	\N
1003009	2	0	1	21	32	\N	\N
1003010	2	0	1	21	33	\N	\N
1003013	2	0	1	21	36	\N	\N
1003014	2	0	1	21	37	\N	\N
1003016	2	0	1	21	39	\N	\N
1003017	2	0	1	21	40	\N	\N
1003065	2	0	1	22	8	\N	\N
1003067	2	0	1	22	10	\N	\N
1003068	2	0	1	22	11	\N	\N
1003070	2	0	1	22	13	\N	\N
1003076	2	0	1	22	19	\N	\N
1003077	2	0	1	22	20	\N	\N
1003083	2	0	1	22	26	\N	\N
1003085	2	0	1	22	28	\N	\N
1003086	2	0	1	22	29	\N	\N
1003088	2	0	1	22	31	\N	\N
1003089	2	0	1	22	32	\N	\N
1003090	2	0	1	22	33	\N	\N
1003093	2	0	1	22	36	\N	\N
1003094	2	0	1	22	37	\N	\N
1003095	2	0	1	22	38	\N	\N
1003097	2	0	1	22	40	\N	\N
1003098	2	0	1	22	41	\N	\N
1003144	2	0	1	23	7	\N	\N
1003145	2	0	1	23	8	\N	\N
1003147	2	0	1	23	10	\N	\N
1003148	2	0	1	23	11	\N	\N
1003149	2	0	1	23	12	\N	\N
1003150	2	0	1	23	13	\N	\N
1003155	2	0	1	23	18	\N	\N
1003156	2	0	1	23	19	\N	\N
1003157	2	0	1	23	20	\N	\N
1003158	2	0	1	23	21	\N	\N
1003159	2	0	1	23	22	\N	\N
1003164	2	0	1	23	27	\N	\N
1003165	2	0	1	23	28	\N	\N
1003166	2	0	1	23	29	\N	\N
1003167	2	0	1	23	30	\N	\N
1003168	2	0	1	23	31	\N	\N
1002759	43	0	1	18	22	Macho Taco Latin Grocery	
1003087	17	0	1	22	30	The Pirate's Plank	null
1002765	3	0	1	18	28	Blaine's Security Element	null
1003069	5	0	1	22	12	Melange Mercantiles	null
1002205	5	0	1	11	28	Paladin Consumer Objects	null
1003169	2	0	1	23	32	\N	\N
1003173	2	0	1	23	36	\N	\N
1003174	2	0	1	23	37	\N	\N
1003177	2	0	1	23	40	\N	\N
1003178	2	0	1	23	41	\N	\N
1003179	2	0	1	23	42	\N	\N
1003404	2	0	1	26	27	\N	\N
1003405	2	0	1	26	28	\N	\N
1003406	2	0	1	26	29	\N	\N
1003407	2	0	1	26	30	\N	\N
1003408	2	0	1	26	31	\N	\N
1003409	2	0	1	26	32	\N	\N
1003410	2	0	1	26	33	\N	\N
1003413	2	0	1	26	36	\N	\N
1003414	2	0	1	26	37	\N	\N
1003415	2	0	1	26	38	\N	\N
1003416	2	0	1	26	39	\N	\N
1003417	2	0	1	26	40	\N	\N
1003419	2	0	1	26	42	\N	\N
1003483	2	0	1	27	26	\N	\N
1003485	2	0	1	27	28	\N	\N
1003486	2	0	1	27	29	\N	\N
1003489	2	0	1	27	32	\N	\N
1003490	2	0	1	27	33	\N	\N
1003493	2	0	1	27	36	\N	\N
1003494	2	0	1	27	37	\N	\N
1003495	2	0	1	27	38	\N	\N
1003496	2	0	1	27	39	\N	\N
1003497	2	0	1	27	40	\N	\N
1003498	2	0	1	27	41	\N	\N
1003563	2	0	1	28	26	\N	\N
1003564	2	0	1	28	27	\N	\N
1003566	2	0	1	28	29	\N	\N
1003567	2	0	1	28	30	\N	\N
1003568	2	0	1	28	31	\N	\N
1003569	2	0	1	28	32	\N	\N
1003570	2	0	1	28	33	\N	\N
1003573	2	0	1	28	36	\N	\N
1003574	2	0	1	28	37	\N	\N
1003576	2	0	1	28	39	\N	\N
1003577	2	0	1	28	40	\N	\N
1003644	2	0	1	29	27	\N	\N
1003645	2	0	1	29	28	\N	\N
1003647	2	0	1	29	30	\N	\N
1003650	2	0	1	29	33	\N	\N
1003653	2	0	1	29	36	\N	\N
1003654	2	0	1	29	37	\N	\N
1003655	2	0	1	29	38	\N	\N
1003656	2	0	1	29	39	\N	\N
1003723	2	0	1	30	26	\N	\N
1003725	2	0	1	30	28	\N	\N
1003728	2	0	1	30	31	\N	\N
1003729	2	0	1	30	32	\N	\N
1003730	2	0	1	30	33	\N	\N
1003734	2	0	1	30	37	\N	\N
1003735	2	0	1	30	38	\N	\N
1003803	2	0	1	31	26	\N	\N
1003804	2	0	1	31	27	\N	\N
1003805	2	0	1	31	28	\N	\N
1003806	2	0	1	31	29	\N	\N
1003807	2	0	1	31	30	\N	\N
1003810	2	0	1	31	33	\N	\N
1003813	2	0	1	31	36	\N	\N
1003814	2	0	1	31	37	\N	\N
1003883	2	0	1	32	26	\N	\N
1003885	2	0	1	32	28	\N	\N
1003888	2	0	1	32	31	\N	\N
1003890	2	0	1	32	33	\N	\N
1003893	2	0	1	32	36	\N	\N
1003963	2	0	1	33	26	\N	\N
1003965	2	0	1	33	28	\N	\N
1003966	2	0	1	33	29	\N	\N
1003967	2	0	1	33	30	\N	\N
1003968	2	0	1	33	31	\N	\N
1003074	2	0	1	22	17	null	null
1003073	2	0	1	22	16	null	null
1003726	2	0	1	30	29		
1003154	2	0	1	23	17	null	null
1003884	2	0	1	32	27		
1003487	34	0	1	27	30	Church of the Resurrection	null
1003075	2	0	1	22	18	null	null
1004055	2	0	1	34	38	\N	\N
1004134	2	0	1	35	37	\N	\N
1004135	2	0	1	35	38	\N	\N
1004204	2	0	1	36	27	\N	\N
1004205	2	0	1	36	28	\N	\N
1004207	2	0	1	36	30	\N	\N
1004208	2	0	1	36	31	\N	\N
1004209	2	0	1	36	32	\N	\N
1004215	2	0	1	36	38	\N	\N
1004284	2	0	1	37	27	\N	\N
1004285	2	0	1	37	28	\N	\N
1004286	2	0	1	37	29	\N	\N
1004287	2	0	1	37	30	\N	\N
1004288	2	0	1	37	31	\N	\N
1004290	2	0	1	37	33	\N	\N
1004292	2	0	1	37	35	\N	\N
1004293	2	0	1	37	36	\N	\N
1004295	2	0	1	37	38	\N	\N
1004363	2	0	1	38	26	\N	\N
1004364	2	0	1	38	27	\N	\N
1004367	2	0	1	38	30	\N	\N
1004369	2	0	1	38	32	\N	\N
1004371	2	0	1	38	34	\N	\N
1004372	2	0	1	38	35	\N	\N
1004373	2	0	1	38	36	\N	\N
1004375	2	0	1	38	38	\N	\N
1004443	2	0	1	39	26	\N	\N
1004444	2	0	1	39	27	\N	\N
1004445	2	0	1	39	28	\N	\N
1004446	2	0	1	39	29	\N	\N
1004523	2	0	1	40	26	\N	\N
1004525	2	0	1	40	28	\N	\N
1004603	2	0	1	41	26	\N	\N
1004604	2	0	1	41	27	\N	\N
1002668	2	0	1	17	11	null	null
1002589	2	0	1	16	12	null	null
1002510	2	0	1	15	13	null	null
1002352	2	0	1	13	15	null	null
1002533	2	0	1	15	36	null	null
1002045	2	0	1	9	28	null	null
1006411	2	0	1	26	7	\N	\N
1006412	2	0	1	27	8	\N	\N
1006413	2	0	1	26	8	\N	\N
1006414	2	0	1	28	9	\N	\N
1006415	2	0	1	27	9	\N	\N
1006416	2	0	1	26	9	\N	\N
1006417	2	0	1	29	10	\N	\N
1006418	2	0	1	28	10	\N	\N
1006419	2	0	1	27	10	\N	\N
1006420	2	0	1	26	10	\N	\N
1006421	2	0	1	38	11	\N	\N
1006422	2	0	1	37	11	\N	\N
1006423	2	0	1	36	11	\N	\N
1006424	2	0	1	35	11	\N	\N
1006425	2	0	1	34	11	\N	\N
1006426	2	0	1	33	11	\N	\N
1006427	2	0	1	32	11	\N	\N
1006428	2	0	1	30	11	\N	\N
1006429	2	0	1	29	11	\N	\N
1006432	2	0	1	26	11	\N	\N
1006433	2	0	1	38	12	\N	\N
1003080	2	0	1	22	23	null	null
1004294	31	0	1	37	37	null	null
1004214	8	0	1	36	37	Beta Command	null
1003649	3	0	1	29	32	Precint 1300	null
1002934	43	0	1	20	37	The Sliggly Jiggly	null
1004213	45	0	1	36	36	Strickland Energy and Energy Accessories	null
1006435	2	0	1	36	12	\N	\N
1006436	2	0	1	35	12	\N	\N
1006437	2	0	1	34	12	\N	\N
1006438	2	0	1	31	12	\N	\N
1006441	2	0	1	28	12	\N	\N
1006442	2	0	1	27	12	\N	\N
1006443	2	0	1	26	12	\N	\N
1006444	2	0	1	38	13	\N	\N
1006447	2	0	1	35	13	\N	\N
1006448	2	0	1	32	13	\N	\N
1006449	2	0	1	31	13	\N	\N
1006450	2	0	1	30	13	\N	\N
1006452	2	0	1	28	13	\N	\N
1006453	2	0	1	27	13	\N	\N
1006455	2	0	1	38	14	\N	\N
1006456	2	0	1	37	14	\N	\N
1006457	2	0	1	36	14	\N	\N
1006466	2	0	1	38	15	\N	\N
1006476	2	0	1	38	16	\N	\N
1006479	2	0	1	32	16	\N	\N
1006480	2	0	1	31	16	\N	\N
1006481	2	0	1	30	16	\N	\N
1006482	2	0	1	29	16	\N	\N
1006486	2	0	1	36	17	\N	\N
1006489	2	0	1	33	17	\N	\N
1006491	2	0	1	31	17	\N	\N
1006492	2	0	1	30	17	\N	\N
1006496	2	0	1	26	17	\N	\N
1006497	2	0	1	37	18	\N	\N
1006501	2	0	1	33	18	\N	\N
1006502	2	0	1	32	18	\N	\N
1006503	2	0	1	30	18	\N	\N
1006504	2	0	1	29	18	\N	\N
1006506	2	0	1	27	18	\N	\N
1006507	2	0	1	26	18	\N	\N
1006508	2	0	1	38	19	\N	\N
1006509	2	0	1	37	19	\N	\N
1006510	2	0	1	36	19	\N	\N
1006513	2	0	1	33	19	\N	\N
1006515	2	0	1	31	19	\N	\N
1006517	2	0	1	28	19	\N	\N
1006518	2	0	1	27	19	\N	\N
1006519	2	0	1	26	19	\N	\N
1006521	2	0	1	39	20	\N	\N
1006522	2	0	1	38	20	\N	\N
1006524	2	0	1	36	20	\N	\N
1006527	2	0	1	33	20	\N	\N
1006529	2	0	1	31	20	\N	\N
1006530	2	0	1	30	20	\N	\N
1006531	2	0	1	28	20	\N	\N
1006532	2	0	1	27	20	\N	\N
1006533	2	0	1	26	20	\N	\N
1006536	2	0	1	40	21	\N	\N
1006537	2	0	1	39	21	\N	\N
1006540	2	0	1	36	21	\N	\N
1006543	2	0	1	33	21	\N	\N
1006545	2	0	1	31	21	\N	\N
1006546	2	0	1	30	21	\N	\N
1006547	2	0	1	29	21	\N	\N
1006549	2	0	1	26	21	\N	\N
1006551	2	0	1	41	22	\N	\N
1006554	2	0	1	38	22	\N	\N
1006555	2	0	1	37	22	\N	\N
1006556	2	0	1	36	22	\N	\N
1006494	2	0	1	28	17	null	null
1006539	14	0	1	37	21	March Credit Company	null
1006495	2	0	1	27	17	null	null
1006485	2	0	1	26	16	null	null
1006516	13	0	1	29	19	Masumi Gardens	null
1004524	2	0	1	40	27		
1004366	14	0	1	38	29	Royal Green's Jackets	null
1006430	17	0	1	28	11	Hannibal's	null
1006559	2	0	1	33	22	\N	\N
1006561	2	0	1	31	22	\N	\N
1006562	2	0	1	30	22	\N	\N
1006563	2	0	1	29	22	\N	\N
1006565	2	0	1	26	22	\N	\N
1006566	2	0	1	42	23	\N	\N
1006567	2	0	1	41	23	\N	\N
1006569	2	0	1	39	23	\N	\N
1006570	2	0	1	38	23	\N	\N
1006571	2	0	1	37	23	\N	\N
1006572	2	0	1	36	23	\N	\N
1006575	2	0	1	33	23	\N	\N
1006576	2	0	1	32	23	\N	\N
1006577	2	0	1	31	23	\N	\N
1006578	2	0	1	30	23	\N	\N
1006579	2	0	1	29	23	\N	\N
1006580	2	0	1	28	23	\N	\N
1006581	2	0	1	27	23	\N	\N
1006658	2	0	1	38	17	\N	\N
1006659	2	0	1	37	16	\N	\N
1006660	2	0	1	36	15	\N	\N
1006661	2	0	1	35	14	\N	\N
1006662	2	0	1	34	13	\N	\N
1006663	2	0	1	33	12	\N	\N
1002211	2	0	1	11	34	null	null
1002210	2	0	1	11	33	null	null
1004370	2	0	1	38	33	null	null
1004291	2	0	1	37	34	null	null
1003975	2	0	1	33	38	null	null
1004054	2	0	1	34	37	null	null
1004133	2	0	1	35	36	null	null
1004212	2	0	1	36	35	null	null
1004211	2	0	1	36	34	null	null
1003895	2	0	1	32	38	null	null
1003974	2	0	1	33	37	null	null
1004053	2	0	1	34	36	null	null
1004132	2	0	1	35	35	null	null
1002936	2	0	1	20	39	null	null
1003176	2	0	1	23	39	null	null
1003175	2	0	1	23	38	null	null
1002927	2	0	1	20	30	null	null
1003969	2	0	1	33	32	null	null
1006440	2	0	1	29	12	null	null
1006451	2	0	1	29	13	null	null
1002357	2	0	1	13	20	null	null
1002356	2	0	1	13	19	null	null
1002355	2	0	1	13	18	null	null
1002354	2	0	1	13	17	null	null
1002025	0	0	1	9	8	Observation Deck	Observation Deck
1002364	2	0	1	13	27		
1003153	2	0	1	23	16	null	null
1006484	2	0	1	27	16	null	null
1002026	0	0	1	9	9		
1002106	0	0	1	10	9		
1006505	2	0	1	28	18	null	null
1002687	2	0	1	17	30		
1002939	0	0	1	20	42	null	null
1006439	1	0	1	30	12	Blessed Spirit Hospital	null
1006483	43	0	1	28	16	Heart of Artichokes	Heart of Artichokes
1006446	45	0	1	36	13	null	null
1006514	3	0	1	32	19	Z.A.H. Security	null
1004203	43	0	1	36	26	Black Goat BBQ	null
1006498	5	0	1	36	18	Yaladnav Industries	null
1003170	2	0	1	23	33	null	null
1006445	8	0	1	37	13	Alpha Command	null
1003897	0	0	1	32	40	null	null
1003977	0	0	1	33	40	null	null
1002925	2	0	1	20	28		
1003575	16	0	1	28	38	The Merry Men	null
1002188	2	0	1	11	11		
1004365	2	0	1	38	28		
1006560	17	0	1	32	22	Rock the Barhah	
1006552	16	0	1	40	22	The Oubliette	
1006431	51	0	1	27	11	Channel 4	null
1002600	2	0	1	16	23		
1006553	2	0	1	39	22	null	null
1003724	1	0	1	30	27	No Borders Free Clinic	null
1006467	2	0	1	37	15	null	null
1002995	2	0	1	21	18	null	null
1003096	1	0	1	22	39	Nightengale's Hospital	null
1002294	31	0	1	12	37	null	null
1002373	45	0	1	13	36	null	null
1002350	45	0	1	13	13	null	null
1003887	18	0	1	32	30	The Balance Beam	
1002994	3	0	1	21	17	Dunnel Security Station	null
1002597	2	0	1	16	20	null	null
1004283	2	0	1	37	26	null	null
1001888	0	0	1	7	31	null	null
1003733	5	0	1	30	36	Callahan Spaceship Parts	null
1002512	8	0	1	15	15	North-West Axis	North-West Axis
1002349	8	0	1	13	12	Delta Command	null
1002837	16	0	1	19	20	Club Eugene	null
1002908	24	0	1	20	11	Zachary's Xenobiology	null
1002278	17	0	1	12	21	The White Van	null
1002199	14	0	1	11	22	Children's Lightbulbs Electronic Emporium	null
1003066	7	0	1	22	9	Rachel's Roses	null
1002916	34	0	1	20	19	Convento das Althèna	Convento das Althèna
1002271	2	0	1	12	14	null	null
1002351	2	0	1	13	14	null	null
1002189	2	0	1	11	12	null	null
1002429	2	0	1	14	12	null	null
1002430	2	0	1	14	13	null	null
1002270	2	0	1	12	13	null	null
1002190	2	0	1	11	13	null	null
1002191	2	0	1	11	14	null	null
1002431	2	0	1	14	14	null	null
1002193	2	0	1	11	16	null	null
1002273	2	0	1	12	16	null	null
1002192	2	0	1	11	15	null	null
1002272	2	0	1	12	15	null	null
1002269	31	0	1	12	12	null	null
1006434	31	0	1	37	12	null	null
-57005	\N	-1	\N	\N	\N	\N	\N
1024812	0	1337	0	-20	-20	\N	\N
1024813	0	1337	0	-20	-19	\N	\N
1024814	0	1337	0	-20	-18	\N	\N
1024815	0	1337	0	-20	-17	\N	\N
1024816	0	1337	0	-20	-16	\N	\N
1024817	0	1337	0	-20	-15	\N	\N
1024818	0	1337	0	-20	-14	\N	\N
1024819	0	1337	0	-20	-13	\N	\N
1024820	0	1337	0	-20	-12	\N	\N
1024821	0	1337	0	-20	-11	\N	\N
1024822	0	1337	0	-20	-10	\N	\N
1024823	0	1337	0	-20	-9	\N	\N
1024824	0	1337	0	-20	-8	\N	\N
1024825	0	1337	0	-20	-7	\N	\N
1024826	0	1337	0	-20	-6	\N	\N
1024827	0	1337	0	-20	-5	\N	\N
1024828	0	1337	0	-20	-4	\N	\N
1024829	0	1337	0	-20	-3	\N	\N
1024830	0	1337	0	-20	-2	\N	\N
1024831	0	1337	0	-20	-1	\N	\N
1024832	0	1337	0	-20	0	\N	\N
1024833	0	1337	0	-20	1	\N	\N
1024834	0	1337	0	-20	2	\N	\N
1024835	0	1337	0	-20	3	\N	\N
1024836	0	1337	0	-20	4	\N	\N
1024837	0	1337	0	-20	5	\N	\N
1024838	0	1337	0	-20	6	\N	\N
1024839	0	1337	0	-20	7	\N	\N
1024840	0	1337	0	-20	8	\N	\N
1024841	0	1337	0	-20	9	\N	\N
1024842	0	1337	0	-20	10	\N	\N
1024843	0	1337	0	-20	11	\N	\N
1024844	0	1337	0	-20	12	\N	\N
1024845	0	1337	0	-20	13	\N	\N
1024846	0	1337	0	-20	14	\N	\N
1024847	0	1337	0	-20	15	\N	\N
1024848	0	1337	0	-20	16	\N	\N
1024849	0	1337	0	-20	17	\N	\N
1024850	0	1337	0	-20	18	\N	\N
1024851	0	1337	0	-20	19	\N	\N
1024852	0	1337	0	-20	20	\N	\N
1024853	0	1337	0	-20	21	\N	\N
1024854	0	1337	0	-20	22	\N	\N
1024855	0	1337	0	-20	23	\N	\N
1024856	0	1337	0	-20	24	\N	\N
1024857	0	1337	0	-20	25	\N	\N
1024858	0	1337	0	-20	26	\N	\N
1024859	0	1337	0	-20	27	\N	\N
1024860	0	1337	0	-20	28	\N	\N
1024861	0	1337	0	-20	29	\N	\N
1024862	0	1337	0	-20	30	\N	\N
1024863	0	1337	0	-20	31	\N	\N
1024864	0	1337	0	-20	32	\N	\N
1024865	0	1337	0	-20	33	\N	\N
1024866	0	1337	0	-20	34	\N	\N
1024867	0	1337	0	-20	35	\N	\N
1024868	0	1337	0	-20	36	\N	\N
1024869	0	1337	0	-20	37	\N	\N
1024870	0	1337	0	-20	38	\N	\N
1024871	0	1337	0	-20	39	\N	\N
1024872	0	1337	0	-20	40	\N	\N
1024873	0	1337	0	-20	41	\N	\N
1024874	0	1337	0	-20	42	\N	\N
1024875	0	1337	0	-20	43	\N	\N
1024876	0	1337	0	-20	44	\N	\N
1024877	0	1337	0	-20	45	\N	\N
1024878	0	1337	0	-20	46	\N	\N
1024879	0	1337	0	-20	47	\N	\N
1024880	0	1337	0	-20	48	\N	\N
1024881	0	1337	0	-20	49	\N	\N
1024882	0	1337	0	-20	50	\N	\N
1024883	0	1337	0	-20	51	\N	\N
1024884	0	1337	0	-20	52	\N	\N
1024885	0	1337	0	-20	53	\N	\N
1024886	0	1337	0	-20	54	\N	\N
1024887	0	1337	0	-20	55	\N	\N
1024888	0	1337	0	-20	56	\N	\N
1024889	0	1337	0	-20	57	\N	\N
1024890	0	1337	0	-20	58	\N	\N
1024891	0	1337	0	-20	59	\N	\N
1024892	0	1337	0	-19	-20	\N	\N
1024893	0	1337	0	-19	-19	\N	\N
1024894	0	1337	0	-19	-18	\N	\N
1024895	0	1337	0	-19	-17	\N	\N
1024896	0	1337	0	-19	-16	\N	\N
1024897	0	1337	0	-19	-15	\N	\N
1024898	0	1337	0	-19	-14	\N	\N
1024899	0	1337	0	-19	-13	\N	\N
1024900	0	1337	0	-19	-12	\N	\N
1024901	0	1337	0	-19	-11	\N	\N
1024902	0	1337	0	-19	-10	\N	\N
1024903	0	1337	0	-19	-9	\N	\N
1024904	0	1337	0	-19	-8	\N	\N
1024905	0	1337	0	-19	-7	\N	\N
1024906	0	1337	0	-19	-6	\N	\N
1024907	0	1337	0	-19	-5	\N	\N
1024908	0	1337	0	-19	-4	\N	\N
1024909	0	1337	0	-19	-3	\N	\N
1024910	0	1337	0	-19	-2	\N	\N
1024911	0	1337	0	-19	-1	\N	\N
1024912	0	1337	0	-19	0	\N	\N
1024913	0	1337	0	-19	1	\N	\N
1024914	0	1337	0	-19	2	\N	\N
1024915	0	1337	0	-19	3	\N	\N
1024916	0	1337	0	-19	4	\N	\N
1024917	0	1337	0	-19	5	\N	\N
1024918	0	1337	0	-19	6	\N	\N
1024919	0	1337	0	-19	7	\N	\N
1024920	0	1337	0	-19	8	\N	\N
1024921	0	1337	0	-19	9	\N	\N
1024922	0	1337	0	-19	10	\N	\N
1024923	0	1337	0	-19	11	\N	\N
1024924	0	1337	0	-19	12	\N	\N
1024925	0	1337	0	-19	13	\N	\N
1024926	0	1337	0	-19	14	\N	\N
1024927	0	1337	0	-19	15	\N	\N
1024928	0	1337	0	-19	16	\N	\N
1024929	0	1337	0	-19	17	\N	\N
1024930	0	1337	0	-19	18	\N	\N
1024931	0	1337	0	-19	19	\N	\N
1024932	0	1337	0	-19	20	\N	\N
1024933	0	1337	0	-19	21	\N	\N
1024934	0	1337	0	-19	22	\N	\N
1024935	0	1337	0	-19	23	\N	\N
1024936	0	1337	0	-19	24	\N	\N
1024937	0	1337	0	-19	25	\N	\N
1024938	0	1337	0	-19	26	\N	\N
1024939	0	1337	0	-19	27	\N	\N
1024940	0	1337	0	-19	28	\N	\N
1024941	0	1337	0	-19	29	\N	\N
1024942	0	1337	0	-19	30	\N	\N
1024943	0	1337	0	-19	31	\N	\N
1024944	0	1337	0	-19	32	\N	\N
1024945	0	1337	0	-19	33	\N	\N
1024946	0	1337	0	-19	34	\N	\N
1024947	0	1337	0	-19	35	\N	\N
1024948	0	1337	0	-19	36	\N	\N
1024949	0	1337	0	-19	37	\N	\N
1024950	0	1337	0	-19	38	\N	\N
1024951	0	1337	0	-19	39	\N	\N
1024952	0	1337	0	-19	40	\N	\N
1024953	0	1337	0	-19	41	\N	\N
1024954	0	1337	0	-19	42	\N	\N
1024955	0	1337	0	-19	43	\N	\N
1024956	0	1337	0	-19	44	\N	\N
1024957	0	1337	0	-19	45	\N	\N
1024958	0	1337	0	-19	46	\N	\N
1024959	0	1337	0	-19	47	\N	\N
1024960	0	1337	0	-19	48	\N	\N
1024961	0	1337	0	-19	49	\N	\N
1024962	0	1337	0	-19	50	\N	\N
1024963	0	1337	0	-19	51	\N	\N
1024964	0	1337	0	-19	52	\N	\N
1024965	0	1337	0	-19	53	\N	\N
1024966	0	1337	0	-19	54	\N	\N
1024967	0	1337	0	-19	55	\N	\N
1024968	0	1337	0	-19	56	\N	\N
1024969	0	1337	0	-19	57	\N	\N
1024970	0	1337	0	-19	58	\N	\N
1024971	0	1337	0	-19	59	\N	\N
1024972	0	1337	0	-18	-20	\N	\N
1024973	0	1337	0	-18	-19	\N	\N
1024974	0	1337	0	-18	-18	\N	\N
1024975	0	1337	0	-18	-17	\N	\N
1024976	0	1337	0	-18	-16	\N	\N
1024977	0	1337	0	-18	-15	\N	\N
1024978	0	1337	0	-18	-14	\N	\N
1024979	0	1337	0	-18	-13	\N	\N
1024980	0	1337	0	-18	-12	\N	\N
1024981	0	1337	0	-18	-11	\N	\N
1024982	0	1337	0	-18	-10	\N	\N
1024983	0	1337	0	-18	-9	\N	\N
1024984	0	1337	0	-18	-8	\N	\N
1024985	0	1337	0	-18	-7	\N	\N
1024986	0	1337	0	-18	-6	\N	\N
1024987	0	1337	0	-18	-5	\N	\N
1024988	0	1337	0	-18	-4	\N	\N
1024989	0	1337	0	-18	-3	\N	\N
1024990	0	1337	0	-18	-2	\N	\N
1024991	0	1337	0	-18	-1	\N	\N
1024992	0	1337	0	-18	0	\N	\N
1024993	0	1337	0	-18	1	\N	\N
1024994	0	1337	0	-18	2	\N	\N
1024995	0	1337	0	-18	3	\N	\N
1024996	0	1337	0	-18	4	\N	\N
1024997	0	1337	0	-18	5	\N	\N
1024998	0	1337	0	-18	6	\N	\N
1024999	0	1337	0	-18	7	\N	\N
1025000	0	1337	0	-18	8	\N	\N
1025001	0	1337	0	-18	9	\N	\N
1025002	0	1337	0	-18	10	\N	\N
1025003	0	1337	0	-18	11	\N	\N
1025004	0	1337	0	-18	12	\N	\N
1025005	0	1337	0	-18	13	\N	\N
1025006	0	1337	0	-18	14	\N	\N
1025007	0	1337	0	-18	15	\N	\N
1025008	0	1337	0	-18	16	\N	\N
1025009	0	1337	0	-18	17	\N	\N
1025010	0	1337	0	-18	18	\N	\N
1025011	0	1337	0	-18	19	\N	\N
1025012	0	1337	0	-18	20	\N	\N
1025013	0	1337	0	-18	21	\N	\N
1025014	0	1337	0	-18	22	\N	\N
1025015	0	1337	0	-18	23	\N	\N
1025016	0	1337	0	-18	24	\N	\N
1025017	0	1337	0	-18	25	\N	\N
1025018	0	1337	0	-18	26	\N	\N
1025019	0	1337	0	-18	27	\N	\N
1025020	0	1337	0	-18	28	\N	\N
1025021	0	1337	0	-18	29	\N	\N
1025022	0	1337	0	-18	30	\N	\N
1025023	0	1337	0	-18	31	\N	\N
1025024	0	1337	0	-18	32	\N	\N
1025025	0	1337	0	-18	33	\N	\N
1025026	0	1337	0	-18	34	\N	\N
1025027	0	1337	0	-18	35	\N	\N
1025028	0	1337	0	-18	36	\N	\N
1025029	0	1337	0	-18	37	\N	\N
1025030	0	1337	0	-18	38	\N	\N
1025031	0	1337	0	-18	39	\N	\N
1025032	0	1337	0	-18	40	\N	\N
1025033	0	1337	0	-18	41	\N	\N
1025034	0	1337	0	-18	42	\N	\N
1025035	0	1337	0	-18	43	\N	\N
1025036	0	1337	0	-18	44	\N	\N
1025037	0	1337	0	-18	45	\N	\N
1025038	0	1337	0	-18	46	\N	\N
1025039	0	1337	0	-18	47	\N	\N
1025040	0	1337	0	-18	48	\N	\N
1025041	0	1337	0	-18	49	\N	\N
1025042	0	1337	0	-18	50	\N	\N
1025043	0	1337	0	-18	51	\N	\N
1025044	0	1337	0	-18	52	\N	\N
1025045	0	1337	0	-18	53	\N	\N
1025046	0	1337	0	-18	54	\N	\N
1025047	0	1337	0	-18	55	\N	\N
1025048	0	1337	0	-18	56	\N	\N
1025049	0	1337	0	-18	57	\N	\N
1025050	0	1337	0	-18	58	\N	\N
1025051	0	1337	0	-18	59	\N	\N
1025052	0	1337	0	-17	-20	\N	\N
1025053	0	1337	0	-17	-19	\N	\N
1025054	0	1337	0	-17	-18	\N	\N
1025055	0	1337	0	-17	-17	\N	\N
1025056	0	1337	0	-17	-16	\N	\N
1025057	0	1337	0	-17	-15	\N	\N
1025058	0	1337	0	-17	-14	\N	\N
1025059	0	1337	0	-17	-13	\N	\N
1025060	0	1337	0	-17	-12	\N	\N
1025061	0	1337	0	-17	-11	\N	\N
1025062	0	1337	0	-17	-10	\N	\N
1025063	0	1337	0	-17	-9	\N	\N
1025064	0	1337	0	-17	-8	\N	\N
1025065	0	1337	0	-17	-7	\N	\N
1025066	0	1337	0	-17	-6	\N	\N
1025067	0	1337	0	-17	-5	\N	\N
1025068	0	1337	0	-17	-4	\N	\N
1025069	0	1337	0	-17	-3	\N	\N
1025070	0	1337	0	-17	-2	\N	\N
1025071	0	1337	0	-17	-1	\N	\N
1025072	0	1337	0	-17	0	\N	\N
1025073	0	1337	0	-17	1	\N	\N
1025074	0	1337	0	-17	2	\N	\N
1025075	0	1337	0	-17	3	\N	\N
1025076	0	1337	0	-17	4	\N	\N
1025077	0	1337	0	-17	5	\N	\N
1025078	0	1337	0	-17	6	\N	\N
1025079	0	1337	0	-17	7	\N	\N
1025080	0	1337	0	-17	8	\N	\N
1025081	0	1337	0	-17	9	\N	\N
1025082	0	1337	0	-17	10	\N	\N
1025083	0	1337	0	-17	11	\N	\N
1025084	0	1337	0	-17	12	\N	\N
1025085	0	1337	0	-17	13	\N	\N
1025086	0	1337	0	-17	14	\N	\N
1025087	0	1337	0	-17	15	\N	\N
1025088	0	1337	0	-17	16	\N	\N
1025089	0	1337	0	-17	17	\N	\N
1025090	0	1337	0	-17	18	\N	\N
1025091	0	1337	0	-17	19	\N	\N
1025092	0	1337	0	-17	20	\N	\N
1025093	0	1337	0	-17	21	\N	\N
1025094	0	1337	0	-17	22	\N	\N
1025095	0	1337	0	-17	23	\N	\N
1025096	0	1337	0	-17	24	\N	\N
1025097	0	1337	0	-17	25	\N	\N
1025098	0	1337	0	-17	26	\N	\N
1025099	0	1337	0	-17	27	\N	\N
1025100	0	1337	0	-17	28	\N	\N
1025101	0	1337	0	-17	29	\N	\N
1025102	0	1337	0	-17	30	\N	\N
1025103	0	1337	0	-17	31	\N	\N
1025104	0	1337	0	-17	32	\N	\N
1025105	0	1337	0	-17	33	\N	\N
1025106	0	1337	0	-17	34	\N	\N
1025107	0	1337	0	-17	35	\N	\N
1025108	0	1337	0	-17	36	\N	\N
1025109	0	1337	0	-17	37	\N	\N
1025110	0	1337	0	-17	38	\N	\N
1025111	0	1337	0	-17	39	\N	\N
1025112	0	1337	0	-17	40	\N	\N
1025113	0	1337	0	-17	41	\N	\N
1025114	0	1337	0	-17	42	\N	\N
1025115	0	1337	0	-17	43	\N	\N
1025116	0	1337	0	-17	44	\N	\N
1025117	0	1337	0	-17	45	\N	\N
1025118	0	1337	0	-17	46	\N	\N
1025119	0	1337	0	-17	47	\N	\N
1025120	0	1337	0	-17	48	\N	\N
1025121	0	1337	0	-17	49	\N	\N
1025122	0	1337	0	-17	50	\N	\N
1025123	0	1337	0	-17	51	\N	\N
1025124	0	1337	0	-17	52	\N	\N
1025125	0	1337	0	-17	53	\N	\N
1025126	0	1337	0	-17	54	\N	\N
1025127	0	1337	0	-17	55	\N	\N
1025128	0	1337	0	-17	56	\N	\N
1025129	0	1337	0	-17	57	\N	\N
1025130	0	1337	0	-17	58	\N	\N
1025131	0	1337	0	-17	59	\N	\N
1025132	0	1337	0	-16	-20	\N	\N
1025133	0	1337	0	-16	-19	\N	\N
1025134	0	1337	0	-16	-18	\N	\N
1025135	0	1337	0	-16	-17	\N	\N
1025136	0	1337	0	-16	-16	\N	\N
1025137	0	1337	0	-16	-15	\N	\N
1025138	0	1337	0	-16	-14	\N	\N
1025139	0	1337	0	-16	-13	\N	\N
1025140	0	1337	0	-16	-12	\N	\N
1025141	0	1337	0	-16	-11	\N	\N
1025142	0	1337	0	-16	-10	\N	\N
1025143	0	1337	0	-16	-9	\N	\N
1025144	0	1337	0	-16	-8	\N	\N
1025145	0	1337	0	-16	-7	\N	\N
1025146	0	1337	0	-16	-6	\N	\N
1025147	0	1337	0	-16	-5	\N	\N
1025148	0	1337	0	-16	-4	\N	\N
1025149	0	1337	0	-16	-3	\N	\N
1025150	0	1337	0	-16	-2	\N	\N
1025151	0	1337	0	-16	-1	\N	\N
1025152	0	1337	0	-16	0	\N	\N
1025153	0	1337	0	-16	1	\N	\N
1025154	0	1337	0	-16	2	\N	\N
1025155	0	1337	0	-16	3	\N	\N
1025156	0	1337	0	-16	4	\N	\N
1025157	0	1337	0	-16	5	\N	\N
1025158	0	1337	0	-16	6	\N	\N
1025159	0	1337	0	-16	7	\N	\N
1025160	0	1337	0	-16	8	\N	\N
1025161	0	1337	0	-16	9	\N	\N
1025162	0	1337	0	-16	10	\N	\N
1025163	0	1337	0	-16	11	\N	\N
1025164	0	1337	0	-16	12	\N	\N
1025165	0	1337	0	-16	13	\N	\N
1025166	0	1337	0	-16	14	\N	\N
1025167	0	1337	0	-16	15	\N	\N
1025168	0	1337	0	-16	16	\N	\N
1025169	0	1337	0	-16	17	\N	\N
1025170	0	1337	0	-16	18	\N	\N
1025171	0	1337	0	-16	19	\N	\N
1025172	0	1337	0	-16	20	\N	\N
1025173	0	1337	0	-16	21	\N	\N
1025174	0	1337	0	-16	22	\N	\N
1025175	0	1337	0	-16	23	\N	\N
1025176	0	1337	0	-16	24	\N	\N
1025177	0	1337	0	-16	25	\N	\N
1025178	0	1337	0	-16	26	\N	\N
1025179	0	1337	0	-16	27	\N	\N
1025180	0	1337	0	-16	28	\N	\N
1025181	0	1337	0	-16	29	\N	\N
1025182	0	1337	0	-16	30	\N	\N
1025183	0	1337	0	-16	31	\N	\N
1025184	0	1337	0	-16	32	\N	\N
1025185	0	1337	0	-16	33	\N	\N
1025186	0	1337	0	-16	34	\N	\N
1025187	0	1337	0	-16	35	\N	\N
1025188	0	1337	0	-16	36	\N	\N
1025189	0	1337	0	-16	37	\N	\N
1025190	0	1337	0	-16	38	\N	\N
1025191	0	1337	0	-16	39	\N	\N
1025192	0	1337	0	-16	40	\N	\N
1025193	0	1337	0	-16	41	\N	\N
1025194	0	1337	0	-16	42	\N	\N
1025195	0	1337	0	-16	43	\N	\N
1025196	0	1337	0	-16	44	\N	\N
1025197	0	1337	0	-16	45	\N	\N
1025198	0	1337	0	-16	46	\N	\N
1025199	0	1337	0	-16	47	\N	\N
1025200	0	1337	0	-16	48	\N	\N
1025201	0	1337	0	-16	49	\N	\N
1025202	0	1337	0	-16	50	\N	\N
1025203	0	1337	0	-16	51	\N	\N
1025204	0	1337	0	-16	52	\N	\N
1025205	0	1337	0	-16	53	\N	\N
1025206	0	1337	0	-16	54	\N	\N
1025207	0	1337	0	-16	55	\N	\N
1025208	0	1337	0	-16	56	\N	\N
1025209	0	1337	0	-16	57	\N	\N
1025210	0	1337	0	-16	58	\N	\N
1025211	0	1337	0	-16	59	\N	\N
1025212	0	1337	0	-15	-20	\N	\N
1025213	0	1337	0	-15	-19	\N	\N
1025214	0	1337	0	-15	-18	\N	\N
1025215	0	1337	0	-15	-17	\N	\N
1025216	0	1337	0	-15	-16	\N	\N
1025217	0	1337	0	-15	-15	\N	\N
1025218	0	1337	0	-15	-14	\N	\N
1025219	0	1337	0	-15	-13	\N	\N
1025220	0	1337	0	-15	-12	\N	\N
1025221	0	1337	0	-15	-11	\N	\N
1025222	0	1337	0	-15	-10	\N	\N
1025223	0	1337	0	-15	-9	\N	\N
1025224	0	1337	0	-15	-8	\N	\N
1025225	0	1337	0	-15	-7	\N	\N
1025226	0	1337	0	-15	-6	\N	\N
1025227	0	1337	0	-15	-5	\N	\N
1025228	0	1337	0	-15	-4	\N	\N
1025229	0	1337	0	-15	-3	\N	\N
1025230	0	1337	0	-15	-2	\N	\N
1025231	0	1337	0	-15	-1	\N	\N
1025232	0	1337	0	-15	0	\N	\N
1025233	0	1337	0	-15	1	\N	\N
1025234	0	1337	0	-15	2	\N	\N
1025235	0	1337	0	-15	3	\N	\N
1025236	0	1337	0	-15	4	\N	\N
1025237	0	1337	0	-15	5	\N	\N
1025238	0	1337	0	-15	6	\N	\N
1025239	0	1337	0	-15	7	\N	\N
1025240	0	1337	0	-15	8	\N	\N
1025241	0	1337	0	-15	9	\N	\N
1025242	0	1337	0	-15	10	\N	\N
1025243	0	1337	0	-15	11	\N	\N
1025244	0	1337	0	-15	12	\N	\N
1025245	0	1337	0	-15	13	\N	\N
1025246	0	1337	0	-15	14	\N	\N
1025247	0	1337	0	-15	15	\N	\N
1025248	0	1337	0	-15	16	\N	\N
1025249	0	1337	0	-15	17	\N	\N
1025250	0	1337	0	-15	18	\N	\N
1025251	0	1337	0	-15	19	\N	\N
1025252	0	1337	0	-15	20	\N	\N
1025253	0	1337	0	-15	21	\N	\N
1025254	0	1337	0	-15	22	\N	\N
1025255	0	1337	0	-15	23	\N	\N
1025256	0	1337	0	-15	24	\N	\N
1025257	0	1337	0	-15	25	\N	\N
1025258	0	1337	0	-15	26	\N	\N
1025259	0	1337	0	-15	27	\N	\N
1025260	0	1337	0	-15	28	\N	\N
1025261	0	1337	0	-15	29	\N	\N
1025262	0	1337	0	-15	30	\N	\N
1025263	0	1337	0	-15	31	\N	\N
1025264	0	1337	0	-15	32	\N	\N
1025265	0	1337	0	-15	33	\N	\N
1025266	0	1337	0	-15	34	\N	\N
1025267	0	1337	0	-15	35	\N	\N
1025268	0	1337	0	-15	36	\N	\N
1025269	0	1337	0	-15	37	\N	\N
1025270	0	1337	0	-15	38	\N	\N
1025271	0	1337	0	-15	39	\N	\N
1025272	0	1337	0	-15	40	\N	\N
1025273	0	1337	0	-15	41	\N	\N
1025274	0	1337	0	-15	42	\N	\N
1025275	0	1337	0	-15	43	\N	\N
1025276	0	1337	0	-15	44	\N	\N
1025277	0	1337	0	-15	45	\N	\N
1025278	0	1337	0	-15	46	\N	\N
1025279	0	1337	0	-15	47	\N	\N
1025280	0	1337	0	-15	48	\N	\N
1025281	0	1337	0	-15	49	\N	\N
1025282	0	1337	0	-15	50	\N	\N
1025283	0	1337	0	-15	51	\N	\N
1025284	0	1337	0	-15	52	\N	\N
1025285	0	1337	0	-15	53	\N	\N
1025286	0	1337	0	-15	54	\N	\N
1025287	0	1337	0	-15	55	\N	\N
1025288	0	1337	0	-15	56	\N	\N
1025289	0	1337	0	-15	57	\N	\N
1025290	0	1337	0	-15	58	\N	\N
1025291	0	1337	0	-15	59	\N	\N
1025292	0	1337	0	-14	-20	\N	\N
1025293	0	1337	0	-14	-19	\N	\N
1025294	0	1337	0	-14	-18	\N	\N
1025295	0	1337	0	-14	-17	\N	\N
1025296	0	1337	0	-14	-16	\N	\N
1025297	0	1337	0	-14	-15	\N	\N
1025298	0	1337	0	-14	-14	\N	\N
1025299	0	1337	0	-14	-13	\N	\N
1025300	0	1337	0	-14	-12	\N	\N
1025301	0	1337	0	-14	-11	\N	\N
1025302	0	1337	0	-14	-10	\N	\N
1025303	0	1337	0	-14	-9	\N	\N
1025304	0	1337	0	-14	-8	\N	\N
1025305	0	1337	0	-14	-7	\N	\N
1025306	0	1337	0	-14	-6	\N	\N
1025307	0	1337	0	-14	-5	\N	\N
1025308	0	1337	0	-14	-4	\N	\N
1025309	0	1337	0	-14	-3	\N	\N
1025310	0	1337	0	-14	-2	\N	\N
1025311	0	1337	0	-14	-1	\N	\N
1025312	0	1337	0	-14	0	\N	\N
1025313	0	1337	0	-14	1	\N	\N
1025314	0	1337	0	-14	2	\N	\N
1025315	0	1337	0	-14	3	\N	\N
1025316	0	1337	0	-14	4	\N	\N
1025317	0	1337	0	-14	5	\N	\N
1025318	0	1337	0	-14	6	\N	\N
1025319	0	1337	0	-14	7	\N	\N
1025320	0	1337	0	-14	8	\N	\N
1025321	0	1337	0	-14	9	\N	\N
1025322	0	1337	0	-14	10	\N	\N
1025323	0	1337	0	-14	11	\N	\N
1025324	0	1337	0	-14	12	\N	\N
1025325	0	1337	0	-14	13	\N	\N
1025326	0	1337	0	-14	14	\N	\N
1025327	0	1337	0	-14	15	\N	\N
1025328	0	1337	0	-14	16	\N	\N
1025329	0	1337	0	-14	17	\N	\N
1025330	0	1337	0	-14	18	\N	\N
1025331	0	1337	0	-14	19	\N	\N
1025332	0	1337	0	-14	20	\N	\N
1025333	0	1337	0	-14	21	\N	\N
1025334	0	1337	0	-14	22	\N	\N
1025335	0	1337	0	-14	23	\N	\N
1025336	0	1337	0	-14	24	\N	\N
1025337	0	1337	0	-14	25	\N	\N
1025338	0	1337	0	-14	26	\N	\N
1025339	0	1337	0	-14	27	\N	\N
1025340	0	1337	0	-14	28	\N	\N
1025341	0	1337	0	-14	29	\N	\N
1025342	0	1337	0	-14	30	\N	\N
1025343	0	1337	0	-14	31	\N	\N
1025344	0	1337	0	-14	32	\N	\N
1025345	0	1337	0	-14	33	\N	\N
1025346	0	1337	0	-14	34	\N	\N
1025347	0	1337	0	-14	35	\N	\N
1025348	0	1337	0	-14	36	\N	\N
1025349	0	1337	0	-14	37	\N	\N
1025350	0	1337	0	-14	38	\N	\N
1025351	0	1337	0	-14	39	\N	\N
1025352	0	1337	0	-14	40	\N	\N
1025353	0	1337	0	-14	41	\N	\N
1025354	0	1337	0	-14	42	\N	\N
1025355	0	1337	0	-14	43	\N	\N
1025356	0	1337	0	-14	44	\N	\N
1025357	0	1337	0	-14	45	\N	\N
1025358	0	1337	0	-14	46	\N	\N
1025359	0	1337	0	-14	47	\N	\N
1025360	0	1337	0	-14	48	\N	\N
1025361	0	1337	0	-14	49	\N	\N
1025362	0	1337	0	-14	50	\N	\N
1025363	0	1337	0	-14	51	\N	\N
1025364	0	1337	0	-14	52	\N	\N
1025365	0	1337	0	-14	53	\N	\N
1025366	0	1337	0	-14	54	\N	\N
1025367	0	1337	0	-14	55	\N	\N
1025368	0	1337	0	-14	56	\N	\N
1025369	0	1337	0	-14	57	\N	\N
1025370	0	1337	0	-14	58	\N	\N
1025371	0	1337	0	-14	59	\N	\N
1025372	0	1337	0	-13	-20	\N	\N
1025373	0	1337	0	-13	-19	\N	\N
1025374	0	1337	0	-13	-18	\N	\N
1025375	0	1337	0	-13	-17	\N	\N
1025376	0	1337	0	-13	-16	\N	\N
1025377	0	1337	0	-13	-15	\N	\N
1025378	0	1337	0	-13	-14	\N	\N
1025379	0	1337	0	-13	-13	\N	\N
1025380	0	1337	0	-13	-12	\N	\N
1025381	0	1337	0	-13	-11	\N	\N
1025382	0	1337	0	-13	-10	\N	\N
1025383	0	1337	0	-13	-9	\N	\N
1025384	0	1337	0	-13	-8	\N	\N
1025385	0	1337	0	-13	-7	\N	\N
1025386	0	1337	0	-13	-6	\N	\N
1025387	0	1337	0	-13	-5	\N	\N
1025388	0	1337	0	-13	-4	\N	\N
1025389	0	1337	0	-13	-3	\N	\N
1025390	0	1337	0	-13	-2	\N	\N
1025391	0	1337	0	-13	-1	\N	\N
1025392	0	1337	0	-13	0	\N	\N
1025393	0	1337	0	-13	1	\N	\N
1025394	0	1337	0	-13	2	\N	\N
1025395	0	1337	0	-13	3	\N	\N
1025396	0	1337	0	-13	4	\N	\N
1025397	0	1337	0	-13	5	\N	\N
1025398	0	1337	0	-13	6	\N	\N
1025399	0	1337	0	-13	7	\N	\N
1025400	0	1337	0	-13	8	\N	\N
1025401	0	1337	0	-13	9	\N	\N
1025402	0	1337	0	-13	10	\N	\N
1025403	0	1337	0	-13	11	\N	\N
1025404	0	1337	0	-13	12	\N	\N
1025405	0	1337	0	-13	13	\N	\N
1025406	0	1337	0	-13	14	\N	\N
1025407	0	1337	0	-13	15	\N	\N
1025408	0	1337	0	-13	16	\N	\N
1025409	0	1337	0	-13	17	\N	\N
1025410	0	1337	0	-13	18	\N	\N
1025411	0	1337	0	-13	19	\N	\N
1025412	0	1337	0	-13	20	\N	\N
1025413	0	1337	0	-13	21	\N	\N
1025414	0	1337	0	-13	22	\N	\N
1025415	0	1337	0	-13	23	\N	\N
1025416	0	1337	0	-13	24	\N	\N
1025417	0	1337	0	-13	25	\N	\N
1025418	0	1337	0	-13	26	\N	\N
1025419	0	1337	0	-13	27	\N	\N
1025420	0	1337	0	-13	28	\N	\N
1025421	0	1337	0	-13	29	\N	\N
1025422	0	1337	0	-13	30	\N	\N
1025423	0	1337	0	-13	31	\N	\N
1025424	0	1337	0	-13	32	\N	\N
1025425	0	1337	0	-13	33	\N	\N
1025426	0	1337	0	-13	34	\N	\N
1025427	0	1337	0	-13	35	\N	\N
1025428	0	1337	0	-13	36	\N	\N
1025429	0	1337	0	-13	37	\N	\N
1025430	0	1337	0	-13	38	\N	\N
1025431	0	1337	0	-13	39	\N	\N
1025432	0	1337	0	-13	40	\N	\N
1025433	0	1337	0	-13	41	\N	\N
1025434	0	1337	0	-13	42	\N	\N
1025435	0	1337	0	-13	43	\N	\N
1025436	0	1337	0	-13	44	\N	\N
1025437	0	1337	0	-13	45	\N	\N
1025438	0	1337	0	-13	46	\N	\N
1025439	0	1337	0	-13	47	\N	\N
1025440	0	1337	0	-13	48	\N	\N
1025441	0	1337	0	-13	49	\N	\N
1025442	0	1337	0	-13	50	\N	\N
1025443	0	1337	0	-13	51	\N	\N
1025444	0	1337	0	-13	52	\N	\N
1025445	0	1337	0	-13	53	\N	\N
1025446	0	1337	0	-13	54	\N	\N
1025447	0	1337	0	-13	55	\N	\N
1025448	0	1337	0	-13	56	\N	\N
1025449	0	1337	0	-13	57	\N	\N
1025450	0	1337	0	-13	58	\N	\N
1025451	0	1337	0	-13	59	\N	\N
1025452	0	1337	0	-12	-20	\N	\N
1025453	0	1337	0	-12	-19	\N	\N
1025454	0	1337	0	-12	-18	\N	\N
1025455	0	1337	0	-12	-17	\N	\N
1025456	0	1337	0	-12	-16	\N	\N
1025457	0	1337	0	-12	-15	\N	\N
1025458	0	1337	0	-12	-14	\N	\N
1025459	0	1337	0	-12	-13	\N	\N
1025460	0	1337	0	-12	-12	\N	\N
1025461	0	1337	0	-12	-11	\N	\N
1025462	0	1337	0	-12	-10	\N	\N
1025463	0	1337	0	-12	-9	\N	\N
1025464	0	1337	0	-12	-8	\N	\N
1025465	0	1337	0	-12	-7	\N	\N
1025466	0	1337	0	-12	-6	\N	\N
1025467	0	1337	0	-12	-5	\N	\N
1025468	0	1337	0	-12	-4	\N	\N
1025469	0	1337	0	-12	-3	\N	\N
1025470	0	1337	0	-12	-2	\N	\N
1025471	0	1337	0	-12	-1	\N	\N
1025472	0	1337	0	-12	0	\N	\N
1025473	0	1337	0	-12	1	\N	\N
1025474	0	1337	0	-12	2	\N	\N
1025475	0	1337	0	-12	3	\N	\N
1025476	0	1337	0	-12	4	\N	\N
1025477	0	1337	0	-12	5	\N	\N
1025478	0	1337	0	-12	6	\N	\N
1025479	0	1337	0	-12	7	\N	\N
1025480	0	1337	0	-12	8	\N	\N
1025481	0	1337	0	-12	9	\N	\N
1025482	0	1337	0	-12	10	\N	\N
1025483	0	1337	0	-12	11	\N	\N
1025484	0	1337	0	-12	12	\N	\N
1025485	0	1337	0	-12	13	\N	\N
1025486	0	1337	0	-12	14	\N	\N
1025487	0	1337	0	-12	15	\N	\N
1025488	0	1337	0	-12	16	\N	\N
1025489	0	1337	0	-12	17	\N	\N
1025490	0	1337	0	-12	18	\N	\N
1025491	0	1337	0	-12	19	\N	\N
1025492	0	1337	0	-12	20	\N	\N
1025493	0	1337	0	-12	21	\N	\N
1025494	0	1337	0	-12	22	\N	\N
1025495	0	1337	0	-12	23	\N	\N
1025496	0	1337	0	-12	24	\N	\N
1025497	0	1337	0	-12	25	\N	\N
1025498	0	1337	0	-12	26	\N	\N
1025499	0	1337	0	-12	27	\N	\N
1025500	0	1337	0	-12	28	\N	\N
1025501	0	1337	0	-12	29	\N	\N
1025502	0	1337	0	-12	30	\N	\N
1025503	0	1337	0	-12	31	\N	\N
1025504	0	1337	0	-12	32	\N	\N
1025505	0	1337	0	-12	33	\N	\N
1025506	0	1337	0	-12	34	\N	\N
1025507	0	1337	0	-12	35	\N	\N
1025508	0	1337	0	-12	36	\N	\N
1025509	0	1337	0	-12	37	\N	\N
1025510	0	1337	0	-12	38	\N	\N
1025511	0	1337	0	-12	39	\N	\N
1025512	0	1337	0	-12	40	\N	\N
1025513	0	1337	0	-12	41	\N	\N
1025514	0	1337	0	-12	42	\N	\N
1025515	0	1337	0	-12	43	\N	\N
1025516	0	1337	0	-12	44	\N	\N
1025517	0	1337	0	-12	45	\N	\N
1025518	0	1337	0	-12	46	\N	\N
1025519	0	1337	0	-12	47	\N	\N
1025520	0	1337	0	-12	48	\N	\N
1025521	0	1337	0	-12	49	\N	\N
1025522	0	1337	0	-12	50	\N	\N
1025523	0	1337	0	-12	51	\N	\N
1025524	0	1337	0	-12	52	\N	\N
1025525	0	1337	0	-12	53	\N	\N
1025526	0	1337	0	-12	54	\N	\N
1025527	0	1337	0	-12	55	\N	\N
1025528	0	1337	0	-12	56	\N	\N
1025529	0	1337	0	-12	57	\N	\N
1025530	0	1337	0	-12	58	\N	\N
1025531	0	1337	0	-12	59	\N	\N
1025532	0	1337	0	-11	-20	\N	\N
1025533	0	1337	0	-11	-19	\N	\N
1025534	0	1337	0	-11	-18	\N	\N
1025535	0	1337	0	-11	-17	\N	\N
1025536	0	1337	0	-11	-16	\N	\N
1025537	0	1337	0	-11	-15	\N	\N
1025538	0	1337	0	-11	-14	\N	\N
1025539	0	1337	0	-11	-13	\N	\N
1025540	0	1337	0	-11	-12	\N	\N
1025541	0	1337	0	-11	-11	\N	\N
1025542	0	1337	0	-11	-10	\N	\N
1025543	0	1337	0	-11	-9	\N	\N
1025544	0	1337	0	-11	-8	\N	\N
1025545	0	1337	0	-11	-7	\N	\N
1025546	0	1337	0	-11	-6	\N	\N
1025547	0	1337	0	-11	-5	\N	\N
1025548	0	1337	0	-11	-4	\N	\N
1025549	0	1337	0	-11	-3	\N	\N
1025550	0	1337	0	-11	-2	\N	\N
1025551	0	1337	0	-11	-1	\N	\N
1025552	0	1337	0	-11	0	\N	\N
1025553	0	1337	0	-11	1	\N	\N
1025554	0	1337	0	-11	2	\N	\N
1025555	0	1337	0	-11	3	\N	\N
1025556	0	1337	0	-11	4	\N	\N
1025557	0	1337	0	-11	5	\N	\N
1025558	0	1337	0	-11	6	\N	\N
1025559	0	1337	0	-11	7	\N	\N
1025560	0	1337	0	-11	8	\N	\N
1025561	0	1337	0	-11	9	\N	\N
1025562	0	1337	0	-11	10	\N	\N
1025563	0	1337	0	-11	11	\N	\N
1025564	0	1337	0	-11	12	\N	\N
1025565	0	1337	0	-11	13	\N	\N
1025566	0	1337	0	-11	14	\N	\N
1025567	0	1337	0	-11	15	\N	\N
1025568	0	1337	0	-11	16	\N	\N
1025569	0	1337	0	-11	17	\N	\N
1025570	0	1337	0	-11	18	\N	\N
1025571	0	1337	0	-11	19	\N	\N
1025572	0	1337	0	-11	20	\N	\N
1025573	0	1337	0	-11	21	\N	\N
1025574	0	1337	0	-11	22	\N	\N
1025575	0	1337	0	-11	23	\N	\N
1025576	0	1337	0	-11	24	\N	\N
1025577	0	1337	0	-11	25	\N	\N
1025578	0	1337	0	-11	26	\N	\N
1025579	0	1337	0	-11	27	\N	\N
1025580	0	1337	0	-11	28	\N	\N
1025581	0	1337	0	-11	29	\N	\N
1025582	0	1337	0	-11	30	\N	\N
1025583	0	1337	0	-11	31	\N	\N
1025584	0	1337	0	-11	32	\N	\N
1025585	0	1337	0	-11	33	\N	\N
1025586	0	1337	0	-11	34	\N	\N
1025587	0	1337	0	-11	35	\N	\N
1025588	0	1337	0	-11	36	\N	\N
1025589	0	1337	0	-11	37	\N	\N
1025590	0	1337	0	-11	38	\N	\N
1025591	0	1337	0	-11	39	\N	\N
1025592	0	1337	0	-11	40	\N	\N
1025593	0	1337	0	-11	41	\N	\N
1025594	0	1337	0	-11	42	\N	\N
1025595	0	1337	0	-11	43	\N	\N
1025596	0	1337	0	-11	44	\N	\N
1025597	0	1337	0	-11	45	\N	\N
1025598	0	1337	0	-11	46	\N	\N
1025599	0	1337	0	-11	47	\N	\N
1025600	0	1337	0	-11	48	\N	\N
1025601	0	1337	0	-11	49	\N	\N
1025602	0	1337	0	-11	50	\N	\N
1025603	0	1337	0	-11	51	\N	\N
1025604	0	1337	0	-11	52	\N	\N
1025605	0	1337	0	-11	53	\N	\N
1025606	0	1337	0	-11	54	\N	\N
1025607	0	1337	0	-11	55	\N	\N
1025608	0	1337	0	-11	56	\N	\N
1025609	0	1337	0	-11	57	\N	\N
1025610	0	1337	0	-11	58	\N	\N
1025611	0	1337	0	-11	59	\N	\N
1025612	0	1337	0	-10	-20	\N	\N
1025613	0	1337	0	-10	-19	\N	\N
1025614	0	1337	0	-10	-18	\N	\N
1025615	0	1337	0	-10	-17	\N	\N
1025616	0	1337	0	-10	-16	\N	\N
1025617	0	1337	0	-10	-15	\N	\N
1025618	0	1337	0	-10	-14	\N	\N
1025619	0	1337	0	-10	-13	\N	\N
1025620	0	1337	0	-10	-12	\N	\N
1025621	0	1337	0	-10	-11	\N	\N
1025622	0	1337	0	-10	-10	\N	\N
1025623	0	1337	0	-10	-9	\N	\N
1025624	0	1337	0	-10	-8	\N	\N
1025625	0	1337	0	-10	-7	\N	\N
1025626	0	1337	0	-10	-6	\N	\N
1025627	0	1337	0	-10	-5	\N	\N
1025628	0	1337	0	-10	-4	\N	\N
1025629	0	1337	0	-10	-3	\N	\N
1025630	0	1337	0	-10	-2	\N	\N
1025631	0	1337	0	-10	-1	\N	\N
1025632	0	1337	0	-10	0	\N	\N
1025633	0	1337	0	-10	1	\N	\N
1025634	0	1337	0	-10	2	\N	\N
1025635	0	1337	0	-10	3	\N	\N
1025636	0	1337	0	-10	4	\N	\N
1025637	0	1337	0	-10	5	\N	\N
1025638	0	1337	0	-10	6	\N	\N
1025639	0	1337	0	-10	7	\N	\N
1025640	0	1337	0	-10	8	\N	\N
1025641	0	1337	0	-10	9	\N	\N
1025642	0	1337	0	-10	10	\N	\N
1025643	0	1337	0	-10	11	\N	\N
1025644	0	1337	0	-10	12	\N	\N
1025645	0	1337	0	-10	13	\N	\N
1025646	0	1337	0	-10	14	\N	\N
1025647	0	1337	0	-10	15	\N	\N
1025648	0	1337	0	-10	16	\N	\N
1025649	0	1337	0	-10	17	\N	\N
1025650	0	1337	0	-10	18	\N	\N
1025651	0	1337	0	-10	19	\N	\N
1025652	0	1337	0	-10	20	\N	\N
1025653	0	1337	0	-10	21	\N	\N
1025654	0	1337	0	-10	22	\N	\N
1025655	0	1337	0	-10	23	\N	\N
1025656	0	1337	0	-10	24	\N	\N
1025657	0	1337	0	-10	25	\N	\N
1025658	0	1337	0	-10	26	\N	\N
1025659	0	1337	0	-10	27	\N	\N
1025660	0	1337	0	-10	28	\N	\N
1025661	0	1337	0	-10	29	\N	\N
1025662	0	1337	0	-10	30	\N	\N
1025663	0	1337	0	-10	31	\N	\N
1025664	0	1337	0	-10	32	\N	\N
1025665	0	1337	0	-10	33	\N	\N
1025666	0	1337	0	-10	34	\N	\N
1025667	0	1337	0	-10	35	\N	\N
1025668	0	1337	0	-10	36	\N	\N
1025669	0	1337	0	-10	37	\N	\N
1025670	0	1337	0	-10	38	\N	\N
1025671	0	1337	0	-10	39	\N	\N
1025672	0	1337	0	-10	40	\N	\N
1025673	0	1337	0	-10	41	\N	\N
1025674	0	1337	0	-10	42	\N	\N
1025675	0	1337	0	-10	43	\N	\N
1025676	0	1337	0	-10	44	\N	\N
1025677	0	1337	0	-10	45	\N	\N
1025678	0	1337	0	-10	46	\N	\N
1025679	0	1337	0	-10	47	\N	\N
1025680	0	1337	0	-10	48	\N	\N
1025681	0	1337	0	-10	49	\N	\N
1025682	0	1337	0	-10	50	\N	\N
1025683	0	1337	0	-10	51	\N	\N
1025684	0	1337	0	-10	52	\N	\N
1025685	0	1337	0	-10	53	\N	\N
1025686	0	1337	0	-10	54	\N	\N
1025687	0	1337	0	-10	55	\N	\N
1025688	0	1337	0	-10	56	\N	\N
1025689	0	1337	0	-10	57	\N	\N
1025690	0	1337	0	-10	58	\N	\N
1025691	0	1337	0	-10	59	\N	\N
1025692	0	1337	0	-9	-20	\N	\N
1025693	0	1337	0	-9	-19	\N	\N
1025694	0	1337	0	-9	-18	\N	\N
1025695	0	1337	0	-9	-17	\N	\N
1025696	0	1337	0	-9	-16	\N	\N
1025697	0	1337	0	-9	-15	\N	\N
1025698	0	1337	0	-9	-14	\N	\N
1025699	0	1337	0	-9	-13	\N	\N
1025700	0	1337	0	-9	-12	\N	\N
1025701	0	1337	0	-9	-11	\N	\N
1025702	0	1337	0	-9	-10	\N	\N
1025703	0	1337	0	-9	-9	\N	\N
1025704	0	1337	0	-9	-8	\N	\N
1025705	0	1337	0	-9	-7	\N	\N
1025706	0	1337	0	-9	-6	\N	\N
1025707	0	1337	0	-9	-5	\N	\N
1025708	0	1337	0	-9	-4	\N	\N
1025709	0	1337	0	-9	-3	\N	\N
1025710	0	1337	0	-9	-2	\N	\N
1025711	0	1337	0	-9	-1	\N	\N
1025712	0	1337	0	-9	0	\N	\N
1025713	0	1337	0	-9	1	\N	\N
1025714	0	1337	0	-9	2	\N	\N
1025715	0	1337	0	-9	3	\N	\N
1025716	0	1337	0	-9	4	\N	\N
1025717	0	1337	0	-9	5	\N	\N
1025718	0	1337	0	-9	6	\N	\N
1025719	0	1337	0	-9	7	\N	\N
1025720	0	1337	0	-9	8	\N	\N
1025721	0	1337	0	-9	9	\N	\N
1025722	0	1337	0	-9	10	\N	\N
1025723	0	1337	0	-9	11	\N	\N
1025724	0	1337	0	-9	12	\N	\N
1025725	0	1337	0	-9	13	\N	\N
1025726	0	1337	0	-9	14	\N	\N
1025727	0	1337	0	-9	15	\N	\N
1025728	0	1337	0	-9	16	\N	\N
1025729	0	1337	0	-9	17	\N	\N
1025730	0	1337	0	-9	18	\N	\N
1025731	0	1337	0	-9	19	\N	\N
1025732	0	1337	0	-9	20	\N	\N
1025733	0	1337	0	-9	21	\N	\N
1025734	0	1337	0	-9	22	\N	\N
1025735	0	1337	0	-9	23	\N	\N
1025736	0	1337	0	-9	24	\N	\N
1025737	0	1337	0	-9	25	\N	\N
1025738	0	1337	0	-9	26	\N	\N
1025739	0	1337	0	-9	27	\N	\N
1025740	0	1337	0	-9	28	\N	\N
1025741	0	1337	0	-9	29	\N	\N
1025742	0	1337	0	-9	30	\N	\N
1025743	0	1337	0	-9	31	\N	\N
1025744	0	1337	0	-9	32	\N	\N
1025745	0	1337	0	-9	33	\N	\N
1025746	0	1337	0	-9	34	\N	\N
1025747	0	1337	0	-9	35	\N	\N
1025748	0	1337	0	-9	36	\N	\N
1025749	0	1337	0	-9	37	\N	\N
1025750	0	1337	0	-9	38	\N	\N
1025751	0	1337	0	-9	39	\N	\N
1025752	0	1337	0	-9	40	\N	\N
1025753	0	1337	0	-9	41	\N	\N
1025754	0	1337	0	-9	42	\N	\N
1025755	0	1337	0	-9	43	\N	\N
1025756	0	1337	0	-9	44	\N	\N
1025757	0	1337	0	-9	45	\N	\N
1025758	0	1337	0	-9	46	\N	\N
1025759	0	1337	0	-9	47	\N	\N
1025760	0	1337	0	-9	48	\N	\N
1025761	0	1337	0	-9	49	\N	\N
1025762	0	1337	0	-9	50	\N	\N
1025763	0	1337	0	-9	51	\N	\N
1025764	0	1337	0	-9	52	\N	\N
1025765	0	1337	0	-9	53	\N	\N
1025766	0	1337	0	-9	54	\N	\N
1025767	0	1337	0	-9	55	\N	\N
1025768	0	1337	0	-9	56	\N	\N
1025769	0	1337	0	-9	57	\N	\N
1025770	0	1337	0	-9	58	\N	\N
1025771	0	1337	0	-9	59	\N	\N
1025772	0	1337	0	-8	-20	\N	\N
1025773	0	1337	0	-8	-19	\N	\N
1025774	0	1337	0	-8	-18	\N	\N
1025775	0	1337	0	-8	-17	\N	\N
1025776	0	1337	0	-8	-16	\N	\N
1025777	0	1337	0	-8	-15	\N	\N
1025778	0	1337	0	-8	-14	\N	\N
1025779	0	1337	0	-8	-13	\N	\N
1025780	0	1337	0	-8	-12	\N	\N
1025781	0	1337	0	-8	-11	\N	\N
1025782	0	1337	0	-8	-10	\N	\N
1025783	0	1337	0	-8	-9	\N	\N
1025784	0	1337	0	-8	-8	\N	\N
1025785	0	1337	0	-8	-7	\N	\N
1025786	0	1337	0	-8	-6	\N	\N
1025787	0	1337	0	-8	-5	\N	\N
1025788	0	1337	0	-8	-4	\N	\N
1025789	0	1337	0	-8	-3	\N	\N
1025790	0	1337	0	-8	-2	\N	\N
1025791	0	1337	0	-8	-1	\N	\N
1025792	0	1337	0	-8	0	\N	\N
1025793	0	1337	0	-8	1	\N	\N
1025794	0	1337	0	-8	2	\N	\N
1025795	0	1337	0	-8	3	\N	\N
1025796	0	1337	0	-8	4	\N	\N
1025797	0	1337	0	-8	5	\N	\N
1025798	0	1337	0	-8	6	\N	\N
1025799	0	1337	0	-8	7	\N	\N
1025800	0	1337	0	-8	8	\N	\N
1025801	0	1337	0	-8	9	\N	\N
1025802	0	1337	0	-8	10	\N	\N
1025803	0	1337	0	-8	11	\N	\N
1025804	0	1337	0	-8	12	\N	\N
1025805	0	1337	0	-8	13	\N	\N
1025806	0	1337	0	-8	14	\N	\N
1025807	0	1337	0	-8	15	\N	\N
1025808	0	1337	0	-8	16	\N	\N
1025809	0	1337	0	-8	17	\N	\N
1025810	0	1337	0	-8	18	\N	\N
1025811	0	1337	0	-8	19	\N	\N
1025812	0	1337	0	-8	20	\N	\N
1025813	0	1337	0	-8	21	\N	\N
1025814	0	1337	0	-8	22	\N	\N
1025815	0	1337	0	-8	23	\N	\N
1025816	0	1337	0	-8	24	\N	\N
1025817	0	1337	0	-8	25	\N	\N
1025818	0	1337	0	-8	26	\N	\N
1025819	0	1337	0	-8	27	\N	\N
1025820	0	1337	0	-8	28	\N	\N
1025821	0	1337	0	-8	29	\N	\N
1025822	0	1337	0	-8	30	\N	\N
1025823	0	1337	0	-8	31	\N	\N
1025824	0	1337	0	-8	32	\N	\N
1025825	0	1337	0	-8	33	\N	\N
1025826	0	1337	0	-8	34	\N	\N
1025827	0	1337	0	-8	35	\N	\N
1025828	0	1337	0	-8	36	\N	\N
1025829	0	1337	0	-8	37	\N	\N
1025830	0	1337	0	-8	38	\N	\N
1025831	0	1337	0	-8	39	\N	\N
1025832	0	1337	0	-8	40	\N	\N
1025833	0	1337	0	-8	41	\N	\N
1025834	0	1337	0	-8	42	\N	\N
1025835	0	1337	0	-8	43	\N	\N
1025836	0	1337	0	-8	44	\N	\N
1025837	0	1337	0	-8	45	\N	\N
1025838	0	1337	0	-8	46	\N	\N
1025839	0	1337	0	-8	47	\N	\N
1025840	0	1337	0	-8	48	\N	\N
1025841	0	1337	0	-8	49	\N	\N
1025842	0	1337	0	-8	50	\N	\N
1025843	0	1337	0	-8	51	\N	\N
1025844	0	1337	0	-8	52	\N	\N
1025845	0	1337	0	-8	53	\N	\N
1025846	0	1337	0	-8	54	\N	\N
1025847	0	1337	0	-8	55	\N	\N
1025848	0	1337	0	-8	56	\N	\N
1025849	0	1337	0	-8	57	\N	\N
1025850	0	1337	0	-8	58	\N	\N
1025851	0	1337	0	-8	59	\N	\N
1025852	0	1337	0	-7	-20	\N	\N
1025853	0	1337	0	-7	-19	\N	\N
1025854	0	1337	0	-7	-18	\N	\N
1025855	0	1337	0	-7	-17	\N	\N
1025856	0	1337	0	-7	-16	\N	\N
1025857	0	1337	0	-7	-15	\N	\N
1025858	0	1337	0	-7	-14	\N	\N
1025859	0	1337	0	-7	-13	\N	\N
1025860	0	1337	0	-7	-12	\N	\N
1025861	0	1337	0	-7	-11	\N	\N
1025862	0	1337	0	-7	-10	\N	\N
1025863	0	1337	0	-7	-9	\N	\N
1025864	0	1337	0	-7	-8	\N	\N
1025865	0	1337	0	-7	-7	\N	\N
1025866	0	1337	0	-7	-6	\N	\N
1025867	0	1337	0	-7	-5	\N	\N
1025868	0	1337	0	-7	-4	\N	\N
1025869	0	1337	0	-7	-3	\N	\N
1025870	0	1337	0	-7	-2	\N	\N
1025871	0	1337	0	-7	-1	\N	\N
1025872	0	1337	0	-7	0	\N	\N
1025873	0	1337	0	-7	1	\N	\N
1025874	0	1337	0	-7	2	\N	\N
1025875	0	1337	0	-7	3	\N	\N
1025876	0	1337	0	-7	4	\N	\N
1025877	0	1337	0	-7	5	\N	\N
1025878	0	1337	0	-7	6	\N	\N
1025879	0	1337	0	-7	7	\N	\N
1025880	0	1337	0	-7	8	\N	\N
1025881	0	1337	0	-7	9	\N	\N
1025882	0	1337	0	-7	10	\N	\N
1025883	0	1337	0	-7	11	\N	\N
1025884	0	1337	0	-7	12	\N	\N
1025885	0	1337	0	-7	13	\N	\N
1025886	0	1337	0	-7	14	\N	\N
1025887	0	1337	0	-7	15	\N	\N
1025888	0	1337	0	-7	16	\N	\N
1025889	0	1337	0	-7	17	\N	\N
1025890	0	1337	0	-7	18	\N	\N
1025891	0	1337	0	-7	19	\N	\N
1025892	0	1337	0	-7	20	\N	\N
1025893	0	1337	0	-7	21	\N	\N
1025894	0	1337	0	-7	22	\N	\N
1025895	0	1337	0	-7	23	\N	\N
1025896	0	1337	0	-7	24	\N	\N
1025897	0	1337	0	-7	25	\N	\N
1025898	0	1337	0	-7	26	\N	\N
1025899	0	1337	0	-7	27	\N	\N
1025900	0	1337	0	-7	28	\N	\N
1025901	0	1337	0	-7	29	\N	\N
1025902	0	1337	0	-7	30	\N	\N
1025903	0	1337	0	-7	31	\N	\N
1025904	0	1337	0	-7	32	\N	\N
1025905	0	1337	0	-7	33	\N	\N
1025906	0	1337	0	-7	34	\N	\N
1025907	0	1337	0	-7	35	\N	\N
1025908	0	1337	0	-7	36	\N	\N
1025909	0	1337	0	-7	37	\N	\N
1025910	0	1337	0	-7	38	\N	\N
1025911	0	1337	0	-7	39	\N	\N
1025912	0	1337	0	-7	40	\N	\N
1025913	0	1337	0	-7	41	\N	\N
1025914	0	1337	0	-7	42	\N	\N
1025915	0	1337	0	-7	43	\N	\N
1025916	0	1337	0	-7	44	\N	\N
1025917	0	1337	0	-7	45	\N	\N
1025918	0	1337	0	-7	46	\N	\N
1025919	0	1337	0	-7	47	\N	\N
1025920	0	1337	0	-7	48	\N	\N
1025921	0	1337	0	-7	49	\N	\N
1025922	0	1337	0	-7	50	\N	\N
1025923	0	1337	0	-7	51	\N	\N
1025924	0	1337	0	-7	52	\N	\N
1025925	0	1337	0	-7	53	\N	\N
1025926	0	1337	0	-7	54	\N	\N
1025927	0	1337	0	-7	55	\N	\N
1025928	0	1337	0	-7	56	\N	\N
1025929	0	1337	0	-7	57	\N	\N
1025930	0	1337	0	-7	58	\N	\N
1025931	0	1337	0	-7	59	\N	\N
1025932	0	1337	0	-6	-20	\N	\N
1025933	0	1337	0	-6	-19	\N	\N
1025934	0	1337	0	-6	-18	\N	\N
1025935	0	1337	0	-6	-17	\N	\N
1025936	0	1337	0	-6	-16	\N	\N
1025937	0	1337	0	-6	-15	\N	\N
1025938	0	1337	0	-6	-14	\N	\N
1025939	0	1337	0	-6	-13	\N	\N
1025940	0	1337	0	-6	-12	\N	\N
1025941	0	1337	0	-6	-11	\N	\N
1025942	0	1337	0	-6	-10	\N	\N
1025943	0	1337	0	-6	-9	\N	\N
1025944	0	1337	0	-6	-8	\N	\N
1025945	0	1337	0	-6	-7	\N	\N
1025946	0	1337	0	-6	-6	\N	\N
1025947	0	1337	0	-6	-5	\N	\N
1025948	0	1337	0	-6	-4	\N	\N
1025949	0	1337	0	-6	-3	\N	\N
1025950	0	1337	0	-6	-2	\N	\N
1025951	0	1337	0	-6	-1	\N	\N
1025952	0	1337	0	-6	0	\N	\N
1025953	0	1337	0	-6	1	\N	\N
1025954	0	1337	0	-6	2	\N	\N
1025955	0	1337	0	-6	3	\N	\N
1025956	0	1337	0	-6	4	\N	\N
1025957	0	1337	0	-6	5	\N	\N
1025958	0	1337	0	-6	6	\N	\N
1025959	0	1337	0	-6	7	\N	\N
1025960	0	1337	0	-6	8	\N	\N
1025961	0	1337	0	-6	9	\N	\N
1025962	0	1337	0	-6	10	\N	\N
1025963	0	1337	0	-6	11	\N	\N
1025964	0	1337	0	-6	12	\N	\N
1025965	0	1337	0	-6	13	\N	\N
1025966	0	1337	0	-6	14	\N	\N
1025967	0	1337	0	-6	15	\N	\N
1025968	0	1337	0	-6	16	\N	\N
1025969	0	1337	0	-6	17	\N	\N
1025970	0	1337	0	-6	18	\N	\N
1025971	0	1337	0	-6	19	\N	\N
1025972	0	1337	0	-6	20	\N	\N
1025973	0	1337	0	-6	21	\N	\N
1025974	0	1337	0	-6	22	\N	\N
1025975	0	1337	0	-6	23	\N	\N
1025976	0	1337	0	-6	24	\N	\N
1025977	0	1337	0	-6	25	\N	\N
1025978	0	1337	0	-6	26	\N	\N
1025979	0	1337	0	-6	27	\N	\N
1025980	0	1337	0	-6	28	\N	\N
1025981	0	1337	0	-6	29	\N	\N
1025982	0	1337	0	-6	30	\N	\N
1025983	0	1337	0	-6	31	\N	\N
1025984	0	1337	0	-6	32	\N	\N
1025985	0	1337	0	-6	33	\N	\N
1025986	0	1337	0	-6	34	\N	\N
1025987	0	1337	0	-6	35	\N	\N
1025988	0	1337	0	-6	36	\N	\N
1025989	0	1337	0	-6	37	\N	\N
1025990	0	1337	0	-6	38	\N	\N
1025991	0	1337	0	-6	39	\N	\N
1025992	0	1337	0	-6	40	\N	\N
1025993	0	1337	0	-6	41	\N	\N
1025994	0	1337	0	-6	42	\N	\N
1025995	0	1337	0	-6	43	\N	\N
1025996	0	1337	0	-6	44	\N	\N
1025997	0	1337	0	-6	45	\N	\N
1025998	0	1337	0	-6	46	\N	\N
1025999	0	1337	0	-6	47	\N	\N
1026000	0	1337	0	-6	48	\N	\N
1026001	0	1337	0	-6	49	\N	\N
1026002	0	1337	0	-6	50	\N	\N
1026003	0	1337	0	-6	51	\N	\N
1026004	0	1337	0	-6	52	\N	\N
1026005	0	1337	0	-6	53	\N	\N
1026006	0	1337	0	-6	54	\N	\N
1026007	0	1337	0	-6	55	\N	\N
1026008	0	1337	0	-6	56	\N	\N
1026009	0	1337	0	-6	57	\N	\N
1026010	0	1337	0	-6	58	\N	\N
1026011	0	1337	0	-6	59	\N	\N
1026012	0	1337	0	-5	-20	\N	\N
1026013	0	1337	0	-5	-19	\N	\N
1026014	0	1337	0	-5	-18	\N	\N
1026015	0	1337	0	-5	-17	\N	\N
1026016	0	1337	0	-5	-16	\N	\N
1026017	0	1337	0	-5	-15	\N	\N
1026018	0	1337	0	-5	-14	\N	\N
1026019	0	1337	0	-5	-13	\N	\N
1026020	0	1337	0	-5	-12	\N	\N
1026021	0	1337	0	-5	-11	\N	\N
1026022	0	1337	0	-5	-10	\N	\N
1026023	0	1337	0	-5	-9	\N	\N
1026024	0	1337	0	-5	-8	\N	\N
1026025	0	1337	0	-5	-7	\N	\N
1026026	0	1337	0	-5	-6	\N	\N
1026027	0	1337	0	-5	-5	\N	\N
1026028	0	1337	0	-5	-4	\N	\N
1026029	0	1337	0	-5	-3	\N	\N
1026030	0	1337	0	-5	-2	\N	\N
1026031	0	1337	0	-5	-1	\N	\N
1026032	0	1337	0	-5	0	\N	\N
1026033	0	1337	0	-5	1	\N	\N
1026034	0	1337	0	-5	2	\N	\N
1026035	0	1337	0	-5	3	\N	\N
1026036	0	1337	0	-5	4	\N	\N
1026037	0	1337	0	-5	5	\N	\N
1026038	0	1337	0	-5	6	\N	\N
1026039	0	1337	0	-5	7	\N	\N
1026040	0	1337	0	-5	8	\N	\N
1026041	0	1337	0	-5	9	\N	\N
1026042	0	1337	0	-5	10	\N	\N
1026043	0	1337	0	-5	11	\N	\N
1026044	0	1337	0	-5	12	\N	\N
1026045	0	1337	0	-5	13	\N	\N
1026046	0	1337	0	-5	14	\N	\N
1026047	0	1337	0	-5	15	\N	\N
1026048	0	1337	0	-5	16	\N	\N
1026049	0	1337	0	-5	17	\N	\N
1026050	0	1337	0	-5	18	\N	\N
1026051	0	1337	0	-5	19	\N	\N
1026052	0	1337	0	-5	20	\N	\N
1026053	0	1337	0	-5	21	\N	\N
1026054	0	1337	0	-5	22	\N	\N
1026055	0	1337	0	-5	23	\N	\N
1026056	0	1337	0	-5	24	\N	\N
1026057	0	1337	0	-5	25	\N	\N
1026058	0	1337	0	-5	26	\N	\N
1026059	0	1337	0	-5	27	\N	\N
1026060	0	1337	0	-5	28	\N	\N
1026061	0	1337	0	-5	29	\N	\N
1026062	0	1337	0	-5	30	\N	\N
1026063	0	1337	0	-5	31	\N	\N
1026064	0	1337	0	-5	32	\N	\N
1026065	0	1337	0	-5	33	\N	\N
1026066	0	1337	0	-5	34	\N	\N
1026067	0	1337	0	-5	35	\N	\N
1026068	0	1337	0	-5	36	\N	\N
1026069	0	1337	0	-5	37	\N	\N
1026070	0	1337	0	-5	38	\N	\N
1026071	0	1337	0	-5	39	\N	\N
1026072	0	1337	0	-5	40	\N	\N
1026073	0	1337	0	-5	41	\N	\N
1026074	0	1337	0	-5	42	\N	\N
1026075	0	1337	0	-5	43	\N	\N
1026076	0	1337	0	-5	44	\N	\N
1026077	0	1337	0	-5	45	\N	\N
1026078	0	1337	0	-5	46	\N	\N
1026079	0	1337	0	-5	47	\N	\N
1026080	0	1337	0	-5	48	\N	\N
1026081	0	1337	0	-5	49	\N	\N
1026082	0	1337	0	-5	50	\N	\N
1026083	0	1337	0	-5	51	\N	\N
1026084	0	1337	0	-5	52	\N	\N
1026085	0	1337	0	-5	53	\N	\N
1026086	0	1337	0	-5	54	\N	\N
1026087	0	1337	0	-5	55	\N	\N
1026088	0	1337	0	-5	56	\N	\N
1026089	0	1337	0	-5	57	\N	\N
1026090	0	1337	0	-5	58	\N	\N
1026091	0	1337	0	-5	59	\N	\N
1026092	0	1337	0	-4	-20	\N	\N
1026093	0	1337	0	-4	-19	\N	\N
1026094	0	1337	0	-4	-18	\N	\N
1026095	0	1337	0	-4	-17	\N	\N
1026096	0	1337	0	-4	-16	\N	\N
1026097	0	1337	0	-4	-15	\N	\N
1026098	0	1337	0	-4	-14	\N	\N
1026099	0	1337	0	-4	-13	\N	\N
1026100	0	1337	0	-4	-12	\N	\N
1026101	0	1337	0	-4	-11	\N	\N
1026102	0	1337	0	-4	-10	\N	\N
1026103	0	1337	0	-4	-9	\N	\N
1026104	0	1337	0	-4	-8	\N	\N
1026105	0	1337	0	-4	-7	\N	\N
1026106	0	1337	0	-4	-6	\N	\N
1026107	0	1337	0	-4	-5	\N	\N
1026108	0	1337	0	-4	-4	\N	\N
1026109	0	1337	0	-4	-3	\N	\N
1026110	0	1337	0	-4	-2	\N	\N
1026111	0	1337	0	-4	-1	\N	\N
1026112	0	1337	0	-4	0	\N	\N
1026113	0	1337	0	-4	1	\N	\N
1026114	0	1337	0	-4	2	\N	\N
1026115	0	1337	0	-4	3	\N	\N
1026116	0	1337	0	-4	4	\N	\N
1026117	0	1337	0	-4	5	\N	\N
1026118	0	1337	0	-4	6	\N	\N
1026119	0	1337	0	-4	7	\N	\N
1026120	0	1337	0	-4	8	\N	\N
1026121	0	1337	0	-4	9	\N	\N
1026122	0	1337	0	-4	10	\N	\N
1026123	0	1337	0	-4	11	\N	\N
1026124	0	1337	0	-4	12	\N	\N
1026125	0	1337	0	-4	13	\N	\N
1026126	0	1337	0	-4	14	\N	\N
1026127	0	1337	0	-4	15	\N	\N
1026128	0	1337	0	-4	16	\N	\N
1026129	0	1337	0	-4	17	\N	\N
1026130	0	1337	0	-4	18	\N	\N
1026131	0	1337	0	-4	19	\N	\N
1026132	0	1337	0	-4	20	\N	\N
1026133	0	1337	0	-4	21	\N	\N
1026134	0	1337	0	-4	22	\N	\N
1026135	0	1337	0	-4	23	\N	\N
1026136	0	1337	0	-4	24	\N	\N
1026137	0	1337	0	-4	25	\N	\N
1026138	0	1337	0	-4	26	\N	\N
1026139	0	1337	0	-4	27	\N	\N
1026140	0	1337	0	-4	28	\N	\N
1026141	0	1337	0	-4	29	\N	\N
1026142	0	1337	0	-4	30	\N	\N
1026143	0	1337	0	-4	31	\N	\N
1026144	0	1337	0	-4	32	\N	\N
1026145	0	1337	0	-4	33	\N	\N
1026146	0	1337	0	-4	34	\N	\N
1026147	0	1337	0	-4	35	\N	\N
1026148	0	1337	0	-4	36	\N	\N
1026149	0	1337	0	-4	37	\N	\N
1026150	0	1337	0	-4	38	\N	\N
1026151	0	1337	0	-4	39	\N	\N
1026152	0	1337	0	-4	40	\N	\N
1026153	0	1337	0	-4	41	\N	\N
1026154	0	1337	0	-4	42	\N	\N
1026155	0	1337	0	-4	43	\N	\N
1026156	0	1337	0	-4	44	\N	\N
1026157	0	1337	0	-4	45	\N	\N
1026158	0	1337	0	-4	46	\N	\N
1026159	0	1337	0	-4	47	\N	\N
1026160	0	1337	0	-4	48	\N	\N
1026161	0	1337	0	-4	49	\N	\N
1026162	0	1337	0	-4	50	\N	\N
1026163	0	1337	0	-4	51	\N	\N
1026164	0	1337	0	-4	52	\N	\N
1026165	0	1337	0	-4	53	\N	\N
1026166	0	1337	0	-4	54	\N	\N
1026167	0	1337	0	-4	55	\N	\N
1026168	0	1337	0	-4	56	\N	\N
1026169	0	1337	0	-4	57	\N	\N
1026170	0	1337	0	-4	58	\N	\N
1026171	0	1337	0	-4	59	\N	\N
1026172	0	1337	0	-3	-20	\N	\N
1026173	0	1337	0	-3	-19	\N	\N
1026174	0	1337	0	-3	-18	\N	\N
1026175	0	1337	0	-3	-17	\N	\N
1026176	0	1337	0	-3	-16	\N	\N
1026177	0	1337	0	-3	-15	\N	\N
1026178	0	1337	0	-3	-14	\N	\N
1026179	0	1337	0	-3	-13	\N	\N
1026180	0	1337	0	-3	-12	\N	\N
1026181	0	1337	0	-3	-11	\N	\N
1026182	0	1337	0	-3	-10	\N	\N
1026183	0	1337	0	-3	-9	\N	\N
1026184	0	1337	0	-3	-8	\N	\N
1026185	0	1337	0	-3	-7	\N	\N
1026186	0	1337	0	-3	-6	\N	\N
1026187	0	1337	0	-3	-5	\N	\N
1026188	0	1337	0	-3	-4	\N	\N
1026189	0	1337	0	-3	-3	\N	\N
1026190	0	1337	0	-3	-2	\N	\N
1026191	0	1337	0	-3	-1	\N	\N
1026192	0	1337	0	-3	0	\N	\N
1026193	0	1337	0	-3	1	\N	\N
1026194	0	1337	0	-3	2	\N	\N
1026195	0	1337	0	-3	3	\N	\N
1026196	0	1337	0	-3	4	\N	\N
1026197	0	1337	0	-3	5	\N	\N
1026198	0	1337	0	-3	6	\N	\N
1026199	0	1337	0	-3	7	\N	\N
1026200	0	1337	0	-3	8	\N	\N
1026201	0	1337	0	-3	9	\N	\N
1026202	0	1337	0	-3	10	\N	\N
1026203	0	1337	0	-3	11	\N	\N
1026204	0	1337	0	-3	12	\N	\N
1026205	0	1337	0	-3	13	\N	\N
1026206	0	1337	0	-3	14	\N	\N
1026207	0	1337	0	-3	15	\N	\N
1026208	0	1337	0	-3	16	\N	\N
1026209	0	1337	0	-3	17	\N	\N
1026210	0	1337	0	-3	18	\N	\N
1026211	0	1337	0	-3	19	\N	\N
1026212	0	1337	0	-3	20	\N	\N
1026213	0	1337	0	-3	21	\N	\N
1026214	0	1337	0	-3	22	\N	\N
1026215	0	1337	0	-3	23	\N	\N
1026216	0	1337	0	-3	24	\N	\N
1026217	0	1337	0	-3	25	\N	\N
1026218	0	1337	0	-3	26	\N	\N
1026219	0	1337	0	-3	27	\N	\N
1026220	0	1337	0	-3	28	\N	\N
1026221	0	1337	0	-3	29	\N	\N
1026222	0	1337	0	-3	30	\N	\N
1026223	0	1337	0	-3	31	\N	\N
1026224	0	1337	0	-3	32	\N	\N
1026225	0	1337	0	-3	33	\N	\N
1026226	0	1337	0	-3	34	\N	\N
1026227	0	1337	0	-3	35	\N	\N
1026228	0	1337	0	-3	36	\N	\N
1026229	0	1337	0	-3	37	\N	\N
1026230	0	1337	0	-3	38	\N	\N
1026231	0	1337	0	-3	39	\N	\N
1026232	0	1337	0	-3	40	\N	\N
1026233	0	1337	0	-3	41	\N	\N
1026234	0	1337	0	-3	42	\N	\N
1026235	0	1337	0	-3	43	\N	\N
1026236	0	1337	0	-3	44	\N	\N
1026237	0	1337	0	-3	45	\N	\N
1026238	0	1337	0	-3	46	\N	\N
1026239	0	1337	0	-3	47	\N	\N
1026240	0	1337	0	-3	48	\N	\N
1026241	0	1337	0	-3	49	\N	\N
1026242	0	1337	0	-3	50	\N	\N
1026243	0	1337	0	-3	51	\N	\N
1026244	0	1337	0	-3	52	\N	\N
1026245	0	1337	0	-3	53	\N	\N
1026246	0	1337	0	-3	54	\N	\N
1026247	0	1337	0	-3	55	\N	\N
1026248	0	1337	0	-3	56	\N	\N
1026249	0	1337	0	-3	57	\N	\N
1026250	0	1337	0	-3	58	\N	\N
1026251	0	1337	0	-3	59	\N	\N
1026252	0	1337	0	-2	-20	\N	\N
1026253	0	1337	0	-2	-19	\N	\N
1026254	0	1337	0	-2	-18	\N	\N
1026255	0	1337	0	-2	-17	\N	\N
1026256	0	1337	0	-2	-16	\N	\N
1026257	0	1337	0	-2	-15	\N	\N
1026258	0	1337	0	-2	-14	\N	\N
1026259	0	1337	0	-2	-13	\N	\N
1026260	0	1337	0	-2	-12	\N	\N
1026261	0	1337	0	-2	-11	\N	\N
1026262	0	1337	0	-2	-10	\N	\N
1026263	0	1337	0	-2	-9	\N	\N
1026264	0	1337	0	-2	-8	\N	\N
1026265	0	1337	0	-2	-7	\N	\N
1026266	0	1337	0	-2	-6	\N	\N
1026267	0	1337	0	-2	-5	\N	\N
1026268	0	1337	0	-2	-4	\N	\N
1026269	0	1337	0	-2	-3	\N	\N
1026270	0	1337	0	-2	-2	\N	\N
1026271	0	1337	0	-2	-1	\N	\N
1026272	0	1337	0	-2	0	\N	\N
1026273	0	1337	0	-2	1	\N	\N
1026274	0	1337	0	-2	2	\N	\N
1026275	0	1337	0	-2	3	\N	\N
1026276	0	1337	0	-2	4	\N	\N
1026277	0	1337	0	-2	5	\N	\N
1026278	0	1337	0	-2	6	\N	\N
1026279	0	1337	0	-2	7	\N	\N
1026280	0	1337	0	-2	8	\N	\N
1026281	0	1337	0	-2	9	\N	\N
1026282	0	1337	0	-2	10	\N	\N
1026283	0	1337	0	-2	11	\N	\N
1026284	0	1337	0	-2	12	\N	\N
1026285	0	1337	0	-2	13	\N	\N
1026286	0	1337	0	-2	14	\N	\N
1026287	0	1337	0	-2	15	\N	\N
1026288	0	1337	0	-2	16	\N	\N
1026289	0	1337	0	-2	17	\N	\N
1026290	0	1337	0	-2	18	\N	\N
1026291	0	1337	0	-2	19	\N	\N
1026292	0	1337	0	-2	20	\N	\N
1026293	0	1337	0	-2	21	\N	\N
1026294	0	1337	0	-2	22	\N	\N
1026295	0	1337	0	-2	23	\N	\N
1026296	0	1337	0	-2	24	\N	\N
1026297	0	1337	0	-2	25	\N	\N
1026298	0	1337	0	-2	26	\N	\N
1026299	0	1337	0	-2	27	\N	\N
1026300	0	1337	0	-2	28	\N	\N
1026301	0	1337	0	-2	29	\N	\N
1026302	0	1337	0	-2	30	\N	\N
1026303	0	1337	0	-2	31	\N	\N
1026304	0	1337	0	-2	32	\N	\N
1026305	0	1337	0	-2	33	\N	\N
1026306	0	1337	0	-2	34	\N	\N
1026307	0	1337	0	-2	35	\N	\N
1026308	0	1337	0	-2	36	\N	\N
1026309	0	1337	0	-2	37	\N	\N
1026310	0	1337	0	-2	38	\N	\N
1026311	0	1337	0	-2	39	\N	\N
1026312	0	1337	0	-2	40	\N	\N
1026313	0	1337	0	-2	41	\N	\N
1026314	0	1337	0	-2	42	\N	\N
1026315	0	1337	0	-2	43	\N	\N
1026316	0	1337	0	-2	44	\N	\N
1026317	0	1337	0	-2	45	\N	\N
1026318	0	1337	0	-2	46	\N	\N
1026319	0	1337	0	-2	47	\N	\N
1026320	0	1337	0	-2	48	\N	\N
1026321	0	1337	0	-2	49	\N	\N
1026322	0	1337	0	-2	50	\N	\N
1026323	0	1337	0	-2	51	\N	\N
1026324	0	1337	0	-2	52	\N	\N
1026325	0	1337	0	-2	53	\N	\N
1026326	0	1337	0	-2	54	\N	\N
1026327	0	1337	0	-2	55	\N	\N
1026328	0	1337	0	-2	56	\N	\N
1026329	0	1337	0	-2	57	\N	\N
1026330	0	1337	0	-2	58	\N	\N
1026331	0	1337	0	-2	59	\N	\N
1026332	0	1337	0	-1	-20	\N	\N
1026333	0	1337	0	-1	-19	\N	\N
1026334	0	1337	0	-1	-18	\N	\N
1026335	0	1337	0	-1	-17	\N	\N
1026336	0	1337	0	-1	-16	\N	\N
1026337	0	1337	0	-1	-15	\N	\N
1026338	0	1337	0	-1	-14	\N	\N
1026339	0	1337	0	-1	-13	\N	\N
1026340	0	1337	0	-1	-12	\N	\N
1026341	0	1337	0	-1	-11	\N	\N
1026342	0	1337	0	-1	-10	\N	\N
1026343	0	1337	0	-1	-9	\N	\N
1026344	0	1337	0	-1	-8	\N	\N
1026345	0	1337	0	-1	-7	\N	\N
1026346	0	1337	0	-1	-6	\N	\N
1026347	0	1337	0	-1	-5	\N	\N
1026348	0	1337	0	-1	-4	\N	\N
1026349	0	1337	0	-1	-3	\N	\N
1026350	0	1337	0	-1	-2	\N	\N
1026351	0	1337	0	-1	-1	\N	\N
1026352	0	1337	0	-1	0	\N	\N
1026353	0	1337	0	-1	1	\N	\N
1026354	0	1337	0	-1	2	\N	\N
1026355	0	1337	0	-1	3	\N	\N
1026356	0	1337	0	-1	4	\N	\N
1026357	0	1337	0	-1	5	\N	\N
1026358	0	1337	0	-1	6	\N	\N
1026359	0	1337	0	-1	7	\N	\N
1026360	0	1337	0	-1	8	\N	\N
1026361	0	1337	0	-1	9	\N	\N
1026362	0	1337	0	-1	10	\N	\N
1026363	0	1337	0	-1	11	\N	\N
1026364	0	1337	0	-1	12	\N	\N
1026365	0	1337	0	-1	13	\N	\N
1026366	0	1337	0	-1	14	\N	\N
1026367	0	1337	0	-1	15	\N	\N
1026368	0	1337	0	-1	16	\N	\N
1026369	0	1337	0	-1	17	\N	\N
1026370	0	1337	0	-1	18	\N	\N
1026371	0	1337	0	-1	19	\N	\N
1026372	0	1337	0	-1	20	\N	\N
1026373	0	1337	0	-1	21	\N	\N
1026374	0	1337	0	-1	22	\N	\N
1026375	0	1337	0	-1	23	\N	\N
1026376	0	1337	0	-1	24	\N	\N
1026377	0	1337	0	-1	25	\N	\N
1026378	0	1337	0	-1	26	\N	\N
1026379	0	1337	0	-1	27	\N	\N
1026380	0	1337	0	-1	28	\N	\N
1026381	0	1337	0	-1	29	\N	\N
1026382	0	1337	0	-1	30	\N	\N
1026383	0	1337	0	-1	31	\N	\N
1026384	0	1337	0	-1	32	\N	\N
1026385	0	1337	0	-1	33	\N	\N
1026386	0	1337	0	-1	34	\N	\N
1026387	0	1337	0	-1	35	\N	\N
1026388	0	1337	0	-1	36	\N	\N
1026389	0	1337	0	-1	37	\N	\N
1026390	0	1337	0	-1	38	\N	\N
1026391	0	1337	0	-1	39	\N	\N
1026392	0	1337	0	-1	40	\N	\N
1026393	0	1337	0	-1	41	\N	\N
1026394	0	1337	0	-1	42	\N	\N
1026395	0	1337	0	-1	43	\N	\N
1026396	0	1337	0	-1	44	\N	\N
1026397	0	1337	0	-1	45	\N	\N
1026398	0	1337	0	-1	46	\N	\N
1026399	0	1337	0	-1	47	\N	\N
1026400	0	1337	0	-1	48	\N	\N
1026401	0	1337	0	-1	49	\N	\N
1026402	0	1337	0	-1	50	\N	\N
1026403	0	1337	0	-1	51	\N	\N
1026404	0	1337	0	-1	52	\N	\N
1026405	0	1337	0	-1	53	\N	\N
1026406	0	1337	0	-1	54	\N	\N
1026407	0	1337	0	-1	55	\N	\N
1026408	0	1337	0	-1	56	\N	\N
1026409	0	1337	0	-1	57	\N	\N
1026410	0	1337	0	-1	58	\N	\N
1026411	0	1337	0	-1	59	\N	\N
1026412	0	1337	0	0	-20	\N	\N
1026413	0	1337	0	0	-19	\N	\N
1026414	0	1337	0	0	-18	\N	\N
1026415	0	1337	0	0	-17	\N	\N
1026416	0	1337	0	0	-16	\N	\N
1026417	0	1337	0	0	-15	\N	\N
1026418	0	1337	0	0	-14	\N	\N
1026419	0	1337	0	0	-13	\N	\N
1026420	0	1337	0	0	-12	\N	\N
1026421	0	1337	0	0	-11	\N	\N
1026422	0	1337	0	0	-10	\N	\N
1026423	0	1337	0	0	-9	\N	\N
1026424	0	1337	0	0	-8	\N	\N
1026425	0	1337	0	0	-7	\N	\N
1026426	0	1337	0	0	-6	\N	\N
1026427	0	1337	0	0	-5	\N	\N
1026428	0	1337	0	0	-4	\N	\N
1026429	0	1337	0	0	-3	\N	\N
1026430	0	1337	0	0	-2	\N	\N
1026431	0	1337	0	0	-1	\N	\N
1026432	0	1337	0	0	0	\N	\N
1026433	0	1337	0	0	1	\N	\N
1026434	0	1337	0	0	2	\N	\N
1026435	0	1337	0	0	3	\N	\N
1026436	0	1337	0	0	4	\N	\N
1026437	0	1337	0	0	5	\N	\N
1026438	0	1337	0	0	6	\N	\N
1026439	0	1337	0	0	7	\N	\N
1026440	0	1337	0	0	8	\N	\N
1026441	0	1337	0	0	9	\N	\N
1026442	0	1337	0	0	10	\N	\N
1026443	0	1337	0	0	11	\N	\N
1026444	0	1337	0	0	12	\N	\N
1026445	0	1337	0	0	13	\N	\N
1026446	0	1337	0	0	14	\N	\N
1026447	0	1337	0	0	15	\N	\N
1026448	0	1337	0	0	16	\N	\N
1026449	0	1337	0	0	17	\N	\N
1026450	0	1337	0	0	18	\N	\N
1026451	0	1337	0	0	19	\N	\N
1026452	0	1337	0	0	20	\N	\N
1026453	0	1337	0	0	21	\N	\N
1026454	0	1337	0	0	22	\N	\N
1026455	0	1337	0	0	23	\N	\N
1026456	0	1337	0	0	24	\N	\N
1026457	0	1337	0	0	25	\N	\N
1026458	0	1337	0	0	26	\N	\N
1026459	0	1337	0	0	27	\N	\N
1026460	0	1337	0	0	28	\N	\N
1026461	0	1337	0	0	29	\N	\N
1026462	0	1337	0	0	30	\N	\N
1026463	0	1337	0	0	31	\N	\N
1026464	0	1337	0	0	32	\N	\N
1026465	0	1337	0	0	33	\N	\N
1026466	0	1337	0	0	34	\N	\N
1026467	0	1337	0	0	35	\N	\N
1026468	0	1337	0	0	36	\N	\N
1026469	0	1337	0	0	37	\N	\N
1026470	0	1337	0	0	38	\N	\N
1026471	0	1337	0	0	39	\N	\N
1026472	0	1337	0	0	40	\N	\N
1026473	0	1337	0	0	41	\N	\N
1026474	0	1337	0	0	42	\N	\N
1026475	0	1337	0	0	43	\N	\N
1026476	0	1337	0	0	44	\N	\N
1026477	0	1337	0	0	45	\N	\N
1026478	0	1337	0	0	46	\N	\N
1026479	0	1337	0	0	47	\N	\N
1026480	0	1337	0	0	48	\N	\N
1026481	0	1337	0	0	49	\N	\N
1026482	0	1337	0	0	50	\N	\N
1026483	0	1337	0	0	51	\N	\N
1026484	0	1337	0	0	52	\N	\N
1026485	0	1337	0	0	53	\N	\N
1026486	0	1337	0	0	54	\N	\N
1026487	0	1337	0	0	55	\N	\N
1026488	0	1337	0	0	56	\N	\N
1026489	0	1337	0	0	57	\N	\N
1026490	0	1337	0	0	58	\N	\N
1026491	0	1337	0	0	59	\N	\N
1026492	0	1337	0	1	-20	\N	\N
1026493	0	1337	0	1	-19	\N	\N
1026494	0	1337	0	1	-18	\N	\N
1026495	0	1337	0	1	-17	\N	\N
1026496	0	1337	0	1	-16	\N	\N
1026497	0	1337	0	1	-15	\N	\N
1026498	0	1337	0	1	-14	\N	\N
1026499	0	1337	0	1	-13	\N	\N
1026500	0	1337	0	1	-12	\N	\N
1026501	0	1337	0	1	-11	\N	\N
1026502	0	1337	0	1	-10	\N	\N
1026503	0	1337	0	1	-9	\N	\N
1026504	0	1337	0	1	-8	\N	\N
1026505	0	1337	0	1	-7	\N	\N
1026506	0	1337	0	1	-6	\N	\N
1026507	0	1337	0	1	-5	\N	\N
1026508	0	1337	0	1	-4	\N	\N
1026509	0	1337	0	1	-3	\N	\N
1026510	0	1337	0	1	-2	\N	\N
1026511	0	1337	0	1	-1	\N	\N
1026512	0	1337	0	1	0	\N	\N
1026513	0	1337	0	1	1	\N	\N
1026514	0	1337	0	1	2	\N	\N
1026515	0	1337	0	1	3	\N	\N
1026516	0	1337	0	1	4	\N	\N
1026517	0	1337	0	1	5	\N	\N
1026518	0	1337	0	1	6	\N	\N
1026519	0	1337	0	1	7	\N	\N
1026520	0	1337	0	1	8	\N	\N
1026521	0	1337	0	1	9	\N	\N
1026522	0	1337	0	1	10	\N	\N
1026523	0	1337	0	1	11	\N	\N
1026524	0	1337	0	1	12	\N	\N
1026525	0	1337	0	1	13	\N	\N
1026526	0	1337	0	1	14	\N	\N
1026527	0	1337	0	1	15	\N	\N
1026528	0	1337	0	1	16	\N	\N
1026529	0	1337	0	1	17	\N	\N
1026530	0	1337	0	1	18	\N	\N
1026531	0	1337	0	1	19	\N	\N
1026532	0	1337	0	1	20	\N	\N
1026533	0	1337	0	1	21	\N	\N
1026534	0	1337	0	1	22	\N	\N
1026535	0	1337	0	1	23	\N	\N
1026536	0	1337	0	1	24	\N	\N
1026537	0	1337	0	1	25	\N	\N
1026538	0	1337	0	1	26	\N	\N
1026539	0	1337	0	1	27	\N	\N
1026540	0	1337	0	1	28	\N	\N
1026541	0	1337	0	1	29	\N	\N
1026542	0	1337	0	1	30	\N	\N
1026543	0	1337	0	1	31	\N	\N
1026544	0	1337	0	1	32	\N	\N
1026545	0	1337	0	1	33	\N	\N
1026546	0	1337	0	1	34	\N	\N
1026547	0	1337	0	1	35	\N	\N
1026548	0	1337	0	1	36	\N	\N
1026549	0	1337	0	1	37	\N	\N
1026550	0	1337	0	1	38	\N	\N
1026551	0	1337	0	1	39	\N	\N
1026552	0	1337	0	1	40	\N	\N
1026553	0	1337	0	1	41	\N	\N
1026554	0	1337	0	1	42	\N	\N
1026555	0	1337	0	1	43	\N	\N
1026556	0	1337	0	1	44	\N	\N
1026557	0	1337	0	1	45	\N	\N
1026558	0	1337	0	1	46	\N	\N
1026559	0	1337	0	1	47	\N	\N
1026560	0	1337	0	1	48	\N	\N
1026561	0	1337	0	1	49	\N	\N
1026562	0	1337	0	1	50	\N	\N
1026563	0	1337	0	1	51	\N	\N
1026564	0	1337	0	1	52	\N	\N
1026565	0	1337	0	1	53	\N	\N
1026566	0	1337	0	1	54	\N	\N
1026567	0	1337	0	1	55	\N	\N
1026568	0	1337	0	1	56	\N	\N
1026569	0	1337	0	1	57	\N	\N
1026570	0	1337	0	1	58	\N	\N
1026571	0	1337	0	1	59	\N	\N
1026572	0	1337	0	2	-20	\N	\N
1026573	0	1337	0	2	-19	\N	\N
1026574	0	1337	0	2	-18	\N	\N
1026575	0	1337	0	2	-17	\N	\N
1026576	0	1337	0	2	-16	\N	\N
1026577	0	1337	0	2	-15	\N	\N
1026578	0	1337	0	2	-14	\N	\N
1026579	0	1337	0	2	-13	\N	\N
1026580	0	1337	0	2	-12	\N	\N
1026581	0	1337	0	2	-11	\N	\N
1026582	0	1337	0	2	-10	\N	\N
1026583	0	1337	0	2	-9	\N	\N
1026584	0	1337	0	2	-8	\N	\N
1026585	0	1337	0	2	-7	\N	\N
1026586	0	1337	0	2	-6	\N	\N
1026587	0	1337	0	2	-5	\N	\N
1026588	0	1337	0	2	-4	\N	\N
1026589	0	1337	0	2	-3	\N	\N
1026590	0	1337	0	2	-2	\N	\N
1026591	0	1337	0	2	-1	\N	\N
1026592	0	1337	0	2	0	\N	\N
1026593	0	1337	0	2	1	\N	\N
1026594	0	1337	0	2	2	\N	\N
1026595	0	1337	0	2	3	\N	\N
1026596	0	1337	0	2	4	\N	\N
1026597	0	1337	0	2	5	\N	\N
1026598	0	1337	0	2	6	\N	\N
1026599	0	1337	0	2	7	\N	\N
1026600	0	1337	0	2	8	\N	\N
1026601	0	1337	0	2	9	\N	\N
1026602	0	1337	0	2	10	\N	\N
1026603	0	1337	0	2	11	\N	\N
1026604	0	1337	0	2	12	\N	\N
1026605	0	1337	0	2	13	\N	\N
1026606	0	1337	0	2	14	\N	\N
1026607	0	1337	0	2	15	\N	\N
1026608	0	1337	0	2	16	\N	\N
1026609	0	1337	0	2	17	\N	\N
1026610	0	1337	0	2	18	\N	\N
1026611	0	1337	0	2	19	\N	\N
1026612	0	1337	0	2	20	\N	\N
1026613	0	1337	0	2	21	\N	\N
1026614	0	1337	0	2	22	\N	\N
1026615	0	1337	0	2	23	\N	\N
1026616	0	1337	0	2	24	\N	\N
1026617	0	1337	0	2	25	\N	\N
1026618	0	1337	0	2	26	\N	\N
1026619	0	1337	0	2	27	\N	\N
1026620	0	1337	0	2	28	\N	\N
1026621	0	1337	0	2	29	\N	\N
1026622	0	1337	0	2	30	\N	\N
1026623	0	1337	0	2	31	\N	\N
1026624	0	1337	0	2	32	\N	\N
1026625	0	1337	0	2	33	\N	\N
1026626	0	1337	0	2	34	\N	\N
1026627	0	1337	0	2	35	\N	\N
1026628	0	1337	0	2	36	\N	\N
1026629	0	1337	0	2	37	\N	\N
1026630	0	1337	0	2	38	\N	\N
1026631	0	1337	0	2	39	\N	\N
1026632	0	1337	0	2	40	\N	\N
1026633	0	1337	0	2	41	\N	\N
1026634	0	1337	0	2	42	\N	\N
1026635	0	1337	0	2	43	\N	\N
1026636	0	1337	0	2	44	\N	\N
1026637	0	1337	0	2	45	\N	\N
1026638	0	1337	0	2	46	\N	\N
1026639	0	1337	0	2	47	\N	\N
1026640	0	1337	0	2	48	\N	\N
1026641	0	1337	0	2	49	\N	\N
1026642	0	1337	0	2	50	\N	\N
1026643	0	1337	0	2	51	\N	\N
1026644	0	1337	0	2	52	\N	\N
1026645	0	1337	0	2	53	\N	\N
1026646	0	1337	0	2	54	\N	\N
1026647	0	1337	0	2	55	\N	\N
1026648	0	1337	0	2	56	\N	\N
1026649	0	1337	0	2	57	\N	\N
1026650	0	1337	0	2	58	\N	\N
1026651	0	1337	0	2	59	\N	\N
1026652	0	1337	0	3	-20	\N	\N
1026653	0	1337	0	3	-19	\N	\N
1026654	0	1337	0	3	-18	\N	\N
1026655	0	1337	0	3	-17	\N	\N
1026656	0	1337	0	3	-16	\N	\N
1026657	0	1337	0	3	-15	\N	\N
1026658	0	1337	0	3	-14	\N	\N
1026659	0	1337	0	3	-13	\N	\N
1026660	0	1337	0	3	-12	\N	\N
1026661	0	1337	0	3	-11	\N	\N
1026662	0	1337	0	3	-10	\N	\N
1026663	0	1337	0	3	-9	\N	\N
1026664	0	1337	0	3	-8	\N	\N
1026665	0	1337	0	3	-7	\N	\N
1026666	0	1337	0	3	-6	\N	\N
1026667	0	1337	0	3	-5	\N	\N
1026668	0	1337	0	3	-4	\N	\N
1026669	0	1337	0	3	-3	\N	\N
1026670	0	1337	0	3	-2	\N	\N
1026671	0	1337	0	3	-1	\N	\N
1026672	0	1337	0	3	0	\N	\N
1026673	0	1337	0	3	1	\N	\N
1026674	0	1337	0	3	2	\N	\N
1026675	0	1337	0	3	3	\N	\N
1026676	0	1337	0	3	4	\N	\N
1026677	0	1337	0	3	5	\N	\N
1026678	0	1337	0	3	6	\N	\N
1026679	0	1337	0	3	7	\N	\N
1026680	0	1337	0	3	8	\N	\N
1026681	0	1337	0	3	9	\N	\N
1026682	0	1337	0	3	10	\N	\N
1026683	0	1337	0	3	11	\N	\N
1026684	0	1337	0	3	12	\N	\N
1026685	0	1337	0	3	13	\N	\N
1026686	0	1337	0	3	14	\N	\N
1026687	0	1337	0	3	15	\N	\N
1026688	0	1337	0	3	16	\N	\N
1026689	0	1337	0	3	17	\N	\N
1026690	0	1337	0	3	18	\N	\N
1026691	0	1337	0	3	19	\N	\N
1026692	0	1337	0	3	20	\N	\N
1026693	0	1337	0	3	21	\N	\N
1026694	0	1337	0	3	22	\N	\N
1026695	0	1337	0	3	23	\N	\N
1026696	0	1337	0	3	24	\N	\N
1026697	0	1337	0	3	25	\N	\N
1026698	0	1337	0	3	26	\N	\N
1026699	0	1337	0	3	27	\N	\N
1026700	0	1337	0	3	28	\N	\N
1026701	0	1337	0	3	29	\N	\N
1026702	0	1337	0	3	30	\N	\N
1026703	0	1337	0	3	31	\N	\N
1026704	0	1337	0	3	32	\N	\N
1026705	0	1337	0	3	33	\N	\N
1026706	0	1337	0	3	34	\N	\N
1026707	0	1337	0	3	35	\N	\N
1026708	0	1337	0	3	36	\N	\N
1026709	0	1337	0	3	37	\N	\N
1026710	0	1337	0	3	38	\N	\N
1026711	0	1337	0	3	39	\N	\N
1026712	0	1337	0	3	40	\N	\N
1026713	0	1337	0	3	41	\N	\N
1026714	0	1337	0	3	42	\N	\N
1026715	0	1337	0	3	43	\N	\N
1026716	0	1337	0	3	44	\N	\N
1026717	0	1337	0	3	45	\N	\N
1026718	0	1337	0	3	46	\N	\N
1026719	0	1337	0	3	47	\N	\N
1026720	0	1337	0	3	48	\N	\N
1026721	0	1337	0	3	49	\N	\N
1026722	0	1337	0	3	50	\N	\N
1026723	0	1337	0	3	51	\N	\N
1026724	0	1337	0	3	52	\N	\N
1026725	0	1337	0	3	53	\N	\N
1026726	0	1337	0	3	54	\N	\N
1026727	0	1337	0	3	55	\N	\N
1026728	0	1337	0	3	56	\N	\N
1026729	0	1337	0	3	57	\N	\N
1026730	0	1337	0	3	58	\N	\N
1026731	0	1337	0	3	59	\N	\N
1026732	0	1337	0	4	-20	\N	\N
1026733	0	1337	0	4	-19	\N	\N
1026734	0	1337	0	4	-18	\N	\N
1026735	0	1337	0	4	-17	\N	\N
1026736	0	1337	0	4	-16	\N	\N
1026737	0	1337	0	4	-15	\N	\N
1026738	0	1337	0	4	-14	\N	\N
1026739	0	1337	0	4	-13	\N	\N
1026740	0	1337	0	4	-12	\N	\N
1026741	0	1337	0	4	-11	\N	\N
1026742	0	1337	0	4	-10	\N	\N
1026743	0	1337	0	4	-9	\N	\N
1026744	0	1337	0	4	-8	\N	\N
1026745	0	1337	0	4	-7	\N	\N
1026746	0	1337	0	4	-6	\N	\N
1026747	0	1337	0	4	-5	\N	\N
1026748	0	1337	0	4	-4	\N	\N
1026749	0	1337	0	4	-3	\N	\N
1026750	0	1337	0	4	-2	\N	\N
1026751	0	1337	0	4	-1	\N	\N
1026752	0	1337	0	4	0	\N	\N
1026753	0	1337	0	4	1	\N	\N
1026754	0	1337	0	4	2	\N	\N
1026755	0	1337	0	4	3	\N	\N
1026756	0	1337	0	4	4	\N	\N
1026757	0	1337	0	4	5	\N	\N
1026758	0	1337	0	4	6	\N	\N
1026759	0	1337	0	4	7	\N	\N
1026760	0	1337	0	4	8	\N	\N
1026761	0	1337	0	4	9	\N	\N
1026762	0	1337	0	4	10	\N	\N
1026763	0	1337	0	4	11	\N	\N
1026764	0	1337	0	4	12	\N	\N
1026765	0	1337	0	4	13	\N	\N
1026766	0	1337	0	4	14	\N	\N
1026767	0	1337	0	4	15	\N	\N
1026768	0	1337	0	4	16	\N	\N
1026769	0	1337	0	4	17	\N	\N
1026770	0	1337	0	4	18	\N	\N
1026771	0	1337	0	4	19	\N	\N
1026772	0	1337	0	4	20	\N	\N
1026773	0	1337	0	4	21	\N	\N
1026774	0	1337	0	4	22	\N	\N
1026775	0	1337	0	4	23	\N	\N
1026776	0	1337	0	4	24	\N	\N
1026777	0	1337	0	4	25	\N	\N
1026778	0	1337	0	4	26	\N	\N
1026779	0	1337	0	4	27	\N	\N
1026780	0	1337	0	4	28	\N	\N
1026781	0	1337	0	4	29	\N	\N
1026782	0	1337	0	4	30	\N	\N
1026783	0	1337	0	4	31	\N	\N
1026784	0	1337	0	4	32	\N	\N
1026785	0	1337	0	4	33	\N	\N
1026786	0	1337	0	4	34	\N	\N
1026787	0	1337	0	4	35	\N	\N
1026788	0	1337	0	4	36	\N	\N
1026789	0	1337	0	4	37	\N	\N
1026790	0	1337	0	4	38	\N	\N
1026791	0	1337	0	4	39	\N	\N
1026792	0	1337	0	4	40	\N	\N
1026793	0	1337	0	4	41	\N	\N
1026794	0	1337	0	4	42	\N	\N
1026795	0	1337	0	4	43	\N	\N
1026796	0	1337	0	4	44	\N	\N
1026797	0	1337	0	4	45	\N	\N
1026798	0	1337	0	4	46	\N	\N
1026799	0	1337	0	4	47	\N	\N
1026800	0	1337	0	4	48	\N	\N
1026801	0	1337	0	4	49	\N	\N
1026802	0	1337	0	4	50	\N	\N
1026803	0	1337	0	4	51	\N	\N
1026804	0	1337	0	4	52	\N	\N
1026805	0	1337	0	4	53	\N	\N
1026806	0	1337	0	4	54	\N	\N
1026807	0	1337	0	4	55	\N	\N
1026808	0	1337	0	4	56	\N	\N
1026809	0	1337	0	4	57	\N	\N
1026810	0	1337	0	4	58	\N	\N
1026811	0	1337	0	4	59	\N	\N
1026812	0	1337	0	5	-20	\N	\N
1026813	0	1337	0	5	-19	\N	\N
1026814	0	1337	0	5	-18	\N	\N
1026815	0	1337	0	5	-17	\N	\N
1026816	0	1337	0	5	-16	\N	\N
1026817	0	1337	0	5	-15	\N	\N
1026818	0	1337	0	5	-14	\N	\N
1026819	0	1337	0	5	-13	\N	\N
1026820	0	1337	0	5	-12	\N	\N
1026821	0	1337	0	5	-11	\N	\N
1026822	0	1337	0	5	-10	\N	\N
1026823	0	1337	0	5	-9	\N	\N
1026824	0	1337	0	5	-8	\N	\N
1026825	0	1337	0	5	-7	\N	\N
1026826	0	1337	0	5	-6	\N	\N
1026827	0	1337	0	5	-5	\N	\N
1026828	0	1337	0	5	-4	\N	\N
1026829	0	1337	0	5	-3	\N	\N
1026830	0	1337	0	5	-2	\N	\N
1026831	0	1337	0	5	-1	\N	\N
1026832	0	1337	0	5	0	\N	\N
1026833	0	1337	0	5	1	\N	\N
1026834	0	1337	0	5	2	\N	\N
1026835	0	1337	0	5	3	\N	\N
1026836	0	1337	0	5	4	\N	\N
1026837	0	1337	0	5	5	\N	\N
1026838	0	1337	0	5	6	\N	\N
1026839	0	1337	0	5	7	\N	\N
1026840	0	1337	0	5	8	\N	\N
1026841	0	1337	0	5	9	\N	\N
1026842	0	1337	0	5	10	\N	\N
1026843	0	1337	0	5	11	\N	\N
1026844	0	1337	0	5	12	\N	\N
1026845	0	1337	0	5	13	\N	\N
1026846	0	1337	0	5	14	\N	\N
1026847	0	1337	0	5	15	\N	\N
1026848	0	1337	0	5	16	\N	\N
1026849	0	1337	0	5	17	\N	\N
1026850	0	1337	0	5	18	\N	\N
1026851	0	1337	0	5	19	\N	\N
1026852	0	1337	0	5	20	\N	\N
1026853	0	1337	0	5	21	\N	\N
1026854	0	1337	0	5	22	\N	\N
1026855	0	1337	0	5	23	\N	\N
1026856	0	1337	0	5	24	\N	\N
1026857	0	1337	0	5	25	\N	\N
1026858	0	1337	0	5	26	\N	\N
1026859	0	1337	0	5	27	\N	\N
1026860	0	1337	0	5	28	\N	\N
1026861	0	1337	0	5	29	\N	\N
1026862	0	1337	0	5	30	\N	\N
1026863	0	1337	0	5	31	\N	\N
1026864	0	1337	0	5	32	\N	\N
1026865	0	1337	0	5	33	\N	\N
1026866	0	1337	0	5	34	\N	\N
1026867	0	1337	0	5	35	\N	\N
1026868	0	1337	0	5	36	\N	\N
1026869	0	1337	0	5	37	\N	\N
1026870	0	1337	0	5	38	\N	\N
1026871	0	1337	0	5	39	\N	\N
1026872	0	1337	0	5	40	\N	\N
1026873	0	1337	0	5	41	\N	\N
1026874	0	1337	0	5	42	\N	\N
1026875	0	1337	0	5	43	\N	\N
1026876	0	1337	0	5	44	\N	\N
1026877	0	1337	0	5	45	\N	\N
1026878	0	1337	0	5	46	\N	\N
1026879	0	1337	0	5	47	\N	\N
1026880	0	1337	0	5	48	\N	\N
1026881	0	1337	0	5	49	\N	\N
1026882	0	1337	0	5	50	\N	\N
1026883	0	1337	0	5	51	\N	\N
1026884	0	1337	0	5	52	\N	\N
1026885	0	1337	0	5	53	\N	\N
1026886	0	1337	0	5	54	\N	\N
1026887	0	1337	0	5	55	\N	\N
1026888	0	1337	0	5	56	\N	\N
1026889	0	1337	0	5	57	\N	\N
1026890	0	1337	0	5	58	\N	\N
1026891	0	1337	0	5	59	\N	\N
1026892	0	1337	0	6	-20	\N	\N
1026893	0	1337	0	6	-19	\N	\N
1026894	0	1337	0	6	-18	\N	\N
1026895	0	1337	0	6	-17	\N	\N
1026896	0	1337	0	6	-16	\N	\N
1026897	0	1337	0	6	-15	\N	\N
1026898	0	1337	0	6	-14	\N	\N
1026899	0	1337	0	6	-13	\N	\N
1026900	0	1337	0	6	-12	\N	\N
1026901	0	1337	0	6	-11	\N	\N
1026902	0	1337	0	6	-10	\N	\N
1026903	0	1337	0	6	-9	\N	\N
1026904	0	1337	0	6	-8	\N	\N
1026905	0	1337	0	6	-7	\N	\N
1026906	0	1337	0	6	-6	\N	\N
1026907	0	1337	0	6	-5	\N	\N
1026908	0	1337	0	6	-4	\N	\N
1026909	0	1337	0	6	-3	\N	\N
1026910	0	1337	0	6	-2	\N	\N
1026911	0	1337	0	6	-1	\N	\N
1026912	0	1337	0	6	0	\N	\N
1026913	0	1337	0	6	1	\N	\N
1026914	0	1337	0	6	2	\N	\N
1026915	0	1337	0	6	3	\N	\N
1026916	0	1337	0	6	4	\N	\N
1026917	0	1337	0	6	5	\N	\N
1026918	0	1337	0	6	6	\N	\N
1026919	0	1337	0	6	7	\N	\N
1026920	0	1337	0	6	8	\N	\N
1026921	0	1337	0	6	9	\N	\N
1026922	0	1337	0	6	10	\N	\N
1026923	0	1337	0	6	11	\N	\N
1026924	0	1337	0	6	12	\N	\N
1026925	0	1337	0	6	13	\N	\N
1026926	0	1337	0	6	14	\N	\N
1026927	0	1337	0	6	15	\N	\N
1026928	0	1337	0	6	16	\N	\N
1026929	0	1337	0	6	17	\N	\N
1026930	0	1337	0	6	18	\N	\N
1026931	0	1337	0	6	19	\N	\N
1026932	0	1337	0	6	20	\N	\N
1026933	0	1337	0	6	21	\N	\N
1026934	0	1337	0	6	22	\N	\N
1026935	0	1337	0	6	23	\N	\N
1026936	0	1337	0	6	24	\N	\N
1026937	0	1337	0	6	25	\N	\N
1026938	0	1337	0	6	26	\N	\N
1026939	0	1337	0	6	27	\N	\N
1026940	0	1337	0	6	28	\N	\N
1026941	0	1337	0	6	29	\N	\N
1026942	0	1337	0	6	30	\N	\N
1026943	0	1337	0	6	31	\N	\N
1026944	0	1337	0	6	32	\N	\N
1026945	0	1337	0	6	33	\N	\N
1026946	0	1337	0	6	34	\N	\N
1026947	0	1337	0	6	35	\N	\N
1026948	0	1337	0	6	36	\N	\N
1026949	0	1337	0	6	37	\N	\N
1026950	0	1337	0	6	38	\N	\N
1026951	0	1337	0	6	39	\N	\N
1026952	0	1337	0	6	40	\N	\N
1026953	0	1337	0	6	41	\N	\N
1026954	0	1337	0	6	42	\N	\N
1026955	0	1337	0	6	43	\N	\N
1026956	0	1337	0	6	44	\N	\N
1026957	0	1337	0	6	45	\N	\N
1026958	0	1337	0	6	46	\N	\N
1026959	0	1337	0	6	47	\N	\N
1026960	0	1337	0	6	48	\N	\N
1026961	0	1337	0	6	49	\N	\N
1026962	0	1337	0	6	50	\N	\N
1026963	0	1337	0	6	51	\N	\N
1026964	0	1337	0	6	52	\N	\N
1026965	0	1337	0	6	53	\N	\N
1026966	0	1337	0	6	54	\N	\N
1026967	0	1337	0	6	55	\N	\N
1026968	0	1337	0	6	56	\N	\N
1026969	0	1337	0	6	57	\N	\N
1026970	0	1337	0	6	58	\N	\N
1026971	0	1337	0	6	59	\N	\N
1026972	0	1337	0	7	-20	\N	\N
1026973	0	1337	0	7	-19	\N	\N
1026974	0	1337	0	7	-18	\N	\N
1026975	0	1337	0	7	-17	\N	\N
1026976	0	1337	0	7	-16	\N	\N
1026977	0	1337	0	7	-15	\N	\N
1026978	0	1337	0	7	-14	\N	\N
1026979	0	1337	0	7	-13	\N	\N
1026980	0	1337	0	7	-12	\N	\N
1026981	0	1337	0	7	-11	\N	\N
1026982	0	1337	0	7	-10	\N	\N
1026983	0	1337	0	7	-9	\N	\N
1026984	0	1337	0	7	-8	\N	\N
1026985	0	1337	0	7	-7	\N	\N
1026986	0	1337	0	7	-6	\N	\N
1026987	0	1337	0	7	-5	\N	\N
1026988	0	1337	0	7	-4	\N	\N
1026989	0	1337	0	7	-3	\N	\N
1026990	0	1337	0	7	-2	\N	\N
1026991	0	1337	0	7	-1	\N	\N
1026992	0	1337	0	7	0	\N	\N
1026993	0	1337	0	7	1	\N	\N
1026994	0	1337	0	7	2	\N	\N
1026995	0	1337	0	7	3	\N	\N
1026996	0	1337	0	7	4	\N	\N
1026997	0	1337	0	7	5	\N	\N
1026998	0	1337	0	7	6	\N	\N
1026999	0	1337	0	7	7	\N	\N
1027000	0	1337	0	7	8	\N	\N
1027001	0	1337	0	7	9	\N	\N
1027002	0	1337	0	7	10	\N	\N
1027003	0	1337	0	7	11	\N	\N
1027004	0	1337	0	7	12	\N	\N
1027005	0	1337	0	7	13	\N	\N
1027006	0	1337	0	7	14	\N	\N
1027007	0	1337	0	7	15	\N	\N
1027008	0	1337	0	7	16	\N	\N
1027009	0	1337	0	7	17	\N	\N
1027010	0	1337	0	7	18	\N	\N
1027011	0	1337	0	7	19	\N	\N
1027012	0	1337	0	7	20	\N	\N
1027013	0	1337	0	7	21	\N	\N
1027014	0	1337	0	7	22	\N	\N
1027015	0	1337	0	7	23	\N	\N
1027016	0	1337	0	7	24	\N	\N
1027017	37	1337	0	7	25	\N	\N
1027018	0	1337	0	7	26	\N	\N
1027019	0	1337	0	7	27	\N	\N
1027020	0	1337	0	7	28	\N	\N
1027021	0	1337	0	7	29	\N	\N
1027022	0	1337	0	7	30	\N	\N
1027023	0	1337	0	7	31	\N	\N
1027024	0	1337	0	7	32	\N	\N
1027025	0	1337	0	7	33	\N	\N
1027026	0	1337	0	7	34	\N	\N
1027027	0	1337	0	7	35	\N	\N
1027028	0	1337	0	7	36	\N	\N
1027029	0	1337	0	7	37	\N	\N
1027030	0	1337	0	7	38	\N	\N
1027031	0	1337	0	7	39	\N	\N
1027032	0	1337	0	7	40	\N	\N
1027033	0	1337	0	7	41	\N	\N
1027034	0	1337	0	7	42	\N	\N
1027035	0	1337	0	7	43	\N	\N
1027036	0	1337	0	7	44	\N	\N
1027037	0	1337	0	7	45	\N	\N
1027038	0	1337	0	7	46	\N	\N
1027039	0	1337	0	7	47	\N	\N
1027040	0	1337	0	7	48	\N	\N
1027041	0	1337	0	7	49	\N	\N
1027042	0	1337	0	7	50	\N	\N
1027043	0	1337	0	7	51	\N	\N
1027044	0	1337	0	7	52	\N	\N
1027045	0	1337	0	7	53	\N	\N
1027046	0	1337	0	7	54	\N	\N
1027047	0	1337	0	7	55	\N	\N
1027048	0	1337	0	7	56	\N	\N
1027049	0	1337	0	7	57	\N	\N
1027050	0	1337	0	7	58	\N	\N
1027051	0	1337	0	7	59	\N	\N
1027052	0	1337	0	8	-20	\N	\N
1027053	0	1337	0	8	-19	\N	\N
1027054	0	1337	0	8	-18	\N	\N
1027055	0	1337	0	8	-17	\N	\N
1027056	0	1337	0	8	-16	\N	\N
1027057	0	1337	0	8	-15	\N	\N
1027058	0	1337	0	8	-14	\N	\N
1027059	0	1337	0	8	-13	\N	\N
1027060	0	1337	0	8	-12	\N	\N
1027061	0	1337	0	8	-11	\N	\N
1027062	0	1337	0	8	-10	\N	\N
1027063	0	1337	0	8	-9	\N	\N
1027064	0	1337	0	8	-8	\N	\N
1027065	0	1337	0	8	-7	\N	\N
1027066	0	1337	0	8	-6	\N	\N
1027067	0	1337	0	8	-5	\N	\N
1027068	0	1337	0	8	-4	\N	\N
1027069	0	1337	0	8	-3	\N	\N
1027070	0	1337	0	8	-2	\N	\N
1027071	0	1337	0	8	-1	\N	\N
1027072	0	1337	0	8	0	\N	\N
1027073	0	1337	0	8	1	\N	\N
1027074	0	1337	0	8	2	\N	\N
1027075	0	1337	0	8	3	\N	\N
1027076	0	1337	0	8	4	\N	\N
1027077	0	1337	0	8	5	\N	\N
1027078	0	1337	0	8	6	\N	\N
1027079	0	1337	0	8	7	\N	\N
1027080	0	1337	0	8	8	\N	\N
1027081	0	1337	0	8	9	\N	\N
1027082	0	1337	0	8	10	\N	\N
1027083	0	1337	0	8	11	\N	\N
1027084	0	1337	0	8	12	\N	\N
1027085	0	1337	0	8	13	\N	\N
1027086	0	1337	0	8	14	\N	\N
1027087	0	1337	0	8	15	\N	\N
1027088	0	1337	0	8	16	\N	\N
1027089	0	1337	0	8	17	\N	\N
1027090	0	1337	0	8	18	\N	\N
1027091	0	1337	0	8	19	\N	\N
1027092	40	1337	0	8	20	\N	\N
1027093	23	1337	0	8	21	\N	\N
1027094	33	1337	0	8	22	\N	\N
1027095	2	1337	0	8	23	\N	\N
1027096	23	1337	0	8	24	\N	\N
1027097	7	1337	0	8	25	\N	\N
1027098	31	1337	0	8	26	\N	\N
1027099	41	1337	0	8	27	\N	\N
1027100	19	1337	0	8	28	\N	\N
1027101	30	1337	0	8	29	\N	\N
1027102	47	1337	0	8	30	\N	\N
1027103	0	1337	0	8	31	\N	\N
1027104	0	1337	0	8	32	\N	\N
1027105	0	1337	0	8	33	\N	\N
1027106	0	1337	0	8	34	\N	\N
1027107	0	1337	0	8	35	\N	\N
1027108	0	1337	0	8	36	\N	\N
1027109	0	1337	0	8	37	\N	\N
1027110	0	1337	0	8	38	\N	\N
1027111	0	1337	0	8	39	\N	\N
1027112	0	1337	0	8	40	\N	\N
1027113	0	1337	0	8	41	\N	\N
1027114	0	1337	0	8	42	\N	\N
1027115	0	1337	0	8	43	\N	\N
1027116	0	1337	0	8	44	\N	\N
1027117	0	1337	0	8	45	\N	\N
1027118	0	1337	0	8	46	\N	\N
1027119	0	1337	0	8	47	\N	\N
1027120	0	1337	0	8	48	\N	\N
1027121	0	1337	0	8	49	\N	\N
1027122	0	1337	0	8	50	\N	\N
1027123	0	1337	0	8	51	\N	\N
1027124	0	1337	0	8	52	\N	\N
1027125	0	1337	0	8	53	\N	\N
1027126	0	1337	0	8	54	\N	\N
1027127	0	1337	0	8	55	\N	\N
1027128	0	1337	0	8	56	\N	\N
1027129	0	1337	0	8	57	\N	\N
1027130	0	1337	0	8	58	\N	\N
1027131	0	1337	0	8	59	\N	\N
1027132	0	1337	0	9	-20	\N	\N
1027133	0	1337	0	9	-19	\N	\N
1027134	0	1337	0	9	-18	\N	\N
1027135	0	1337	0	9	-17	\N	\N
1027136	0	1337	0	9	-16	\N	\N
1027137	0	1337	0	9	-15	\N	\N
1027138	0	1337	0	9	-14	\N	\N
1027139	0	1337	0	9	-13	\N	\N
1027140	0	1337	0	9	-12	\N	\N
1027141	0	1337	0	9	-11	\N	\N
1027142	0	1337	0	9	-10	\N	\N
1027143	0	1337	0	9	-9	\N	\N
1027144	0	1337	0	9	-8	\N	\N
1027145	0	1337	0	9	-7	\N	\N
1027146	0	1337	0	9	-6	\N	\N
1027147	0	1337	0	9	-5	\N	\N
1027148	0	1337	0	9	-4	\N	\N
1027149	0	1337	0	9	-3	\N	\N
1027150	0	1337	0	9	-2	\N	\N
1027151	0	1337	0	9	-1	\N	\N
1027152	0	1337	0	9	0	\N	\N
1027153	0	1337	0	9	1	\N	\N
1027154	0	1337	0	9	2	\N	\N
1027155	0	1337	0	9	3	\N	\N
1027156	0	1337	0	9	4	\N	\N
1027157	0	1337	0	9	5	\N	\N
1027158	0	1337	0	9	6	\N	\N
1027159	0	1337	0	9	7	\N	\N
1027160	0	1337	0	9	8	\N	\N
1027161	0	1337	0	9	9	\N	\N
1027162	0	1337	0	9	10	\N	\N
1027163	0	1337	0	9	11	\N	\N
1027164	0	1337	0	9	12	\N	\N
1027165	0	1337	0	9	13	\N	\N
1027166	0	1337	0	9	14	\N	\N
1027167	0	1337	0	9	15	\N	\N
1027168	0	1337	0	9	16	\N	\N
1027169	15	1337	0	9	17	\N	\N
1027170	13	1337	0	9	18	\N	\N
1027171	14	1337	0	9	19	\N	\N
1027172	10	1337	0	9	20	\N	\N
1027173	10	1337	0	9	21	\N	\N
1027174	29	1337	0	9	22	\N	\N
1027175	51	1337	0	9	23	\N	\N
1027176	39	1337	0	9	24	\N	\N
1027177	40	1337	0	9	25	\N	\N
1027178	29	1337	0	9	26	\N	\N
1027179	49	1337	0	9	27	\N	\N
1027180	5	1337	0	9	28	\N	\N
1027181	16	1337	0	9	29	\N	\N
1027182	27	1337	0	9	30	\N	\N
1027183	34	1337	0	9	31	\N	\N
1027184	7	1337	0	9	32	\N	\N
1027185	32	1337	0	9	33	\N	\N
1027186	0	1337	0	9	34	\N	\N
1027187	0	1337	0	9	35	\N	\N
1027188	0	1337	0	9	36	\N	\N
1027189	0	1337	0	9	37	\N	\N
1027190	0	1337	0	9	38	\N	\N
1027191	0	1337	0	9	39	\N	\N
1027192	0	1337	0	9	40	\N	\N
1027193	0	1337	0	9	41	\N	\N
1027194	0	1337	0	9	42	\N	\N
1027195	0	1337	0	9	43	\N	\N
1027196	0	1337	0	9	44	\N	\N
1027197	0	1337	0	9	45	\N	\N
1027198	0	1337	0	9	46	\N	\N
1027199	0	1337	0	9	47	\N	\N
1027200	0	1337	0	9	48	\N	\N
1027201	0	1337	0	9	49	\N	\N
1027202	0	1337	0	9	50	\N	\N
1027203	0	1337	0	9	51	\N	\N
1027204	0	1337	0	9	52	\N	\N
1027205	0	1337	0	9	53	\N	\N
1027206	0	1337	0	9	54	\N	\N
1027207	0	1337	0	9	55	\N	\N
1027208	0	1337	0	9	56	\N	\N
1027209	0	1337	0	9	57	\N	\N
1027210	0	1337	0	9	58	\N	\N
1027211	0	1337	0	9	59	\N	\N
1027212	0	1337	0	10	-20	\N	\N
1027213	0	1337	0	10	-19	\N	\N
1027214	0	1337	0	10	-18	\N	\N
1027215	0	1337	0	10	-17	\N	\N
1027216	0	1337	0	10	-16	\N	\N
1027217	0	1337	0	10	-15	\N	\N
1027218	0	1337	0	10	-14	\N	\N
1027219	0	1337	0	10	-13	\N	\N
1027220	0	1337	0	10	-12	\N	\N
1027221	0	1337	0	10	-11	\N	\N
1027222	0	1337	0	10	-10	\N	\N
1027223	0	1337	0	10	-9	\N	\N
1027224	0	1337	0	10	-8	\N	\N
1027225	0	1337	0	10	-7	\N	\N
1027226	0	1337	0	10	-6	\N	\N
1027227	0	1337	0	10	-5	\N	\N
1027228	0	1337	0	10	-4	\N	\N
1027229	0	1337	0	10	-3	\N	\N
1027230	0	1337	0	10	-2	\N	\N
1027231	0	1337	0	10	-1	\N	\N
1027232	0	1337	0	10	0	\N	\N
1027233	0	1337	0	10	1	\N	\N
1027234	0	1337	0	10	2	\N	\N
1027235	0	1337	0	10	3	\N	\N
1027236	0	1337	0	10	4	\N	\N
1027237	0	1337	0	10	5	\N	\N
1027238	0	1337	0	10	6	\N	\N
1027239	0	1337	0	10	7	\N	\N
1027240	0	1337	0	10	8	\N	\N
1027241	0	1337	0	10	9	\N	\N
1027242	0	1337	0	10	10	\N	\N
1027243	0	1337	0	10	11	\N	\N
1027244	0	1337	0	10	12	\N	\N
1027245	0	1337	0	10	13	\N	\N
1027246	0	1337	0	10	14	\N	\N
1027247	0	1337	0	10	15	\N	\N
1027248	44	1337	0	10	16	\N	\N
1027249	48	1337	0	10	17	\N	\N
1027250	4	1337	0	10	18	\N	\N
1027251	43	1337	0	10	19	\N	\N
1027252	20	1337	0	10	20	\N	\N
1027253	2	1337	0	10	21	\N	\N
1027254	52	1337	0	10	22	\N	\N
1027255	26	1337	0	10	23	\N	\N
1027256	43	1337	0	10	24	\N	\N
1027257	47	1337	0	10	25	\N	\N
1027258	25	1337	0	10	26	\N	\N
1027259	5	1337	0	10	27	\N	\N
1027260	33	1337	0	10	28	\N	\N
1027261	25	1337	0	10	29	\N	\N
1027262	32	1337	0	10	30	\N	\N
1027263	53	1337	0	10	31	\N	\N
1027264	6	1337	0	10	32	\N	\N
1027265	25	1337	0	10	33	\N	\N
1027266	4	1337	0	10	34	\N	\N
1027267	0	1337	0	10	35	\N	\N
1027268	0	1337	0	10	36	\N	\N
1027269	0	1337	0	10	37	\N	\N
1027270	0	1337	0	10	38	\N	\N
1027271	0	1337	0	10	39	\N	\N
1027272	0	1337	0	10	40	\N	\N
1027273	0	1337	0	10	41	\N	\N
1027274	0	1337	0	10	42	\N	\N
1027275	0	1337	0	10	43	\N	\N
1027276	0	1337	0	10	44	\N	\N
1027277	0	1337	0	10	45	\N	\N
1027278	0	1337	0	10	46	\N	\N
1027279	0	1337	0	10	47	\N	\N
1027280	0	1337	0	10	48	\N	\N
1027281	0	1337	0	10	49	\N	\N
1027282	0	1337	0	10	50	\N	\N
1027283	0	1337	0	10	51	\N	\N
1027284	0	1337	0	10	52	\N	\N
1027285	0	1337	0	10	53	\N	\N
1027286	0	1337	0	10	54	\N	\N
1027287	0	1337	0	10	55	\N	\N
1027288	0	1337	0	10	56	\N	\N
1027289	0	1337	0	10	57	\N	\N
1027290	0	1337	0	10	58	\N	\N
1027291	0	1337	0	10	59	\N	\N
1027292	0	1337	0	11	-20	\N	\N
1027293	0	1337	0	11	-19	\N	\N
1027294	0	1337	0	11	-18	\N	\N
1027295	0	1337	0	11	-17	\N	\N
1027296	0	1337	0	11	-16	\N	\N
1027297	0	1337	0	11	-15	\N	\N
1027298	0	1337	0	11	-14	\N	\N
1027299	0	1337	0	11	-13	\N	\N
1027300	0	1337	0	11	-12	\N	\N
1027301	0	1337	0	11	-11	\N	\N
1027302	0	1337	0	11	-10	\N	\N
1027303	0	1337	0	11	-9	\N	\N
1027304	0	1337	0	11	-8	\N	\N
1027305	0	1337	0	11	-7	\N	\N
1027306	0	1337	0	11	-6	\N	\N
1027307	0	1337	0	11	-5	\N	\N
1027308	0	1337	0	11	-4	\N	\N
1027309	0	1337	0	11	-3	\N	\N
1027310	0	1337	0	11	-2	\N	\N
1027311	0	1337	0	11	-1	\N	\N
1027312	0	1337	0	11	0	\N	\N
1027313	0	1337	0	11	1	\N	\N
1027314	0	1337	0	11	2	\N	\N
1027315	0	1337	0	11	3	\N	\N
1027316	0	1337	0	11	4	\N	\N
1027317	0	1337	0	11	5	\N	\N
1027318	0	1337	0	11	6	\N	\N
1027319	0	1337	0	11	7	\N	\N
1027320	0	1337	0	11	8	\N	\N
1027321	0	1337	0	11	9	\N	\N
1027322	0	1337	0	11	10	\N	\N
1027323	0	1337	0	11	11	\N	\N
1027324	0	1337	0	11	12	\N	\N
1027325	0	1337	0	11	13	\N	\N
1027326	33	1337	0	11	14	\N	\N
1027327	9	1337	0	11	15	\N	\N
1027328	23	1337	0	11	16	\N	\N
1027329	44	1337	0	11	17	\N	\N
1027330	12	1337	0	11	18	\N	\N
1027331	44	1337	0	11	19	\N	\N
1027332	47	1337	0	11	20	\N	\N
1027333	26	1337	0	11	21	\N	\N
1027334	40	1337	0	11	22	\N	\N
1027335	7	1337	0	11	23	\N	\N
1027336	30	1337	0	11	24	\N	\N
1027337	39	1337	0	11	25	\N	\N
1027338	5	1337	0	11	26	\N	\N
1027339	13	1337	0	11	27	\N	\N
1027340	35	1337	0	11	28	\N	\N
1027341	46	1337	0	11	29	\N	\N
1027342	28	1337	0	11	30	\N	\N
1027343	19	1337	0	11	31	\N	\N
1027344	33	1337	0	11	32	\N	\N
1027345	18	1337	0	11	33	\N	\N
1027346	13	1337	0	11	34	\N	\N
1027347	19	1337	0	11	35	\N	\N
1027348	22	1337	0	11	36	\N	\N
1027349	0	1337	0	11	37	\N	\N
1027350	0	1337	0	11	38	\N	\N
1027351	0	1337	0	11	39	\N	\N
1027352	0	1337	0	11	40	\N	\N
1027353	0	1337	0	11	41	\N	\N
1027354	0	1337	0	11	42	\N	\N
1027355	0	1337	0	11	43	\N	\N
1027356	0	1337	0	11	44	\N	\N
1027357	0	1337	0	11	45	\N	\N
1027358	0	1337	0	11	46	\N	\N
1027359	0	1337	0	11	47	\N	\N
1027360	0	1337	0	11	48	\N	\N
1027361	0	1337	0	11	49	\N	\N
1027362	0	1337	0	11	50	\N	\N
1027363	0	1337	0	11	51	\N	\N
1027364	0	1337	0	11	52	\N	\N
1027365	0	1337	0	11	53	\N	\N
1027366	0	1337	0	11	54	\N	\N
1027367	0	1337	0	11	55	\N	\N
1027368	0	1337	0	11	56	\N	\N
1027369	0	1337	0	11	57	\N	\N
1027370	0	1337	0	11	58	\N	\N
1027371	0	1337	0	11	59	\N	\N
1027372	0	1337	0	12	-20	\N	\N
1027373	0	1337	0	12	-19	\N	\N
1027374	0	1337	0	12	-18	\N	\N
1027375	0	1337	0	12	-17	\N	\N
1027376	0	1337	0	12	-16	\N	\N
1027377	0	1337	0	12	-15	\N	\N
1027378	0	1337	0	12	-14	\N	\N
1027379	0	1337	0	12	-13	\N	\N
1027380	0	1337	0	12	-12	\N	\N
1027381	0	1337	0	12	-11	\N	\N
1027382	0	1337	0	12	-10	\N	\N
1027383	0	1337	0	12	-9	\N	\N
1027384	0	1337	0	12	-8	\N	\N
1027385	0	1337	0	12	-7	\N	\N
1027386	0	1337	0	12	-6	\N	\N
1027387	0	1337	0	12	-5	\N	\N
1027388	0	1337	0	12	-4	\N	\N
1027389	0	1337	0	12	-3	\N	\N
1027390	0	1337	0	12	-2	\N	\N
1027391	0	1337	0	12	-1	\N	\N
1027392	0	1337	0	12	0	\N	\N
1027393	0	1337	0	12	1	\N	\N
1027394	0	1337	0	12	2	\N	\N
1027395	0	1337	0	12	3	\N	\N
1027396	0	1337	0	12	4	\N	\N
1027397	0	1337	0	12	5	\N	\N
1027398	0	1337	0	12	6	\N	\N
1027399	0	1337	0	12	7	\N	\N
1027400	0	1337	0	12	8	\N	\N
1027401	0	1337	0	12	9	\N	\N
1027402	0	1337	0	12	10	\N	\N
1027403	0	1337	0	12	11	\N	\N
1027404	0	1337	0	12	12	\N	\N
1027405	15	1337	0	12	13	\N	\N
1027406	31	1337	0	12	14	\N	\N
1027407	45	1337	0	12	15	\N	\N
1027408	27	1337	0	12	16	\N	\N
1027409	48	1337	0	12	17	\N	\N
1027410	32	1337	0	12	18	\N	\N
1027411	36	1337	0	12	19	\N	\N
1027412	22	1337	0	12	20	\N	\N
1027413	27	1337	0	12	21	\N	\N
1027414	4	1337	0	12	22	\N	\N
1027415	47	1337	0	12	23	\N	\N
1027416	39	1337	0	12	24	\N	\N
1027417	31	1337	0	12	25	\N	\N
1027418	23	1337	0	12	26	\N	\N
1027419	44	1337	0	12	27	\N	\N
1027420	13	1337	0	12	28	\N	\N
1027421	15	1337	0	12	29	\N	\N
1027422	20	1337	0	12	30	\N	\N
1027423	52	1337	0	12	31	\N	\N
1027424	17	1337	0	12	32	\N	\N
1027425	35	1337	0	12	33	\N	\N
1027426	23	1337	0	12	34	\N	\N
1027427	9	1337	0	12	35	\N	\N
1027428	38	1337	0	12	36	\N	\N
1027429	2	1337	0	12	37	\N	\N
1027430	0	1337	0	12	38	\N	\N
1027431	0	1337	0	12	39	\N	\N
1027432	0	1337	0	12	40	\N	\N
1027433	0	1337	0	12	41	\N	\N
1027434	0	1337	0	12	42	\N	\N
1027435	0	1337	0	12	43	\N	\N
1027436	0	1337	0	12	44	\N	\N
1027437	0	1337	0	12	45	\N	\N
1027438	0	1337	0	12	46	\N	\N
1027439	0	1337	0	12	47	\N	\N
1027440	0	1337	0	12	48	\N	\N
1027441	0	1337	0	12	49	\N	\N
1027442	0	1337	0	12	50	\N	\N
1027443	0	1337	0	12	51	\N	\N
1027444	0	1337	0	12	52	\N	\N
1027445	0	1337	0	12	53	\N	\N
1027446	0	1337	0	12	54	\N	\N
1027447	0	1337	0	12	55	\N	\N
1027448	0	1337	0	12	56	\N	\N
1027449	0	1337	0	12	57	\N	\N
1027450	0	1337	0	12	58	\N	\N
1027451	0	1337	0	12	59	\N	\N
1027452	0	1337	0	13	-20	\N	\N
1027453	0	1337	0	13	-19	\N	\N
1027454	0	1337	0	13	-18	\N	\N
1027455	0	1337	0	13	-17	\N	\N
1027456	0	1337	0	13	-16	\N	\N
1027457	0	1337	0	13	-15	\N	\N
1027458	0	1337	0	13	-14	\N	\N
1027459	0	1337	0	13	-13	\N	\N
1027460	0	1337	0	13	-12	\N	\N
1027461	0	1337	0	13	-11	\N	\N
1027462	0	1337	0	13	-10	\N	\N
1027463	0	1337	0	13	-9	\N	\N
1027464	0	1337	0	13	-8	\N	\N
1027465	0	1337	0	13	-7	\N	\N
1027466	0	1337	0	13	-6	\N	\N
1027467	0	1337	0	13	-5	\N	\N
1027468	0	1337	0	13	-4	\N	\N
1027469	0	1337	0	13	-3	\N	\N
1027470	0	1337	0	13	-2	\N	\N
1027471	0	1337	0	13	-1	\N	\N
1027472	0	1337	0	13	0	\N	\N
1027473	0	1337	0	13	1	\N	\N
1027474	0	1337	0	13	2	\N	\N
1027475	0	1337	0	13	3	\N	\N
1027476	0	1337	0	13	4	\N	\N
1027477	0	1337	0	13	5	\N	\N
1027478	0	1337	0	13	6	\N	\N
1027479	0	1337	0	13	7	\N	\N
1027480	0	1337	0	13	8	\N	\N
1027481	0	1337	0	13	9	\N	\N
1027482	0	1337	0	13	10	\N	\N
1027483	0	1337	0	13	11	\N	\N
1027484	8	1337	0	13	12	\N	\N
1027485	1	1337	0	13	13	\N	\N
1027486	10	1337	0	13	14	\N	\N
1027487	26	1337	0	13	15	\N	\N
1027488	30	1337	0	13	16	\N	\N
1027489	43	1337	0	13	17	\N	\N
1027490	28	1337	0	13	18	\N	\N
1027491	24	1337	0	13	19	\N	\N
1027492	52	1337	0	13	20	\N	\N
1027493	53	1337	0	13	21	\N	\N
1027494	24	1337	0	13	22	\N	\N
1027495	53	1337	0	13	23	\N	\N
1027496	8	1337	0	13	24	\N	\N
1027497	22	1337	0	13	25	\N	\N
1027498	22	1337	0	13	26	\N	\N
1027499	43	1337	0	13	27	\N	\N
1027500	24	1337	0	13	28	\N	\N
1027501	43	1337	0	13	29	\N	\N
1027502	31	1337	0	13	30	\N	\N
1027503	25	1337	0	13	31	\N	\N
1027504	26	1337	0	13	32	\N	\N
1027505	53	1337	0	13	33	\N	\N
1027506	5	1337	0	13	34	\N	\N
1027507	8	1337	0	13	35	\N	\N
1027508	35	1337	0	13	36	\N	\N
1027509	41	1337	0	13	37	\N	\N
1027510	18	1337	0	13	38	\N	\N
1027511	0	1337	0	13	39	\N	\N
1027512	0	1337	0	13	40	\N	\N
1027513	0	1337	0	13	41	\N	\N
1027514	0	1337	0	13	42	\N	\N
1027515	0	1337	0	13	43	\N	\N
1027516	0	1337	0	13	44	\N	\N
1027517	0	1337	0	13	45	\N	\N
1027518	0	1337	0	13	46	\N	\N
1027519	0	1337	0	13	47	\N	\N
1027520	0	1337	0	13	48	\N	\N
1027521	0	1337	0	13	49	\N	\N
1027522	0	1337	0	13	50	\N	\N
1027523	0	1337	0	13	51	\N	\N
1027524	0	1337	0	13	52	\N	\N
1027525	0	1337	0	13	53	\N	\N
1027526	0	1337	0	13	54	\N	\N
1027527	0	1337	0	13	55	\N	\N
1027528	0	1337	0	13	56	\N	\N
1027529	0	1337	0	13	57	\N	\N
1027530	0	1337	0	13	58	\N	\N
1027531	0	1337	0	13	59	\N	\N
1027532	0	1337	0	14	-20	\N	\N
1027533	0	1337	0	14	-19	\N	\N
1027534	0	1337	0	14	-18	\N	\N
1027535	0	1337	0	14	-17	\N	\N
1027536	0	1337	0	14	-16	\N	\N
1027537	0	1337	0	14	-15	\N	\N
1027538	0	1337	0	14	-14	\N	\N
1027539	0	1337	0	14	-13	\N	\N
1027540	0	1337	0	14	-12	\N	\N
1027541	0	1337	0	14	-11	\N	\N
1027542	0	1337	0	14	-10	\N	\N
1027543	0	1337	0	14	-9	\N	\N
1027544	0	1337	0	14	-8	\N	\N
1027545	0	1337	0	14	-7	\N	\N
1027546	0	1337	0	14	-6	\N	\N
1027547	0	1337	0	14	-5	\N	\N
1027548	0	1337	0	14	-4	\N	\N
1027549	0	1337	0	14	-3	\N	\N
1027550	0	1337	0	14	-2	\N	\N
1027551	0	1337	0	14	-1	\N	\N
1027552	0	1337	0	14	0	\N	\N
1027553	0	1337	0	14	1	\N	\N
1027554	0	1337	0	14	2	\N	\N
1027555	0	1337	0	14	3	\N	\N
1027556	0	1337	0	14	4	\N	\N
1027557	0	1337	0	14	5	\N	\N
1027558	0	1337	0	14	6	\N	\N
1027559	0	1337	0	14	7	\N	\N
1027560	0	1337	0	14	8	\N	\N
1027561	0	1337	0	14	9	\N	\N
1027562	0	1337	0	14	10	\N	\N
1027563	31	1337	0	14	11	\N	\N
1027564	24	1337	0	14	12	\N	\N
1027565	6	1337	0	14	13	\N	\N
1027566	16	1337	0	14	14	\N	\N
1027567	43	1337	0	14	15	\N	\N
1027568	5	1337	0	14	16	\N	\N
1027569	24	1337	0	14	17	\N	\N
1027570	46	1337	0	14	18	\N	\N
1027571	4	1337	0	14	19	\N	\N
1027572	19	1337	0	14	20	\N	\N
1027573	28	1337	0	14	21	\N	\N
1027574	8	1337	0	14	22	\N	\N
1027575	17	1337	0	14	23	\N	\N
1027576	38	1337	0	14	24	\N	\N
1027577	9	1337	0	14	25	\N	\N
1027578	45	1337	0	14	26	\N	\N
1027579	20	1337	0	14	27	\N	\N
1027580	29	1337	0	14	28	\N	\N
1027581	12	1337	0	14	29	\N	\N
1027582	10	1337	0	14	30	\N	\N
1027583	19	1337	0	14	31	\N	\N
1027584	20	1337	0	14	32	\N	\N
1027585	46	1337	0	14	33	\N	\N
1027586	16	1337	0	14	34	\N	\N
1027587	20	1337	0	14	35	\N	\N
1027588	48	1337	0	14	36	\N	\N
1027589	36	1337	0	14	37	\N	\N
1027590	34	1337	0	14	38	\N	\N
1027591	47	1337	0	14	39	\N	\N
1027592	0	1337	0	14	40	\N	\N
1027593	0	1337	0	14	41	\N	\N
1027594	0	1337	0	14	42	\N	\N
1027595	0	1337	0	14	43	\N	\N
1027596	0	1337	0	14	44	\N	\N
1027597	0	1337	0	14	45	\N	\N
1027598	0	1337	0	14	46	\N	\N
1027599	0	1337	0	14	47	\N	\N
1027600	0	1337	0	14	48	\N	\N
1027601	0	1337	0	14	49	\N	\N
1027602	0	1337	0	14	50	\N	\N
1027603	0	1337	0	14	51	\N	\N
1027604	0	1337	0	14	52	\N	\N
1027605	0	1337	0	14	53	\N	\N
1027606	0	1337	0	14	54	\N	\N
1027607	0	1337	0	14	55	\N	\N
1027608	0	1337	0	14	56	\N	\N
1027609	0	1337	0	14	57	\N	\N
1027610	0	1337	0	14	58	\N	\N
1027611	0	1337	0	14	59	\N	\N
1027612	0	1337	0	15	-20	\N	\N
1027613	0	1337	0	15	-19	\N	\N
1027614	0	1337	0	15	-18	\N	\N
1027615	0	1337	0	15	-17	\N	\N
1027616	0	1337	0	15	-16	\N	\N
1027617	0	1337	0	15	-15	\N	\N
1027618	0	1337	0	15	-14	\N	\N
1027619	0	1337	0	15	-13	\N	\N
1027620	0	1337	0	15	-12	\N	\N
1027621	0	1337	0	15	-11	\N	\N
1027622	0	1337	0	15	-10	\N	\N
1027623	0	1337	0	15	-9	\N	\N
1027624	0	1337	0	15	-8	\N	\N
1027625	0	1337	0	15	-7	\N	\N
1027626	0	1337	0	15	-6	\N	\N
1027627	0	1337	0	15	-5	\N	\N
1027628	0	1337	0	15	-4	\N	\N
1027629	0	1337	0	15	-3	\N	\N
1027630	0	1337	0	15	-2	\N	\N
1027631	0	1337	0	15	-1	\N	\N
1027632	0	1337	0	15	0	\N	\N
1027633	0	1337	0	15	1	\N	\N
1027634	0	1337	0	15	2	\N	\N
1027635	0	1337	0	15	3	\N	\N
1027636	0	1337	0	15	4	\N	\N
1027637	0	1337	0	15	5	\N	\N
1027638	0	1337	0	15	6	\N	\N
1027639	0	1337	0	15	7	\N	\N
1027640	0	1337	0	15	8	\N	\N
1027641	0	1337	0	15	9	\N	\N
1027642	0	1337	0	15	10	\N	\N
1027643	26	1337	0	15	11	\N	\N
1027644	43	1337	0	15	12	\N	\N
1027645	38	1337	0	15	13	\N	\N
1027646	45	1337	0	15	14	\N	\N
1027647	17	1337	0	15	15	\N	\N
1027648	24	1337	0	15	16	\N	\N
1027649	29	1337	0	15	17	\N	\N
1027650	38	1337	0	15	18	\N	\N
1027651	13	1337	0	15	19	\N	\N
1027652	19	1337	0	15	20	\N	\N
1027653	2	1337	0	15	21	\N	\N
1027654	47	1337	0	15	22	\N	\N
1027655	45	1337	0	15	23	\N	\N
1027656	7	1337	0	15	24	\N	\N
1027657	6	1337	0	15	25	\N	\N
1027658	43	1337	0	15	26	\N	\N
1027659	39	1337	0	15	27	\N	\N
1027660	3	1337	0	15	28	\N	\N
1027661	16	1337	0	15	29	\N	\N
1027662	29	1337	0	15	30	\N	\N
1027663	5	1337	0	15	31	\N	\N
1027664	7	1337	0	15	32	\N	\N
1027665	18	1337	0	15	33	\N	\N
1027666	53	1337	0	15	34	\N	\N
1027667	25	1337	0	15	35	\N	\N
1027668	23	1337	0	15	36	\N	\N
1027669	7	1337	0	15	37	\N	\N
1027670	10	1337	0	15	38	\N	\N
1027671	28	1337	0	15	39	\N	\N
1027672	0	1337	0	15	40	\N	\N
1027673	0	1337	0	15	41	\N	\N
1027674	0	1337	0	15	42	\N	\N
1027675	0	1337	0	15	43	\N	\N
1027676	0	1337	0	15	44	\N	\N
1027677	0	1337	0	15	45	\N	\N
1027678	0	1337	0	15	46	\N	\N
1027679	0	1337	0	15	47	\N	\N
1027680	0	1337	0	15	48	\N	\N
1027681	0	1337	0	15	49	\N	\N
1027682	0	1337	0	15	50	\N	\N
1027683	0	1337	0	15	51	\N	\N
1027684	0	1337	0	15	52	\N	\N
1027685	0	1337	0	15	53	\N	\N
1027686	0	1337	0	15	54	\N	\N
1027687	0	1337	0	15	55	\N	\N
1027688	0	1337	0	15	56	\N	\N
1027689	0	1337	0	15	57	\N	\N
1027690	0	1337	0	15	58	\N	\N
1027691	0	1337	0	15	59	\N	\N
1027692	0	1337	0	16	-20	\N	\N
1027693	0	1337	0	16	-19	\N	\N
1027694	0	1337	0	16	-18	\N	\N
1027695	0	1337	0	16	-17	\N	\N
1027696	0	1337	0	16	-16	\N	\N
1027697	0	1337	0	16	-15	\N	\N
1027698	0	1337	0	16	-14	\N	\N
1027699	0	1337	0	16	-13	\N	\N
1027700	0	1337	0	16	-12	\N	\N
1027701	0	1337	0	16	-11	\N	\N
1027702	0	1337	0	16	-10	\N	\N
1027703	0	1337	0	16	-9	\N	\N
1027704	0	1337	0	16	-8	\N	\N
1027705	0	1337	0	16	-7	\N	\N
1027706	0	1337	0	16	-6	\N	\N
1027707	0	1337	0	16	-5	\N	\N
1027708	0	1337	0	16	-4	\N	\N
1027709	0	1337	0	16	-3	\N	\N
1027710	0	1337	0	16	-2	\N	\N
1027711	0	1337	0	16	-1	\N	\N
1027712	0	1337	0	16	0	\N	\N
1027713	0	1337	0	16	1	\N	\N
1027714	0	1337	0	16	2	\N	\N
1027715	0	1337	0	16	3	\N	\N
1027716	0	1337	0	16	4	\N	\N
1027717	0	1337	0	16	5	\N	\N
1027718	0	1337	0	16	6	\N	\N
1027719	0	1337	0	16	7	\N	\N
1027720	0	1337	0	16	8	\N	\N
1027721	0	1337	0	16	9	\N	\N
1027722	37	1337	0	16	10	\N	\N
1027723	10	1337	0	16	11	\N	\N
1027724	11	1337	0	16	12	\N	\N
1027725	34	1337	0	16	13	\N	\N
1027726	5	1337	0	16	14	\N	\N
1027727	5	1337	0	16	15	\N	\N
1027728	22	1337	0	16	16	\N	\N
1027729	14	1337	0	16	17	\N	\N
1027730	45	1337	0	16	18	\N	\N
1027731	24	1337	0	16	19	\N	\N
1027732	15	1337	0	16	20	\N	\N
1027733	30	1337	0	16	21	\N	\N
1027734	7	1337	0	16	22	\N	\N
1027735	26	1337	0	16	23	\N	\N
1027736	16	1337	0	16	24	\N	\N
1027737	46	1337	0	16	25	\N	\N
1027738	41	1337	0	16	26	\N	\N
1027739	45	1337	0	16	27	\N	\N
1027740	12	1337	0	16	28	\N	\N
1027741	36	1337	0	16	29	\N	\N
1027742	5	1337	0	16	30	\N	\N
1027743	21	1337	0	16	31	\N	\N
1027744	6	1337	0	16	32	\N	\N
1027745	18	1337	0	16	33	\N	\N
1027746	43	1337	0	16	34	\N	\N
1027747	14	1337	0	16	35	\N	\N
1027748	29	1337	0	16	36	\N	\N
1027749	11	1337	0	16	37	\N	\N
1027750	13	1337	0	16	38	\N	\N
1027751	53	1337	0	16	39	\N	\N
1027752	29	1337	0	16	40	\N	\N
1027753	0	1337	0	16	41	\N	\N
1027754	0	1337	0	16	42	\N	\N
1027755	0	1337	0	16	43	\N	\N
1027756	0	1337	0	16	44	\N	\N
1027757	0	1337	0	16	45	\N	\N
1027758	0	1337	0	16	46	\N	\N
1027759	0	1337	0	16	47	\N	\N
1027760	0	1337	0	16	48	\N	\N
1027761	0	1337	0	16	49	\N	\N
1027762	0	1337	0	16	50	\N	\N
1027763	0	1337	0	16	51	\N	\N
1027764	0	1337	0	16	52	\N	\N
1027765	0	1337	0	16	53	\N	\N
1027766	0	1337	0	16	54	\N	\N
1027767	0	1337	0	16	55	\N	\N
1027768	0	1337	0	16	56	\N	\N
1027769	0	1337	0	16	57	\N	\N
1027770	0	1337	0	16	58	\N	\N
1027771	0	1337	0	16	59	\N	\N
1027772	0	1337	0	17	-20	\N	\N
1027773	0	1337	0	17	-19	\N	\N
1027774	0	1337	0	17	-18	\N	\N
1027775	0	1337	0	17	-17	\N	\N
1027776	0	1337	0	17	-16	\N	\N
1027777	0	1337	0	17	-15	\N	\N
1027778	0	1337	0	17	-14	\N	\N
1027779	0	1337	0	17	-13	\N	\N
1027780	0	1337	0	17	-12	\N	\N
1027781	0	1337	0	17	-11	\N	\N
1027782	0	1337	0	17	-10	\N	\N
1027783	0	1337	0	17	-9	\N	\N
1027784	0	1337	0	17	-8	\N	\N
1027785	0	1337	0	17	-7	\N	\N
1027786	0	1337	0	17	-6	\N	\N
1027787	0	1337	0	17	-5	\N	\N
1027788	0	1337	0	17	-4	\N	\N
1027789	0	1337	0	17	-3	\N	\N
1027790	0	1337	0	17	-2	\N	\N
1027791	0	1337	0	17	-1	\N	\N
1027792	0	1337	0	17	0	\N	\N
1027793	0	1337	0	17	1	\N	\N
1027794	0	1337	0	17	2	\N	\N
1027795	0	1337	0	17	3	\N	\N
1027796	0	1337	0	17	4	\N	\N
1027797	0	1337	0	17	5	\N	\N
1027798	0	1337	0	17	6	\N	\N
1027799	0	1337	0	17	7	\N	\N
1027800	0	1337	0	17	8	\N	\N
1027801	43	1337	0	17	9	\N	\N
1027802	44	1337	0	17	10	\N	\N
1027803	13	1337	0	17	11	\N	\N
1027804	27	1337	0	17	12	\N	\N
1027805	39	1337	0	17	13	\N	\N
1027806	8	1337	0	17	14	\N	\N
1027807	23	1337	0	17	15	\N	\N
1027808	24	1337	0	17	16	\N	\N
1027809	33	1337	0	17	17	\N	\N
1027810	24	1337	0	17	18	\N	\N
1027811	26	1337	0	17	19	\N	\N
1027812	15	1337	0	17	20	\N	\N
1027813	43	1337	0	17	21	\N	\N
1027814	46	1337	0	17	22	\N	\N
1027815	38	1337	0	17	23	\N	\N
1027816	23	1337	0	17	24	\N	\N
1027817	52	1337	0	17	25	\N	\N
1027818	46	1337	0	17	26	\N	\N
1027819	34	1337	0	17	27	\N	\N
1027820	36	1337	0	17	28	\N	\N
1027821	34	1337	0	17	29	\N	\N
1027822	19	1337	0	17	30	\N	\N
1027823	3	1337	0	17	31	\N	\N
1027824	45	1337	0	17	32	\N	\N
1027825	8	1337	0	17	33	\N	\N
1027826	29	1337	0	17	34	\N	\N
1027827	8	1337	0	17	35	\N	\N
1027828	49	1337	0	17	36	\N	\N
1027829	6	1337	0	17	37	\N	\N
1027830	25	1337	0	17	38	\N	\N
1027831	25	1337	0	17	39	\N	\N
1027832	38	1337	0	17	40	\N	\N
1027833	19	1337	0	17	41	\N	\N
1027834	0	1337	0	17	42	\N	\N
1027835	0	1337	0	17	43	\N	\N
1027836	0	1337	0	17	44	\N	\N
1027837	0	1337	0	17	45	\N	\N
1027838	0	1337	0	17	46	\N	\N
1027839	0	1337	0	17	47	\N	\N
1027840	0	1337	0	17	48	\N	\N
1027841	0	1337	0	17	49	\N	\N
1027842	0	1337	0	17	50	\N	\N
1027843	0	1337	0	17	51	\N	\N
1027844	0	1337	0	17	52	\N	\N
1027845	0	1337	0	17	53	\N	\N
1027846	0	1337	0	17	54	\N	\N
1027847	0	1337	0	17	55	\N	\N
1027848	0	1337	0	17	56	\N	\N
1027849	0	1337	0	17	57	\N	\N
1027850	0	1337	0	17	58	\N	\N
1027851	0	1337	0	17	59	\N	\N
1027852	0	1337	0	18	-20	\N	\N
1027853	0	1337	0	18	-19	\N	\N
1027854	0	1337	0	18	-18	\N	\N
1027855	0	1337	0	18	-17	\N	\N
1027856	0	1337	0	18	-16	\N	\N
1027857	0	1337	0	18	-15	\N	\N
1027858	0	1337	0	18	-14	\N	\N
1027859	0	1337	0	18	-13	\N	\N
1027860	0	1337	0	18	-12	\N	\N
1027861	0	1337	0	18	-11	\N	\N
1027862	0	1337	0	18	-10	\N	\N
1027863	0	1337	0	18	-9	\N	\N
1027864	0	1337	0	18	-8	\N	\N
1027865	0	1337	0	18	-7	\N	\N
1027866	0	1337	0	18	-6	\N	\N
1027867	0	1337	0	18	-5	\N	\N
1027868	0	1337	0	18	-4	\N	\N
1027869	0	1337	0	18	-3	\N	\N
1027870	0	1337	0	18	-2	\N	\N
1027871	0	1337	0	18	-1	\N	\N
1027872	0	1337	0	18	0	\N	\N
1027873	0	1337	0	18	1	\N	\N
1027874	0	1337	0	18	2	\N	\N
1027875	0	1337	0	18	3	\N	\N
1027876	0	1337	0	18	4	\N	\N
1027877	0	1337	0	18	5	\N	\N
1027878	0	1337	0	18	6	\N	\N
1027879	0	1337	0	18	7	\N	\N
1027880	0	1337	0	18	8	\N	\N
1027881	4	1337	0	18	9	\N	\N
1027882	35	1337	0	18	10	\N	\N
1027883	22	1337	0	18	11	\N	\N
1027884	21	1337	0	18	12	\N	\N
1027885	7	1337	0	18	13	\N	\N
1027886	1	1337	0	18	14	\N	\N
1027887	33	1337	0	18	15	\N	\N
1027888	9	1337	0	18	16	\N	\N
1027889	28	1337	0	18	17	\N	\N
1027890	5	1337	0	18	18	\N	\N
1027891	20	1337	0	18	19	\N	\N
1027892	37	1337	0	18	20	\N	\N
1027893	41	1337	0	18	21	\N	\N
1027894	30	1337	0	18	22	\N	\N
1027895	34	1337	0	18	23	\N	\N
1027896	53	1337	0	18	24	\N	\N
1027897	17	1337	0	18	25	\N	\N
1027898	26	1337	0	18	26	\N	\N
1027899	11	1337	0	18	27	\N	\N
1027900	45	1337	0	18	28	\N	\N
1027901	49	1337	0	18	29	\N	\N
1027902	46	1337	0	18	30	\N	\N
1027903	38	1337	0	18	31	\N	\N
1027904	13	1337	0	18	32	\N	\N
1027905	40	1337	0	18	33	\N	\N
1027906	28	1337	0	18	34	\N	\N
1027907	52	1337	0	18	35	\N	\N
1027908	9	1337	0	18	36	\N	\N
1027909	8	1337	0	18	37	\N	\N
1027910	31	1337	0	18	38	\N	\N
1027911	24	1337	0	18	39	\N	\N
1027912	19	1337	0	18	40	\N	\N
1027913	8	1337	0	18	41	\N	\N
1027914	0	1337	0	18	42	\N	\N
1027915	0	1337	0	18	43	\N	\N
1027916	0	1337	0	18	44	\N	\N
1027917	0	1337	0	18	45	\N	\N
1027918	0	1337	0	18	46	\N	\N
1027919	0	1337	0	18	47	\N	\N
1027920	0	1337	0	18	48	\N	\N
1027921	0	1337	0	18	49	\N	\N
1027922	0	1337	0	18	50	\N	\N
1027923	0	1337	0	18	51	\N	\N
1027924	0	1337	0	18	52	\N	\N
1027925	0	1337	0	18	53	\N	\N
1027926	0	1337	0	18	54	\N	\N
1027927	0	1337	0	18	55	\N	\N
1027928	0	1337	0	18	56	\N	\N
1027929	0	1337	0	18	57	\N	\N
1027930	0	1337	0	18	58	\N	\N
1027931	0	1337	0	18	59	\N	\N
1027932	0	1337	0	19	-20	\N	\N
1027933	0	1337	0	19	-19	\N	\N
1027934	0	1337	0	19	-18	\N	\N
1027935	0	1337	0	19	-17	\N	\N
1027936	0	1337	0	19	-16	\N	\N
1027937	0	1337	0	19	-15	\N	\N
1027938	0	1337	0	19	-14	\N	\N
1027939	0	1337	0	19	-13	\N	\N
1027940	0	1337	0	19	-12	\N	\N
1027941	0	1337	0	19	-11	\N	\N
1027942	0	1337	0	19	-10	\N	\N
1027943	0	1337	0	19	-9	\N	\N
1027944	0	1337	0	19	-8	\N	\N
1027945	0	1337	0	19	-7	\N	\N
1027946	0	1337	0	19	-6	\N	\N
1027947	0	1337	0	19	-5	\N	\N
1027948	0	1337	0	19	-4	\N	\N
1027949	0	1337	0	19	-3	\N	\N
1027950	0	1337	0	19	-2	\N	\N
1027951	0	1337	0	19	-1	\N	\N
1027952	0	1337	0	19	0	\N	\N
1027953	0	1337	0	19	1	\N	\N
1027954	0	1337	0	19	2	\N	\N
1027955	0	1337	0	19	3	\N	\N
1027956	0	1337	0	19	4	\N	\N
1027957	0	1337	0	19	5	\N	\N
1027958	0	1337	0	19	6	\N	\N
1027959	0	1337	0	19	7	\N	\N
1027960	0	1337	0	19	8	\N	\N
1027961	17	1337	0	19	9	\N	\N
1027962	18	1337	0	19	10	\N	\N
1027963	12	1337	0	19	11	\N	\N
1027964	15	1337	0	19	12	\N	\N
1027965	43	1337	0	19	13	\N	\N
1027966	26	1337	0	19	14	\N	\N
1027967	45	1337	0	19	15	\N	\N
1027968	14	1337	0	19	16	\N	\N
1027969	33	1337	0	19	17	\N	\N
1027970	18	1337	0	19	18	\N	\N
1027971	30	1337	0	19	19	\N	\N
1027972	29	1337	0	19	20	\N	\N
1027973	19	1337	0	19	21	\N	\N
1027974	13	1337	0	19	22	\N	\N
1027975	51	1337	0	19	23	\N	\N
1027976	31	1337	0	19	24	\N	\N
1027977	6	1337	0	19	25	\N	\N
1027978	38	1337	0	19	26	\N	\N
1027979	15	1337	0	19	27	\N	\N
1027980	21	1337	0	19	28	\N	\N
1027981	8	1337	0	19	29	\N	\N
1027982	20	1337	0	19	30	\N	\N
1027983	46	1337	0	19	31	\N	\N
1027984	4	1337	0	19	32	\N	\N
1027985	8	1337	0	19	33	\N	\N
1027986	20	1337	0	19	34	\N	\N
1027987	41	1337	0	19	35	\N	\N
1027988	6	1337	0	19	36	\N	\N
1027989	35	1337	0	19	37	\N	\N
1027990	41	1337	0	19	38	\N	\N
1027991	3	1337	0	19	39	\N	\N
1027992	29	1337	0	19	40	\N	\N
1027993	19	1337	0	19	41	\N	\N
1027994	0	1337	0	19	42	\N	\N
1027995	0	1337	0	19	43	\N	\N
1027996	0	1337	0	19	44	\N	\N
1027997	0	1337	0	19	45	\N	\N
1027998	0	1337	0	19	46	\N	\N
1027999	0	1337	0	19	47	\N	\N
1028000	0	1337	0	19	48	\N	\N
1028001	0	1337	0	19	49	\N	\N
1028002	0	1337	0	19	50	\N	\N
1028003	0	1337	0	19	51	\N	\N
1028004	0	1337	0	19	52	\N	\N
1028005	0	1337	0	19	53	\N	\N
1028006	0	1337	0	19	54	\N	\N
1028007	0	1337	0	19	55	\N	\N
1028008	0	1337	0	19	56	\N	\N
1028009	0	1337	0	19	57	\N	\N
1028010	0	1337	0	19	58	\N	\N
1028011	0	1337	0	19	59	\N	\N
1028012	0	1337	0	20	-20	\N	\N
1028013	0	1337	0	20	-19	\N	\N
1028014	0	1337	0	20	-18	\N	\N
1028015	0	1337	0	20	-17	\N	\N
1028016	0	1337	0	20	-16	\N	\N
1028017	0	1337	0	20	-15	\N	\N
1028018	0	1337	0	20	-14	\N	\N
1028019	0	1337	0	20	-13	\N	\N
1028020	0	1337	0	20	-12	\N	\N
1028021	0	1337	0	20	-11	\N	\N
1028022	0	1337	0	20	-10	\N	\N
1028023	0	1337	0	20	-9	\N	\N
1028024	0	1337	0	20	-8	\N	\N
1028025	0	1337	0	20	-7	\N	\N
1028026	0	1337	0	20	-6	\N	\N
1028027	0	1337	0	20	-5	\N	\N
1028028	0	1337	0	20	-4	\N	\N
1028029	0	1337	0	20	-3	\N	\N
1028030	0	1337	0	20	-2	\N	\N
1028031	0	1337	0	20	-1	\N	\N
1028032	0	1337	0	20	0	\N	\N
1028033	0	1337	0	20	1	\N	\N
1028034	0	1337	0	20	2	\N	\N
1028035	0	1337	0	20	3	\N	\N
1028036	0	1337	0	20	4	\N	\N
1028037	0	1337	0	20	5	\N	\N
1028038	0	1337	0	20	6	\N	\N
1028039	0	1337	0	20	7	\N	\N
1028040	37	1337	0	20	8	\N	\N
1028041	40	1337	0	20	9	\N	\N
1028042	23	1337	0	20	10	\N	\N
1028043	51	1337	0	20	11	\N	\N
1028044	11	1337	0	20	12	\N	\N
1028045	48	1337	0	20	13	\N	\N
1028046	10	1337	0	20	14	\N	\N
1028047	23	1337	0	20	15	\N	\N
1028048	53	1337	0	20	16	\N	\N
1028049	36	1337	0	20	17	\N	\N
1028050	20	1337	0	20	18	\N	\N
1028051	34	1337	0	20	19	\N	\N
1028052	10	1337	0	20	20	\N	\N
1028053	35	1337	0	20	21	\N	\N
1028054	11	1337	0	20	22	\N	\N
1028055	53	1337	0	20	23	\N	\N
1028056	25	1337	0	20	24	\N	\N
1028057	27	1337	0	20	25	\N	\N
1028058	30	1337	0	20	26	\N	\N
1028059	7	1337	0	20	27	\N	\N
1028060	31	1337	0	20	28	\N	\N
1028061	47	1337	0	20	29	\N	\N
1028062	17	1337	0	20	30	\N	\N
1028063	16	1337	0	20	31	\N	\N
1028064	46	1337	0	20	32	\N	\N
1028065	24	1337	0	20	33	\N	\N
1028066	15	1337	0	20	34	\N	\N
1028067	49	1337	0	20	35	\N	\N
1028068	25	1337	0	20	36	\N	\N
1028069	21	1337	0	20	37	\N	\N
1028070	30	1337	0	20	38	\N	\N
1028071	32	1337	0	20	39	\N	\N
1028072	32	1337	0	20	40	\N	\N
1028073	48	1337	0	20	41	\N	\N
1028074	30	1337	0	20	42	\N	\N
1028075	0	1337	0	20	43	\N	\N
1028076	0	1337	0	20	44	\N	\N
1028077	0	1337	0	20	45	\N	\N
1028078	0	1337	0	20	46	\N	\N
1028079	0	1337	0	20	47	\N	\N
1028080	0	1337	0	20	48	\N	\N
1028081	0	1337	0	20	49	\N	\N
1028082	0	1337	0	20	50	\N	\N
1028083	0	1337	0	20	51	\N	\N
1028084	0	1337	0	20	52	\N	\N
1028085	0	1337	0	20	53	\N	\N
1028086	0	1337	0	20	54	\N	\N
1028087	0	1337	0	20	55	\N	\N
1028088	0	1337	0	20	56	\N	\N
1028089	0	1337	0	20	57	\N	\N
1028090	0	1337	0	20	58	\N	\N
1028091	0	1337	0	20	59	\N	\N
1028092	0	1337	0	21	-20	\N	\N
1028093	0	1337	0	21	-19	\N	\N
1028094	0	1337	0	21	-18	\N	\N
1028095	0	1337	0	21	-17	\N	\N
1028096	0	1337	0	21	-16	\N	\N
1028097	0	1337	0	21	-15	\N	\N
1028098	0	1337	0	21	-14	\N	\N
1028099	0	1337	0	21	-13	\N	\N
1028100	0	1337	0	21	-12	\N	\N
1028101	0	1337	0	21	-11	\N	\N
1028102	0	1337	0	21	-10	\N	\N
1028103	0	1337	0	21	-9	\N	\N
1028104	0	1337	0	21	-8	\N	\N
1028105	0	1337	0	21	-7	\N	\N
1028106	0	1337	0	21	-6	\N	\N
1028107	0	1337	0	21	-5	\N	\N
1028108	0	1337	0	21	-4	\N	\N
1028109	0	1337	0	21	-3	\N	\N
1028110	0	1337	0	21	-2	\N	\N
1028111	0	1337	0	21	-1	\N	\N
1028112	0	1337	0	21	0	\N	\N
1028113	0	1337	0	21	1	\N	\N
1028114	0	1337	0	21	2	\N	\N
1028115	0	1337	0	21	3	\N	\N
1028116	0	1337	0	21	4	\N	\N
1028117	0	1337	0	21	5	\N	\N
1028118	0	1337	0	21	6	\N	\N
1028119	0	1337	0	21	7	\N	\N
1028120	31	1337	0	21	8	\N	\N
1028121	9	1337	0	21	9	\N	\N
1028122	39	1337	0	21	10	\N	\N
1028123	16	1337	0	21	11	\N	\N
1028124	25	1337	0	21	12	\N	\N
1028125	53	1337	0	21	13	\N	\N
1028126	14	1337	0	21	14	\N	\N
1028127	35	1337	0	21	15	\N	\N
1028128	4	1337	0	21	16	\N	\N
1028129	45	1337	0	21	17	\N	\N
1028130	14	1337	0	21	18	\N	\N
1028131	47	1337	0	21	19	\N	\N
1028132	38	1337	0	21	20	\N	\N
1028133	42	1337	0	21	21	\N	\N
1028134	42	1337	0	21	22	\N	\N
1028135	8	1337	0	21	23	\N	\N
1028136	33	1337	0	21	24	\N	\N
1028137	29	1337	0	21	25	\N	\N
1028138	3	1337	0	21	26	\N	\N
1028139	8	1337	0	21	27	\N	\N
1028140	8	1337	0	21	28	\N	\N
1028141	42	1337	0	21	29	\N	\N
1028142	7	1337	0	21	30	\N	\N
1028143	27	1337	0	21	31	\N	\N
1028144	36	1337	0	21	32	\N	\N
1028145	31	1337	0	21	33	\N	\N
1028146	15	1337	0	21	34	\N	\N
1028147	14	1337	0	21	35	\N	\N
1028148	5	1337	0	21	36	\N	\N
1028149	18	1337	0	21	37	\N	\N
1028150	48	1337	0	21	38	\N	\N
1028151	7	1337	0	21	39	\N	\N
1028152	44	1337	0	21	40	\N	\N
1028153	4	1337	0	21	41	\N	\N
1028154	3	1337	0	21	42	\N	\N
1028155	0	1337	0	21	43	\N	\N
1028156	0	1337	0	21	44	\N	\N
1028157	0	1337	0	21	45	\N	\N
1028158	0	1337	0	21	46	\N	\N
1028159	0	1337	0	21	47	\N	\N
1028160	0	1337	0	21	48	\N	\N
1028161	0	1337	0	21	49	\N	\N
1028162	0	1337	0	21	50	\N	\N
1028163	0	1337	0	21	51	\N	\N
1028164	0	1337	0	21	52	\N	\N
1028165	0	1337	0	21	53	\N	\N
1028166	0	1337	0	21	54	\N	\N
1028167	0	1337	0	21	55	\N	\N
1028168	0	1337	0	21	56	\N	\N
1028169	0	1337	0	21	57	\N	\N
1028170	0	1337	0	21	58	\N	\N
1028171	0	1337	0	21	59	\N	\N
1028172	0	1337	0	22	-20	\N	\N
1028173	0	1337	0	22	-19	\N	\N
1028174	0	1337	0	22	-18	\N	\N
1028175	0	1337	0	22	-17	\N	\N
1028176	0	1337	0	22	-16	\N	\N
1028177	0	1337	0	22	-15	\N	\N
1028178	0	1337	0	22	-14	\N	\N
1028179	0	1337	0	22	-13	\N	\N
1028180	0	1337	0	22	-12	\N	\N
1028181	0	1337	0	22	-11	\N	\N
1028182	0	1337	0	22	-10	\N	\N
1028183	0	1337	0	22	-9	\N	\N
1028184	0	1337	0	22	-8	\N	\N
1028185	0	1337	0	22	-7	\N	\N
1028186	0	1337	0	22	-6	\N	\N
1028187	0	1337	0	22	-5	\N	\N
1028188	0	1337	0	22	-4	\N	\N
1028189	0	1337	0	22	-3	\N	\N
1028190	0	1337	0	22	-2	\N	\N
1028191	0	1337	0	22	-1	\N	\N
1028192	0	1337	0	22	0	\N	\N
1028193	0	1337	0	22	1	\N	\N
1028194	0	1337	0	22	2	\N	\N
1028195	0	1337	0	22	3	\N	\N
1028196	0	1337	0	22	4	\N	\N
1028197	0	1337	0	22	5	\N	\N
1028198	0	1337	0	22	6	\N	\N
1028199	0	1337	0	22	7	\N	\N
1028200	39	1337	0	22	8	\N	\N
1028201	22	1337	0	22	9	\N	\N
1028202	46	1337	0	22	10	\N	\N
1028203	8	1337	0	22	11	\N	\N
1028204	37	1337	0	22	12	\N	\N
1028205	51	1337	0	22	13	\N	\N
1028206	1	1337	0	22	14	\N	\N
1028207	23	1337	0	22	15	\N	\N
1028208	4	1337	0	22	16	\N	\N
1028209	39	1337	0	22	17	\N	\N
1028210	9	1337	0	22	18	\N	\N
1028211	36	1337	0	22	19	\N	\N
1028212	18	1337	0	22	20	\N	\N
1028213	40	1337	0	22	21	\N	\N
1028214	53	1337	0	22	22	\N	\N
1028215	18	1337	0	22	23	\N	\N
1028216	7	1337	0	22	24	\N	\N
1028217	23	1337	0	22	25	\N	\N
1028218	40	1337	0	22	26	\N	\N
1028219	5	1337	0	22	27	\N	\N
1028220	34	1337	0	22	28	\N	\N
1028221	49	1337	0	22	29	\N	\N
1028222	21	1337	0	22	30	\N	\N
1028223	18	1337	0	22	31	\N	\N
1028224	43	1337	0	22	32	\N	\N
1028225	51	1337	0	22	33	\N	\N
1028226	11	1337	0	22	34	\N	\N
1028227	44	1337	0	22	35	\N	\N
1028228	14	1337	0	22	36	\N	\N
1028229	11	1337	0	22	37	\N	\N
1028230	53	1337	0	22	38	\N	\N
1028231	48	1337	0	22	39	\N	\N
1028232	19	1337	0	22	40	\N	\N
1028233	30	1337	0	22	41	\N	\N
1028234	17	1337	0	22	42	\N	\N
1028235	0	1337	0	22	43	\N	\N
1028236	0	1337	0	22	44	\N	\N
1028237	0	1337	0	22	45	\N	\N
1028238	0	1337	0	22	46	\N	\N
1028239	0	1337	0	22	47	\N	\N
1028240	0	1337	0	22	48	\N	\N
1028241	0	1337	0	22	49	\N	\N
1028242	0	1337	0	22	50	\N	\N
1028243	0	1337	0	22	51	\N	\N
1028244	0	1337	0	22	52	\N	\N
1028245	0	1337	0	22	53	\N	\N
1028246	0	1337	0	22	54	\N	\N
1028247	0	1337	0	22	55	\N	\N
1028248	0	1337	0	22	56	\N	\N
1028249	0	1337	0	22	57	\N	\N
1028250	0	1337	0	22	58	\N	\N
1028251	0	1337	0	22	59	\N	\N
1028252	0	1337	0	23	-20	\N	\N
1028253	0	1337	0	23	-19	\N	\N
1028254	0	1337	0	23	-18	\N	\N
1028255	0	1337	0	23	-17	\N	\N
1028256	0	1337	0	23	-16	\N	\N
1028257	0	1337	0	23	-15	\N	\N
1028258	0	1337	0	23	-14	\N	\N
1028259	0	1337	0	23	-13	\N	\N
1028260	0	1337	0	23	-12	\N	\N
1028261	0	1337	0	23	-11	\N	\N
1028262	0	1337	0	23	-10	\N	\N
1028263	0	1337	0	23	-9	\N	\N
1028264	0	1337	0	23	-8	\N	\N
1028265	0	1337	0	23	-7	\N	\N
1028266	0	1337	0	23	-6	\N	\N
1028267	0	1337	0	23	-5	\N	\N
1028268	0	1337	0	23	-4	\N	\N
1028269	0	1337	0	23	-3	\N	\N
1028270	0	1337	0	23	-2	\N	\N
1028271	0	1337	0	23	-1	\N	\N
1028272	0	1337	0	23	0	\N	\N
1028273	0	1337	0	23	1	\N	\N
1028274	0	1337	0	23	2	\N	\N
1028275	0	1337	0	23	3	\N	\N
1028276	0	1337	0	23	4	\N	\N
1028277	0	1337	0	23	5	\N	\N
1028278	0	1337	0	23	6	\N	\N
1028279	0	1337	0	23	7	\N	\N
1028280	24	1337	0	23	8	\N	\N
1028281	7	1337	0	23	9	\N	\N
1028282	35	1337	0	23	10	\N	\N
1028283	45	1337	0	23	11	\N	\N
1028284	25	1337	0	23	12	\N	\N
1028285	5	1337	0	23	13	\N	\N
1028286	53	1337	0	23	14	\N	\N
1028287	43	1337	0	23	15	\N	\N
1028288	1	1337	0	23	16	\N	\N
1028289	47	1337	0	23	17	\N	\N
1028290	15	1337	0	23	18	\N	\N
1028291	20	1337	0	23	19	\N	\N
1028292	22	1337	0	23	20	\N	\N
1028293	31	1337	0	23	21	\N	\N
1028294	36	1337	0	23	22	\N	\N
1028295	18	1337	0	23	23	\N	\N
1028296	16	1337	0	23	24	\N	\N
1028297	34	1337	0	23	25	\N	\N
1028298	11	1337	0	23	26	\N	\N
1028299	38	1337	0	23	27	\N	\N
1028300	41	1337	0	23	28	\N	\N
1028301	27	1337	0	23	29	\N	\N
1028302	27	1337	0	23	30	\N	\N
1028303	6	1337	0	23	31	\N	\N
1028304	18	1337	0	23	32	\N	\N
1028305	16	1337	0	23	33	\N	\N
1028306	46	1337	0	23	34	\N	\N
1028307	53	1337	0	23	35	\N	\N
1028308	10	1337	0	23	36	\N	\N
1028309	7	1337	0	23	37	\N	\N
1028310	1	1337	0	23	38	\N	\N
1028311	40	1337	0	23	39	\N	\N
1028312	34	1337	0	23	40	\N	\N
1028313	21	1337	0	23	41	\N	\N
1028314	46	1337	0	23	42	\N	\N
1028315	0	1337	0	23	43	\N	\N
1028316	0	1337	0	23	44	\N	\N
1028317	0	1337	0	23	45	\N	\N
1028318	0	1337	0	23	46	\N	\N
1028319	0	1337	0	23	47	\N	\N
1028320	0	1337	0	23	48	\N	\N
1028321	0	1337	0	23	49	\N	\N
1028322	0	1337	0	23	50	\N	\N
1028323	0	1337	0	23	51	\N	\N
1028324	0	1337	0	23	52	\N	\N
1028325	0	1337	0	23	53	\N	\N
1028326	0	1337	0	23	54	\N	\N
1028327	0	1337	0	23	55	\N	\N
1028328	0	1337	0	23	56	\N	\N
1028329	0	1337	0	23	57	\N	\N
1028330	0	1337	0	23	58	\N	\N
1028331	0	1337	0	23	59	\N	\N
1028332	0	1337	0	24	-20	\N	\N
1028333	0	1337	0	24	-19	\N	\N
1028334	0	1337	0	24	-18	\N	\N
1028335	0	1337	0	24	-17	\N	\N
1028336	0	1337	0	24	-16	\N	\N
1028337	0	1337	0	24	-15	\N	\N
1028338	0	1337	0	24	-14	\N	\N
1028339	0	1337	0	24	-13	\N	\N
1028340	0	1337	0	24	-12	\N	\N
1028341	0	1337	0	24	-11	\N	\N
1028342	0	1337	0	24	-10	\N	\N
1028343	0	1337	0	24	-9	\N	\N
1028344	0	1337	0	24	-8	\N	\N
1028345	0	1337	0	24	-7	\N	\N
1028346	0	1337	0	24	-6	\N	\N
1028347	0	1337	0	24	-5	\N	\N
1028348	0	1337	0	24	-4	\N	\N
1028349	0	1337	0	24	-3	\N	\N
1028350	0	1337	0	24	-2	\N	\N
1028351	0	1337	0	24	-1	\N	\N
1028352	0	1337	0	24	0	\N	\N
1028353	0	1337	0	24	1	\N	\N
1028354	0	1337	0	24	2	\N	\N
1028355	0	1337	0	24	3	\N	\N
1028356	0	1337	0	24	4	\N	\N
1028357	0	1337	0	24	5	\N	\N
1028358	0	1337	0	24	6	\N	\N
1028359	0	1337	0	24	7	\N	\N
1028360	53	1337	0	24	8	\N	\N
1028361	37	1337	0	24	9	\N	\N
1028362	8	1337	0	24	10	\N	\N
1028363	34	1337	0	24	11	\N	\N
1028364	49	1337	0	24	12	\N	\N
1028365	11	1337	0	24	13	\N	\N
1028366	22	1337	0	24	14	\N	\N
1028367	5	1337	0	24	15	\N	\N
1028368	22	1337	0	24	16	\N	\N
1028369	12	1337	0	24	17	\N	\N
1028370	30	1337	0	24	18	\N	\N
1028371	39	1337	0	24	19	\N	\N
1028372	13	1337	0	24	20	\N	\N
1028373	12	1337	0	24	21	\N	\N
1028374	39	1337	0	24	22	\N	\N
1028375	3	1337	0	24	23	\N	\N
1028376	12	1337	0	24	24	\N	\N
1028377	23	1337	0	24	25	\N	\N
1028378	28	1337	0	24	26	\N	\N
1028379	49	1337	0	24	27	\N	\N
1028380	22	1337	0	24	28	\N	\N
1028381	2	1337	0	24	29	\N	\N
1028382	23	1337	0	24	30	\N	\N
1028383	31	1337	0	24	31	\N	\N
1028384	23	1337	0	24	32	\N	\N
1028385	52	1337	0	24	33	\N	\N
1028386	41	1337	0	24	34	\N	\N
1028387	53	1337	0	24	35	\N	\N
1028388	19	1337	0	24	36	\N	\N
1028389	38	1337	0	24	37	\N	\N
1028390	25	1337	0	24	38	\N	\N
1028391	24	1337	0	24	39	\N	\N
1028392	19	1337	0	24	40	\N	\N
1028393	28	1337	0	24	41	\N	\N
1028394	41	1337	0	24	42	\N	\N
1028395	0	1337	0	24	43	\N	\N
1028396	0	1337	0	24	44	\N	\N
1028397	0	1337	0	24	45	\N	\N
1028398	0	1337	0	24	46	\N	\N
1028399	0	1337	0	24	47	\N	\N
1028400	0	1337	0	24	48	\N	\N
1028401	0	1337	0	24	49	\N	\N
1028402	0	1337	0	24	50	\N	\N
1028403	0	1337	0	24	51	\N	\N
1028404	0	1337	0	24	52	\N	\N
1028405	0	1337	0	24	53	\N	\N
1028406	0	1337	0	24	54	\N	\N
1028407	0	1337	0	24	55	\N	\N
1028408	0	1337	0	24	56	\N	\N
1028409	0	1337	0	24	57	\N	\N
1028410	0	1337	0	24	58	\N	\N
1028411	0	1337	0	24	59	\N	\N
1028412	0	1337	0	25	-20	\N	\N
1028413	0	1337	0	25	-19	\N	\N
1028414	0	1337	0	25	-18	\N	\N
1028415	0	1337	0	25	-17	\N	\N
1028416	0	1337	0	25	-16	\N	\N
1028417	0	1337	0	25	-15	\N	\N
1028418	0	1337	0	25	-14	\N	\N
1028419	0	1337	0	25	-13	\N	\N
1028420	0	1337	0	25	-12	\N	\N
1028421	0	1337	0	25	-11	\N	\N
1028422	0	1337	0	25	-10	\N	\N
1028423	0	1337	0	25	-9	\N	\N
1028424	0	1337	0	25	-8	\N	\N
1028425	0	1337	0	25	-7	\N	\N
1028426	0	1337	0	25	-6	\N	\N
1028427	0	1337	0	25	-5	\N	\N
1028428	0	1337	0	25	-4	\N	\N
1028429	0	1337	0	25	-3	\N	\N
1028430	0	1337	0	25	-2	\N	\N
1028431	0	1337	0	25	-1	\N	\N
1028432	0	1337	0	25	0	\N	\N
1028433	0	1337	0	25	1	\N	\N
1028434	0	1337	0	25	2	\N	\N
1028435	0	1337	0	25	3	\N	\N
1028436	0	1337	0	25	4	\N	\N
1028437	0	1337	0	25	5	\N	\N
1028438	0	1337	0	25	6	\N	\N
1028439	32	1337	0	25	7	\N	\N
1028440	48	1337	0	25	8	\N	\N
1028441	22	1337	0	25	9	\N	\N
1028442	41	1337	0	25	10	\N	\N
1028443	1	1337	0	25	11	\N	\N
1028444	1	1337	0	25	12	\N	\N
1028445	3	1337	0	25	13	\N	\N
1028446	44	1337	0	25	14	\N	\N
1028447	21	1337	0	25	15	\N	\N
1028448	39	1337	0	25	16	\N	\N
1028449	25	1337	0	25	17	\N	\N
1028450	53	1337	0	25	18	\N	\N
1028451	19	1337	0	25	19	\N	\N
1028452	1	1337	0	25	20	\N	\N
1028453	4	1337	0	25	21	\N	\N
1028454	39	1337	0	25	22	\N	\N
1028455	49	1337	0	25	23	\N	\N
1028456	33	1337	0	25	24	\N	\N
1028457	8	1337	0	25	25	\N	\N
1028458	3	1337	0	25	26	\N	\N
1028459	7	1337	0	25	27	\N	\N
1028460	17	1337	0	25	28	\N	\N
1028461	18	1337	0	25	29	\N	\N
1028462	7	1337	0	25	30	\N	\N
1028463	48	1337	0	25	31	\N	\N
1028464	19	1337	0	25	32	\N	\N
1028465	15	1337	0	25	33	\N	\N
1028466	10	1337	0	25	34	\N	\N
1028467	43	1337	0	25	35	\N	\N
1028468	5	1337	0	25	36	\N	\N
1028469	39	1337	0	25	37	\N	\N
1028470	42	1337	0	25	38	\N	\N
1028471	3	1337	0	25	39	\N	\N
1028472	39	1337	0	25	40	\N	\N
1028473	36	1337	0	25	41	\N	\N
1028474	4	1337	0	25	42	\N	\N
1028475	42	1337	0	25	43	\N	\N
1028476	0	1337	0	25	44	\N	\N
1028477	0	1337	0	25	45	\N	\N
1028478	0	1337	0	25	46	\N	\N
1028479	0	1337	0	25	47	\N	\N
1028480	0	1337	0	25	48	\N	\N
1028481	0	1337	0	25	49	\N	\N
1028482	0	1337	0	25	50	\N	\N
1028483	0	1337	0	25	51	\N	\N
1028484	0	1337	0	25	52	\N	\N
1028485	0	1337	0	25	53	\N	\N
1028486	0	1337	0	25	54	\N	\N
1028487	0	1337	0	25	55	\N	\N
1028488	0	1337	0	25	56	\N	\N
1028489	0	1337	0	25	57	\N	\N
1028490	0	1337	0	25	58	\N	\N
1028491	0	1337	0	25	59	\N	\N
1028492	0	1337	0	26	-20	\N	\N
1028493	0	1337	0	26	-19	\N	\N
1028494	0	1337	0	26	-18	\N	\N
1028495	0	1337	0	26	-17	\N	\N
1028496	0	1337	0	26	-16	\N	\N
1028497	0	1337	0	26	-15	\N	\N
1028498	0	1337	0	26	-14	\N	\N
1028499	0	1337	0	26	-13	\N	\N
1028500	0	1337	0	26	-12	\N	\N
1028501	0	1337	0	26	-11	\N	\N
1028502	0	1337	0	26	-10	\N	\N
1028503	0	1337	0	26	-9	\N	\N
1028504	0	1337	0	26	-8	\N	\N
1028505	0	1337	0	26	-7	\N	\N
1028506	0	1337	0	26	-6	\N	\N
1028507	0	1337	0	26	-5	\N	\N
1028508	0	1337	0	26	-4	\N	\N
1028509	0	1337	0	26	-3	\N	\N
1028510	0	1337	0	26	-2	\N	\N
1028511	0	1337	0	26	-1	\N	\N
1028512	0	1337	0	26	0	\N	\N
1028513	0	1337	0	26	1	\N	\N
1028514	0	1337	0	26	2	\N	\N
1028515	0	1337	0	26	3	\N	\N
1028516	0	1337	0	26	4	\N	\N
1028517	0	1337	0	26	5	\N	\N
1028518	0	1337	0	26	6	\N	\N
1028519	0	1337	0	26	7	\N	\N
1028520	36	1337	0	26	8	\N	\N
1028521	11	1337	0	26	9	\N	\N
1028522	45	1337	0	26	10	\N	\N
1028523	37	1337	0	26	11	\N	\N
1028524	3	1337	0	26	12	\N	\N
1028525	47	1337	0	26	13	\N	\N
1028526	52	1337	0	26	14	\N	\N
1028527	35	1337	0	26	15	\N	\N
1028528	5	1337	0	26	16	\N	\N
1028529	6	1337	0	26	17	\N	\N
1028530	9	1337	0	26	18	\N	\N
1028531	52	1337	0	26	19	\N	\N
1028532	10	1337	0	26	20	\N	\N
1028533	11	1337	0	26	21	\N	\N
1028534	8	1337	0	26	22	\N	\N
1028535	14	1337	0	26	23	\N	\N
1028536	39	1337	0	26	24	\N	\N
1028537	11	1337	0	26	25	\N	\N
1028538	41	1337	0	26	26	\N	\N
1028539	33	1337	0	26	27	\N	\N
1028540	46	1337	0	26	28	\N	\N
1028541	20	1337	0	26	29	\N	\N
1028542	30	1337	0	26	30	\N	\N
1028543	21	1337	0	26	31	\N	\N
1028544	22	1337	0	26	32	\N	\N
1028545	3	1337	0	26	33	\N	\N
1028546	28	1337	0	26	34	\N	\N
1028547	51	1337	0	26	35	\N	\N
1028548	45	1337	0	26	36	\N	\N
1028549	24	1337	0	26	37	\N	\N
1028550	18	1337	0	26	38	\N	\N
1028551	22	1337	0	26	39	\N	\N
1028552	41	1337	0	26	40	\N	\N
1028553	30	1337	0	26	41	\N	\N
1028554	26	1337	0	26	42	\N	\N
1028555	0	1337	0	26	43	\N	\N
1028556	0	1337	0	26	44	\N	\N
1028557	0	1337	0	26	45	\N	\N
1028558	0	1337	0	26	46	\N	\N
1028559	0	1337	0	26	47	\N	\N
1028560	0	1337	0	26	48	\N	\N
1028561	0	1337	0	26	49	\N	\N
1028562	0	1337	0	26	50	\N	\N
1028563	0	1337	0	26	51	\N	\N
1028564	0	1337	0	26	52	\N	\N
1028565	0	1337	0	26	53	\N	\N
1028566	0	1337	0	26	54	\N	\N
1028567	0	1337	0	26	55	\N	\N
1028568	0	1337	0	26	56	\N	\N
1028569	0	1337	0	26	57	\N	\N
1028570	0	1337	0	26	58	\N	\N
1028571	0	1337	0	26	59	\N	\N
1028572	0	1337	0	27	-20	\N	\N
1028573	0	1337	0	27	-19	\N	\N
1028574	0	1337	0	27	-18	\N	\N
1028575	0	1337	0	27	-17	\N	\N
1028576	0	1337	0	27	-16	\N	\N
1028577	0	1337	0	27	-15	\N	\N
1028578	0	1337	0	27	-14	\N	\N
1028579	0	1337	0	27	-13	\N	\N
1028580	0	1337	0	27	-12	\N	\N
1028581	0	1337	0	27	-11	\N	\N
1028582	0	1337	0	27	-10	\N	\N
1028583	0	1337	0	27	-9	\N	\N
1028584	0	1337	0	27	-8	\N	\N
1028585	0	1337	0	27	-7	\N	\N
1028586	0	1337	0	27	-6	\N	\N
1028587	0	1337	0	27	-5	\N	\N
1028588	0	1337	0	27	-4	\N	\N
1028589	0	1337	0	27	-3	\N	\N
1028590	0	1337	0	27	-2	\N	\N
1028591	0	1337	0	27	-1	\N	\N
1028592	0	1337	0	27	0	\N	\N
1028593	0	1337	0	27	1	\N	\N
1028594	0	1337	0	27	2	\N	\N
1028595	0	1337	0	27	3	\N	\N
1028596	0	1337	0	27	4	\N	\N
1028597	0	1337	0	27	5	\N	\N
1028598	0	1337	0	27	6	\N	\N
1028599	0	1337	0	27	7	\N	\N
1028600	39	1337	0	27	8	\N	\N
1028601	47	1337	0	27	9	\N	\N
1028602	10	1337	0	27	10	\N	\N
1028603	47	1337	0	27	11	\N	\N
1028604	41	1337	0	27	12	\N	\N
1028605	48	1337	0	27	13	\N	\N
1028606	4	1337	0	27	14	\N	\N
1028607	36	1337	0	27	15	\N	\N
1028608	51	1337	0	27	16	\N	\N
1028609	15	1337	0	27	17	\N	\N
1028610	25	1337	0	27	18	\N	\N
1028611	2	1337	0	27	19	\N	\N
1028612	49	1337	0	27	20	\N	\N
1028613	1	1337	0	27	21	\N	\N
1028614	46	1337	0	27	22	\N	\N
1028615	34	1337	0	27	23	\N	\N
1028616	49	1337	0	27	24	\N	\N
1028617	35	1337	0	27	25	\N	\N
1028618	15	1337	0	27	26	\N	\N
1028619	1	1337	0	27	27	\N	\N
1028620	46	1337	0	27	28	\N	\N
1028621	28	1337	0	27	29	\N	\N
1028622	14	1337	0	27	30	\N	\N
1028623	15	1337	0	27	31	\N	\N
1028624	34	1337	0	27	32	\N	\N
1028625	37	1337	0	27	33	\N	\N
1028626	6	1337	0	27	34	\N	\N
1028627	40	1337	0	27	35	\N	\N
1028628	49	1337	0	27	36	\N	\N
1028629	40	1337	0	27	37	\N	\N
1028630	34	1337	0	27	38	\N	\N
1028631	32	1337	0	27	39	\N	\N
1028632	49	1337	0	27	40	\N	\N
1028633	16	1337	0	27	41	\N	\N
1028634	9	1337	0	27	42	\N	\N
1028635	0	1337	0	27	43	\N	\N
1028636	0	1337	0	27	44	\N	\N
1028637	0	1337	0	27	45	\N	\N
1028638	0	1337	0	27	46	\N	\N
1028639	0	1337	0	27	47	\N	\N
1028640	0	1337	0	27	48	\N	\N
1028641	0	1337	0	27	49	\N	\N
1028642	0	1337	0	27	50	\N	\N
1028643	0	1337	0	27	51	\N	\N
1028644	0	1337	0	27	52	\N	\N
1028645	0	1337	0	27	53	\N	\N
1028646	0	1337	0	27	54	\N	\N
1028647	0	1337	0	27	55	\N	\N
1028648	0	1337	0	27	56	\N	\N
1028649	0	1337	0	27	57	\N	\N
1028650	0	1337	0	27	58	\N	\N
1028651	0	1337	0	27	59	\N	\N
1028652	0	1337	0	28	-20	\N	\N
1028653	0	1337	0	28	-19	\N	\N
1028654	0	1337	0	28	-18	\N	\N
1028655	0	1337	0	28	-17	\N	\N
1028656	0	1337	0	28	-16	\N	\N
1028657	0	1337	0	28	-15	\N	\N
1028658	0	1337	0	28	-14	\N	\N
1028659	0	1337	0	28	-13	\N	\N
1028660	0	1337	0	28	-12	\N	\N
1028661	0	1337	0	28	-11	\N	\N
1028662	0	1337	0	28	-10	\N	\N
1028663	0	1337	0	28	-9	\N	\N
1028664	0	1337	0	28	-8	\N	\N
1028665	0	1337	0	28	-7	\N	\N
1028666	0	1337	0	28	-6	\N	\N
1028667	0	1337	0	28	-5	\N	\N
1028668	0	1337	0	28	-4	\N	\N
1028669	0	1337	0	28	-3	\N	\N
1028670	0	1337	0	28	-2	\N	\N
1028671	0	1337	0	28	-1	\N	\N
1028672	0	1337	0	28	0	\N	\N
1028673	0	1337	0	28	1	\N	\N
1028674	0	1337	0	28	2	\N	\N
1028675	0	1337	0	28	3	\N	\N
1028676	0	1337	0	28	4	\N	\N
1028677	0	1337	0	28	5	\N	\N
1028678	0	1337	0	28	6	\N	\N
1028679	0	1337	0	28	7	\N	\N
1028680	5	1337	0	28	8	\N	\N
1028681	25	1337	0	28	9	\N	\N
1028682	24	1337	0	28	10	\N	\N
1028683	40	1337	0	28	11	\N	\N
1028684	19	1337	0	28	12	\N	\N
1028685	3	1337	0	28	13	\N	\N
1028686	29	1337	0	28	14	\N	\N
1028687	37	1337	0	28	15	\N	\N
1028688	7	1337	0	28	16	\N	\N
1028689	10	1337	0	28	17	\N	\N
1028690	51	1337	0	28	18	\N	\N
1028691	45	1337	0	28	19	\N	\N
1028692	12	1337	0	28	20	\N	\N
1028693	22	1337	0	28	21	\N	\N
1028694	3	1337	0	28	22	\N	\N
1028695	24	1337	0	28	23	\N	\N
1028696	12	1337	0	28	24	\N	\N
1028697	16	1337	0	28	25	\N	\N
1028698	3	1337	0	28	26	\N	\N
1028699	52	1337	0	28	27	\N	\N
1028700	3	1337	0	28	28	\N	\N
1028701	27	1337	0	28	29	\N	\N
1028702	45	1337	0	28	30	\N	\N
1028703	48	1337	0	28	31	\N	\N
1028704	46	1337	0	28	32	\N	\N
1028705	47	1337	0	28	33	\N	\N
1028706	12	1337	0	28	34	\N	\N
1028707	53	1337	0	28	35	\N	\N
1028708	27	1337	0	28	36	\N	\N
1028709	34	1337	0	28	37	\N	\N
1028710	20	1337	0	28	38	\N	\N
1028711	51	1337	0	28	39	\N	\N
1028712	30	1337	0	28	40	\N	\N
1028713	23	1337	0	28	41	\N	\N
1028714	34	1337	0	28	42	\N	\N
1028715	0	1337	0	28	43	\N	\N
1028716	0	1337	0	28	44	\N	\N
1028717	0	1337	0	28	45	\N	\N
1028718	0	1337	0	28	46	\N	\N
1028719	0	1337	0	28	47	\N	\N
1028720	0	1337	0	28	48	\N	\N
1028721	0	1337	0	28	49	\N	\N
1028722	0	1337	0	28	50	\N	\N
1028723	0	1337	0	28	51	\N	\N
1028724	0	1337	0	28	52	\N	\N
1028725	0	1337	0	28	53	\N	\N
1028726	0	1337	0	28	54	\N	\N
1028727	0	1337	0	28	55	\N	\N
1028728	0	1337	0	28	56	\N	\N
1028729	0	1337	0	28	57	\N	\N
1028730	0	1337	0	28	58	\N	\N
1028731	0	1337	0	28	59	\N	\N
1028732	0	1337	0	29	-20	\N	\N
1028733	0	1337	0	29	-19	\N	\N
1028734	0	1337	0	29	-18	\N	\N
1028735	0	1337	0	29	-17	\N	\N
1028736	0	1337	0	29	-16	\N	\N
1028737	0	1337	0	29	-15	\N	\N
1028738	0	1337	0	29	-14	\N	\N
1028739	0	1337	0	29	-13	\N	\N
1028740	0	1337	0	29	-12	\N	\N
1028741	0	1337	0	29	-11	\N	\N
1028742	0	1337	0	29	-10	\N	\N
1028743	0	1337	0	29	-9	\N	\N
1028744	0	1337	0	29	-8	\N	\N
1028745	0	1337	0	29	-7	\N	\N
1028746	0	1337	0	29	-6	\N	\N
1028747	0	1337	0	29	-5	\N	\N
1028748	0	1337	0	29	-4	\N	\N
1028749	0	1337	0	29	-3	\N	\N
1028750	0	1337	0	29	-2	\N	\N
1028751	0	1337	0	29	-1	\N	\N
1028752	0	1337	0	29	0	\N	\N
1028753	0	1337	0	29	1	\N	\N
1028754	0	1337	0	29	2	\N	\N
1028755	0	1337	0	29	3	\N	\N
1028756	0	1337	0	29	4	\N	\N
1028757	0	1337	0	29	5	\N	\N
1028758	0	1337	0	29	6	\N	\N
1028759	0	1337	0	29	7	\N	\N
1028760	8	1337	0	29	8	\N	\N
1028761	30	1337	0	29	9	\N	\N
1028762	29	1337	0	29	10	\N	\N
1028763	9	1337	0	29	11	\N	\N
1028764	46	1337	0	29	12	\N	\N
1028765	41	1337	0	29	13	\N	\N
1028766	42	1337	0	29	14	\N	\N
1028767	31	1337	0	29	15	\N	\N
1028768	40	1337	0	29	16	\N	\N
1028769	17	1337	0	29	17	\N	\N
1028770	24	1337	0	29	18	\N	\N
1028771	38	1337	0	29	19	\N	\N
1028772	18	1337	0	29	20	\N	\N
1028773	17	1337	0	29	21	\N	\N
1028774	5	1337	0	29	22	\N	\N
1028775	15	1337	0	29	23	\N	\N
1028776	33	1337	0	29	24	\N	\N
1028777	9	1337	0	29	25	\N	\N
1028778	32	1337	0	29	26	\N	\N
1028779	40	1337	0	29	27	\N	\N
1028780	5	1337	0	29	28	\N	\N
1028781	20	1337	0	29	29	\N	\N
1028782	19	1337	0	29	30	\N	\N
1028783	3	1337	0	29	31	\N	\N
1028784	19	1337	0	29	32	\N	\N
1028785	7	1337	0	29	33	\N	\N
1028786	38	1337	0	29	34	\N	\N
1028787	18	1337	0	29	35	\N	\N
1028788	25	1337	0	29	36	\N	\N
1028789	37	1337	0	29	37	\N	\N
1028790	7	1337	0	29	38	\N	\N
1028791	34	1337	0	29	39	\N	\N
1028792	42	1337	0	29	40	\N	\N
1028793	6	1337	0	29	41	\N	\N
1028794	12	1337	0	29	42	\N	\N
1028795	0	1337	0	29	43	\N	\N
1028796	0	1337	0	29	44	\N	\N
1028797	0	1337	0	29	45	\N	\N
1028798	0	1337	0	29	46	\N	\N
1028799	0	1337	0	29	47	\N	\N
1028800	0	1337	0	29	48	\N	\N
1028801	0	1337	0	29	49	\N	\N
1028802	0	1337	0	29	50	\N	\N
1028803	0	1337	0	29	51	\N	\N
1028804	0	1337	0	29	52	\N	\N
1028805	0	1337	0	29	53	\N	\N
1028806	0	1337	0	29	54	\N	\N
1028807	0	1337	0	29	55	\N	\N
1028808	0	1337	0	29	56	\N	\N
1028809	0	1337	0	29	57	\N	\N
1028810	0	1337	0	29	58	\N	\N
1028811	0	1337	0	29	59	\N	\N
1028812	0	1337	0	30	-20	\N	\N
1028813	0	1337	0	30	-19	\N	\N
1028814	0	1337	0	30	-18	\N	\N
1028815	0	1337	0	30	-17	\N	\N
1028816	0	1337	0	30	-16	\N	\N
1028817	0	1337	0	30	-15	\N	\N
1028818	0	1337	0	30	-14	\N	\N
1028819	0	1337	0	30	-13	\N	\N
1028820	0	1337	0	30	-12	\N	\N
1028821	0	1337	0	30	-11	\N	\N
1028822	0	1337	0	30	-10	\N	\N
1028823	0	1337	0	30	-9	\N	\N
1028824	0	1337	0	30	-8	\N	\N
1028825	0	1337	0	30	-7	\N	\N
1028826	0	1337	0	30	-6	\N	\N
1028827	0	1337	0	30	-5	\N	\N
1028828	0	1337	0	30	-4	\N	\N
1028829	0	1337	0	30	-3	\N	\N
1028830	0	1337	0	30	-2	\N	\N
1028831	0	1337	0	30	-1	\N	\N
1028832	0	1337	0	30	0	\N	\N
1028833	0	1337	0	30	1	\N	\N
1028834	0	1337	0	30	2	\N	\N
1028835	0	1337	0	30	3	\N	\N
1028836	0	1337	0	30	4	\N	\N
1028837	0	1337	0	30	5	\N	\N
1028838	0	1337	0	30	6	\N	\N
1028839	0	1337	0	30	7	\N	\N
1028840	36	1337	0	30	8	\N	\N
1028841	49	1337	0	30	9	\N	\N
1028842	3	1337	0	30	10	\N	\N
1028843	22	1337	0	30	11	\N	\N
1028844	27	1337	0	30	12	\N	\N
1028845	16	1337	0	30	13	\N	\N
1028846	28	1337	0	30	14	\N	\N
1028847	38	1337	0	30	15	\N	\N
1028848	3	1337	0	30	16	\N	\N
1028849	18	1337	0	30	17	\N	\N
1028850	8	1337	0	30	18	\N	\N
1028851	53	1337	0	30	19	\N	\N
1028852	26	1337	0	30	20	\N	\N
1028853	32	1337	0	30	21	\N	\N
1028854	45	1337	0	30	22	\N	\N
1028855	6	1337	0	30	23	\N	\N
1028856	45	1337	0	30	24	\N	\N
1028857	3	1337	0	30	25	\N	\N
1028858	28	1337	0	30	26	\N	\N
1028859	9	1337	0	30	27	\N	\N
1028860	42	1337	0	30	28	\N	\N
1028861	11	1337	0	30	29	\N	\N
1028862	32	1337	0	30	30	\N	\N
1028863	38	1337	0	30	31	\N	\N
1028864	43	1337	0	30	32	\N	\N
1028865	19	1337	0	30	33	\N	\N
1028866	2	1337	0	30	34	\N	\N
1028867	16	1337	0	30	35	\N	\N
1028868	19	1337	0	30	36	\N	\N
1028869	8	1337	0	30	37	\N	\N
1028870	22	1337	0	30	38	\N	\N
1028871	16	1337	0	30	39	\N	\N
1028872	31	1337	0	30	40	\N	\N
1028873	52	1337	0	30	41	\N	\N
1028874	18	1337	0	30	42	\N	\N
1028875	0	1337	0	30	43	\N	\N
1028876	0	1337	0	30	44	\N	\N
1028877	0	1337	0	30	45	\N	\N
1028878	0	1337	0	30	46	\N	\N
1028879	0	1337	0	30	47	\N	\N
1028880	0	1337	0	30	48	\N	\N
1028881	0	1337	0	30	49	\N	\N
1028882	0	1337	0	30	50	\N	\N
1028883	0	1337	0	30	51	\N	\N
1028884	0	1337	0	30	52	\N	\N
1028885	0	1337	0	30	53	\N	\N
1028886	0	1337	0	30	54	\N	\N
1028887	0	1337	0	30	55	\N	\N
1028888	0	1337	0	30	56	\N	\N
1028889	0	1337	0	30	57	\N	\N
1028890	0	1337	0	30	58	\N	\N
1028891	0	1337	0	30	59	\N	\N
1028892	0	1337	0	31	-20	\N	\N
1028893	0	1337	0	31	-19	\N	\N
1028894	0	1337	0	31	-18	\N	\N
1028895	0	1337	0	31	-17	\N	\N
1028896	0	1337	0	31	-16	\N	\N
1028897	0	1337	0	31	-15	\N	\N
1028898	0	1337	0	31	-14	\N	\N
1028899	0	1337	0	31	-13	\N	\N
1028900	0	1337	0	31	-12	\N	\N
1028901	0	1337	0	31	-11	\N	\N
1028902	0	1337	0	31	-10	\N	\N
1028903	0	1337	0	31	-9	\N	\N
1028904	0	1337	0	31	-8	\N	\N
1028905	0	1337	0	31	-7	\N	\N
1028906	0	1337	0	31	-6	\N	\N
1028907	0	1337	0	31	-5	\N	\N
1028908	0	1337	0	31	-4	\N	\N
1028909	0	1337	0	31	-3	\N	\N
1028910	0	1337	0	31	-2	\N	\N
1028911	0	1337	0	31	-1	\N	\N
1028912	0	1337	0	31	0	\N	\N
1028913	0	1337	0	31	1	\N	\N
1028914	0	1337	0	31	2	\N	\N
1028915	0	1337	0	31	3	\N	\N
1028916	0	1337	0	31	4	\N	\N
1028917	0	1337	0	31	5	\N	\N
1028918	0	1337	0	31	6	\N	\N
1028919	0	1337	0	31	7	\N	\N
1028920	0	1337	0	31	8	\N	\N
1028921	48	1337	0	31	9	\N	\N
1028922	51	1337	0	31	10	\N	\N
1028923	32	1337	0	31	11	\N	\N
1028924	35	1337	0	31	12	\N	\N
1028925	23	1337	0	31	13	\N	\N
1028926	40	1337	0	31	14	\N	\N
1028927	48	1337	0	31	15	\N	\N
1028928	43	1337	0	31	16	\N	\N
1028929	21	1337	0	31	17	\N	\N
1028930	23	1337	0	31	18	\N	\N
1028931	7	1337	0	31	19	\N	\N
1028932	39	1337	0	31	20	\N	\N
1028933	16	1337	0	31	21	\N	\N
1028934	53	1337	0	31	22	\N	\N
1028935	38	1337	0	31	23	\N	\N
1028936	18	1337	0	31	24	\N	\N
1028937	32	1337	0	31	25	\N	\N
1028938	33	1337	0	31	26	\N	\N
1028939	52	1337	0	31	27	\N	\N
1028940	32	1337	0	31	28	\N	\N
1028941	11	1337	0	31	29	\N	\N
1028942	36	1337	0	31	30	\N	\N
1028943	49	1337	0	31	31	\N	\N
1028944	53	1337	0	31	32	\N	\N
1028945	40	1337	0	31	33	\N	\N
1028946	27	1337	0	31	34	\N	\N
1028947	42	1337	0	31	35	\N	\N
1028948	12	1337	0	31	36	\N	\N
1028949	21	1337	0	31	37	\N	\N
1028950	36	1337	0	31	38	\N	\N
1028951	15	1337	0	31	39	\N	\N
1028952	49	1337	0	31	40	\N	\N
1028953	21	1337	0	31	41	\N	\N
1028954	0	1337	0	31	42	\N	\N
1028955	0	1337	0	31	43	\N	\N
1028956	0	1337	0	31	44	\N	\N
1028957	0	1337	0	31	45	\N	\N
1028958	0	1337	0	31	46	\N	\N
1028959	0	1337	0	31	47	\N	\N
1028960	0	1337	0	31	48	\N	\N
1028961	0	1337	0	31	49	\N	\N
1028962	0	1337	0	31	50	\N	\N
1028963	0	1337	0	31	51	\N	\N
1028964	0	1337	0	31	52	\N	\N
1028965	0	1337	0	31	53	\N	\N
1028966	0	1337	0	31	54	\N	\N
1028967	0	1337	0	31	55	\N	\N
1028968	0	1337	0	31	56	\N	\N
1028969	0	1337	0	31	57	\N	\N
1028970	0	1337	0	31	58	\N	\N
1028971	0	1337	0	31	59	\N	\N
1028972	0	1337	0	32	-20	\N	\N
1028973	0	1337	0	32	-19	\N	\N
1028974	0	1337	0	32	-18	\N	\N
1028975	0	1337	0	32	-17	\N	\N
1028976	0	1337	0	32	-16	\N	\N
1028977	0	1337	0	32	-15	\N	\N
1028978	0	1337	0	32	-14	\N	\N
1028979	0	1337	0	32	-13	\N	\N
1028980	0	1337	0	32	-12	\N	\N
1028981	0	1337	0	32	-11	\N	\N
1028982	0	1337	0	32	-10	\N	\N
1028983	0	1337	0	32	-9	\N	\N
1028984	0	1337	0	32	-8	\N	\N
1028985	0	1337	0	32	-7	\N	\N
1028986	0	1337	0	32	-6	\N	\N
1028987	0	1337	0	32	-5	\N	\N
1028988	0	1337	0	32	-4	\N	\N
1028989	0	1337	0	32	-3	\N	\N
1028990	0	1337	0	32	-2	\N	\N
1028991	0	1337	0	32	-1	\N	\N
1028992	0	1337	0	32	0	\N	\N
1028993	0	1337	0	32	1	\N	\N
1028994	0	1337	0	32	2	\N	\N
1028995	0	1337	0	32	3	\N	\N
1028996	0	1337	0	32	4	\N	\N
1028997	0	1337	0	32	5	\N	\N
1028998	0	1337	0	32	6	\N	\N
1028999	0	1337	0	32	7	\N	\N
1029000	0	1337	0	32	8	\N	\N
1029001	38	1337	0	32	9	\N	\N
1029002	10	1337	0	32	10	\N	\N
1029003	15	1337	0	32	11	\N	\N
1029004	4	1337	0	32	12	\N	\N
1029005	12	1337	0	32	13	\N	\N
1029006	4	1337	0	32	14	\N	\N
1029007	8	1337	0	32	15	\N	\N
1029008	10	1337	0	32	16	\N	\N
1029009	24	1337	0	32	17	\N	\N
1029010	39	1337	0	32	18	\N	\N
1029011	15	1337	0	32	19	\N	\N
1029012	4	1337	0	32	20	\N	\N
1029013	4	1337	0	32	21	\N	\N
1029014	51	1337	0	32	22	\N	\N
1029015	29	1337	0	32	23	\N	\N
1029016	1	1337	0	32	24	\N	\N
1029017	20	1337	0	32	25	\N	\N
1029018	53	1337	0	32	26	\N	\N
1029019	21	1337	0	32	27	\N	\N
1029020	34	1337	0	32	28	\N	\N
1029021	44	1337	0	32	29	\N	\N
1029022	23	1337	0	32	30	\N	\N
1029023	42	1337	0	32	31	\N	\N
1029024	27	1337	0	32	32	\N	\N
1029025	34	1337	0	32	33	\N	\N
1029026	4	1337	0	32	34	\N	\N
1029027	43	1337	0	32	35	\N	\N
1029028	23	1337	0	32	36	\N	\N
1029029	29	1337	0	32	37	\N	\N
1029030	25	1337	0	32	38	\N	\N
1029031	41	1337	0	32	39	\N	\N
1029032	39	1337	0	32	40	\N	\N
1029033	13	1337	0	32	41	\N	\N
1029034	0	1337	0	32	42	\N	\N
1029035	0	1337	0	32	43	\N	\N
1029036	0	1337	0	32	44	\N	\N
1029037	0	1337	0	32	45	\N	\N
1029038	0	1337	0	32	46	\N	\N
1029039	0	1337	0	32	47	\N	\N
1029040	0	1337	0	32	48	\N	\N
1029041	0	1337	0	32	49	\N	\N
1029042	0	1337	0	32	50	\N	\N
1029043	0	1337	0	32	51	\N	\N
1029044	0	1337	0	32	52	\N	\N
1029045	0	1337	0	32	53	\N	\N
1029046	0	1337	0	32	54	\N	\N
1029047	0	1337	0	32	55	\N	\N
1029048	0	1337	0	32	56	\N	\N
1029049	0	1337	0	32	57	\N	\N
1029050	0	1337	0	32	58	\N	\N
1029051	0	1337	0	32	59	\N	\N
1029052	0	1337	0	33	-20	\N	\N
1029053	0	1337	0	33	-19	\N	\N
1029054	0	1337	0	33	-18	\N	\N
1029055	0	1337	0	33	-17	\N	\N
1029056	0	1337	0	33	-16	\N	\N
1029057	0	1337	0	33	-15	\N	\N
1029058	0	1337	0	33	-14	\N	\N
1029059	0	1337	0	33	-13	\N	\N
1029060	0	1337	0	33	-12	\N	\N
1029061	0	1337	0	33	-11	\N	\N
1029062	0	1337	0	33	-10	\N	\N
1029063	0	1337	0	33	-9	\N	\N
1029064	0	1337	0	33	-8	\N	\N
1029065	0	1337	0	33	-7	\N	\N
1029066	0	1337	0	33	-6	\N	\N
1029067	0	1337	0	33	-5	\N	\N
1029068	0	1337	0	33	-4	\N	\N
1029069	0	1337	0	33	-3	\N	\N
1029070	0	1337	0	33	-2	\N	\N
1029071	0	1337	0	33	-1	\N	\N
1029072	0	1337	0	33	0	\N	\N
1029073	0	1337	0	33	1	\N	\N
1029074	0	1337	0	33	2	\N	\N
1029075	0	1337	0	33	3	\N	\N
1029076	0	1337	0	33	4	\N	\N
1029077	0	1337	0	33	5	\N	\N
1029078	0	1337	0	33	6	\N	\N
1029079	0	1337	0	33	7	\N	\N
1029080	0	1337	0	33	8	\N	\N
1029081	19	1337	0	33	9	\N	\N
1029082	11	1337	0	33	10	\N	\N
1029083	20	1337	0	33	11	\N	\N
1029084	11	1337	0	33	12	\N	\N
1029085	42	1337	0	33	13	\N	\N
1029086	43	1337	0	33	14	\N	\N
1029087	4	1337	0	33	15	\N	\N
1029088	49	1337	0	33	16	\N	\N
1029089	12	1337	0	33	17	\N	\N
1029090	20	1337	0	33	18	\N	\N
1029091	27	1337	0	33	19	\N	\N
1029092	29	1337	0	33	20	\N	\N
1029093	25	1337	0	33	21	\N	\N
1029094	14	1337	0	33	22	\N	\N
1029095	18	1337	0	33	23	\N	\N
1029096	4	1337	0	33	24	\N	\N
1029097	10	1337	0	33	25	\N	\N
1029098	25	1337	0	33	26	\N	\N
1029099	15	1337	0	33	27	\N	\N
1029100	46	1337	0	33	28	\N	\N
1029101	35	1337	0	33	29	\N	\N
1029102	39	1337	0	33	30	\N	\N
1029103	39	1337	0	33	31	\N	\N
1029104	44	1337	0	33	32	\N	\N
1029105	12	1337	0	33	33	\N	\N
1029106	33	1337	0	33	34	\N	\N
1029107	28	1337	0	33	35	\N	\N
1029108	47	1337	0	33	36	\N	\N
1029109	33	1337	0	33	37	\N	\N
1029110	53	1337	0	33	38	\N	\N
1029111	12	1337	0	33	39	\N	\N
1029112	14	1337	0	33	40	\N	\N
1029113	38	1337	0	33	41	\N	\N
1029114	0	1337	0	33	42	\N	\N
1029115	0	1337	0	33	43	\N	\N
1029116	0	1337	0	33	44	\N	\N
1029117	0	1337	0	33	45	\N	\N
1029118	0	1337	0	33	46	\N	\N
1029119	0	1337	0	33	47	\N	\N
1029120	0	1337	0	33	48	\N	\N
1029121	0	1337	0	33	49	\N	\N
1029122	0	1337	0	33	50	\N	\N
1029123	0	1337	0	33	51	\N	\N
1029124	0	1337	0	33	52	\N	\N
1029125	0	1337	0	33	53	\N	\N
1029126	0	1337	0	33	54	\N	\N
1029127	0	1337	0	33	55	\N	\N
1029128	0	1337	0	33	56	\N	\N
1029129	0	1337	0	33	57	\N	\N
1029130	0	1337	0	33	58	\N	\N
1029131	0	1337	0	33	59	\N	\N
1029132	0	1337	0	34	-20	\N	\N
1029133	0	1337	0	34	-19	\N	\N
1029134	0	1337	0	34	-18	\N	\N
1029135	0	1337	0	34	-17	\N	\N
1029136	0	1337	0	34	-16	\N	\N
1029137	0	1337	0	34	-15	\N	\N
1029138	0	1337	0	34	-14	\N	\N
1029139	0	1337	0	34	-13	\N	\N
1029140	0	1337	0	34	-12	\N	\N
1029141	0	1337	0	34	-11	\N	\N
1029142	0	1337	0	34	-10	\N	\N
1029143	0	1337	0	34	-9	\N	\N
1029144	0	1337	0	34	-8	\N	\N
1029145	0	1337	0	34	-7	\N	\N
1029146	0	1337	0	34	-6	\N	\N
1029147	0	1337	0	34	-5	\N	\N
1029148	0	1337	0	34	-4	\N	\N
1029149	0	1337	0	34	-3	\N	\N
1029150	0	1337	0	34	-2	\N	\N
1029151	0	1337	0	34	-1	\N	\N
1029152	0	1337	0	34	0	\N	\N
1029153	0	1337	0	34	1	\N	\N
1029154	0	1337	0	34	2	\N	\N
1029155	0	1337	0	34	3	\N	\N
1029156	0	1337	0	34	4	\N	\N
1029157	0	1337	0	34	5	\N	\N
1029158	0	1337	0	34	6	\N	\N
1029159	0	1337	0	34	7	\N	\N
1029160	0	1337	0	34	8	\N	\N
1029161	0	1337	0	34	9	\N	\N
1029162	23	1337	0	34	10	\N	\N
1029163	4	1337	0	34	11	\N	\N
1029164	46	1337	0	34	12	\N	\N
1029165	33	1337	0	34	13	\N	\N
1029166	46	1337	0	34	14	\N	\N
1029167	34	1337	0	34	15	\N	\N
1029168	30	1337	0	34	16	\N	\N
1029169	5	1337	0	34	17	\N	\N
1029170	5	1337	0	34	18	\N	\N
1029171	26	1337	0	34	19	\N	\N
1029172	6	1337	0	34	20	\N	\N
1029173	41	1337	0	34	21	\N	\N
1029174	32	1337	0	34	22	\N	\N
1029175	21	1337	0	34	23	\N	\N
1029176	36	1337	0	34	24	\N	\N
1029177	39	1337	0	34	25	\N	\N
1029178	21	1337	0	34	26	\N	\N
1029179	30	1337	0	34	27	\N	\N
1029180	24	1337	0	34	28	\N	\N
1029181	26	1337	0	34	29	\N	\N
1029182	46	1337	0	34	30	\N	\N
1029183	29	1337	0	34	31	\N	\N
1029184	42	1337	0	34	32	\N	\N
1029185	30	1337	0	34	33	\N	\N
1029186	7	1337	0	34	34	\N	\N
1029187	4	1337	0	34	35	\N	\N
1029188	10	1337	0	34	36	\N	\N
1029189	9	1337	0	34	37	\N	\N
1029190	13	1337	0	34	38	\N	\N
1029191	4	1337	0	34	39	\N	\N
1029192	41	1337	0	34	40	\N	\N
1029193	0	1337	0	34	41	\N	\N
1029194	0	1337	0	34	42	\N	\N
1029195	0	1337	0	34	43	\N	\N
1029196	0	1337	0	34	44	\N	\N
1029197	0	1337	0	34	45	\N	\N
1029198	0	1337	0	34	46	\N	\N
1029199	0	1337	0	34	47	\N	\N
1029200	0	1337	0	34	48	\N	\N
1029201	0	1337	0	34	49	\N	\N
1029202	0	1337	0	34	50	\N	\N
1029203	0	1337	0	34	51	\N	\N
1029204	0	1337	0	34	52	\N	\N
1029205	0	1337	0	34	53	\N	\N
1029206	0	1337	0	34	54	\N	\N
1029207	0	1337	0	34	55	\N	\N
1029208	0	1337	0	34	56	\N	\N
1029209	0	1337	0	34	57	\N	\N
1029210	0	1337	0	34	58	\N	\N
1029211	0	1337	0	34	59	\N	\N
1029212	0	1337	0	35	-20	\N	\N
1029213	0	1337	0	35	-19	\N	\N
1029214	0	1337	0	35	-18	\N	\N
1029215	0	1337	0	35	-17	\N	\N
1029216	0	1337	0	35	-16	\N	\N
1029217	0	1337	0	35	-15	\N	\N
1029218	0	1337	0	35	-14	\N	\N
1029219	0	1337	0	35	-13	\N	\N
1029220	0	1337	0	35	-12	\N	\N
1029221	0	1337	0	35	-11	\N	\N
1029222	0	1337	0	35	-10	\N	\N
1029223	0	1337	0	35	-9	\N	\N
1029224	0	1337	0	35	-8	\N	\N
1029225	0	1337	0	35	-7	\N	\N
1029226	0	1337	0	35	-6	\N	\N
1029227	0	1337	0	35	-5	\N	\N
1029228	0	1337	0	35	-4	\N	\N
1029229	0	1337	0	35	-3	\N	\N
1029230	0	1337	0	35	-2	\N	\N
1029231	0	1337	0	35	-1	\N	\N
1029232	0	1337	0	35	0	\N	\N
1029233	0	1337	0	35	1	\N	\N
1029234	0	1337	0	35	2	\N	\N
1029235	0	1337	0	35	3	\N	\N
1029236	0	1337	0	35	4	\N	\N
1029237	0	1337	0	35	5	\N	\N
1029238	0	1337	0	35	6	\N	\N
1029239	0	1337	0	35	7	\N	\N
1029240	0	1337	0	35	8	\N	\N
1029241	0	1337	0	35	9	\N	\N
1029242	0	1337	0	35	10	\N	\N
1029243	8	1337	0	35	11	\N	\N
1029244	37	1337	0	35	12	\N	\N
1029245	7	1337	0	35	13	\N	\N
1029246	33	1337	0	35	14	\N	\N
1029247	4	1337	0	35	15	\N	\N
1029248	30	1337	0	35	16	\N	\N
1029249	37	1337	0	35	17	\N	\N
1029250	39	1337	0	35	18	\N	\N
1029251	32	1337	0	35	19	\N	\N
1029252	49	1337	0	35	20	\N	\N
1029253	5	1337	0	35	21	\N	\N
1029254	25	1337	0	35	22	\N	\N
1029255	7	1337	0	35	23	\N	\N
1029256	1	1337	0	35	24	\N	\N
1029257	18	1337	0	35	25	\N	\N
1029258	5	1337	0	35	26	\N	\N
1029259	19	1337	0	35	27	\N	\N
1029260	45	1337	0	35	28	\N	\N
1029261	52	1337	0	35	29	\N	\N
1029262	37	1337	0	35	30	\N	\N
1029263	33	1337	0	35	31	\N	\N
1029264	44	1337	0	35	32	\N	\N
1029265	23	1337	0	35	33	\N	\N
1029266	29	1337	0	35	34	\N	\N
1029267	25	1337	0	35	35	\N	\N
1029268	51	1337	0	35	36	\N	\N
1029269	19	1337	0	35	37	\N	\N
1029270	28	1337	0	35	38	\N	\N
1029271	22	1337	0	35	39	\N	\N
1029272	0	1337	0	35	40	\N	\N
1029273	0	1337	0	35	41	\N	\N
1029274	0	1337	0	35	42	\N	\N
1029275	0	1337	0	35	43	\N	\N
1029276	0	1337	0	35	44	\N	\N
1029277	0	1337	0	35	45	\N	\N
1029278	0	1337	0	35	46	\N	\N
1029279	0	1337	0	35	47	\N	\N
1029280	0	1337	0	35	48	\N	\N
1029281	0	1337	0	35	49	\N	\N
1029282	0	1337	0	35	50	\N	\N
1029283	0	1337	0	35	51	\N	\N
1029284	0	1337	0	35	52	\N	\N
1029285	0	1337	0	35	53	\N	\N
1029286	0	1337	0	35	54	\N	\N
1029287	0	1337	0	35	55	\N	\N
1029288	0	1337	0	35	56	\N	\N
1029289	0	1337	0	35	57	\N	\N
1029290	0	1337	0	35	58	\N	\N
1029291	0	1337	0	35	59	\N	\N
1029292	0	1337	0	36	-20	\N	\N
1029293	0	1337	0	36	-19	\N	\N
1029294	0	1337	0	36	-18	\N	\N
1029295	0	1337	0	36	-17	\N	\N
1029296	0	1337	0	36	-16	\N	\N
1029297	0	1337	0	36	-15	\N	\N
1029298	0	1337	0	36	-14	\N	\N
1029299	0	1337	0	36	-13	\N	\N
1029300	0	1337	0	36	-12	\N	\N
1029301	0	1337	0	36	-11	\N	\N
1029302	0	1337	0	36	-10	\N	\N
1029303	0	1337	0	36	-9	\N	\N
1029304	0	1337	0	36	-8	\N	\N
1029305	0	1337	0	36	-7	\N	\N
1029306	0	1337	0	36	-6	\N	\N
1029307	0	1337	0	36	-5	\N	\N
1029308	0	1337	0	36	-4	\N	\N
1029309	0	1337	0	36	-3	\N	\N
1029310	0	1337	0	36	-2	\N	\N
1029311	0	1337	0	36	-1	\N	\N
1029312	0	1337	0	36	0	\N	\N
1029313	0	1337	0	36	1	\N	\N
1029314	0	1337	0	36	2	\N	\N
1029315	0	1337	0	36	3	\N	\N
1029316	0	1337	0	36	4	\N	\N
1029317	0	1337	0	36	5	\N	\N
1029318	0	1337	0	36	6	\N	\N
1029319	0	1337	0	36	7	\N	\N
1029320	0	1337	0	36	8	\N	\N
1029321	0	1337	0	36	9	\N	\N
1029322	0	1337	0	36	10	\N	\N
1029323	13	1337	0	36	11	\N	\N
1029324	1	1337	0	36	12	\N	\N
1029325	17	1337	0	36	13	\N	\N
1029326	46	1337	0	36	14	\N	\N
1029327	23	1337	0	36	15	\N	\N
1029328	33	1337	0	36	16	\N	\N
1029329	47	1337	0	36	17	\N	\N
1029330	11	1337	0	36	18	\N	\N
1029331	30	1337	0	36	19	\N	\N
1029332	16	1337	0	36	20	\N	\N
1029333	45	1337	0	36	21	\N	\N
1029334	36	1337	0	36	22	\N	\N
1029335	24	1337	0	36	23	\N	\N
1029336	16	1337	0	36	24	\N	\N
1029337	19	1337	0	36	25	\N	\N
1029338	40	1337	0	36	26	\N	\N
1029339	28	1337	0	36	27	\N	\N
1029340	42	1337	0	36	28	\N	\N
1029341	5	1337	0	36	29	\N	\N
1029342	32	1337	0	36	30	\N	\N
1029343	31	1337	0	36	31	\N	\N
1029344	19	1337	0	36	32	\N	\N
1029345	52	1337	0	36	33	\N	\N
1029346	23	1337	0	36	34	\N	\N
1029347	28	1337	0	36	35	\N	\N
1029348	8	1337	0	36	36	\N	\N
1029349	40	1337	0	36	37	\N	\N
1029350	12	1337	0	36	38	\N	\N
1029351	11	1337	0	36	39	\N	\N
1029352	0	1337	0	36	40	\N	\N
1029353	0	1337	0	36	41	\N	\N
1029354	0	1337	0	36	42	\N	\N
1029355	0	1337	0	36	43	\N	\N
1029356	0	1337	0	36	44	\N	\N
1029357	0	1337	0	36	45	\N	\N
1029358	0	1337	0	36	46	\N	\N
1029359	0	1337	0	36	47	\N	\N
1029360	0	1337	0	36	48	\N	\N
1029361	0	1337	0	36	49	\N	\N
1029362	0	1337	0	36	50	\N	\N
1029363	0	1337	0	36	51	\N	\N
1029364	0	1337	0	36	52	\N	\N
1029365	0	1337	0	36	53	\N	\N
1029366	0	1337	0	36	54	\N	\N
1029367	0	1337	0	36	55	\N	\N
1029368	0	1337	0	36	56	\N	\N
1029369	0	1337	0	36	57	\N	\N
1029370	0	1337	0	36	58	\N	\N
1029371	0	1337	0	36	59	\N	\N
1029372	0	1337	0	37	-20	\N	\N
1029373	0	1337	0	37	-19	\N	\N
1029374	0	1337	0	37	-18	\N	\N
1029375	0	1337	0	37	-17	\N	\N
1029376	0	1337	0	37	-16	\N	\N
1029377	0	1337	0	37	-15	\N	\N
1029378	0	1337	0	37	-14	\N	\N
1029379	0	1337	0	37	-13	\N	\N
1029380	0	1337	0	37	-12	\N	\N
1029381	0	1337	0	37	-11	\N	\N
1029382	0	1337	0	37	-10	\N	\N
1029383	0	1337	0	37	-9	\N	\N
1029384	0	1337	0	37	-8	\N	\N
1029385	0	1337	0	37	-7	\N	\N
1029386	0	1337	0	37	-6	\N	\N
1029387	0	1337	0	37	-5	\N	\N
1029388	0	1337	0	37	-4	\N	\N
1029389	0	1337	0	37	-3	\N	\N
1029390	0	1337	0	37	-2	\N	\N
1029391	0	1337	0	37	-1	\N	\N
1029392	0	1337	0	37	0	\N	\N
1029393	0	1337	0	37	1	\N	\N
1029394	0	1337	0	37	2	\N	\N
1029395	0	1337	0	37	3	\N	\N
1029396	0	1337	0	37	4	\N	\N
1029397	0	1337	0	37	5	\N	\N
1029398	0	1337	0	37	6	\N	\N
1029399	0	1337	0	37	7	\N	\N
1029400	0	1337	0	37	8	\N	\N
1029401	0	1337	0	37	9	\N	\N
1029402	0	1337	0	37	10	\N	\N
1029403	0	1337	0	37	11	\N	\N
1029404	3	1337	0	37	12	\N	\N
1029405	30	1337	0	37	13	\N	\N
1029406	25	1337	0	37	14	\N	\N
1029407	48	1337	0	37	15	\N	\N
1029408	38	1337	0	37	16	\N	\N
1029409	24	1337	0	37	17	\N	\N
1029410	33	1337	0	37	18	\N	\N
1029411	16	1337	0	37	19	\N	\N
1029412	28	1337	0	37	20	\N	\N
1029413	26	1337	0	37	21	\N	\N
1029414	40	1337	0	37	22	\N	\N
1029415	35	1337	0	37	23	\N	\N
1029416	28	1337	0	37	24	\N	\N
1029417	1	1337	0	37	25	\N	\N
1029418	6	1337	0	37	26	\N	\N
1029419	41	1337	0	37	27	\N	\N
1029420	28	1337	0	37	28	\N	\N
1029421	12	1337	0	37	29	\N	\N
1029422	41	1337	0	37	30	\N	\N
1029423	37	1337	0	37	31	\N	\N
1029424	7	1337	0	37	32	\N	\N
1029425	12	1337	0	37	33	\N	\N
1029426	19	1337	0	37	34	\N	\N
1029427	41	1337	0	37	35	\N	\N
1029428	8	1337	0	37	36	\N	\N
1029429	22	1337	0	37	37	\N	\N
1029430	15	1337	0	37	38	\N	\N
1029431	0	1337	0	37	39	\N	\N
1029432	0	1337	0	37	40	\N	\N
1029433	0	1337	0	37	41	\N	\N
1029434	0	1337	0	37	42	\N	\N
1029435	0	1337	0	37	43	\N	\N
1029436	0	1337	0	37	44	\N	\N
1029437	0	1337	0	37	45	\N	\N
1029438	0	1337	0	37	46	\N	\N
1029439	0	1337	0	37	47	\N	\N
1029440	0	1337	0	37	48	\N	\N
1029441	0	1337	0	37	49	\N	\N
1029442	0	1337	0	37	50	\N	\N
1029443	0	1337	0	37	51	\N	\N
1029444	0	1337	0	37	52	\N	\N
1029445	0	1337	0	37	53	\N	\N
1029446	0	1337	0	37	54	\N	\N
1029447	0	1337	0	37	55	\N	\N
1029448	0	1337	0	37	56	\N	\N
1029449	0	1337	0	37	57	\N	\N
1029450	0	1337	0	37	58	\N	\N
1029451	0	1337	0	37	59	\N	\N
1029452	0	1337	0	38	-20	\N	\N
1029453	0	1337	0	38	-19	\N	\N
1029454	0	1337	0	38	-18	\N	\N
1029455	0	1337	0	38	-17	\N	\N
1029456	0	1337	0	38	-16	\N	\N
1029457	0	1337	0	38	-15	\N	\N
1029458	0	1337	0	38	-14	\N	\N
1029459	0	1337	0	38	-13	\N	\N
1029460	0	1337	0	38	-12	\N	\N
1029461	0	1337	0	38	-11	\N	\N
1029462	0	1337	0	38	-10	\N	\N
1029463	0	1337	0	38	-9	\N	\N
1029464	0	1337	0	38	-8	\N	\N
1029465	0	1337	0	38	-7	\N	\N
1029466	0	1337	0	38	-6	\N	\N
1029467	0	1337	0	38	-5	\N	\N
1029468	0	1337	0	38	-4	\N	\N
1029469	0	1337	0	38	-3	\N	\N
1029470	0	1337	0	38	-2	\N	\N
1029471	0	1337	0	38	-1	\N	\N
1029472	0	1337	0	38	0	\N	\N
1029473	0	1337	0	38	1	\N	\N
1029474	0	1337	0	38	2	\N	\N
1029475	0	1337	0	38	3	\N	\N
1029476	0	1337	0	38	4	\N	\N
1029477	0	1337	0	38	5	\N	\N
1029478	0	1337	0	38	6	\N	\N
1029479	0	1337	0	38	7	\N	\N
1029480	0	1337	0	38	8	\N	\N
1029481	0	1337	0	38	9	\N	\N
1029482	0	1337	0	38	10	\N	\N
1029483	0	1337	0	38	11	\N	\N
1029484	0	1337	0	38	12	\N	\N
1029485	41	1337	0	38	13	\N	\N
1029486	37	1337	0	38	14	\N	\N
1029487	9	1337	0	38	15	\N	\N
1029488	10	1337	0	38	16	\N	\N
1029489	36	1337	0	38	17	\N	\N
1029490	41	1337	0	38	18	\N	\N
1029491	18	1337	0	38	19	\N	\N
1029492	51	1337	0	38	20	\N	\N
1029493	34	1337	0	38	21	\N	\N
1029494	7	1337	0	38	22	\N	\N
1029495	52	1337	0	38	23	\N	\N
1029496	51	1337	0	38	24	\N	\N
1029497	51	1337	0	38	25	\N	\N
1029498	24	1337	0	38	26	\N	\N
1029499	20	1337	0	38	27	\N	\N
1029500	20	1337	0	38	28	\N	\N
1029501	30	1337	0	38	29	\N	\N
1029502	27	1337	0	38	30	\N	\N
1029503	16	1337	0	38	31	\N	\N
1029504	31	1337	0	38	32	\N	\N
1029505	41	1337	0	38	33	\N	\N
1029506	43	1337	0	38	34	\N	\N
1029507	26	1337	0	38	35	\N	\N
1029508	1	1337	0	38	36	\N	\N
1029509	12	1337	0	38	37	\N	\N
1029510	0	1337	0	38	38	\N	\N
1029511	0	1337	0	38	39	\N	\N
1029512	0	1337	0	38	40	\N	\N
1029513	0	1337	0	38	41	\N	\N
1029514	0	1337	0	38	42	\N	\N
1029515	0	1337	0	38	43	\N	\N
1029516	0	1337	0	38	44	\N	\N
1029517	0	1337	0	38	45	\N	\N
1029518	0	1337	0	38	46	\N	\N
1029519	0	1337	0	38	47	\N	\N
1029520	0	1337	0	38	48	\N	\N
1029521	0	1337	0	38	49	\N	\N
1029522	0	1337	0	38	50	\N	\N
1029523	0	1337	0	38	51	\N	\N
1029524	0	1337	0	38	52	\N	\N
1029525	0	1337	0	38	53	\N	\N
1029526	0	1337	0	38	54	\N	\N
1029527	0	1337	0	38	55	\N	\N
1029528	0	1337	0	38	56	\N	\N
1029529	0	1337	0	38	57	\N	\N
1029530	0	1337	0	38	58	\N	\N
1029531	0	1337	0	38	59	\N	\N
1029532	0	1337	0	39	-20	\N	\N
1029533	0	1337	0	39	-19	\N	\N
1029534	0	1337	0	39	-18	\N	\N
1029535	0	1337	0	39	-17	\N	\N
1029536	0	1337	0	39	-16	\N	\N
1029537	0	1337	0	39	-15	\N	\N
1029538	0	1337	0	39	-14	\N	\N
1029539	0	1337	0	39	-13	\N	\N
1029540	0	1337	0	39	-12	\N	\N
1029541	0	1337	0	39	-11	\N	\N
1029542	0	1337	0	39	-10	\N	\N
1029543	0	1337	0	39	-9	\N	\N
1029544	0	1337	0	39	-8	\N	\N
1029545	0	1337	0	39	-7	\N	\N
1029546	0	1337	0	39	-6	\N	\N
1029547	0	1337	0	39	-5	\N	\N
1029548	0	1337	0	39	-4	\N	\N
1029549	0	1337	0	39	-3	\N	\N
1029550	0	1337	0	39	-2	\N	\N
1029551	0	1337	0	39	-1	\N	\N
1029552	0	1337	0	39	0	\N	\N
1029553	0	1337	0	39	1	\N	\N
1029554	0	1337	0	39	2	\N	\N
1029555	0	1337	0	39	3	\N	\N
1029556	0	1337	0	39	4	\N	\N
1029557	0	1337	0	39	5	\N	\N
1029558	0	1337	0	39	6	\N	\N
1029559	0	1337	0	39	7	\N	\N
1029560	0	1337	0	39	8	\N	\N
1029561	0	1337	0	39	9	\N	\N
1029562	0	1337	0	39	10	\N	\N
1029563	0	1337	0	39	11	\N	\N
1029564	0	1337	0	39	12	\N	\N
1029565	0	1337	0	39	13	\N	\N
1029566	1	1337	0	39	14	\N	\N
1029567	51	1337	0	39	15	\N	\N
1029568	37	1337	0	39	16	\N	\N
1029569	24	1337	0	39	17	\N	\N
1029570	11	1337	0	39	18	\N	\N
1029571	6	1337	0	39	19	\N	\N
1029572	10	1337	0	39	20	\N	\N
1029573	48	1337	0	39	21	\N	\N
1029574	11	1337	0	39	22	\N	\N
1029575	20	1337	0	39	23	\N	\N
1029576	52	1337	0	39	24	\N	\N
1029577	42	1337	0	39	25	\N	\N
1029578	37	1337	0	39	26	\N	\N
1029579	46	1337	0	39	27	\N	\N
1029580	39	1337	0	39	28	\N	\N
1029581	38	1337	0	39	29	\N	\N
1029582	1	1337	0	39	30	\N	\N
1029583	1	1337	0	39	31	\N	\N
1029584	46	1337	0	39	32	\N	\N
1029585	9	1337	0	39	33	\N	\N
1029586	28	1337	0	39	34	\N	\N
1029587	18	1337	0	39	35	\N	\N
1029588	1	1337	0	39	36	\N	\N
1029589	0	1337	0	39	37	\N	\N
1029590	0	1337	0	39	38	\N	\N
1029591	0	1337	0	39	39	\N	\N
1029592	0	1337	0	39	40	\N	\N
1029593	0	1337	0	39	41	\N	\N
1029594	0	1337	0	39	42	\N	\N
1029595	0	1337	0	39	43	\N	\N
1029596	0	1337	0	39	44	\N	\N
1029597	0	1337	0	39	45	\N	\N
1029598	0	1337	0	39	46	\N	\N
1029599	0	1337	0	39	47	\N	\N
1029600	0	1337	0	39	48	\N	\N
1029601	0	1337	0	39	49	\N	\N
1029602	0	1337	0	39	50	\N	\N
1029603	0	1337	0	39	51	\N	\N
1029604	0	1337	0	39	52	\N	\N
1029605	0	1337	0	39	53	\N	\N
1029606	0	1337	0	39	54	\N	\N
1029607	0	1337	0	39	55	\N	\N
1029608	0	1337	0	39	56	\N	\N
1029609	0	1337	0	39	57	\N	\N
1029610	0	1337	0	39	58	\N	\N
1029611	0	1337	0	39	59	\N	\N
1029612	0	1337	0	40	-20	\N	\N
1029613	0	1337	0	40	-19	\N	\N
1029614	0	1337	0	40	-18	\N	\N
1029615	0	1337	0	40	-17	\N	\N
1029616	0	1337	0	40	-16	\N	\N
1029617	0	1337	0	40	-15	\N	\N
1029618	0	1337	0	40	-14	\N	\N
1029619	0	1337	0	40	-13	\N	\N
1029620	0	1337	0	40	-12	\N	\N
1029621	0	1337	0	40	-11	\N	\N
1029622	0	1337	0	40	-10	\N	\N
1029623	0	1337	0	40	-9	\N	\N
1029624	0	1337	0	40	-8	\N	\N
1029625	0	1337	0	40	-7	\N	\N
1029626	0	1337	0	40	-6	\N	\N
1029627	0	1337	0	40	-5	\N	\N
1029628	0	1337	0	40	-4	\N	\N
1029629	0	1337	0	40	-3	\N	\N
1029630	0	1337	0	40	-2	\N	\N
1029631	0	1337	0	40	-1	\N	\N
1029632	0	1337	0	40	0	\N	\N
1029633	0	1337	0	40	1	\N	\N
1029634	0	1337	0	40	2	\N	\N
1029635	0	1337	0	40	3	\N	\N
1029636	0	1337	0	40	4	\N	\N
1029637	0	1337	0	40	5	\N	\N
1029638	0	1337	0	40	6	\N	\N
1029639	0	1337	0	40	7	\N	\N
1029640	0	1337	0	40	8	\N	\N
1029641	0	1337	0	40	9	\N	\N
1029642	0	1337	0	40	10	\N	\N
1029643	0	1337	0	40	11	\N	\N
1029644	0	1337	0	40	12	\N	\N
1029645	0	1337	0	40	13	\N	\N
1029646	0	1337	0	40	14	\N	\N
1029647	0	1337	0	40	15	\N	\N
1029648	51	1337	0	40	16	\N	\N
1029649	8	1337	0	40	17	\N	\N
1029650	31	1337	0	40	18	\N	\N
1029651	9	1337	0	40	19	\N	\N
1029652	21	1337	0	40	20	\N	\N
1029653	11	1337	0	40	21	\N	\N
1029654	1	1337	0	40	22	\N	\N
1029655	30	1337	0	40	23	\N	\N
1029656	12	1337	0	40	24	\N	\N
1029657	44	1337	0	40	25	\N	\N
1029658	22	1337	0	40	26	\N	\N
1029659	40	1337	0	40	27	\N	\N
1029660	48	1337	0	40	28	\N	\N
1029661	17	1337	0	40	29	\N	\N
1029662	48	1337	0	40	30	\N	\N
1029663	52	1337	0	40	31	\N	\N
1029664	47	1337	0	40	32	\N	\N
1029665	25	1337	0	40	33	\N	\N
1029666	14	1337	0	40	34	\N	\N
1029667	0	1337	0	40	35	\N	\N
1029668	0	1337	0	40	36	\N	\N
1029669	0	1337	0	40	37	\N	\N
1029670	0	1337	0	40	38	\N	\N
1029671	0	1337	0	40	39	\N	\N
1029672	0	1337	0	40	40	\N	\N
1029673	0	1337	0	40	41	\N	\N
1029674	0	1337	0	40	42	\N	\N
1029675	0	1337	0	40	43	\N	\N
1029676	0	1337	0	40	44	\N	\N
1029677	0	1337	0	40	45	\N	\N
1029678	0	1337	0	40	46	\N	\N
1029679	0	1337	0	40	47	\N	\N
1029680	0	1337	0	40	48	\N	\N
1029681	0	1337	0	40	49	\N	\N
1029682	0	1337	0	40	50	\N	\N
1029683	0	1337	0	40	51	\N	\N
1029684	0	1337	0	40	52	\N	\N
1029685	0	1337	0	40	53	\N	\N
1029686	0	1337	0	40	54	\N	\N
1029687	0	1337	0	40	55	\N	\N
1029688	0	1337	0	40	56	\N	\N
1029689	0	1337	0	40	57	\N	\N
1029690	0	1337	0	40	58	\N	\N
1029691	0	1337	0	40	59	\N	\N
1029692	0	1337	0	41	-20	\N	\N
1029693	0	1337	0	41	-19	\N	\N
1029694	0	1337	0	41	-18	\N	\N
1029695	0	1337	0	41	-17	\N	\N
1029696	0	1337	0	41	-16	\N	\N
1029697	0	1337	0	41	-15	\N	\N
1029698	0	1337	0	41	-14	\N	\N
1029699	0	1337	0	41	-13	\N	\N
1029700	0	1337	0	41	-12	\N	\N
1029701	0	1337	0	41	-11	\N	\N
1029702	0	1337	0	41	-10	\N	\N
1029703	0	1337	0	41	-9	\N	\N
1029704	0	1337	0	41	-8	\N	\N
1029705	0	1337	0	41	-7	\N	\N
1029706	0	1337	0	41	-6	\N	\N
1029707	0	1337	0	41	-5	\N	\N
1029708	0	1337	0	41	-4	\N	\N
1029709	0	1337	0	41	-3	\N	\N
1029710	0	1337	0	41	-2	\N	\N
1029711	0	1337	0	41	-1	\N	\N
1029712	0	1337	0	41	0	\N	\N
1029713	0	1337	0	41	1	\N	\N
1029714	0	1337	0	41	2	\N	\N
1029715	0	1337	0	41	3	\N	\N
1029716	0	1337	0	41	4	\N	\N
1029717	0	1337	0	41	5	\N	\N
1029718	0	1337	0	41	6	\N	\N
1029719	0	1337	0	41	7	\N	\N
1029720	0	1337	0	41	8	\N	\N
1029721	0	1337	0	41	9	\N	\N
1029722	0	1337	0	41	10	\N	\N
1029723	0	1337	0	41	11	\N	\N
1029724	0	1337	0	41	12	\N	\N
1029725	0	1337	0	41	13	\N	\N
1029726	0	1337	0	41	14	\N	\N
1029727	0	1337	0	41	15	\N	\N
1029728	0	1337	0	41	16	\N	\N
1029729	11	1337	0	41	17	\N	\N
1029730	1	1337	0	41	18	\N	\N
1029731	28	1337	0	41	19	\N	\N
1029732	33	1337	0	41	20	\N	\N
1029733	20	1337	0	41	21	\N	\N
1029734	25	1337	0	41	22	\N	\N
1029735	53	1337	0	41	23	\N	\N
1029736	36	1337	0	41	24	\N	\N
1029737	20	1337	0	41	25	\N	\N
1029738	32	1337	0	41	26	\N	\N
1029739	48	1337	0	41	27	\N	\N
1029740	40	1337	0	41	28	\N	\N
1029741	51	1337	0	41	29	\N	\N
1029742	10	1337	0	41	30	\N	\N
1029743	48	1337	0	41	31	\N	\N
1029744	30	1337	0	41	32	\N	\N
1029745	24	1337	0	41	33	\N	\N
1029746	0	1337	0	41	34	\N	\N
1029747	0	1337	0	41	35	\N	\N
1029748	0	1337	0	41	36	\N	\N
1029749	0	1337	0	41	37	\N	\N
1029750	0	1337	0	41	38	\N	\N
1029751	0	1337	0	41	39	\N	\N
1029752	0	1337	0	41	40	\N	\N
1029753	0	1337	0	41	41	\N	\N
1029754	0	1337	0	41	42	\N	\N
1029755	0	1337	0	41	43	\N	\N
1029756	0	1337	0	41	44	\N	\N
1029757	0	1337	0	41	45	\N	\N
1029758	0	1337	0	41	46	\N	\N
1029759	0	1337	0	41	47	\N	\N
1029760	0	1337	0	41	48	\N	\N
1029761	0	1337	0	41	49	\N	\N
1029762	0	1337	0	41	50	\N	\N
1029763	0	1337	0	41	51	\N	\N
1029764	0	1337	0	41	52	\N	\N
1029765	0	1337	0	41	53	\N	\N
1029766	0	1337	0	41	54	\N	\N
1029767	0	1337	0	41	55	\N	\N
1029768	0	1337	0	41	56	\N	\N
1029769	0	1337	0	41	57	\N	\N
1029770	0	1337	0	41	58	\N	\N
1029771	0	1337	0	41	59	\N	\N
1029772	0	1337	0	42	-20	\N	\N
1029773	0	1337	0	42	-19	\N	\N
1029774	0	1337	0	42	-18	\N	\N
1029775	0	1337	0	42	-17	\N	\N
1029776	0	1337	0	42	-16	\N	\N
1029777	0	1337	0	42	-15	\N	\N
1029778	0	1337	0	42	-14	\N	\N
1029779	0	1337	0	42	-13	\N	\N
1029780	0	1337	0	42	-12	\N	\N
1029781	0	1337	0	42	-11	\N	\N
1029782	0	1337	0	42	-10	\N	\N
1029783	0	1337	0	42	-9	\N	\N
1029784	0	1337	0	42	-8	\N	\N
1029785	0	1337	0	42	-7	\N	\N
1029786	0	1337	0	42	-6	\N	\N
1029787	0	1337	0	42	-5	\N	\N
1029788	0	1337	0	42	-4	\N	\N
1029789	0	1337	0	42	-3	\N	\N
1029790	0	1337	0	42	-2	\N	\N
1029791	0	1337	0	42	-1	\N	\N
1029792	0	1337	0	42	0	\N	\N
1029793	0	1337	0	42	1	\N	\N
1029794	0	1337	0	42	2	\N	\N
1029795	0	1337	0	42	3	\N	\N
1029796	0	1337	0	42	4	\N	\N
1029797	0	1337	0	42	5	\N	\N
1029798	0	1337	0	42	6	\N	\N
1029799	0	1337	0	42	7	\N	\N
1029800	0	1337	0	42	8	\N	\N
1029801	0	1337	0	42	9	\N	\N
1029802	0	1337	0	42	10	\N	\N
1029803	0	1337	0	42	11	\N	\N
1029804	0	1337	0	42	12	\N	\N
1029805	0	1337	0	42	13	\N	\N
1029806	0	1337	0	42	14	\N	\N
1029807	0	1337	0	42	15	\N	\N
1029808	0	1337	0	42	16	\N	\N
1029809	0	1337	0	42	17	\N	\N
1029810	0	1337	0	42	18	\N	\N
1029811	0	1337	0	42	19	\N	\N
1029812	33	1337	0	42	20	\N	\N
1029813	19	1337	0	42	21	\N	\N
1029814	32	1337	0	42	22	\N	\N
1029815	16	1337	0	42	23	\N	\N
1029816	6	1337	0	42	24	\N	\N
1029817	6	1337	0	42	25	\N	\N
1029818	44	1337	0	42	26	\N	\N
1029819	41	1337	0	42	27	\N	\N
1029820	18	1337	0	42	28	\N	\N
1029821	8	1337	0	42	29	\N	\N
1029822	40	1337	0	42	30	\N	\N
1029823	0	1337	0	42	31	\N	\N
1029824	0	1337	0	42	32	\N	\N
1029825	0	1337	0	42	33	\N	\N
1029826	0	1337	0	42	34	\N	\N
1029827	0	1337	0	42	35	\N	\N
1029828	0	1337	0	42	36	\N	\N
1029829	0	1337	0	42	37	\N	\N
1029830	0	1337	0	42	38	\N	\N
1029831	0	1337	0	42	39	\N	\N
1029832	0	1337	0	42	40	\N	\N
1029833	0	1337	0	42	41	\N	\N
1029834	0	1337	0	42	42	\N	\N
1029835	0	1337	0	42	43	\N	\N
1029836	0	1337	0	42	44	\N	\N
1029837	0	1337	0	42	45	\N	\N
1029838	0	1337	0	42	46	\N	\N
1029839	0	1337	0	42	47	\N	\N
1029840	0	1337	0	42	48	\N	\N
1029841	0	1337	0	42	49	\N	\N
1029842	0	1337	0	42	50	\N	\N
1029843	0	1337	0	42	51	\N	\N
1029844	0	1337	0	42	52	\N	\N
1029845	0	1337	0	42	53	\N	\N
1029846	0	1337	0	42	54	\N	\N
1029847	0	1337	0	42	55	\N	\N
1029848	0	1337	0	42	56	\N	\N
1029849	0	1337	0	42	57	\N	\N
1029850	0	1337	0	42	58	\N	\N
1029851	0	1337	0	42	59	\N	\N
1029852	0	1337	0	43	-20	\N	\N
1029853	0	1337	0	43	-19	\N	\N
1029854	0	1337	0	43	-18	\N	\N
1029855	0	1337	0	43	-17	\N	\N
1029856	0	1337	0	43	-16	\N	\N
1029857	0	1337	0	43	-15	\N	\N
1029858	0	1337	0	43	-14	\N	\N
1029859	0	1337	0	43	-13	\N	\N
1029860	0	1337	0	43	-12	\N	\N
1029861	0	1337	0	43	-11	\N	\N
1029862	0	1337	0	43	-10	\N	\N
1029863	0	1337	0	43	-9	\N	\N
1029864	0	1337	0	43	-8	\N	\N
1029865	0	1337	0	43	-7	\N	\N
1029866	0	1337	0	43	-6	\N	\N
1029867	0	1337	0	43	-5	\N	\N
1029868	0	1337	0	43	-4	\N	\N
1029869	0	1337	0	43	-3	\N	\N
1029870	0	1337	0	43	-2	\N	\N
1029871	0	1337	0	43	-1	\N	\N
1029872	0	1337	0	43	0	\N	\N
1029873	0	1337	0	43	1	\N	\N
1029874	0	1337	0	43	2	\N	\N
1029875	0	1337	0	43	3	\N	\N
1029876	0	1337	0	43	4	\N	\N
1029877	0	1337	0	43	5	\N	\N
1029878	0	1337	0	43	6	\N	\N
1029879	0	1337	0	43	7	\N	\N
1029880	0	1337	0	43	8	\N	\N
1029881	0	1337	0	43	9	\N	\N
1029882	0	1337	0	43	10	\N	\N
1029883	0	1337	0	43	11	\N	\N
1029884	0	1337	0	43	12	\N	\N
1029885	0	1337	0	43	13	\N	\N
1029886	0	1337	0	43	14	\N	\N
1029887	0	1337	0	43	15	\N	\N
1029888	0	1337	0	43	16	\N	\N
1029889	0	1337	0	43	17	\N	\N
1029890	0	1337	0	43	18	\N	\N
1029891	0	1337	0	43	19	\N	\N
1029892	0	1337	0	43	20	\N	\N
1029893	0	1337	0	43	21	\N	\N
1029894	0	1337	0	43	22	\N	\N
1029895	0	1337	0	43	23	\N	\N
1029896	0	1337	0	43	24	\N	\N
1029897	33	1337	0	43	25	\N	\N
1029898	0	1337	0	43	26	\N	\N
1029899	0	1337	0	43	27	\N	\N
1029900	0	1337	0	43	28	\N	\N
1029901	0	1337	0	43	29	\N	\N
1029902	0	1337	0	43	30	\N	\N
1029903	0	1337	0	43	31	\N	\N
1029904	0	1337	0	43	32	\N	\N
1029905	0	1337	0	43	33	\N	\N
1029906	0	1337	0	43	34	\N	\N
1029907	0	1337	0	43	35	\N	\N
1029908	0	1337	0	43	36	\N	\N
1029909	0	1337	0	43	37	\N	\N
1029910	0	1337	0	43	38	\N	\N
1029911	0	1337	0	43	39	\N	\N
1029912	0	1337	0	43	40	\N	\N
1029913	0	1337	0	43	41	\N	\N
1029914	0	1337	0	43	42	\N	\N
1029915	0	1337	0	43	43	\N	\N
1029916	0	1337	0	43	44	\N	\N
1029917	0	1337	0	43	45	\N	\N
1029918	0	1337	0	43	46	\N	\N
1029919	0	1337	0	43	47	\N	\N
1029920	0	1337	0	43	48	\N	\N
1029921	0	1337	0	43	49	\N	\N
1029922	0	1337	0	43	50	\N	\N
1029923	0	1337	0	43	51	\N	\N
1029924	0	1337	0	43	52	\N	\N
1029925	0	1337	0	43	53	\N	\N
1029926	0	1337	0	43	54	\N	\N
1029927	0	1337	0	43	55	\N	\N
1029928	0	1337	0	43	56	\N	\N
1029929	0	1337	0	43	57	\N	\N
1029930	0	1337	0	43	58	\N	\N
1029931	0	1337	0	43	59	\N	\N
1029932	0	1337	0	44	-20	\N	\N
1029933	0	1337	0	44	-19	\N	\N
1029934	0	1337	0	44	-18	\N	\N
1029935	0	1337	0	44	-17	\N	\N
1029936	0	1337	0	44	-16	\N	\N
1029937	0	1337	0	44	-15	\N	\N
1029938	0	1337	0	44	-14	\N	\N
1029939	0	1337	0	44	-13	\N	\N
1029940	0	1337	0	44	-12	\N	\N
1029941	0	1337	0	44	-11	\N	\N
1029942	0	1337	0	44	-10	\N	\N
1029943	0	1337	0	44	-9	\N	\N
1029944	0	1337	0	44	-8	\N	\N
1029945	0	1337	0	44	-7	\N	\N
1029946	0	1337	0	44	-6	\N	\N
1029947	0	1337	0	44	-5	\N	\N
1029948	0	1337	0	44	-4	\N	\N
1029949	0	1337	0	44	-3	\N	\N
1029950	0	1337	0	44	-2	\N	\N
1029951	0	1337	0	44	-1	\N	\N
1029952	0	1337	0	44	0	\N	\N
1029953	0	1337	0	44	1	\N	\N
1029954	0	1337	0	44	2	\N	\N
1029955	0	1337	0	44	3	\N	\N
1029956	0	1337	0	44	4	\N	\N
1029957	0	1337	0	44	5	\N	\N
1029958	0	1337	0	44	6	\N	\N
1029959	0	1337	0	44	7	\N	\N
1029960	0	1337	0	44	8	\N	\N
1029961	0	1337	0	44	9	\N	\N
1029962	0	1337	0	44	10	\N	\N
1029963	0	1337	0	44	11	\N	\N
1029964	0	1337	0	44	12	\N	\N
1029965	0	1337	0	44	13	\N	\N
1029966	0	1337	0	44	14	\N	\N
1029967	0	1337	0	44	15	\N	\N
1029968	0	1337	0	44	16	\N	\N
1029969	0	1337	0	44	17	\N	\N
1029970	0	1337	0	44	18	\N	\N
1029971	0	1337	0	44	19	\N	\N
1029972	0	1337	0	44	20	\N	\N
1029973	0	1337	0	44	21	\N	\N
1029974	0	1337	0	44	22	\N	\N
1029975	0	1337	0	44	23	\N	\N
1029976	0	1337	0	44	24	\N	\N
1029977	0	1337	0	44	25	\N	\N
1029978	0	1337	0	44	26	\N	\N
1029979	0	1337	0	44	27	\N	\N
1029980	0	1337	0	44	28	\N	\N
1029981	0	1337	0	44	29	\N	\N
1029982	0	1337	0	44	30	\N	\N
1029983	0	1337	0	44	31	\N	\N
1029984	0	1337	0	44	32	\N	\N
1029985	0	1337	0	44	33	\N	\N
1029986	0	1337	0	44	34	\N	\N
1029987	0	1337	0	44	35	\N	\N
1029988	0	1337	0	44	36	\N	\N
1029989	0	1337	0	44	37	\N	\N
1029990	0	1337	0	44	38	\N	\N
1029991	0	1337	0	44	39	\N	\N
1029992	0	1337	0	44	40	\N	\N
1029993	0	1337	0	44	41	\N	\N
1029994	0	1337	0	44	42	\N	\N
1029995	0	1337	0	44	43	\N	\N
1029996	0	1337	0	44	44	\N	\N
1029997	0	1337	0	44	45	\N	\N
1029998	0	1337	0	44	46	\N	\N
1029999	0	1337	0	44	47	\N	\N
1030000	0	1337	0	44	48	\N	\N
1030001	0	1337	0	44	49	\N	\N
1030002	0	1337	0	44	50	\N	\N
1030003	0	1337	0	44	51	\N	\N
1030004	0	1337	0	44	52	\N	\N
1030005	0	1337	0	44	53	\N	\N
1030006	0	1337	0	44	54	\N	\N
1030007	0	1337	0	44	55	\N	\N
1030008	0	1337	0	44	56	\N	\N
1030009	0	1337	0	44	57	\N	\N
1030010	0	1337	0	44	58	\N	\N
1030011	0	1337	0	44	59	\N	\N
1030012	0	1337	0	45	-20	\N	\N
1030013	0	1337	0	45	-19	\N	\N
1030014	0	1337	0	45	-18	\N	\N
1030015	0	1337	0	45	-17	\N	\N
1030016	0	1337	0	45	-16	\N	\N
1030017	0	1337	0	45	-15	\N	\N
1030018	0	1337	0	45	-14	\N	\N
1030019	0	1337	0	45	-13	\N	\N
1030020	0	1337	0	45	-12	\N	\N
1030021	0	1337	0	45	-11	\N	\N
1030022	0	1337	0	45	-10	\N	\N
1030023	0	1337	0	45	-9	\N	\N
1030024	0	1337	0	45	-8	\N	\N
1030025	0	1337	0	45	-7	\N	\N
1030026	0	1337	0	45	-6	\N	\N
1030027	0	1337	0	45	-5	\N	\N
1030028	0	1337	0	45	-4	\N	\N
1030029	0	1337	0	45	-3	\N	\N
1030030	0	1337	0	45	-2	\N	\N
1030031	0	1337	0	45	-1	\N	\N
1030032	0	1337	0	45	0	\N	\N
1030033	0	1337	0	45	1	\N	\N
1030034	0	1337	0	45	2	\N	\N
1030035	0	1337	0	45	3	\N	\N
1030036	0	1337	0	45	4	\N	\N
1030037	0	1337	0	45	5	\N	\N
1030038	0	1337	0	45	6	\N	\N
1030039	0	1337	0	45	7	\N	\N
1030040	0	1337	0	45	8	\N	\N
1030041	0	1337	0	45	9	\N	\N
1030042	0	1337	0	45	10	\N	\N
1030043	0	1337	0	45	11	\N	\N
1030044	0	1337	0	45	12	\N	\N
1030045	0	1337	0	45	13	\N	\N
1030046	0	1337	0	45	14	\N	\N
1030047	0	1337	0	45	15	\N	\N
1030048	0	1337	0	45	16	\N	\N
1030049	0	1337	0	45	17	\N	\N
1030050	0	1337	0	45	18	\N	\N
1030051	0	1337	0	45	19	\N	\N
1030052	0	1337	0	45	20	\N	\N
1030053	0	1337	0	45	21	\N	\N
1030054	0	1337	0	45	22	\N	\N
1030055	0	1337	0	45	23	\N	\N
1030056	0	1337	0	45	24	\N	\N
1030057	0	1337	0	45	25	\N	\N
1030058	0	1337	0	45	26	\N	\N
1030059	0	1337	0	45	27	\N	\N
1030060	0	1337	0	45	28	\N	\N
1030061	0	1337	0	45	29	\N	\N
1030062	0	1337	0	45	30	\N	\N
1030063	0	1337	0	45	31	\N	\N
1030064	0	1337	0	45	32	\N	\N
1030065	0	1337	0	45	33	\N	\N
1030066	0	1337	0	45	34	\N	\N
1030067	0	1337	0	45	35	\N	\N
1030068	0	1337	0	45	36	\N	\N
1030069	0	1337	0	45	37	\N	\N
1030070	0	1337	0	45	38	\N	\N
1030071	0	1337	0	45	39	\N	\N
1030072	0	1337	0	45	40	\N	\N
1030073	0	1337	0	45	41	\N	\N
1030074	0	1337	0	45	42	\N	\N
1030075	0	1337	0	45	43	\N	\N
1030076	0	1337	0	45	44	\N	\N
1030077	0	1337	0	45	45	\N	\N
1030078	0	1337	0	45	46	\N	\N
1030079	0	1337	0	45	47	\N	\N
1030080	0	1337	0	45	48	\N	\N
1030081	0	1337	0	45	49	\N	\N
1030082	0	1337	0	45	50	\N	\N
1030083	0	1337	0	45	51	\N	\N
1030084	0	1337	0	45	52	\N	\N
1030085	0	1337	0	45	53	\N	\N
1030086	0	1337	0	45	54	\N	\N
1030087	0	1337	0	45	55	\N	\N
1030088	0	1337	0	45	56	\N	\N
1030089	0	1337	0	45	57	\N	\N
1030090	0	1337	0	45	58	\N	\N
1030091	0	1337	0	45	59	\N	\N
1030092	0	1337	0	46	-20	\N	\N
1030093	0	1337	0	46	-19	\N	\N
1030094	0	1337	0	46	-18	\N	\N
1030095	0	1337	0	46	-17	\N	\N
1030096	0	1337	0	46	-16	\N	\N
1030097	0	1337	0	46	-15	\N	\N
1030098	0	1337	0	46	-14	\N	\N
1030099	0	1337	0	46	-13	\N	\N
1030100	0	1337	0	46	-12	\N	\N
1030101	0	1337	0	46	-11	\N	\N
1030102	0	1337	0	46	-10	\N	\N
1030103	0	1337	0	46	-9	\N	\N
1030104	0	1337	0	46	-8	\N	\N
1030105	0	1337	0	46	-7	\N	\N
1030106	0	1337	0	46	-6	\N	\N
1030107	0	1337	0	46	-5	\N	\N
1030108	0	1337	0	46	-4	\N	\N
1030109	0	1337	0	46	-3	\N	\N
1030110	0	1337	0	46	-2	\N	\N
1030111	0	1337	0	46	-1	\N	\N
1030112	0	1337	0	46	0	\N	\N
1030113	0	1337	0	46	1	\N	\N
1030114	0	1337	0	46	2	\N	\N
1030115	0	1337	0	46	3	\N	\N
1030116	0	1337	0	46	4	\N	\N
1030117	0	1337	0	46	5	\N	\N
1030118	0	1337	0	46	6	\N	\N
1030119	0	1337	0	46	7	\N	\N
1030120	0	1337	0	46	8	\N	\N
1030121	0	1337	0	46	9	\N	\N
1030122	0	1337	0	46	10	\N	\N
1030123	0	1337	0	46	11	\N	\N
1030124	0	1337	0	46	12	\N	\N
1030125	0	1337	0	46	13	\N	\N
1030126	0	1337	0	46	14	\N	\N
1030127	0	1337	0	46	15	\N	\N
1030128	0	1337	0	46	16	\N	\N
1030129	0	1337	0	46	17	\N	\N
1030130	0	1337	0	46	18	\N	\N
1030131	0	1337	0	46	19	\N	\N
1030132	0	1337	0	46	20	\N	\N
1030133	0	1337	0	46	21	\N	\N
1030134	0	1337	0	46	22	\N	\N
1030135	0	1337	0	46	23	\N	\N
1030136	0	1337	0	46	24	\N	\N
1030137	0	1337	0	46	25	\N	\N
1030138	0	1337	0	46	26	\N	\N
1030139	0	1337	0	46	27	\N	\N
1030140	0	1337	0	46	28	\N	\N
1030141	0	1337	0	46	29	\N	\N
1030142	0	1337	0	46	30	\N	\N
1030143	0	1337	0	46	31	\N	\N
1030144	0	1337	0	46	32	\N	\N
1030145	0	1337	0	46	33	\N	\N
1030146	0	1337	0	46	34	\N	\N
1030147	0	1337	0	46	35	\N	\N
1030148	0	1337	0	46	36	\N	\N
1030149	0	1337	0	46	37	\N	\N
1030150	0	1337	0	46	38	\N	\N
1030151	0	1337	0	46	39	\N	\N
1030152	0	1337	0	46	40	\N	\N
1030153	0	1337	0	46	41	\N	\N
1030154	0	1337	0	46	42	\N	\N
1030155	0	1337	0	46	43	\N	\N
1030156	0	1337	0	46	44	\N	\N
1030157	0	1337	0	46	45	\N	\N
1030158	0	1337	0	46	46	\N	\N
1030159	0	1337	0	46	47	\N	\N
1030160	0	1337	0	46	48	\N	\N
1030161	0	1337	0	46	49	\N	\N
1030162	0	1337	0	46	50	\N	\N
1030163	0	1337	0	46	51	\N	\N
1030164	0	1337	0	46	52	\N	\N
1030165	0	1337	0	46	53	\N	\N
1030166	0	1337	0	46	54	\N	\N
1030167	0	1337	0	46	55	\N	\N
1030168	0	1337	0	46	56	\N	\N
1030169	0	1337	0	46	57	\N	\N
1030170	0	1337	0	46	58	\N	\N
1030171	0	1337	0	46	59	\N	\N
1030172	0	1337	0	47	-20	\N	\N
1030173	0	1337	0	47	-19	\N	\N
1030174	0	1337	0	47	-18	\N	\N
1030175	0	1337	0	47	-17	\N	\N
1030176	0	1337	0	47	-16	\N	\N
1030177	0	1337	0	47	-15	\N	\N
1030178	0	1337	0	47	-14	\N	\N
1030179	0	1337	0	47	-13	\N	\N
1030180	0	1337	0	47	-12	\N	\N
1030181	0	1337	0	47	-11	\N	\N
1030182	0	1337	0	47	-10	\N	\N
1030183	0	1337	0	47	-9	\N	\N
1030184	0	1337	0	47	-8	\N	\N
1030185	0	1337	0	47	-7	\N	\N
1030186	0	1337	0	47	-6	\N	\N
1030187	0	1337	0	47	-5	\N	\N
1030188	0	1337	0	47	-4	\N	\N
1030189	0	1337	0	47	-3	\N	\N
1030190	0	1337	0	47	-2	\N	\N
1030191	0	1337	0	47	-1	\N	\N
1030192	0	1337	0	47	0	\N	\N
1030193	0	1337	0	47	1	\N	\N
1030194	0	1337	0	47	2	\N	\N
1030195	0	1337	0	47	3	\N	\N
1030196	0	1337	0	47	4	\N	\N
1030197	0	1337	0	47	5	\N	\N
1030198	0	1337	0	47	6	\N	\N
1030199	0	1337	0	47	7	\N	\N
1030200	0	1337	0	47	8	\N	\N
1030201	0	1337	0	47	9	\N	\N
1030202	0	1337	0	47	10	\N	\N
1030203	0	1337	0	47	11	\N	\N
1030204	0	1337	0	47	12	\N	\N
1030205	0	1337	0	47	13	\N	\N
1030206	0	1337	0	47	14	\N	\N
1030207	0	1337	0	47	15	\N	\N
1030208	0	1337	0	47	16	\N	\N
1030209	0	1337	0	47	17	\N	\N
1030210	0	1337	0	47	18	\N	\N
1030211	0	1337	0	47	19	\N	\N
1030212	0	1337	0	47	20	\N	\N
1030213	0	1337	0	47	21	\N	\N
1030214	0	1337	0	47	22	\N	\N
1030215	0	1337	0	47	23	\N	\N
1030216	0	1337	0	47	24	\N	\N
1030217	0	1337	0	47	25	\N	\N
1030218	0	1337	0	47	26	\N	\N
1030219	0	1337	0	47	27	\N	\N
1030220	0	1337	0	47	28	\N	\N
1030221	0	1337	0	47	29	\N	\N
1030222	0	1337	0	47	30	\N	\N
1030223	0	1337	0	47	31	\N	\N
1030224	0	1337	0	47	32	\N	\N
1030225	0	1337	0	47	33	\N	\N
1030226	0	1337	0	47	34	\N	\N
1030227	0	1337	0	47	35	\N	\N
1030228	0	1337	0	47	36	\N	\N
1030229	0	1337	0	47	37	\N	\N
1030230	0	1337	0	47	38	\N	\N
1030231	0	1337	0	47	39	\N	\N
1030232	0	1337	0	47	40	\N	\N
1030233	0	1337	0	47	41	\N	\N
1030234	0	1337	0	47	42	\N	\N
1030235	0	1337	0	47	43	\N	\N
1030236	0	1337	0	47	44	\N	\N
1030237	0	1337	0	47	45	\N	\N
1030238	0	1337	0	47	46	\N	\N
1030239	0	1337	0	47	47	\N	\N
1030240	0	1337	0	47	48	\N	\N
1030241	0	1337	0	47	49	\N	\N
1030242	0	1337	0	47	50	\N	\N
1030243	0	1337	0	47	51	\N	\N
1030244	0	1337	0	47	52	\N	\N
1030245	0	1337	0	47	53	\N	\N
1030246	0	1337	0	47	54	\N	\N
1030247	0	1337	0	47	55	\N	\N
1030248	0	1337	0	47	56	\N	\N
1030249	0	1337	0	47	57	\N	\N
1030250	0	1337	0	47	58	\N	\N
1030251	0	1337	0	47	59	\N	\N
1030252	0	1337	0	48	-20	\N	\N
1030253	0	1337	0	48	-19	\N	\N
1030254	0	1337	0	48	-18	\N	\N
1030255	0	1337	0	48	-17	\N	\N
1030256	0	1337	0	48	-16	\N	\N
1030257	0	1337	0	48	-15	\N	\N
1030258	0	1337	0	48	-14	\N	\N
1030259	0	1337	0	48	-13	\N	\N
1030260	0	1337	0	48	-12	\N	\N
1030261	0	1337	0	48	-11	\N	\N
1030262	0	1337	0	48	-10	\N	\N
1030263	0	1337	0	48	-9	\N	\N
1030264	0	1337	0	48	-8	\N	\N
1030265	0	1337	0	48	-7	\N	\N
1030266	0	1337	0	48	-6	\N	\N
1030267	0	1337	0	48	-5	\N	\N
1030268	0	1337	0	48	-4	\N	\N
1030269	0	1337	0	48	-3	\N	\N
1030270	0	1337	0	48	-2	\N	\N
1030271	0	1337	0	48	-1	\N	\N
1030272	0	1337	0	48	0	\N	\N
1030273	0	1337	0	48	1	\N	\N
1030274	0	1337	0	48	2	\N	\N
1030275	0	1337	0	48	3	\N	\N
1030276	0	1337	0	48	4	\N	\N
1030277	0	1337	0	48	5	\N	\N
1030278	0	1337	0	48	6	\N	\N
1030279	0	1337	0	48	7	\N	\N
1030280	0	1337	0	48	8	\N	\N
1030281	0	1337	0	48	9	\N	\N
1030282	0	1337	0	48	10	\N	\N
1030283	0	1337	0	48	11	\N	\N
1030284	0	1337	0	48	12	\N	\N
1030285	0	1337	0	48	13	\N	\N
1030286	0	1337	0	48	14	\N	\N
1030287	0	1337	0	48	15	\N	\N
1030288	0	1337	0	48	16	\N	\N
1030289	0	1337	0	48	17	\N	\N
1030290	0	1337	0	48	18	\N	\N
1030291	0	1337	0	48	19	\N	\N
1030292	0	1337	0	48	20	\N	\N
1030293	0	1337	0	48	21	\N	\N
1030294	0	1337	0	48	22	\N	\N
1030295	0	1337	0	48	23	\N	\N
1030296	0	1337	0	48	24	\N	\N
1030297	0	1337	0	48	25	\N	\N
1030298	0	1337	0	48	26	\N	\N
1030299	0	1337	0	48	27	\N	\N
1030300	0	1337	0	48	28	\N	\N
1030301	0	1337	0	48	29	\N	\N
1030302	0	1337	0	48	30	\N	\N
1030303	0	1337	0	48	31	\N	\N
1030304	0	1337	0	48	32	\N	\N
1030305	0	1337	0	48	33	\N	\N
1030306	0	1337	0	48	34	\N	\N
1030307	0	1337	0	48	35	\N	\N
1030308	0	1337	0	48	36	\N	\N
1030309	0	1337	0	48	37	\N	\N
1030310	0	1337	0	48	38	\N	\N
1030311	0	1337	0	48	39	\N	\N
1030312	0	1337	0	48	40	\N	\N
1030313	0	1337	0	48	41	\N	\N
1030314	0	1337	0	48	42	\N	\N
1030315	0	1337	0	48	43	\N	\N
1030316	0	1337	0	48	44	\N	\N
1030317	0	1337	0	48	45	\N	\N
1030318	0	1337	0	48	46	\N	\N
1030319	0	1337	0	48	47	\N	\N
1030320	0	1337	0	48	48	\N	\N
1030321	0	1337	0	48	49	\N	\N
1030322	0	1337	0	48	50	\N	\N
1030323	0	1337	0	48	51	\N	\N
1030324	0	1337	0	48	52	\N	\N
1030325	0	1337	0	48	53	\N	\N
1030326	0	1337	0	48	54	\N	\N
1030327	0	1337	0	48	55	\N	\N
1030328	0	1337	0	48	56	\N	\N
1030329	0	1337	0	48	57	\N	\N
1030330	0	1337	0	48	58	\N	\N
1030331	0	1337	0	48	59	\N	\N
1030332	0	1337	0	49	-20	\N	\N
1030333	0	1337	0	49	-19	\N	\N
1030334	0	1337	0	49	-18	\N	\N
1030335	0	1337	0	49	-17	\N	\N
1030336	0	1337	0	49	-16	\N	\N
1030337	0	1337	0	49	-15	\N	\N
1030338	0	1337	0	49	-14	\N	\N
1030339	0	1337	0	49	-13	\N	\N
1030340	0	1337	0	49	-12	\N	\N
1030341	0	1337	0	49	-11	\N	\N
1030342	0	1337	0	49	-10	\N	\N
1030343	0	1337	0	49	-9	\N	\N
1030344	0	1337	0	49	-8	\N	\N
1030345	0	1337	0	49	-7	\N	\N
1030346	0	1337	0	49	-6	\N	\N
1030347	0	1337	0	49	-5	\N	\N
1030348	0	1337	0	49	-4	\N	\N
1030349	0	1337	0	49	-3	\N	\N
1030350	0	1337	0	49	-2	\N	\N
1030351	0	1337	0	49	-1	\N	\N
1030352	0	1337	0	49	0	\N	\N
1030353	0	1337	0	49	1	\N	\N
1030354	0	1337	0	49	2	\N	\N
1030355	0	1337	0	49	3	\N	\N
1030356	0	1337	0	49	4	\N	\N
1030357	0	1337	0	49	5	\N	\N
1030358	0	1337	0	49	6	\N	\N
1030359	0	1337	0	49	7	\N	\N
1030360	0	1337	0	49	8	\N	\N
1030361	0	1337	0	49	9	\N	\N
1030362	0	1337	0	49	10	\N	\N
1030363	0	1337	0	49	11	\N	\N
1030364	0	1337	0	49	12	\N	\N
1030365	0	1337	0	49	13	\N	\N
1030366	0	1337	0	49	14	\N	\N
1030367	0	1337	0	49	15	\N	\N
1030368	0	1337	0	49	16	\N	\N
1030369	0	1337	0	49	17	\N	\N
1030370	0	1337	0	49	18	\N	\N
1030371	0	1337	0	49	19	\N	\N
1030372	0	1337	0	49	20	\N	\N
1030373	0	1337	0	49	21	\N	\N
1030374	0	1337	0	49	22	\N	\N
1030375	0	1337	0	49	23	\N	\N
1030376	0	1337	0	49	24	\N	\N
1030377	0	1337	0	49	25	\N	\N
1030378	0	1337	0	49	26	\N	\N
1030379	0	1337	0	49	27	\N	\N
1030380	0	1337	0	49	28	\N	\N
1030381	0	1337	0	49	29	\N	\N
1030382	0	1337	0	49	30	\N	\N
1030383	0	1337	0	49	31	\N	\N
1030384	0	1337	0	49	32	\N	\N
1030385	0	1337	0	49	33	\N	\N
1030386	0	1337	0	49	34	\N	\N
1030387	0	1337	0	49	35	\N	\N
1030388	0	1337	0	49	36	\N	\N
1030389	0	1337	0	49	37	\N	\N
1030390	0	1337	0	49	38	\N	\N
1030391	0	1337	0	49	39	\N	\N
1030392	0	1337	0	49	40	\N	\N
1030393	0	1337	0	49	41	\N	\N
1030394	0	1337	0	49	42	\N	\N
1030395	0	1337	0	49	43	\N	\N
1030396	0	1337	0	49	44	\N	\N
1030397	0	1337	0	49	45	\N	\N
1030398	0	1337	0	49	46	\N	\N
1030399	0	1337	0	49	47	\N	\N
1030400	0	1337	0	49	48	\N	\N
1030401	0	1337	0	49	49	\N	\N
1030402	0	1337	0	49	50	\N	\N
1030403	0	1337	0	49	51	\N	\N
1030404	0	1337	0	49	52	\N	\N
1030405	0	1337	0	49	53	\N	\N
1030406	0	1337	0	49	54	\N	\N
1030407	0	1337	0	49	55	\N	\N
1030408	0	1337	0	49	56	\N	\N
1030409	0	1337	0	49	57	\N	\N
1030410	0	1337	0	49	58	\N	\N
1030411	0	1337	0	49	59	\N	\N
1030412	0	1337	0	50	-20	\N	\N
1030413	0	1337	0	50	-19	\N	\N
1030414	0	1337	0	50	-18	\N	\N
1030415	0	1337	0	50	-17	\N	\N
1030416	0	1337	0	50	-16	\N	\N
1030417	0	1337	0	50	-15	\N	\N
1030418	0	1337	0	50	-14	\N	\N
1030419	0	1337	0	50	-13	\N	\N
1030420	0	1337	0	50	-12	\N	\N
1030421	0	1337	0	50	-11	\N	\N
1030422	0	1337	0	50	-10	\N	\N
1030423	0	1337	0	50	-9	\N	\N
1030424	0	1337	0	50	-8	\N	\N
1030425	0	1337	0	50	-7	\N	\N
1030426	0	1337	0	50	-6	\N	\N
1030427	0	1337	0	50	-5	\N	\N
1030428	0	1337	0	50	-4	\N	\N
1030429	0	1337	0	50	-3	\N	\N
1030430	0	1337	0	50	-2	\N	\N
1030431	0	1337	0	50	-1	\N	\N
1030432	0	1337	0	50	0	\N	\N
1030433	0	1337	0	50	1	\N	\N
1030434	0	1337	0	50	2	\N	\N
1030435	0	1337	0	50	3	\N	\N
1030436	0	1337	0	50	4	\N	\N
1030437	0	1337	0	50	5	\N	\N
1030438	0	1337	0	50	6	\N	\N
1030439	0	1337	0	50	7	\N	\N
1030440	0	1337	0	50	8	\N	\N
1030441	0	1337	0	50	9	\N	\N
1030442	0	1337	0	50	10	\N	\N
1030443	0	1337	0	50	11	\N	\N
1030444	0	1337	0	50	12	\N	\N
1030445	0	1337	0	50	13	\N	\N
1030446	0	1337	0	50	14	\N	\N
1030447	0	1337	0	50	15	\N	\N
1030448	0	1337	0	50	16	\N	\N
1030449	0	1337	0	50	17	\N	\N
1030450	0	1337	0	50	18	\N	\N
1030451	0	1337	0	50	19	\N	\N
1030452	0	1337	0	50	20	\N	\N
1030453	0	1337	0	50	21	\N	\N
1030454	0	1337	0	50	22	\N	\N
1030455	0	1337	0	50	23	\N	\N
1030456	0	1337	0	50	24	\N	\N
1030457	0	1337	0	50	25	\N	\N
1030458	0	1337	0	50	26	\N	\N
1030459	0	1337	0	50	27	\N	\N
1030460	0	1337	0	50	28	\N	\N
1030461	0	1337	0	50	29	\N	\N
1030462	0	1337	0	50	30	\N	\N
1030463	0	1337	0	50	31	\N	\N
1030464	0	1337	0	50	32	\N	\N
1030465	0	1337	0	50	33	\N	\N
1030466	0	1337	0	50	34	\N	\N
1030467	0	1337	0	50	35	\N	\N
1030468	0	1337	0	50	36	\N	\N
1030469	0	1337	0	50	37	\N	\N
1030470	0	1337	0	50	38	\N	\N
1030471	0	1337	0	50	39	\N	\N
1030472	0	1337	0	50	40	\N	\N
1030473	0	1337	0	50	41	\N	\N
1030474	0	1337	0	50	42	\N	\N
1030475	0	1337	0	50	43	\N	\N
1030476	0	1337	0	50	44	\N	\N
1030477	0	1337	0	50	45	\N	\N
1030478	0	1337	0	50	46	\N	\N
1030479	0	1337	0	50	47	\N	\N
1030480	0	1337	0	50	48	\N	\N
1030481	0	1337	0	50	49	\N	\N
1030482	0	1337	0	50	50	\N	\N
1030483	0	1337	0	50	51	\N	\N
1030484	0	1337	0	50	52	\N	\N
1030485	0	1337	0	50	53	\N	\N
1030486	0	1337	0	50	54	\N	\N
1030487	0	1337	0	50	55	\N	\N
1030488	0	1337	0	50	56	\N	\N
1030489	0	1337	0	50	57	\N	\N
1030490	0	1337	0	50	58	\N	\N
1030491	0	1337	0	50	59	\N	\N
1030492	0	1337	0	51	-20	\N	\N
1030493	0	1337	0	51	-19	\N	\N
1030494	0	1337	0	51	-18	\N	\N
1030495	0	1337	0	51	-17	\N	\N
1030496	0	1337	0	51	-16	\N	\N
1030497	0	1337	0	51	-15	\N	\N
1030498	0	1337	0	51	-14	\N	\N
1030499	0	1337	0	51	-13	\N	\N
1030500	0	1337	0	51	-12	\N	\N
1030501	0	1337	0	51	-11	\N	\N
1030502	0	1337	0	51	-10	\N	\N
1030503	0	1337	0	51	-9	\N	\N
1030504	0	1337	0	51	-8	\N	\N
1030505	0	1337	0	51	-7	\N	\N
1030506	0	1337	0	51	-6	\N	\N
1030507	0	1337	0	51	-5	\N	\N
1030508	0	1337	0	51	-4	\N	\N
1030509	0	1337	0	51	-3	\N	\N
1030510	0	1337	0	51	-2	\N	\N
1030511	0	1337	0	51	-1	\N	\N
1030512	0	1337	0	51	0	\N	\N
1030513	0	1337	0	51	1	\N	\N
1030514	0	1337	0	51	2	\N	\N
1030515	0	1337	0	51	3	\N	\N
1030516	0	1337	0	51	4	\N	\N
1030517	0	1337	0	51	5	\N	\N
1030518	0	1337	0	51	6	\N	\N
1030519	0	1337	0	51	7	\N	\N
1030520	0	1337	0	51	8	\N	\N
1030521	0	1337	0	51	9	\N	\N
1030522	0	1337	0	51	10	\N	\N
1030523	0	1337	0	51	11	\N	\N
1030524	0	1337	0	51	12	\N	\N
1030525	0	1337	0	51	13	\N	\N
1030526	0	1337	0	51	14	\N	\N
1030527	0	1337	0	51	15	\N	\N
1030528	0	1337	0	51	16	\N	\N
1030529	0	1337	0	51	17	\N	\N
1030530	0	1337	0	51	18	\N	\N
1030531	0	1337	0	51	19	\N	\N
1030532	0	1337	0	51	20	\N	\N
1030533	0	1337	0	51	21	\N	\N
1030534	0	1337	0	51	22	\N	\N
1030535	0	1337	0	51	23	\N	\N
1030536	0	1337	0	51	24	\N	\N
1030537	0	1337	0	51	25	\N	\N
1030538	0	1337	0	51	26	\N	\N
1030539	0	1337	0	51	27	\N	\N
1030540	0	1337	0	51	28	\N	\N
1030541	0	1337	0	51	29	\N	\N
1030542	0	1337	0	51	30	\N	\N
1030543	0	1337	0	51	31	\N	\N
1030544	0	1337	0	51	32	\N	\N
1030545	0	1337	0	51	33	\N	\N
1030546	0	1337	0	51	34	\N	\N
1030547	0	1337	0	51	35	\N	\N
1030548	0	1337	0	51	36	\N	\N
1030549	0	1337	0	51	37	\N	\N
1030550	0	1337	0	51	38	\N	\N
1030551	0	1337	0	51	39	\N	\N
1030552	0	1337	0	51	40	\N	\N
1030553	0	1337	0	51	41	\N	\N
1030554	0	1337	0	51	42	\N	\N
1030555	0	1337	0	51	43	\N	\N
1030556	0	1337	0	51	44	\N	\N
1030557	0	1337	0	51	45	\N	\N
1030558	0	1337	0	51	46	\N	\N
1030559	0	1337	0	51	47	\N	\N
1030560	0	1337	0	51	48	\N	\N
1030561	0	1337	0	51	49	\N	\N
1030562	0	1337	0	51	50	\N	\N
1030563	0	1337	0	51	51	\N	\N
1030564	0	1337	0	51	52	\N	\N
1030565	0	1337	0	51	53	\N	\N
1030566	0	1337	0	51	54	\N	\N
1030567	0	1337	0	51	55	\N	\N
1030568	0	1337	0	51	56	\N	\N
1030569	0	1337	0	51	57	\N	\N
1030570	0	1337	0	51	58	\N	\N
1030571	0	1337	0	51	59	\N	\N
1030572	0	1337	0	52	-20	\N	\N
1030573	0	1337	0	52	-19	\N	\N
1030574	0	1337	0	52	-18	\N	\N
1030575	0	1337	0	52	-17	\N	\N
1030576	0	1337	0	52	-16	\N	\N
1030577	0	1337	0	52	-15	\N	\N
1030578	0	1337	0	52	-14	\N	\N
1030579	0	1337	0	52	-13	\N	\N
1030580	0	1337	0	52	-12	\N	\N
1030581	0	1337	0	52	-11	\N	\N
1030582	0	1337	0	52	-10	\N	\N
1030583	0	1337	0	52	-9	\N	\N
1030584	0	1337	0	52	-8	\N	\N
1030585	0	1337	0	52	-7	\N	\N
1030586	0	1337	0	52	-6	\N	\N
1030587	0	1337	0	52	-5	\N	\N
1030588	0	1337	0	52	-4	\N	\N
1030589	0	1337	0	52	-3	\N	\N
1030590	0	1337	0	52	-2	\N	\N
1030591	0	1337	0	52	-1	\N	\N
1030592	0	1337	0	52	0	\N	\N
1030593	0	1337	0	52	1	\N	\N
1030594	0	1337	0	52	2	\N	\N
1030595	0	1337	0	52	3	\N	\N
1030596	0	1337	0	52	4	\N	\N
1030597	0	1337	0	52	5	\N	\N
1030598	0	1337	0	52	6	\N	\N
1030599	0	1337	0	52	7	\N	\N
1030600	0	1337	0	52	8	\N	\N
1030601	0	1337	0	52	9	\N	\N
1030602	0	1337	0	52	10	\N	\N
1030603	0	1337	0	52	11	\N	\N
1030604	0	1337	0	52	12	\N	\N
1030605	0	1337	0	52	13	\N	\N
1030606	0	1337	0	52	14	\N	\N
1030607	0	1337	0	52	15	\N	\N
1030608	0	1337	0	52	16	\N	\N
1030609	0	1337	0	52	17	\N	\N
1030610	0	1337	0	52	18	\N	\N
1030611	0	1337	0	52	19	\N	\N
1030612	0	1337	0	52	20	\N	\N
1030613	0	1337	0	52	21	\N	\N
1030614	0	1337	0	52	22	\N	\N
1030615	0	1337	0	52	23	\N	\N
1030616	0	1337	0	52	24	\N	\N
1030617	0	1337	0	52	25	\N	\N
1030618	0	1337	0	52	26	\N	\N
1030619	0	1337	0	52	27	\N	\N
1030620	0	1337	0	52	28	\N	\N
1030621	0	1337	0	52	29	\N	\N
1030622	0	1337	0	52	30	\N	\N
1030623	0	1337	0	52	31	\N	\N
1030624	0	1337	0	52	32	\N	\N
1030625	0	1337	0	52	33	\N	\N
1030626	0	1337	0	52	34	\N	\N
1030627	0	1337	0	52	35	\N	\N
1030628	0	1337	0	52	36	\N	\N
1030629	0	1337	0	52	37	\N	\N
1030630	0	1337	0	52	38	\N	\N
1030631	0	1337	0	52	39	\N	\N
1030632	0	1337	0	52	40	\N	\N
1030633	0	1337	0	52	41	\N	\N
1030634	0	1337	0	52	42	\N	\N
1030635	0	1337	0	52	43	\N	\N
1030636	0	1337	0	52	44	\N	\N
1030637	0	1337	0	52	45	\N	\N
1030638	0	1337	0	52	46	\N	\N
1030639	0	1337	0	52	47	\N	\N
1030640	0	1337	0	52	48	\N	\N
1030641	0	1337	0	52	49	\N	\N
1030642	0	1337	0	52	50	\N	\N
1030643	0	1337	0	52	51	\N	\N
1030644	0	1337	0	52	52	\N	\N
1030645	0	1337	0	52	53	\N	\N
1030646	0	1337	0	52	54	\N	\N
1030647	0	1337	0	52	55	\N	\N
1030648	0	1337	0	52	56	\N	\N
1030649	0	1337	0	52	57	\N	\N
1030650	0	1337	0	52	58	\N	\N
1030651	0	1337	0	52	59	\N	\N
1030652	0	1337	0	53	-20	\N	\N
1030653	0	1337	0	53	-19	\N	\N
1030654	0	1337	0	53	-18	\N	\N
1030655	0	1337	0	53	-17	\N	\N
1030656	0	1337	0	53	-16	\N	\N
1030657	0	1337	0	53	-15	\N	\N
1030658	0	1337	0	53	-14	\N	\N
1030659	0	1337	0	53	-13	\N	\N
1030660	0	1337	0	53	-12	\N	\N
1030661	0	1337	0	53	-11	\N	\N
1030662	0	1337	0	53	-10	\N	\N
1030663	0	1337	0	53	-9	\N	\N
1030664	0	1337	0	53	-8	\N	\N
1030665	0	1337	0	53	-7	\N	\N
1030666	0	1337	0	53	-6	\N	\N
1030667	0	1337	0	53	-5	\N	\N
1030668	0	1337	0	53	-4	\N	\N
1030669	0	1337	0	53	-3	\N	\N
1030670	0	1337	0	53	-2	\N	\N
1030671	0	1337	0	53	-1	\N	\N
1030672	0	1337	0	53	0	\N	\N
1030673	0	1337	0	53	1	\N	\N
1030674	0	1337	0	53	2	\N	\N
1030675	0	1337	0	53	3	\N	\N
1030676	0	1337	0	53	4	\N	\N
1030677	0	1337	0	53	5	\N	\N
1030678	0	1337	0	53	6	\N	\N
1030679	0	1337	0	53	7	\N	\N
1030680	0	1337	0	53	8	\N	\N
1030681	0	1337	0	53	9	\N	\N
1030682	0	1337	0	53	10	\N	\N
1030683	0	1337	0	53	11	\N	\N
1030684	0	1337	0	53	12	\N	\N
1030685	0	1337	0	53	13	\N	\N
1030686	0	1337	0	53	14	\N	\N
1030687	0	1337	0	53	15	\N	\N
1030688	0	1337	0	53	16	\N	\N
1030689	0	1337	0	53	17	\N	\N
1030690	0	1337	0	53	18	\N	\N
1030691	0	1337	0	53	19	\N	\N
1030692	0	1337	0	53	20	\N	\N
1030693	0	1337	0	53	21	\N	\N
1030694	0	1337	0	53	22	\N	\N
1030695	0	1337	0	53	23	\N	\N
1030696	0	1337	0	53	24	\N	\N
1030697	0	1337	0	53	25	\N	\N
1030698	0	1337	0	53	26	\N	\N
1030699	0	1337	0	53	27	\N	\N
1030700	0	1337	0	53	28	\N	\N
1030701	0	1337	0	53	29	\N	\N
1030702	0	1337	0	53	30	\N	\N
1030703	0	1337	0	53	31	\N	\N
1030704	0	1337	0	53	32	\N	\N
1030705	0	1337	0	53	33	\N	\N
1030706	0	1337	0	53	34	\N	\N
1030707	0	1337	0	53	35	\N	\N
1030708	0	1337	0	53	36	\N	\N
1030709	0	1337	0	53	37	\N	\N
1030710	0	1337	0	53	38	\N	\N
1030711	0	1337	0	53	39	\N	\N
1030712	0	1337	0	53	40	\N	\N
1030713	0	1337	0	53	41	\N	\N
1030714	0	1337	0	53	42	\N	\N
1030715	0	1337	0	53	43	\N	\N
1030716	0	1337	0	53	44	\N	\N
1030717	0	1337	0	53	45	\N	\N
1030718	0	1337	0	53	46	\N	\N
1030719	0	1337	0	53	47	\N	\N
1030720	0	1337	0	53	48	\N	\N
1030721	0	1337	0	53	49	\N	\N
1030722	0	1337	0	53	50	\N	\N
1030723	0	1337	0	53	51	\N	\N
1030724	0	1337	0	53	52	\N	\N
1030725	0	1337	0	53	53	\N	\N
1030726	0	1337	0	53	54	\N	\N
1030727	0	1337	0	53	55	\N	\N
1030728	0	1337	0	53	56	\N	\N
1030729	0	1337	0	53	57	\N	\N
1030730	0	1337	0	53	58	\N	\N
1030731	0	1337	0	53	59	\N	\N
1030732	0	1337	0	54	-20	\N	\N
1030733	0	1337	0	54	-19	\N	\N
1030734	0	1337	0	54	-18	\N	\N
1030735	0	1337	0	54	-17	\N	\N
1030736	0	1337	0	54	-16	\N	\N
1030737	0	1337	0	54	-15	\N	\N
1030738	0	1337	0	54	-14	\N	\N
1030739	0	1337	0	54	-13	\N	\N
1030740	0	1337	0	54	-12	\N	\N
1030741	0	1337	0	54	-11	\N	\N
1030742	0	1337	0	54	-10	\N	\N
1030743	0	1337	0	54	-9	\N	\N
1030744	0	1337	0	54	-8	\N	\N
1030745	0	1337	0	54	-7	\N	\N
1030746	0	1337	0	54	-6	\N	\N
1030747	0	1337	0	54	-5	\N	\N
1030748	0	1337	0	54	-4	\N	\N
1030749	0	1337	0	54	-3	\N	\N
1030750	0	1337	0	54	-2	\N	\N
1030751	0	1337	0	54	-1	\N	\N
1030752	0	1337	0	54	0	\N	\N
1030753	0	1337	0	54	1	\N	\N
1030754	0	1337	0	54	2	\N	\N
1030755	0	1337	0	54	3	\N	\N
1030756	0	1337	0	54	4	\N	\N
1030757	0	1337	0	54	5	\N	\N
1030758	0	1337	0	54	6	\N	\N
1030759	0	1337	0	54	7	\N	\N
1030760	0	1337	0	54	8	\N	\N
1030761	0	1337	0	54	9	\N	\N
1030762	0	1337	0	54	10	\N	\N
1030763	0	1337	0	54	11	\N	\N
1030764	0	1337	0	54	12	\N	\N
1030765	0	1337	0	54	13	\N	\N
1030766	0	1337	0	54	14	\N	\N
1030767	0	1337	0	54	15	\N	\N
1030768	0	1337	0	54	16	\N	\N
1030769	0	1337	0	54	17	\N	\N
1030770	0	1337	0	54	18	\N	\N
1030771	0	1337	0	54	19	\N	\N
1030772	0	1337	0	54	20	\N	\N
1030773	0	1337	0	54	21	\N	\N
1030774	0	1337	0	54	22	\N	\N
1030775	0	1337	0	54	23	\N	\N
1030776	0	1337	0	54	24	\N	\N
1030777	0	1337	0	54	25	\N	\N
1030778	0	1337	0	54	26	\N	\N
1030779	0	1337	0	54	27	\N	\N
1030780	0	1337	0	54	28	\N	\N
1030781	0	1337	0	54	29	\N	\N
1030782	0	1337	0	54	30	\N	\N
1030783	0	1337	0	54	31	\N	\N
1030784	0	1337	0	54	32	\N	\N
1030785	0	1337	0	54	33	\N	\N
1030786	0	1337	0	54	34	\N	\N
1030787	0	1337	0	54	35	\N	\N
1030788	0	1337	0	54	36	\N	\N
1030789	0	1337	0	54	37	\N	\N
1030790	0	1337	0	54	38	\N	\N
1030791	0	1337	0	54	39	\N	\N
1030792	0	1337	0	54	40	\N	\N
1030793	0	1337	0	54	41	\N	\N
1030794	0	1337	0	54	42	\N	\N
1030795	0	1337	0	54	43	\N	\N
1030796	0	1337	0	54	44	\N	\N
1030797	0	1337	0	54	45	\N	\N
1030798	0	1337	0	54	46	\N	\N
1030799	0	1337	0	54	47	\N	\N
1030800	0	1337	0	54	48	\N	\N
1030801	0	1337	0	54	49	\N	\N
1030802	0	1337	0	54	50	\N	\N
1030803	0	1337	0	54	51	\N	\N
1030804	0	1337	0	54	52	\N	\N
1030805	0	1337	0	54	53	\N	\N
1030806	0	1337	0	54	54	\N	\N
1030807	0	1337	0	54	55	\N	\N
1030808	0	1337	0	54	56	\N	\N
1030809	0	1337	0	54	57	\N	\N
1030810	0	1337	0	54	58	\N	\N
1030811	0	1337	0	54	59	\N	\N
1030812	0	1337	0	55	-20	\N	\N
1030813	0	1337	0	55	-19	\N	\N
1030814	0	1337	0	55	-18	\N	\N
1030815	0	1337	0	55	-17	\N	\N
1030816	0	1337	0	55	-16	\N	\N
1030817	0	1337	0	55	-15	\N	\N
1030818	0	1337	0	55	-14	\N	\N
1030819	0	1337	0	55	-13	\N	\N
1030820	0	1337	0	55	-12	\N	\N
1030821	0	1337	0	55	-11	\N	\N
1030822	0	1337	0	55	-10	\N	\N
1030823	0	1337	0	55	-9	\N	\N
1030824	0	1337	0	55	-8	\N	\N
1030825	0	1337	0	55	-7	\N	\N
1030826	0	1337	0	55	-6	\N	\N
1030827	0	1337	0	55	-5	\N	\N
1030828	0	1337	0	55	-4	\N	\N
1030829	0	1337	0	55	-3	\N	\N
1030830	0	1337	0	55	-2	\N	\N
1030831	0	1337	0	55	-1	\N	\N
1030832	0	1337	0	55	0	\N	\N
1030833	0	1337	0	55	1	\N	\N
1030834	0	1337	0	55	2	\N	\N
1030835	0	1337	0	55	3	\N	\N
1030836	0	1337	0	55	4	\N	\N
1030837	0	1337	0	55	5	\N	\N
1030838	0	1337	0	55	6	\N	\N
1030839	0	1337	0	55	7	\N	\N
1030840	0	1337	0	55	8	\N	\N
1030841	0	1337	0	55	9	\N	\N
1030842	0	1337	0	55	10	\N	\N
1030843	0	1337	0	55	11	\N	\N
1030844	0	1337	0	55	12	\N	\N
1030845	0	1337	0	55	13	\N	\N
1030846	0	1337	0	55	14	\N	\N
1030847	0	1337	0	55	15	\N	\N
1030848	0	1337	0	55	16	\N	\N
1030849	0	1337	0	55	17	\N	\N
1030850	0	1337	0	55	18	\N	\N
1030851	0	1337	0	55	19	\N	\N
1030852	0	1337	0	55	20	\N	\N
1030853	0	1337	0	55	21	\N	\N
1030854	0	1337	0	55	22	\N	\N
1030855	0	1337	0	55	23	\N	\N
1030856	0	1337	0	55	24	\N	\N
1030857	0	1337	0	55	25	\N	\N
1030858	0	1337	0	55	26	\N	\N
1030859	0	1337	0	55	27	\N	\N
1030860	0	1337	0	55	28	\N	\N
1030861	0	1337	0	55	29	\N	\N
1030862	0	1337	0	55	30	\N	\N
1030863	0	1337	0	55	31	\N	\N
1030864	0	1337	0	55	32	\N	\N
1030865	0	1337	0	55	33	\N	\N
1030866	0	1337	0	55	34	\N	\N
1030867	0	1337	0	55	35	\N	\N
1030868	0	1337	0	55	36	\N	\N
1030869	0	1337	0	55	37	\N	\N
1030870	0	1337	0	55	38	\N	\N
1030871	0	1337	0	55	39	\N	\N
1030872	0	1337	0	55	40	\N	\N
1030873	0	1337	0	55	41	\N	\N
1030874	0	1337	0	55	42	\N	\N
1030875	0	1337	0	55	43	\N	\N
1030876	0	1337	0	55	44	\N	\N
1030877	0	1337	0	55	45	\N	\N
1030878	0	1337	0	55	46	\N	\N
1030879	0	1337	0	55	47	\N	\N
1030880	0	1337	0	55	48	\N	\N
1030881	0	1337	0	55	49	\N	\N
1030882	0	1337	0	55	50	\N	\N
1030883	0	1337	0	55	51	\N	\N
1030884	0	1337	0	55	52	\N	\N
1030885	0	1337	0	55	53	\N	\N
1030886	0	1337	0	55	54	\N	\N
1030887	0	1337	0	55	55	\N	\N
1030888	0	1337	0	55	56	\N	\N
1030889	0	1337	0	55	57	\N	\N
1030890	0	1337	0	55	58	\N	\N
1030891	0	1337	0	55	59	\N	\N
1030892	0	1337	0	56	-20	\N	\N
1030893	0	1337	0	56	-19	\N	\N
1030894	0	1337	0	56	-18	\N	\N
1030895	0	1337	0	56	-17	\N	\N
1030896	0	1337	0	56	-16	\N	\N
1030897	0	1337	0	56	-15	\N	\N
1030898	0	1337	0	56	-14	\N	\N
1030899	0	1337	0	56	-13	\N	\N
1030900	0	1337	0	56	-12	\N	\N
1030901	0	1337	0	56	-11	\N	\N
1030902	0	1337	0	56	-10	\N	\N
1030903	0	1337	0	56	-9	\N	\N
1030904	0	1337	0	56	-8	\N	\N
1030905	0	1337	0	56	-7	\N	\N
1030906	0	1337	0	56	-6	\N	\N
1030907	0	1337	0	56	-5	\N	\N
1030908	0	1337	0	56	-4	\N	\N
1030909	0	1337	0	56	-3	\N	\N
1030910	0	1337	0	56	-2	\N	\N
1030911	0	1337	0	56	-1	\N	\N
1030912	0	1337	0	56	0	\N	\N
1030913	0	1337	0	56	1	\N	\N
1030914	0	1337	0	56	2	\N	\N
1030915	0	1337	0	56	3	\N	\N
1030916	0	1337	0	56	4	\N	\N
1030917	0	1337	0	56	5	\N	\N
1030918	0	1337	0	56	6	\N	\N
1030919	0	1337	0	56	7	\N	\N
1030920	0	1337	0	56	8	\N	\N
1030921	0	1337	0	56	9	\N	\N
1030922	0	1337	0	56	10	\N	\N
1030923	0	1337	0	56	11	\N	\N
1030924	0	1337	0	56	12	\N	\N
1030925	0	1337	0	56	13	\N	\N
1030926	0	1337	0	56	14	\N	\N
1030927	0	1337	0	56	15	\N	\N
1030928	0	1337	0	56	16	\N	\N
1030929	0	1337	0	56	17	\N	\N
1030930	0	1337	0	56	18	\N	\N
1030931	0	1337	0	56	19	\N	\N
1030932	0	1337	0	56	20	\N	\N
1030933	0	1337	0	56	21	\N	\N
1030934	0	1337	0	56	22	\N	\N
1030935	0	1337	0	56	23	\N	\N
1030936	0	1337	0	56	24	\N	\N
1030937	0	1337	0	56	25	\N	\N
1030938	0	1337	0	56	26	\N	\N
1030939	0	1337	0	56	27	\N	\N
1030940	0	1337	0	56	28	\N	\N
1030941	0	1337	0	56	29	\N	\N
1030942	0	1337	0	56	30	\N	\N
1030943	0	1337	0	56	31	\N	\N
1030944	0	1337	0	56	32	\N	\N
1030945	0	1337	0	56	33	\N	\N
1030946	0	1337	0	56	34	\N	\N
1030947	0	1337	0	56	35	\N	\N
1030948	0	1337	0	56	36	\N	\N
1030949	0	1337	0	56	37	\N	\N
1030950	0	1337	0	56	38	\N	\N
1030951	0	1337	0	56	39	\N	\N
1030952	0	1337	0	56	40	\N	\N
1030953	0	1337	0	56	41	\N	\N
1030954	0	1337	0	56	42	\N	\N
1030955	0	1337	0	56	43	\N	\N
1030956	0	1337	0	56	44	\N	\N
1030957	0	1337	0	56	45	\N	\N
1030958	0	1337	0	56	46	\N	\N
1030959	0	1337	0	56	47	\N	\N
1030960	0	1337	0	56	48	\N	\N
1030961	0	1337	0	56	49	\N	\N
1030962	0	1337	0	56	50	\N	\N
1030963	0	1337	0	56	51	\N	\N
1030964	0	1337	0	56	52	\N	\N
1030965	0	1337	0	56	53	\N	\N
1030966	0	1337	0	56	54	\N	\N
1030967	0	1337	0	56	55	\N	\N
1030968	0	1337	0	56	56	\N	\N
1030969	0	1337	0	56	57	\N	\N
1030970	0	1337	0	56	58	\N	\N
1030971	0	1337	0	56	59	\N	\N
1030972	0	1337	0	57	-20	\N	\N
1030973	0	1337	0	57	-19	\N	\N
1030974	0	1337	0	57	-18	\N	\N
1030975	0	1337	0	57	-17	\N	\N
1030976	0	1337	0	57	-16	\N	\N
1030977	0	1337	0	57	-15	\N	\N
1030978	0	1337	0	57	-14	\N	\N
1030979	0	1337	0	57	-13	\N	\N
1030980	0	1337	0	57	-12	\N	\N
1030981	0	1337	0	57	-11	\N	\N
1030982	0	1337	0	57	-10	\N	\N
1030983	0	1337	0	57	-9	\N	\N
1030984	0	1337	0	57	-8	\N	\N
1030985	0	1337	0	57	-7	\N	\N
1030986	0	1337	0	57	-6	\N	\N
1030987	0	1337	0	57	-5	\N	\N
1030988	0	1337	0	57	-4	\N	\N
1030989	0	1337	0	57	-3	\N	\N
1030990	0	1337	0	57	-2	\N	\N
1030991	0	1337	0	57	-1	\N	\N
1030992	0	1337	0	57	0	\N	\N
1030993	0	1337	0	57	1	\N	\N
1030994	0	1337	0	57	2	\N	\N
1030995	0	1337	0	57	3	\N	\N
1030996	0	1337	0	57	4	\N	\N
1030997	0	1337	0	57	5	\N	\N
1030998	0	1337	0	57	6	\N	\N
1030999	0	1337	0	57	7	\N	\N
1031000	0	1337	0	57	8	\N	\N
1031001	0	1337	0	57	9	\N	\N
1031002	0	1337	0	57	10	\N	\N
1031003	0	1337	0	57	11	\N	\N
1031004	0	1337	0	57	12	\N	\N
1031005	0	1337	0	57	13	\N	\N
1031006	0	1337	0	57	14	\N	\N
1031007	0	1337	0	57	15	\N	\N
1031008	0	1337	0	57	16	\N	\N
1031009	0	1337	0	57	17	\N	\N
1031010	0	1337	0	57	18	\N	\N
1031011	0	1337	0	57	19	\N	\N
1031012	0	1337	0	57	20	\N	\N
1031013	0	1337	0	57	21	\N	\N
1031014	0	1337	0	57	22	\N	\N
1031015	0	1337	0	57	23	\N	\N
1031016	0	1337	0	57	24	\N	\N
1031017	0	1337	0	57	25	\N	\N
1031018	0	1337	0	57	26	\N	\N
1031019	0	1337	0	57	27	\N	\N
1031020	0	1337	0	57	28	\N	\N
1031021	0	1337	0	57	29	\N	\N
1031022	0	1337	0	57	30	\N	\N
1031023	0	1337	0	57	31	\N	\N
1031024	0	1337	0	57	32	\N	\N
1031025	0	1337	0	57	33	\N	\N
1031026	0	1337	0	57	34	\N	\N
1031027	0	1337	0	57	35	\N	\N
1031028	0	1337	0	57	36	\N	\N
1031029	0	1337	0	57	37	\N	\N
1031030	0	1337	0	57	38	\N	\N
1031031	0	1337	0	57	39	\N	\N
1031032	0	1337	0	57	40	\N	\N
1031033	0	1337	0	57	41	\N	\N
1031034	0	1337	0	57	42	\N	\N
1031035	0	1337	0	57	43	\N	\N
1031036	0	1337	0	57	44	\N	\N
1031037	0	1337	0	57	45	\N	\N
1031038	0	1337	0	57	46	\N	\N
1031039	0	1337	0	57	47	\N	\N
1031040	0	1337	0	57	48	\N	\N
1031041	0	1337	0	57	49	\N	\N
1031042	0	1337	0	57	50	\N	\N
1031043	0	1337	0	57	51	\N	\N
1031044	0	1337	0	57	52	\N	\N
1031045	0	1337	0	57	53	\N	\N
1031046	0	1337	0	57	54	\N	\N
1031047	0	1337	0	57	55	\N	\N
1031048	0	1337	0	57	56	\N	\N
1031049	0	1337	0	57	57	\N	\N
1031050	0	1337	0	57	58	\N	\N
1031051	0	1337	0	57	59	\N	\N
1031052	0	1337	0	58	-20	\N	\N
1031053	0	1337	0	58	-19	\N	\N
1031054	0	1337	0	58	-18	\N	\N
1031055	0	1337	0	58	-17	\N	\N
1031056	0	1337	0	58	-16	\N	\N
1031057	0	1337	0	58	-15	\N	\N
1031058	0	1337	0	58	-14	\N	\N
1031059	0	1337	0	58	-13	\N	\N
1031060	0	1337	0	58	-12	\N	\N
1031061	0	1337	0	58	-11	\N	\N
1031062	0	1337	0	58	-10	\N	\N
1031063	0	1337	0	58	-9	\N	\N
1031064	0	1337	0	58	-8	\N	\N
1031065	0	1337	0	58	-7	\N	\N
1031066	0	1337	0	58	-6	\N	\N
1031067	0	1337	0	58	-5	\N	\N
1031068	0	1337	0	58	-4	\N	\N
1031069	0	1337	0	58	-3	\N	\N
1031070	0	1337	0	58	-2	\N	\N
1031071	0	1337	0	58	-1	\N	\N
1031072	0	1337	0	58	0	\N	\N
1031073	0	1337	0	58	1	\N	\N
1031074	0	1337	0	58	2	\N	\N
1031075	0	1337	0	58	3	\N	\N
1031076	0	1337	0	58	4	\N	\N
1031077	0	1337	0	58	5	\N	\N
1031078	0	1337	0	58	6	\N	\N
1031079	0	1337	0	58	7	\N	\N
1031080	0	1337	0	58	8	\N	\N
1031081	0	1337	0	58	9	\N	\N
1031082	0	1337	0	58	10	\N	\N
1031083	0	1337	0	58	11	\N	\N
1031084	0	1337	0	58	12	\N	\N
1031085	0	1337	0	58	13	\N	\N
1031086	0	1337	0	58	14	\N	\N
1031087	0	1337	0	58	15	\N	\N
1031088	0	1337	0	58	16	\N	\N
1031089	0	1337	0	58	17	\N	\N
1031090	0	1337	0	58	18	\N	\N
1031091	0	1337	0	58	19	\N	\N
1031092	0	1337	0	58	20	\N	\N
1031093	0	1337	0	58	21	\N	\N
1031094	0	1337	0	58	22	\N	\N
1031095	0	1337	0	58	23	\N	\N
1031096	0	1337	0	58	24	\N	\N
1031097	0	1337	0	58	25	\N	\N
1031098	0	1337	0	58	26	\N	\N
1031099	0	1337	0	58	27	\N	\N
1031100	0	1337	0	58	28	\N	\N
1031101	0	1337	0	58	29	\N	\N
1031102	0	1337	0	58	30	\N	\N
1031103	0	1337	0	58	31	\N	\N
1031104	0	1337	0	58	32	\N	\N
1031105	0	1337	0	58	33	\N	\N
1031106	0	1337	0	58	34	\N	\N
1031107	0	1337	0	58	35	\N	\N
1031108	0	1337	0	58	36	\N	\N
1031109	0	1337	0	58	37	\N	\N
1031110	0	1337	0	58	38	\N	\N
1031111	0	1337	0	58	39	\N	\N
1031112	0	1337	0	58	40	\N	\N
1031113	0	1337	0	58	41	\N	\N
1031114	0	1337	0	58	42	\N	\N
1031115	0	1337	0	58	43	\N	\N
1031116	0	1337	0	58	44	\N	\N
1031117	0	1337	0	58	45	\N	\N
1031118	0	1337	0	58	46	\N	\N
1031119	0	1337	0	58	47	\N	\N
1031120	0	1337	0	58	48	\N	\N
1031121	0	1337	0	58	49	\N	\N
1031122	0	1337	0	58	50	\N	\N
1031123	0	1337	0	58	51	\N	\N
1031124	0	1337	0	58	52	\N	\N
1031125	0	1337	0	58	53	\N	\N
1031126	0	1337	0	58	54	\N	\N
1031127	0	1337	0	58	55	\N	\N
1031128	0	1337	0	58	56	\N	\N
1031129	0	1337	0	58	57	\N	\N
1031130	0	1337	0	58	58	\N	\N
1031131	0	1337	0	58	59	\N	\N
1031132	0	1337	0	59	-20	\N	\N
1031133	0	1337	0	59	-19	\N	\N
1031134	0	1337	0	59	-18	\N	\N
1031135	0	1337	0	59	-17	\N	\N
1031136	0	1337	0	59	-16	\N	\N
1031137	0	1337	0	59	-15	\N	\N
1031138	0	1337	0	59	-14	\N	\N
1031139	0	1337	0	59	-13	\N	\N
1031140	0	1337	0	59	-12	\N	\N
1031141	0	1337	0	59	-11	\N	\N
1031142	0	1337	0	59	-10	\N	\N
1031143	0	1337	0	59	-9	\N	\N
1031144	0	1337	0	59	-8	\N	\N
1031145	0	1337	0	59	-7	\N	\N
1031146	0	1337	0	59	-6	\N	\N
1031147	0	1337	0	59	-5	\N	\N
1031148	0	1337	0	59	-4	\N	\N
1031149	0	1337	0	59	-3	\N	\N
1031150	0	1337	0	59	-2	\N	\N
1031151	0	1337	0	59	-1	\N	\N
1031152	0	1337	0	59	0	\N	\N
1031153	0	1337	0	59	1	\N	\N
1031154	0	1337	0	59	2	\N	\N
1031155	0	1337	0	59	3	\N	\N
1031156	0	1337	0	59	4	\N	\N
1031157	0	1337	0	59	5	\N	\N
1031158	0	1337	0	59	6	\N	\N
1031159	0	1337	0	59	7	\N	\N
1031160	0	1337	0	59	8	\N	\N
1031161	0	1337	0	59	9	\N	\N
1031162	0	1337	0	59	10	\N	\N
1031163	0	1337	0	59	11	\N	\N
1031164	0	1337	0	59	12	\N	\N
1031165	0	1337	0	59	13	\N	\N
1031166	0	1337	0	59	14	\N	\N
1031167	0	1337	0	59	15	\N	\N
1031168	0	1337	0	59	16	\N	\N
1031169	0	1337	0	59	17	\N	\N
1031170	0	1337	0	59	18	\N	\N
1031171	0	1337	0	59	19	\N	\N
1031172	0	1337	0	59	20	\N	\N
1031173	0	1337	0	59	21	\N	\N
1031174	0	1337	0	59	22	\N	\N
1031175	0	1337	0	59	23	\N	\N
1031176	0	1337	0	59	24	\N	\N
1031177	0	1337	0	59	25	\N	\N
1031178	0	1337	0	59	26	\N	\N
1031179	0	1337	0	59	27	\N	\N
1031180	0	1337	0	59	28	\N	\N
1031181	0	1337	0	59	29	\N	\N
1031182	0	1337	0	59	30	\N	\N
1031183	0	1337	0	59	31	\N	\N
1031184	0	1337	0	59	32	\N	\N
1031185	0	1337	0	59	33	\N	\N
1031186	0	1337	0	59	34	\N	\N
1031187	0	1337	0	59	35	\N	\N
1031188	0	1337	0	59	36	\N	\N
1031189	0	1337	0	59	37	\N	\N
1031190	0	1337	0	59	38	\N	\N
1031191	0	1337	0	59	39	\N	\N
1031192	0	1337	0	59	40	\N	\N
1031193	0	1337	0	59	41	\N	\N
1031194	0	1337	0	59	42	\N	\N
1031195	0	1337	0	59	43	\N	\N
1031196	0	1337	0	59	44	\N	\N
1031197	0	1337	0	59	45	\N	\N
1031198	0	1337	0	59	46	\N	\N
1031199	0	1337	0	59	47	\N	\N
1031200	0	1337	0	59	48	\N	\N
1031201	0	1337	0	59	49	\N	\N
1031202	0	1337	0	59	50	\N	\N
1031203	0	1337	0	59	51	\N	\N
1031204	0	1337	0	59	52	\N	\N
1031205	0	1337	0	59	53	\N	\N
1031206	0	1337	0	59	54	\N	\N
1031207	0	1337	0	59	55	\N	\N
1031208	0	1337	0	59	56	\N	\N
1031209	0	1337	0	59	57	\N	\N
1031210	0	1337	0	59	58	\N	\N
1031211	0	1337	0	59	59	\N	\N
\.


--
-- Data for Name: locationtype; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY locationtype (typeid, name, cssname, searchrate) FROM stdin;
0	Deep Space	space	0.20000000000000001
1	Medbay	medbay	0.20000000000000001
2	Living Quarters	living	0.20000000000000001
3	Security Outpost	security	0.20000000000000001
4	Corridor	corridor	0.20000000000000001
6	Warehouse	warehs	0.20000000000000001
8	Command Center	cmd	0.20000000000000001
9	Elevator	elev	0.20000000000000001
10	Airlock	airlk	0.20000000000000001
11	Shuttle Bay	shutbay	0.20000000000000001
12	Mall	mall	0.20000000000000001
14	Commercial District	commer	0.20000000000000001
15	Armory	armory	0.20000000000000001
16	Nightclub	nc	0.20000000000000001
17	Bar	bar	0.20000000000000001
18	Gymnasium	gym	0.20000000000000001
21	Brig	brig	0.20000000000000001
23	Locker room	delete	0.20000000000000001
24	Biology Lab	biolab	0.20000000000000001
25	Physics lab	phylab	0.20000000000000001
26	Astronomy Lab	astrlab	0.20000000000000001
27	Psionic Lab	psilab	0.20000000000000001
28	Geology lab	geolab	0.20000000000000001
29	Robotics lab	roblab	0.20000000000000001
30	Fenetics lab	genlab	0.20000000000000001
32	Generator Room	generator	0.20000000000000001
33	Observation Deck	observdk	0.20000000000000001
35	Arena	arena	0.20000000000000001
36	Life Support	lifespt	0.20000000000000001
22	Solar Panels	delete	0.20000000000000001
37	Education Center	edu	0.20000000000000001
34	Worhship Facility	church	0.20000000000000001
38	Damage Control	damage	0.20000000000000001
39	Supply Depot	supply	0.20000000000000001
40	Infirmary	infirm	0.20000000000000001
41	Waste Processing Center	waste	0.20000000000000001
42	Information Distribution	lib	0.20000000000000001
43	Grocery Depot	grocery	0.20000000000000001
44	Vocational Training Center	votech	0.20000000000000001
45	Power Distribution	power	0.20000000000000001
7	Hydroponics Bay	greenhs	0.20000000000000001
5	Manufacturing Area	manu	0.20000000000000001
19	Meditation Commune	medrm	0.20000000000000001
13	Nature Park	park	0.20000000000000001
20	Arcade	recrm	0.20000000000000001
46	Security Depot	secdep	0.20000000000000001
47	Amusement Park	coaster	0.20000000000000001
48	Commercial Food Dispensary	food	0.20000000000000001
49	Slums	slum	0.20000000000000001
51	Infotainment Theater	theatre	0.20000000000000001
52	Office Space	office	0.20000000000000001
53	Raw Processing Facility	raw	0.20000000000000001
31	Cloning Facility	cryolab	0.20000000000000001
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY messages (messageid, messagedate, message, read, type, altid) FROM stdin;
19	2010-01-21 21:42:50.341491	Testing this for fun and profit...NOT	t	0	9
23	2010-01-22 00:40:49.713813	<a href="viewCharacter.jsp?id=9">Test2</a> said, "test"	t	0	9
25	2010-01-22 00:41:21.134757	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me tests emoting as well"	t	0	9
27	2010-01-22 00:42:31.630785	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me tests emoting again"	t	0	9
29	2010-01-22 00:43:07.790509	&lt;a href&#061;&quot;viewCharacter&#046;jsp&#063;id&#061;2&quot;&gt;A lonely kitten&lt;&#047;a&gt; said&#044; &quot;&#047;me tests emoting again&quot;	t	0	9
31	2010-01-22 00:44:00.542327	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;that sucked"	t	0	9
33	2010-01-22 00:44:09.434668	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me tries one more time"	t	0	9
35	2010-01-22 00:44:55.143479	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me is getting very frustrated"	t	0	9
37	2010-01-22 00:45:36.611948	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> 47;me tests emoting again	t	0	9
1	2010-01-19 22:24:52.44637	test	t	0	1
2	2010-01-19 22:24:53.668333	test	t	0	1
3	2010-01-19 22:24:54.068009	test	t	0	1
4	2010-01-19 22:24:54.457283	test	t	0	1
5	2010-01-19 22:24:54.756637	test	t	0	1
6	2010-01-19 22:24:55.016038	test	t	0	1
7	2010-01-19 22:24:55.295531	test	t	0	1
8	2010-01-19 22:24:55.574894	test	t	0	1
9	2010-01-19 22:24:55.914473	test	t	0	1
10	2010-01-19 22:24:56.243906	test	t	0	1
11	2010-01-19 22:24:56.573139	test	t	0	1
12	2010-01-19 22:24:56.912665	test	t	0	1
13	2010-01-19 22:24:57.212379	test	t	0	1
14	2010-01-19 22:24:57.541379	test	t	0	1
21	2010-01-21 21:42:50.341491	Testing this for fun and profit...NOT	t	0	2
24	2010-01-22 00:40:49.713813	<a href="viewCharacter.jsp?id=9">Test2</a> said, "test"	t	0	2
26	2010-01-22 00:41:21.134757	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me tests emoting as well"	t	0	2
39	2010-01-22 00:46:41.833208	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> me is getting very frustrated	t	0	9
41	2010-01-22 00:46:59.353725	<a href="viewCharacter.jsp?id=2">A lonely kitten</a>  is getting very frustrated	t	0	9
15	2010-01-19 22:24:57.851198	test	t	0	1
16	2010-01-19 22:24:58.170664	test16	t	0	1
17	2010-01-19 22:24:58.480154	test17	t	0	1
18	2010-01-19 22:24:58.789528	test18	t	0	1
20	2010-01-21 21:42:50.341491	Testing this for fun and profit...NOT	t	0	1
22	2010-01-22 00:40:22.365005	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "Test"	t	0	1
43	2010-01-22 00:53:08.101025	<a href="viewCharacter.jsp?id=1">Purveyor</a>  test	t	0	1
44	2010-01-22 01:17:12.18739	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "Testing 1&#045;2&#045;3  Testing"	t	0	1
45	2010-01-22 11:03:27.900702	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "Helloo"	t	0	1
46	2010-01-22 11:05:02.470739	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "&#124;&#063;&#124;"	t	0	1
47	2010-01-22 11:05:10.839404	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "Helloos&#063;&#063;&#063;"	t	0	1
49	2010-01-22 11:19:35.793644	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "help"	t	0	1
28	2010-01-22 00:42:31.630785	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me tests emoting again"	t	0	2
30	2010-01-22 00:43:07.790509	&lt;a href&#061;&quot;viewCharacter&#046;jsp&#063;id&#061;2&quot;&gt;A lonely kitten&lt;&#047;a&gt; said&#044; &quot;&#047;me tests emoting again&quot;	t	0	2
32	2010-01-22 00:44:00.542327	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;that sucked"	t	0	2
34	2010-01-22 00:44:09.434668	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me tries one more time"	t	0	2
36	2010-01-22 00:44:55.143479	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> said, "&#047;me is getting very frustrated"	t	0	2
38	2010-01-22 00:45:36.611948	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> 47;me tests emoting again	t	0	2
40	2010-01-22 00:46:41.833208	<a href="viewCharacter.jsp?id=2">A lonely kitten</a> me is getting very frustrated	t	0	2
42	2010-01-22 00:46:59.353725	<a href="viewCharacter.jsp?id=2">A lonely kitten</a>  is getting very frustrated	t	0	2
1107	2010-02-18 22:11:02.339204	You search and find a Vodka.	t	0	2
1108	2010-02-18 22:11:02.339204	You search and find nothing.	t	0	2
1109	2010-02-18 22:11:02.339204	You search and find nothing.	t	0	2
1110	2010-02-18 22:11:02.339204	You search and find nothing.	t	0	2
1111	2010-02-18 22:11:02.339204	You search and find nothing.	t	0	2
1102	2010-02-18 22:11:02.308427	You search and find nothing.	t	0	2
1103	2010-02-18 22:11:02.308427	You search and find nothing.	t	0	2
1104	2010-02-18 22:11:02.308427	You search and find a Vodka.	t	0	2
1105	2010-02-18 22:11:02.308427	You search and find nothing.	t	0	2
1106	2010-02-18 22:11:02.308427	You search and find a Energy pack .	t	0	2
1112	2010-02-18 22:11:02.594072	You search and find a Vodka.	t	0	2
1113	2010-02-18 22:11:02.594072	You search and find a Energy pistol.	t	0	2
1092	2010-02-18 20:20:07.604965	You search and find nothing.	t	0	13
1093	2010-02-18 20:20:07.604965	You search and find nothing.	t	0	13
1094	2010-02-18 20:20:07.604965	You search and find a Vodka.	t	0	13
1095	2010-02-18 20:20:07.604965	You search and find nothing.	t	0	13
1096	2010-02-18 20:20:07.604965	You search and find a Energy rifle .	t	0	13
1097	2010-02-18 20:20:08.208579	You search and find nothing.	t	0	13
1098	2010-02-18 20:20:08.208579	You search and find nothing.	t	0	13
1099	2010-02-18 20:20:08.208579	You search and find nothing.	t	0	13
1100	2010-02-18 20:20:08.208579	You search and find nothing.	t	0	13
1101	2010-02-18 20:20:08.208579	You search and find nothing.	t	0	13
1597	2010-02-21 23:12:51.341632	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	12
1598	2010-02-21 23:12:53.757539	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	12
1599	2010-02-21 23:12:56.162336	You search and find a Energy pack .	t	0	12
1600	2010-02-21 23:12:56.162336	You search and find nothing.	t	0	12
1601	2010-02-21 23:12:56.162336	You search and find nothing.	t	0	12
1602	2010-02-21 23:12:56.162336	You search and find nothing.	t	0	12
1603	2010-02-21 23:12:56.162336	You search and find nothing.	t	0	12
2351	2010-03-11 08:55:20.403184	You have unequipped your Energy pistol.	t	0	13
2352	2010-03-11 08:55:41.163372	You drop your Energy pistol.	t	0	13
2353	2010-03-11 08:55:41.767643	You drop your Energy pistol.	t	0	13
2354	2010-03-11 08:55:42.399322	You drop your Energy pack.	t	0	13
48	2010-01-22 11:05:21.338849	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "hello&#063;&#063;&#063;&#063;&#047;&#047;&#047;&#047;&#047;&#047;"	t	0	1
50	2010-01-22 11:19:53.312329	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "test"	t	0	1
51	2010-01-22 11:20:03.307672	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "1"	t	0	1
52	2010-01-22 11:20:06.209887	<a href="viewCharacter.jsp?id=1">Purveyor</a> said, "2"	t	0	1
55	2010-01-25 06:24:21.227702	<a href="/viewCharacter.jsp?id=10">Test3</a> said, "Well&#044; hello there fine citizens&#046;  "	t	0	10
53	2010-01-25 06:24:21.227702	<a href="/viewCharacter.jsp?id=10">Test3</a> said, "Well&#044; hello there fine citizens&#046;  "	t	0	1
54	2010-01-25 06:24:21.227702	<a href="/viewCharacter.jsp?id=10">Test3</a> said, "Well&#044; hello there fine citizens&#046;  "	t	0	9
59	2010-02-06 20:45:48.974979	<a href="/viewCharacter.jsp?id=1">Uncle Purvy</a> said, "Did I fix this&#063;"	t	0	1
56	2010-02-06 20:45:48.974979	<a href="/viewCharacter.jsp?id=1">Uncle Purvy</a> said, "Did I fix this&#063;"	t	0	9
60	2010-02-09 23:46:45.072063	You search and find nothing.	t	0	1
57	2010-02-06 20:45:48.974979	<a href="/viewCharacter.jsp?id=1">Uncle Purvy</a> said, "Did I fix this&#063;"	t	0	10
61	2010-02-09 23:52:53.678189	You search and find nothing.	t	0	10
62	2010-02-09 23:53:41.916773	You search and find nothing.	t	0	10
63	2010-02-09 23:54:32.68591	You search and find nothing.	t	0	1
64	2010-02-10 00:01:47.264647	You search and find nothing.	t	0	1
65	2010-02-10 00:01:47.264647	You search and find nothing.	t	0	1
66	2010-02-10 00:01:47.264647	You search and find nothing.	t	0	1
67	2010-02-10 00:01:47.264647	You search and find nothing.	t	0	1
68	2010-02-10 00:01:47.264647	You search and find nothing.	t	0	1
69	2010-02-10 00:46:04.245412	You search and find nothing.	t	0	1
70	2010-02-10 00:46:13.14071	You search and find nothing.	t	0	1
71	2010-02-10 00:46:13.14071	You search and find nothing.	t	0	1
72	2010-02-10 00:46:13.14071	You search and find nothing.	t	0	1
73	2010-02-10 00:46:13.14071	You search and find nothing.	t	0	1
74	2010-02-10 00:46:13.14071	You search and find nothing.	t	0	1
1114	2010-02-18 22:11:02.594072	You search and find nothing.	t	0	2
79	2010-02-10 00:46:14.603974	You search and find nothing.	t	0	1
1115	2010-02-18 22:11:02.594072	You search and find a Energy pistol.	t	0	2
81	2010-02-10 00:47:01.134843	You search and find nothing.	t	0	1
82	2010-02-10 00:47:11.305035	You search and find nothing.	t	0	1
83	2010-02-10 00:47:11.347654	You search and find nothing.	t	0	1
84	2010-02-10 00:49:03.349151	You search and find nothing.	t	0	1
2355	2010-03-11 08:55:43.19932	You drop your Energy pack.	t	0	13
87	2010-02-10 00:49:11.222387	You search and find nothing.	t	0	1
88	2010-02-10 00:49:11.420132	You search and find nothing.	t	0	1
89	2010-02-10 00:49:38.244322	You search and find nothing.	t	0	1
90	2010-02-10 01:09:25.776437	You search and find nothing.	t	0	1
91	2010-02-10 01:09:25.776437	You search and find nothing.	t	0	1
92	2010-02-10 01:09:25.776437	You search and find nothing.	t	0	1
93	2010-02-10 01:09:25.776437	You search and find a Energy rifle .	t	0	1
94	2010-02-10 01:09:25.776437	You search and find nothing.	t	0	1
95	2010-02-10 01:10:14.124252	You search and find nothing.	t	0	1
96	2010-02-10 01:10:14.124252	You search and find nothing.	t	0	1
97	2010-02-10 01:10:14.124252	You search and find nothing.	t	0	1
98	2010-02-10 01:10:14.124252	You search and find a Vodka.	t	0	1
99	2010-02-10 01:10:14.124252	You search and find a Vodka.	t	0	1
100	2010-02-10 01:10:16.32498	You search and find nothing.	t	0	1
101	2010-02-10 01:10:16.32498	You search and find nothing.	t	0	1
102	2010-02-10 01:10:16.32498	You search and find nothing.	t	0	1
103	2010-02-10 01:10:16.32498	You search and find a MRE.	t	0	1
104	2010-02-10 01:10:16.32498	You search and find a Energy pack .	t	0	1
105	2010-02-10 01:12:19.721364	You search and find nothing.	t	0	1
106	2010-02-10 01:12:19.721364	You search and find a Vodka.	t	0	1
107	2010-02-10 01:12:19.721364	You search and find nothing.	t	0	1
108	2010-02-10 01:12:19.721364	You search and find nothing.	t	0	1
109	2010-02-10 01:12:19.721364	You search and find nothing.	t	0	1
110	2010-02-10 01:13:57.329402	You search and find a MRE.	t	0	1
111	2010-02-10 01:13:57.329402	You search and find nothing.	t	0	1
112	2010-02-10 01:13:57.329402	You search and find nothing.	t	0	1
113	2010-02-10 01:13:57.329402	You search and find nothing.	t	0	1
114	2010-02-10 01:13:57.329402	You search and find a MRE.	t	0	1
115	2010-02-10 01:14:35.80391	You search and find nothing.	t	0	1
116	2010-02-10 01:14:35.80391	You search and find nothing.	t	0	1
117	2010-02-10 01:14:35.80391	You search and find nothing.	t	0	1
118	2010-02-10 01:14:35.80391	You search and find nothing.	t	0	1
119	2010-02-10 01:14:35.80391	You search and find nothing.	t	0	1
120	2010-02-10 01:14:50.319066	You search and find nothing.	t	0	1
121	2010-02-10 01:14:50.319066	You search and find nothing.	t	0	1
122	2010-02-10 01:14:50.319066	You search and find a Vodka.	t	0	1
123	2010-02-10 01:14:50.319066	You search and find nothing.	t	0	1
124	2010-02-10 01:14:50.319066	You search and find nothing.	t	0	1
125	2010-02-10 01:14:51.317107	You search and find nothing.	t	0	1
126	2010-02-10 01:14:51.317107	You search and find nothing.	t	0	1
127	2010-02-10 01:14:51.317107	You search and find nothing.	t	0	1
128	2010-02-10 01:14:51.317107	You search and find nothing.	t	0	1
129	2010-02-10 01:14:51.317107	You search and find a Energy pistol.	t	0	1
130	2010-02-10 01:14:51.997004	You search and find nothing.	t	0	1
131	2010-02-10 01:14:51.997004	You search and find nothing.	t	0	1
132	2010-02-10 01:14:51.997004	You search and find nothing.	t	0	1
133	2010-02-10 01:14:51.997004	You search and find nothing.	t	0	1
134	2010-02-10 01:14:51.997004	You search and find nothing.	t	0	1
135	2010-02-10 01:14:53.44637	You search and find nothing.	t	0	1
136	2010-02-10 01:14:53.44637	You search and find nothing.	t	0	1
137	2010-02-10 01:14:53.44637	You search and find nothing.	t	0	1
138	2010-02-10 01:14:53.44637	You search and find nothing.	t	0	1
139	2010-02-10 01:14:53.44637	You search and find a Energy pack .	t	0	1
140	2010-02-10 01:14:53.955816	You search and find nothing.	t	0	1
58	2010-02-06 20:45:48.974979	<a href="/viewCharacter.jsp?id=1">Uncle Purvy</a> said, "Did I fix this&#063;"	t	0	12
2356	2010-03-11 08:55:45.293458	You drop your null.	t	0	13
141	2010-02-10 01:14:53.955816	You search and find nothing.	t	0	1
142	2010-02-10 01:14:53.955816	You search and find nothing.	t	0	1
143	2010-02-10 01:14:53.955816	You search and find nothing.	t	0	1
144	2010-02-10 01:14:53.955816	You search and find nothing.	t	0	1
145	2010-02-10 01:14:54.389371	You search and find nothing.	t	0	1
146	2010-02-10 01:14:54.389371	You search and find nothing.	t	0	1
147	2010-02-10 01:14:54.389371	You search and find nothing.	t	0	1
148	2010-02-10 01:14:54.389371	You search and find nothing.	t	0	1
149	2010-02-10 01:14:54.389371	You search and find nothing.	t	0	1
150	2010-02-10 01:16:52.527612	You search and find nothing.	t	0	1
151	2010-02-10 01:16:52.527612	You search and find nothing.	t	0	1
152	2010-02-10 01:16:52.527612	You search and find nothing.	t	0	1
153	2010-02-10 01:16:52.527612	You search and find a Vodka.	t	0	1
154	2010-02-10 01:16:52.527612	You search and find nothing.	t	0	1
155	2010-02-10 01:17:38.023048	You search and find nothing.	t	0	1
156	2010-02-10 01:17:38.023048	You search and find a Vodka.	t	0	1
157	2010-02-10 01:17:38.023048	You search and find nothing.	t	0	1
158	2010-02-10 01:17:38.023048	You search and find nothing.	t	0	1
159	2010-02-10 01:17:38.023048	You search and find nothing.	t	0	1
160	2010-02-10 01:17:43.15405	You search and find a Energy pack .	t	0	1
161	2010-02-10 01:17:43.15405	You search and find nothing.	t	0	1
162	2010-02-10 01:17:43.15405	You search and find nothing.	t	0	1
163	2010-02-10 01:17:43.15405	You search and find nothing.	t	0	1
164	2010-02-10 01:17:43.15405	You search and find nothing.	t	0	1
165	2010-02-10 01:17:44.859698	You search and find nothing.	t	0	1
166	2010-02-10 01:17:44.859698	You search and find nothing.	t	0	1
167	2010-02-10 01:17:44.859698	You search and find nothing.	t	0	1
168	2010-02-10 01:17:44.859698	You search and find a Vodka.	t	0	1
169	2010-02-10 01:17:44.859698	You search and find nothing.	t	0	1
170	2010-02-10 01:17:46.917645	You search and find nothing.	t	0	1
171	2010-02-10 01:17:46.917645	You search and find a Energy pistol.	t	0	1
172	2010-02-10 01:17:46.917645	You search and find nothing.	t	0	1
173	2010-02-10 01:17:46.917645	You search and find nothing.	t	0	1
174	2010-02-10 01:17:46.917645	You search and find nothing.	t	0	1
175	2010-02-10 01:17:48.668966	You search and find a Vodka.	t	0	1
176	2010-02-10 01:17:48.668966	You search and find nothing.	t	0	1
177	2010-02-10 01:17:48.668966	You search and find nothing.	t	0	1
178	2010-02-10 01:17:48.668966	You search and find nothing.	t	0	1
179	2010-02-10 01:17:48.668966	You search and find nothing.	t	0	1
180	2010-02-10 01:17:50.710001	You search and find nothing.	t	0	1
181	2010-02-10 01:17:50.710001	You search and find nothing.	t	0	1
182	2010-02-10 01:17:50.710001	You search and find a Energy pack .	t	0	1
183	2010-02-10 01:17:50.710001	You search and find nothing.	t	0	1
184	2010-02-10 01:17:50.710001	You search and find a Vodka.	t	0	1
185	2010-02-10 01:17:52.469	You search and find nothing.	t	0	1
186	2010-02-10 01:17:52.469	You search and find nothing.	t	0	1
187	2010-02-10 01:17:52.469	You search and find nothing.	t	0	1
188	2010-02-10 01:17:52.469	You search and find nothing.	t	0	1
189	2010-02-10 01:17:52.469	You search and find nothing.	t	0	1
190	2010-02-10 01:17:53.845864	You search and find nothing.	t	0	1
191	2010-02-10 01:17:53.845864	You search and find nothing.	t	0	1
192	2010-02-10 01:17:53.845864	You search and find nothing.	t	0	1
193	2010-02-10 01:17:53.845864	You search and find nothing.	t	0	1
194	2010-02-10 01:17:53.845864	You search and find nothing.	t	0	1
195	2010-02-10 01:17:54.884228	You search and find a MRE.	t	0	1
196	2010-02-10 01:17:54.884228	You search and find nothing.	t	0	1
197	2010-02-10 01:17:54.884228	You search and find nothing.	t	0	1
198	2010-02-10 01:17:54.884228	You search and find nothing.	t	0	1
199	2010-02-10 01:17:54.884228	You search and find a Energy rifle .	t	0	1
200	2010-02-10 01:17:56.084051	You search and find nothing.	t	0	1
201	2010-02-10 01:17:56.084051	You search and find nothing.	t	0	1
202	2010-02-10 01:17:56.084051	You search and find a MRE.	t	0	1
203	2010-02-10 01:17:56.084051	You search and find nothing.	t	0	1
204	2010-02-10 01:17:56.084051	You search and find nothing.	t	0	1
205	2010-02-10 01:17:56.748775	You search and find nothing.	t	0	1
206	2010-02-10 01:17:56.748775	You search and find nothing.	t	0	1
207	2010-02-10 01:17:56.748775	You search and find nothing.	t	0	1
208	2010-02-10 01:17:56.748775	You search and find a Vodka.	t	0	1
209	2010-02-10 01:17:56.748775	You search and find nothing.	t	0	1
210	2010-02-10 01:17:57.316818	You search and find nothing.	t	0	1
211	2010-02-10 01:17:57.316818	You search and find nothing.	t	0	1
212	2010-02-10 01:17:57.316818	You search and find nothing.	t	0	1
213	2010-02-10 01:17:57.316818	You search and find nothing.	t	0	1
214	2010-02-10 01:17:57.316818	You search and find nothing.	t	0	1
215	2010-02-10 01:22:56.810482	You search and find a Energy pack .	t	0	1
216	2010-02-10 01:22:56.810482	You search and find a Vodka.	t	0	1
217	2010-02-10 01:22:56.810482	You search and find nothing.	t	0	1
218	2010-02-10 01:22:56.810482	You search and find nothing.	t	0	1
219	2010-02-10 01:22:56.810482	You search and find nothing.	t	0	1
220	2010-02-10 01:23:30.593617	You search and find nothing.	t	0	1
221	2010-02-10 01:23:30.593617	You search and find a Vodka.	t	0	1
222	2010-02-10 01:23:30.593617	You search and find nothing.	t	0	1
223	2010-02-10 01:23:30.593617	You search and find nothing.	t	0	1
224	2010-02-10 01:23:30.593617	You search and find a Energy rifle .	t	0	1
225	2010-02-10 08:43:46.348721	You search and find nothing.	t	0	1
226	2010-02-10 08:43:46.348721	You search and find nothing.	t	0	1
227	2010-02-10 08:43:46.348721	You search and find nothing.	t	0	1
228	2010-02-10 08:43:46.348721	You search and find nothing.	t	0	1
229	2010-02-10 08:43:46.348721	You search and find nothing.	t	0	1
230	2010-02-10 08:43:47.709805	You search and find nothing.	t	0	1
231	2010-02-10 08:43:47.709805	You search and find nothing.	t	0	1
232	2010-02-10 08:43:47.709805	You search and find nothing.	t	0	1
2357	2010-03-11 08:55:46.060287	You drop your null.	t	0	13
1117	2010-02-18 22:11:02.935446	You search and find a Energy pack .	t	0	2
1607	2010-02-21 23:12:56.606795	You search and find nothing.	t	0	12
2358	2010-03-11 08:55:46.548418	You drop your null.	t	0	13
233	2010-02-10 08:43:47.709805	You search and find nothing.	t	0	1
234	2010-02-10 08:43:47.709805	You search and find nothing.	t	0	1
235	2010-02-10 08:43:48.681411	You search and find nothing.	t	0	1
236	2010-02-10 08:43:48.681411	You search and find nothing.	t	0	1
237	2010-02-10 08:43:48.681411	You search and find nothing.	t	0	1
238	2010-02-10 08:43:48.681411	You search and find a MRE.	t	0	1
239	2010-02-10 08:43:48.681411	You search and find nothing.	t	0	1
240	2010-02-10 08:43:54.56858	You search and find a Energy pack .	t	0	1
241	2010-02-10 08:43:54.56858	You search and find a Vodka.	t	0	1
242	2010-02-10 08:43:54.56858	You search and find a Energy pistol.	t	0	1
243	2010-02-10 08:43:54.56858	You search and find nothing.	t	0	1
244	2010-02-10 08:43:54.56858	You search and find nothing.	t	0	1
245	2010-02-10 08:43:56.09834	You search and find a Energy pack .	t	0	1
246	2010-02-10 08:43:56.09834	You search and find nothing.	t	0	1
247	2010-02-10 08:43:56.09834	You search and find nothing.	t	0	1
248	2010-02-10 08:43:56.09834	You search and find nothing.	t	0	1
249	2010-02-10 08:43:56.09834	You search and find nothing.	t	0	1
250	2010-02-10 08:43:56.760824	You search and find a Vodka.	t	0	1
251	2010-02-10 08:43:56.760824	You search and find nothing.	t	0	1
252	2010-02-10 08:43:56.760824	You search and find nothing.	t	0	1
253	2010-02-10 08:43:56.760824	You search and find nothing.	t	0	1
254	2010-02-10 08:43:56.760824	You search and find nothing.	t	0	1
255	2010-02-10 08:43:57.287701	You search and find nothing.	t	0	1
256	2010-02-10 08:43:57.287701	You search and find nothing.	t	0	1
257	2010-02-10 08:43:57.287701	You search and find nothing.	t	0	1
258	2010-02-10 08:43:57.287701	You search and find nothing.	t	0	1
259	2010-02-10 08:43:57.287701	You search and find a Energy rifle .	t	0	1
260	2010-02-10 08:43:57.79985	You search and find nothing.	t	0	1
261	2010-02-10 08:43:57.79985	You search and find nothing.	t	0	1
262	2010-02-10 08:43:57.79985	You search and find nothing.	t	0	1
263	2010-02-10 08:43:57.79985	You search and find nothing.	t	0	1
264	2010-02-10 08:43:57.79985	You search and find a MRE.	t	0	1
265	2010-02-10 08:44:00.8168	You search and find nothing.	t	0	1
266	2010-02-10 08:44:00.8168	You search and find nothing.	t	0	1
267	2010-02-10 08:44:00.8168	You search and find a Energy pistol.	t	0	1
268	2010-02-10 08:44:00.8168	You search and find nothing.	t	0	1
269	2010-02-10 08:44:00.8168	You search and find a Vodka.	t	0	1
270	2010-02-10 08:44:01.400049	You search and find a Vodka.	t	0	1
271	2010-02-10 08:44:01.400049	You search and find nothing.	t	0	1
272	2010-02-10 08:44:01.400049	You search and find nothing.	t	0	1
273	2010-02-10 08:44:01.400049	You search and find nothing.	t	0	1
274	2010-02-10 08:44:01.400049	You search and find nothing.	t	0	1
275	2010-02-10 08:44:01.921812	You search and find a Vodka.	t	0	1
276	2010-02-10 08:44:01.921812	You search and find nothing.	t	0	1
277	2010-02-10 08:44:01.921812	You search and find nothing.	t	0	1
278	2010-02-10 08:44:01.921812	You search and find nothing.	t	0	1
279	2010-02-10 08:44:01.921812	You search and find nothing.	t	0	1
280	2010-02-10 08:44:02.41603	You search and find a Energy pistol.	t	0	1
281	2010-02-10 08:44:02.41603	You search and find nothing.	t	0	1
282	2010-02-10 08:44:02.41603	You search and find nothing.	t	0	1
283	2010-02-10 08:44:02.41603	You search and find nothing.	t	0	1
284	2010-02-10 08:44:02.41603	You search and find nothing.	t	0	1
285	2010-02-10 08:44:02.993018	You search and find a MRE.	t	0	1
286	2010-02-10 08:44:02.993018	You search and find nothing.	t	0	1
287	2010-02-10 08:44:02.993018	You search and find nothing.	t	0	1
288	2010-02-10 08:44:02.993018	You search and find a MRE.	t	0	1
289	2010-02-10 08:44:02.993018	You search and find a Energy rifle .	t	0	1
290	2010-02-10 08:44:03.567392	You search and find nothing.	t	0	1
291	2010-02-10 08:44:03.567392	You search and find nothing.	t	0	1
292	2010-02-10 08:44:03.567392	You search and find nothing.	t	0	1
293	2010-02-10 08:44:03.567392	You search and find nothing.	t	0	1
294	2010-02-10 08:44:03.567392	You search and find nothing.	t	0	1
295	2010-02-10 08:44:05.67243	You search and find a MRE.	t	0	1
296	2010-02-10 08:44:05.67243	You search and find nothing.	t	0	1
297	2010-02-10 08:44:05.67243	You search and find nothing.	t	0	1
298	2010-02-10 08:44:05.67243	You search and find nothing.	t	0	1
299	2010-02-10 08:44:05.67243	You search and find nothing.	t	0	1
300	2010-02-10 08:44:05.954344	You search and find nothing.	t	0	1
301	2010-02-10 08:44:05.954344	You search and find nothing.	t	0	1
302	2010-02-10 08:44:05.954344	You search and find nothing.	t	0	1
303	2010-02-10 08:44:05.954344	You search and find nothing.	t	0	1
304	2010-02-10 08:44:05.954344	You search and find nothing.	t	0	1
305	2010-02-10 08:44:06.760679	You search and find nothing.	t	0	1
306	2010-02-10 08:44:06.760679	You search and find nothing.	t	0	1
307	2010-02-10 08:44:06.760679	You search and find nothing.	t	0	1
308	2010-02-10 08:44:06.760679	You search and find nothing.	t	0	1
309	2010-02-10 08:44:06.760679	You search and find nothing.	t	0	1
310	2010-02-10 08:44:58.690021	You search and find nothing.	t	0	1
311	2010-02-10 08:44:58.690021	You search and find nothing.	t	0	1
312	2010-02-10 08:44:58.690021	You search and find nothing.	t	0	1
313	2010-02-10 08:44:58.690021	You search and find nothing.	t	0	1
314	2010-02-10 08:44:58.690021	You search and find nothing.	t	0	1
315	2010-02-10 08:44:58.908328	You search and find nothing.	t	0	1
316	2010-02-10 08:44:58.908328	You search and find a Energy pistol.	t	0	1
317	2010-02-10 08:44:58.908328	You search and find a Energy pack .	t	0	1
318	2010-02-10 08:44:58.908328	You search and find nothing.	t	0	1
319	2010-02-10 08:44:58.908328	You search and find nothing.	t	0	1
320	2010-02-10 08:44:59.294095	You search and find nothing.	t	0	1
321	2010-02-10 08:44:59.294095	You search and find nothing.	t	0	1
322	2010-02-10 08:44:59.294095	You search and find nothing.	t	0	1
323	2010-02-10 08:44:59.294095	You search and find a Energy rifle .	t	0	1
2359	2010-03-11 08:55:46.764285	You drop your null.	t	0	13
1120	2010-02-18 22:11:02.935446	You search and find nothing.	t	0	2
1121	2010-02-18 22:11:02.935446	You search and find nothing.	t	0	2
2360	2010-03-11 08:55:46.948398	You drop your null.	t	0	13
2361	2010-03-11 08:55:47.140285	You drop your null.	t	0	13
324	2010-02-10 08:44:59.294095	You search and find nothing.	t	0	1
325	2010-02-10 08:44:59.316417	You search and find nothing.	t	0	1
326	2010-02-10 08:44:59.316417	You search and find nothing.	t	0	1
327	2010-02-10 08:44:59.316417	You search and find nothing.	t	0	1
328	2010-02-10 08:44:59.316417	You search and find a Vodka.	t	0	1
329	2010-02-10 08:44:59.316417	You search and find nothing.	t	0	1
330	2010-02-10 08:44:59.494411	You search and find nothing.	t	0	1
331	2010-02-10 08:44:59.494411	You search and find a Energy rifle .	t	0	1
332	2010-02-10 08:44:59.494411	You search and find nothing.	t	0	1
333	2010-02-10 08:44:59.494411	You search and find nothing.	t	0	1
334	2010-02-10 08:44:59.494411	You search and find a MRE.	t	0	1
335	2010-02-10 08:44:59.681935	You search and find a Energy rifle .	t	0	1
336	2010-02-10 08:44:59.681935	You search and find nothing.	t	0	1
337	2010-02-10 08:44:59.681935	You search and find nothing.	t	0	1
338	2010-02-10 08:44:59.681935	You search and find nothing.	t	0	1
339	2010-02-10 08:44:59.681935	You search and find nothing.	t	0	1
340	2010-02-10 08:44:59.888896	You search and find nothing.	t	0	1
341	2010-02-10 08:44:59.888896	You search and find nothing.	t	0	1
342	2010-02-10 08:44:59.888896	You search and find nothing.	t	0	1
343	2010-02-10 08:44:59.888896	You search and find nothing.	t	0	1
344	2010-02-10 08:44:59.888896	You search and find nothing.	t	0	1
345	2010-02-10 08:45:00.065921	You search and find a Vodka.	t	0	1
346	2010-02-10 08:45:00.065921	You search and find nothing.	t	0	1
347	2010-02-10 08:45:00.065921	You search and find nothing.	t	0	1
348	2010-02-10 08:45:00.065921	You search and find nothing.	t	0	1
349	2010-02-10 08:45:00.065921	You search and find nothing.	t	0	1
350	2010-02-10 08:45:00.25574	You search and find nothing.	t	0	1
351	2010-02-10 08:45:00.25574	You search and find nothing.	t	0	1
352	2010-02-10 08:45:00.25574	You search and find nothing.	t	0	1
353	2010-02-10 08:45:00.25574	You search and find nothing.	t	0	1
354	2010-02-10 08:45:00.25574	You search and find nothing.	t	0	1
355	2010-02-10 08:45:00.433791	You search and find nothing.	t	0	1
356	2010-02-10 08:45:00.433791	You search and find nothing.	t	0	1
357	2010-02-10 08:45:00.433791	You search and find nothing.	t	0	1
358	2010-02-10 08:45:00.433791	You search and find a Energy pistol.	t	0	1
359	2010-02-10 08:45:00.433791	You search and find a Vodka.	t	0	1
360	2010-02-10 08:45:00.623633	You search and find nothing.	t	0	1
361	2010-02-10 08:45:00.623633	You search and find nothing.	t	0	1
362	2010-02-10 08:45:00.623633	You search and find a Energy rifle .	t	0	1
363	2010-02-10 08:45:00.623633	You search and find nothing.	t	0	1
364	2010-02-10 08:45:00.623633	You search and find nothing.	t	0	1
365	2010-02-10 08:45:00.809946	You search and find nothing.	t	0	1
366	2010-02-10 08:45:00.809946	You search and find nothing.	t	0	1
367	2010-02-10 08:45:00.809946	You search and find nothing.	t	0	1
368	2010-02-10 08:45:00.809946	You search and find nothing.	t	0	1
369	2010-02-10 08:45:00.809946	You search and find nothing.	t	0	1
370	2010-02-10 08:45:01.015966	You search and find nothing.	t	0	1
371	2010-02-10 08:45:01.015966	You search and find nothing.	t	0	1
372	2010-02-10 08:45:01.015966	You search and find nothing.	t	0	1
373	2010-02-10 08:45:01.015966	You search and find nothing.	t	0	1
374	2010-02-10 08:45:01.015966	You search and find nothing.	t	0	1
375	2010-02-10 08:45:01.177849	You search and find nothing.	t	0	1
376	2010-02-10 08:45:01.177849	You search and find nothing.	t	0	1
377	2010-02-10 08:45:01.177849	You search and find nothing.	t	0	1
378	2010-02-10 08:45:01.177849	You search and find nothing.	t	0	1
379	2010-02-10 08:45:01.177849	You search and find nothing.	t	0	1
380	2010-02-10 08:45:01.375549	You search and find nothing.	t	0	1
381	2010-02-10 08:45:01.375549	You search and find nothing.	t	0	1
382	2010-02-10 08:45:01.375549	You search and find nothing.	t	0	1
383	2010-02-10 08:45:01.375549	You search and find nothing.	t	0	1
384	2010-02-10 08:45:01.375549	You search and find nothing.	t	0	1
385	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
386	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
387	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
388	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
389	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
390	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
391	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
392	2010-02-10 08:47:27.194076	You search and find a Vodka.	t	0	1
393	2010-02-10 08:47:27.194076	You search and find a Vodka.	t	0	1
394	2010-02-10 08:47:27.194076	You search and find nothing.	t	0	1
395	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
396	2010-02-10 08:47:28.264569	You search and find a Vodka.	t	0	1
397	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
1116	2010-02-18 22:11:02.594072	You search and find nothing.	t	0	2
1118	2010-02-18 22:11:02.935446	You search and find nothing.	t	0	2
1119	2010-02-18 22:11:02.935446	You search and find a Energy rifle .	t	0	2
2362	2010-03-11 08:55:47.489095	You drop your null.	t	0	13
2363	2010-03-11 08:55:47.50557	You drop your null.	t	0	13
2364	2010-03-11 08:55:47.699828	You drop your null.	t	0	13
2365	2010-03-11 08:55:47.87628	You drop your null.	t	0	13
1609	2010-02-21 23:12:57.152341	You search and find nothing.	t	0	12
2366	2010-03-11 08:55:48.05238	You drop your null.	t	0	13
1610	2010-02-21 23:12:57.152341	You search and find nothing.	t	0	12
1611	2010-02-21 23:12:57.152341	You search and find a Energy rifle .	t	0	12
1612	2010-02-21 23:12:57.152341	You search and find nothing.	t	0	12
1613	2010-02-21 23:12:57.152341	You search and find nothing.	t	0	12
1614	2010-02-21 23:12:57.71076	You search and find nothing.	t	0	12
1615	2010-02-21 23:12:57.71076	You search and find a Energy rifle .	t	0	12
1616	2010-02-21 23:12:57.71076	You search and find a Energy pack .	t	0	12
1617	2010-02-21 23:12:57.71076	You search and find nothing.	t	0	12
2367	2010-03-11 08:55:48.228337	You drop your null.	t	0	13
2368	2010-03-11 08:55:48.412247	You drop your null.	t	0	13
2369	2010-03-11 08:55:48.588346	You drop your null.	t	0	13
2370	2010-03-11 08:55:48.755414	You drop your null.	t	0	13
2371	2010-03-11 08:55:48.916262	You drop your null.	t	0	13
398	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
399	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
400	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
401	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
402	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
403	2010-02-10 08:47:28.264569	You search and find a Energy pack .	t	0	1
404	2010-02-10 08:47:28.264569	You search and find nothing.	t	0	1
405	2010-02-10 08:47:31.673219	You search and find a Energy rifle .	t	0	1
406	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
407	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
408	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
409	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
410	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
411	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
412	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
413	2010-02-10 08:47:31.673219	You search and find nothing.	t	0	1
414	2010-02-10 08:47:31.673219	You search and find a MRE.	t	0	1
415	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
416	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
417	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
418	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
419	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
420	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
421	2010-02-10 08:47:33.527719	You search and find a MRE.	t	0	1
422	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
423	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
424	2010-02-10 08:47:33.527719	You search and find nothing.	t	0	1
425	2010-02-10 08:47:34.375897	You search and find a Vodka.	t	0	1
426	2010-02-10 08:47:34.375897	You search and find a Energy pack .	t	0	1
427	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
428	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
429	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
430	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
431	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
432	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
433	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
434	2010-02-10 08:47:34.375897	You search and find nothing.	t	0	1
435	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
436	2010-02-10 08:47:35.119358	You search and find a MRE.	t	0	1
437	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
438	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
439	2010-02-10 08:47:35.119358	You search and find a Energy pack .	t	0	1
440	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
441	2010-02-10 08:47:35.119358	You search and find a Vodka.	t	0	1
442	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
443	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
444	2010-02-10 08:47:35.119358	You search and find nothing.	t	0	1
445	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
446	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
447	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
448	2010-02-10 08:47:35.873447	You search and find a Vodka.	t	0	1
449	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
450	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
451	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
2372	2010-03-11 08:55:49.09233	You drop your null.	t	0	13
2373	2010-03-11 08:55:49.259501	You drop your null.	t	0	13
2374	2010-03-11 08:55:49.428494	You drop your null.	t	0	13
2375	2010-03-11 08:58:56.066737	You drop your null.	t	0	13
2376	2010-03-11 09:03:01.663879	You search and find nothing.	t	0	13
2377	2010-03-11 09:03:01.663879	You search and find a Energy pack.	t	0	13
2378	2010-03-11 09:03:01.663879	You search and find nothing.	t	0	13
2379	2010-03-11 09:03:01.663879	You search and find nothing.	t	0	13
2380	2010-03-11 09:03:01.663879	You search and find nothing.	t	0	13
2381	2010-03-11 09:03:02.298203	You search and find nothing.	t	0	13
2382	2010-03-11 09:03:02.298203	You search and find nothing.	t	0	13
1619	2010-02-21 23:12:58.239522	You search and find nothing.	t	0	12
1620	2010-02-21 23:12:58.239522	You search and find nothing.	t	0	12
1621	2010-02-21 23:12:58.239522	You search and find nothing.	t	0	12
1622	2010-02-21 23:12:58.239522	You search and find nothing.	t	0	12
1623	2010-02-21 23:12:58.239522	You search and find nothing.	t	0	12
1624	2010-02-21 23:12:58.734695	You search and find nothing.	t	0	12
1625	2010-02-21 23:12:58.734695	You search and find nothing.	t	0	12
1626	2010-02-21 23:12:58.734695	You search and find a Energy pistol.	t	0	12
1627	2010-02-21 23:12:58.734695	You search and find nothing.	t	0	12
1628	2010-02-21 23:12:58.734695	You search and find nothing.	t	0	12
1629	2010-02-21 23:12:59.022203	You search and find nothing.	t	0	12
1630	2010-02-21 23:12:59.022203	You search and find nothing.	t	0	12
1631	2010-02-21 23:12:59.022203	You search and find nothing.	t	0	12
1632	2010-02-21 23:12:59.022203	You search and find nothing.	t	0	12
1633	2010-02-21 23:12:59.022203	You search and find nothing.	t	0	12
1634	2010-02-21 23:12:59.367114	You search and find nothing.	t	0	12
1635	2010-02-21 23:12:59.367114	You search and find nothing.	t	0	12
1636	2010-02-21 23:12:59.367114	You search and find a Energy pistol.	t	0	12
1637	2010-02-21 23:12:59.367114	You search and find nothing.	t	0	12
1638	2010-02-21 23:12:59.367114	You search and find nothing.	t	0	12
2383	2010-03-11 09:03:02.298203	You search and find nothing.	t	0	13
2384	2010-03-11 09:03:02.298203	You search and find a MRE.	t	0	13
2385	2010-03-11 09:03:02.298203	You search and find nothing.	t	0	13
452	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
453	2010-02-10 08:47:35.873447	You search and find nothing.	t	0	1
454	2010-02-10 08:47:35.873447	You search and find a Energy rifle .	t	0	1
455	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
456	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
457	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
458	2010-02-10 08:47:36.575942	You search and find a Energy pack .	t	0	1
459	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
460	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
461	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
462	2010-02-10 08:47:36.575942	You search and find a Vodka.	t	0	1
463	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
464	2010-02-10 08:47:36.575942	You search and find nothing.	t	0	1
465	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
466	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
467	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
468	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
469	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
470	2010-02-10 08:47:37.312467	You search and find a Vodka.	t	0	1
471	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
472	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
473	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
474	2010-02-10 08:47:37.312467	You search and find nothing.	t	0	1
475	2010-02-10 08:47:38.015657	You search and find nothing.	t	0	1
476	2010-02-10 08:47:38.015657	You search and find a Vodka.	t	0	1
477	2010-02-10 08:47:38.015657	You search and find nothing.	t	0	1
478	2010-02-10 08:47:38.015657	You search and find nothing.	t	0	1
479	2010-02-10 08:47:38.015657	You search and find nothing.	t	0	1
480	2010-02-10 08:47:38.56776	You search and find nothing.	t	0	1
481	2010-02-10 08:47:38.56776	You search and find nothing.	t	0	1
482	2010-02-10 08:47:38.56776	You search and find nothing.	t	0	1
483	2010-02-10 08:47:38.56776	You search and find nothing.	t	0	1
484	2010-02-10 08:47:38.56776	You search and find nothing.	t	0	1
485	2010-02-10 08:47:39.135792	You search and find nothing.	t	0	1
486	2010-02-10 08:47:39.135792	You search and find nothing.	t	0	1
487	2010-02-10 08:47:39.135792	You search and find a Vodka.	t	0	1
488	2010-02-10 08:47:39.135792	You search and find nothing.	t	0	1
489	2010-02-10 08:47:39.135792	You search and find nothing.	t	0	1
490	2010-02-10 08:47:39.679751	You search and find nothing.	t	0	1
491	2010-02-10 08:47:39.679751	You search and find nothing.	t	0	1
492	2010-02-10 08:47:39.679751	You search and find nothing.	t	0	1
493	2010-02-10 08:47:39.679751	You search and find nothing.	t	0	1
494	2010-02-10 08:47:39.679751	You search and find nothing.	t	0	1
495	2010-02-10 08:47:40.744649	You search and find a Vodka.	t	0	1
496	2010-02-10 08:47:41.284494	You search and find a Energy rifle .	t	0	1
497	2010-02-10 08:47:41.520404	You search and find nothing.	t	0	1
498	2010-02-10 08:47:41.928422	You search and find nothing.	t	0	1
499	2010-02-10 08:47:42.328456	You search and find nothing.	t	0	1
500	2010-02-10 08:47:42.682796	You search and find nothing.	t	0	1
501	2010-02-10 08:47:43.032404	You search and find nothing.	t	0	1
502	2010-02-10 08:47:43.40791	You search and find nothing.	t	0	1
503	2010-02-10 08:47:43.719715	You search and find nothing.	t	0	1
504	2010-02-10 08:47:44.063983	You search and find a Energy pistol.	t	0	1
505	2010-02-10 08:47:44.375673	You search and find nothing.	t	0	1
506	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
507	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
508	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
509	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
510	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
511	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
512	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
513	2010-02-10 08:47:45.49687	You search and find nothing.	t	0	1
514	2010-02-10 08:47:45.49687	You search and find a Energy rifle .	t	0	1
515	2010-02-10 08:47:45.49687	You search and find a Energy pack .	t	0	1
516	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
517	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
518	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
519	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
520	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
521	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
522	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
523	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
524	2010-02-10 09:09:57.119832	You search and find a Vodka.	t	0	1
525	2010-02-10 09:09:57.119832	You search and find nothing.	t	0	1
526	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
527	2010-02-10 09:09:57.665209	You search and find a Energy pistol.	t	0	1
528	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
529	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
530	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
531	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
532	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
533	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
534	2010-02-10 09:09:57.665209	You search and find nothing.	t	0	1
535	2010-02-10 09:09:57.665209	You search and find a Energy pistol.	t	0	1
536	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
537	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
538	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
2386	2010-03-11 09:03:03.955154	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2387	2010-03-11 09:03:05.191114	You drop your Energy pack.	t	0	13
1639	2010-02-21 23:12:59.609669	You search and find nothing.	t	0	12
1640	2010-02-21 23:12:59.609669	You search and find a Vodka.	t	0	12
1641	2010-02-21 23:12:59.609669	You search and find nothing.	t	0	12
1642	2010-02-21 23:12:59.609669	You search and find nothing.	t	0	12
2388	2010-03-11 09:03:09.717045	You drop your null.	t	0	13
2389	2010-03-11 09:03:10.548369	You drop your null.	t	0	13
539	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
540	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
541	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
542	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
543	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
544	2010-02-10 09:09:58.232376	You search and find nothing.	t	0	1
545	2010-02-10 09:09:58.232376	You search and find a Vodka.	t	0	1
546	2010-02-10 09:09:58.713188	You search and find nothing.	t	0	1
547	2010-02-10 09:09:58.713188	You search and find a Energy pistol.	t	0	1
548	2010-02-10 09:09:58.713188	You search and find a Vodka.	t	0	1
549	2010-02-10 09:09:58.713188	You search and find nothing.	t	0	1
550	2010-02-10 09:09:58.713188	You search and find nothing.	t	0	1
551	2010-02-10 09:09:58.713188	You search and find nothing.	t	0	1
552	2010-02-10 09:09:58.713188	You search and find nothing.	t	0	1
553	2010-02-10 09:09:58.713188	You search and find a MRE.	t	0	1
554	2010-02-10 09:09:58.713188	You search and find a Energy pack .	t	0	1
555	2010-02-10 09:09:58.713188	You search and find nothing.	t	0	1
556	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
557	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
558	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
559	2010-02-10 09:09:59.1832	You search and find a Energy pack .	t	0	1
560	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
561	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
562	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
563	2010-02-10 09:09:59.1832	You search and find nothing.	t	0	1
564	2010-02-10 09:09:59.1832	You search and find a Vodka.	t	0	1
565	2010-02-10 09:09:59.1832	You search and find a Vodka.	t	0	1
566	2010-02-10 09:09:59.658967	You search and find a Vodka.	t	0	1
567	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
568	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
569	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
570	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
571	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
572	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
573	2010-02-10 09:09:59.658967	You search and find a Energy pistol.	t	0	1
574	2010-02-10 09:09:59.658967	You search and find nothing.	t	0	1
575	2010-02-10 09:09:59.658967	You search and find a Energy pistol.	t	0	1
576	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
577	2010-02-10 09:10:00.18433	You search and find a Energy pistol.	t	0	1
578	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
579	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
580	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
581	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
582	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
583	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
584	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
585	2010-02-10 09:10:00.18433	You search and find nothing.	t	0	1
586	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
587	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
588	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
589	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
590	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
591	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
592	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
1604	2010-02-21 23:12:56.606795	You search and find a Vodka.	t	0	12
1605	2010-02-21 23:12:56.606795	You search and find nothing.	t	0	12
1606	2010-02-21 23:12:56.606795	You search and find nothing.	t	0	12
1608	2010-02-21 23:12:56.606795	You search and find a Vodka.	t	0	12
1618	2010-02-21 23:12:57.71076	You search and find nothing.	t	0	12
1643	2010-02-21 23:12:59.609669	You search and find nothing.	t	0	12
1644	2010-02-21 23:13:01.373133	You drop your null.	t	0	12
1645	2010-02-21 23:13:01.485685	You drop your null.	t	0	12
1646	2010-02-21 23:13:01.993564	You drop your null.	t	0	12
1647	2010-02-21 23:13:02.606719	You drop your null.	t	0	12
1648	2010-02-21 23:13:03.386885	You drop your null.	t	0	12
1649	2010-02-21 23:13:03.792391	You drop your null.	t	0	12
1650	2010-02-21 23:13:04.135677	You drop your null.	t	0	12
1651	2010-02-21 23:13:04.455021	You drop your null.	t	0	12
1652	2010-02-21 23:13:04.778493	You drop your null.	t	0	12
1653	2010-02-21 23:13:45.871866	You drop your null.	t	0	12
1654	2010-02-21 23:13:46.582622	You drop your null.	t	0	12
1655	2010-02-21 23:14:29.122849	You drop your null.	t	0	12
1656	2010-02-21 23:14:29.634497	You drop your null.	t	0	12
1657	2010-02-21 23:14:30.145528	You drop your null.	t	0	12
1658	2010-02-21 23:14:30.97941	You drop your null.	t	0	12
1659	2010-02-21 23:14:31.807483	You drop your null.	t	0	12
1660	2010-02-21 23:15:20.336538	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1661	2010-02-21 23:15:20.785371	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1662	2010-02-21 23:15:21.197458	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1663	2010-02-21 23:39:10.935873	You drop your Energy pistol.	t	0	13
1664	2010-02-21 23:39:12.448114	You drop your Energy pistol.	t	0	13
1665	2010-02-21 23:39:16.492154	You drop your Energy rifle .	t	0	13
1666	2010-02-21 23:39:17.19614	You drop your Energy pistol.	t	0	13
1667	2010-02-21 23:39:17.589242	You drop your Energy pistol.	t	0	13
1668	2010-02-21 23:39:21.854891	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
1669	2010-02-21 23:39:22.475775	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
1670	2010-02-21 23:39:23.146011	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
1671	2010-02-21 23:39:24.397368	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
1672	2010-02-21 23:39:24.593331	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
1673	2010-02-21 23:39:25.404241	You drop your Energy pack .	t	0	13
1674	2010-02-21 23:39:25.784237	You drop your Energy pack .	t	0	13
1675	2010-02-21 23:42:56.98513	You drop your Energy pack.	t	0	13
593	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
594	2010-02-10 09:10:00.688545	You search and find nothing.	t	0	1
595	2010-02-10 09:10:00.688545	You search and find a Vodka.	t	0	1
596	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
597	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
598	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
599	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
600	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
601	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
602	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
603	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
604	2010-02-10 09:10:01.153625	You search and find nothing.	t	0	1
605	2010-02-10 09:10:01.153625	You search and find a Energy pistol.	t	0	1
606	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
607	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
608	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
609	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
610	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
611	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
612	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
613	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
614	2010-02-10 09:10:01.593435	You search and find a MRE.	t	0	1
615	2010-02-10 09:10:01.593435	You search and find nothing.	t	0	1
616	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
617	2010-02-10 09:11:14.08131	You search and find a MRE.	t	0	1
618	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
619	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
620	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
621	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
622	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
623	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
624	2010-02-10 09:11:14.08131	You search and find nothing.	t	0	1
625	2010-02-10 09:11:14.08131	You search and find a Energy rifle .	t	0	1
626	2010-02-10 09:11:14.247432	You search and find a Vodka.	t	0	1
627	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
628	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
629	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
630	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
631	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
632	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
633	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
634	2010-02-10 09:11:14.247432	You search and find nothing.	t	0	1
635	2010-02-10 09:11:14.247432	You search and find a Energy pistol.	t	0	1
636	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
637	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
638	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
639	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
640	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
641	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
642	2010-02-10 09:11:14.423471	You search and find a Energy pack .	t	0	1
643	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
644	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
645	2010-02-10 09:11:14.423471	You search and find nothing.	t	0	1
646	2010-02-10 09:11:14.607605	You search and find a Energy rifle .	t	0	1
647	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
648	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
649	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
650	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
651	2010-02-10 09:11:14.607605	You search and find a Vodka.	t	0	1
652	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
653	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
654	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
655	2010-02-10 09:11:14.607605	You search and find nothing.	t	0	1
656	2010-02-10 09:11:14.800692	You search and find a Energy pistol.	t	0	1
657	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
658	2010-02-10 09:11:14.800692	You search and find a Vodka.	t	0	1
659	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
660	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
661	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
662	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
663	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
664	2010-02-10 09:11:14.800692	You search and find a Energy pack .	t	0	1
665	2010-02-10 09:11:14.800692	You search and find nothing.	t	0	1
666	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
667	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
668	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
669	2010-02-10 09:11:14.982861	You search and find a Energy pack .	t	0	1
670	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
671	2010-02-10 09:11:14.982861	You search and find a MRE.	t	0	1
672	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
673	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
674	2010-02-10 09:11:14.982861	You search and find a Vodka.	t	0	1
675	2010-02-10 09:11:14.982861	You search and find nothing.	t	0	1
676	2010-02-10 09:11:15.191817	You search and find a Energy pistol.	t	0	1
677	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
678	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
679	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
1676	2010-02-21 23:43:00.129311	You search and find nothing.	t	0	13
1677	2010-02-21 23:43:00.129311	You search and find nothing.	t	0	13
1678	2010-02-21 23:43:00.129311	You search and find nothing.	t	0	13
1679	2010-02-21 23:43:00.129311	You search and find nothing.	t	0	13
2390	2010-03-11 09:03:10.748441	You drop your null.	t	0	13
2391	2010-03-11 09:03:10.94003	You drop your null.	t	0	13
2392	2010-03-11 09:03:11.132222	You drop your null.	t	0	13
2393	2010-03-11 09:03:11.332465	You drop your null.	t	0	13
680	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
681	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
682	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
683	2010-02-10 09:11:15.191817	You search and find a Vodka.	t	0	1
684	2010-02-10 09:11:15.191817	You search and find a Energy rifle .	t	0	1
685	2010-02-10 09:11:15.191817	You search and find nothing.	t	0	1
686	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
687	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
688	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
689	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
690	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
691	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
692	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
693	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
694	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
695	2010-02-10 09:11:15.338995	You search and find nothing.	t	0	1
696	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
697	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
698	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
699	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
700	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
701	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
702	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
703	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
704	2010-02-10 09:11:15.522526	You search and find nothing.	t	0	1
705	2010-02-10 09:11:15.522526	You search and find a Energy rifle .	t	0	1
706	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
707	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
708	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
709	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
710	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
711	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
712	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
713	2010-02-10 09:11:15.68223	You search and find a MRE.	t	0	1
714	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
715	2010-02-10 09:11:15.68223	You search and find nothing.	t	0	1
716	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
717	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
718	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
719	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
720	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
721	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
722	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
723	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
724	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
725	2010-02-10 09:13:11.956238	You search and find nothing.	t	0	12
726	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
727	2010-02-10 09:13:12.489117	You search and find a Vodka.	t	0	12
728	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
729	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
730	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
731	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
732	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
733	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
734	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
2394	2010-03-11 09:04:09.677978	You search and find nothing.	t	0	13
2395	2010-03-11 09:04:09.677978	You search and find nothing.	t	0	13
2396	2010-03-11 09:04:09.677978	You search and find nothing.	t	0	13
2397	2010-03-11 09:04:09.677978	You search and find nothing.	t	0	13
2398	2010-03-11 09:04:09.677978	You search and find nothing.	t	0	13
2399	2010-03-11 09:04:10.674389	You search and find nothing.	t	0	13
2400	2010-03-11 09:04:10.674389	You search and find nothing.	t	0	13
2401	2010-03-11 09:04:10.674389	You search and find nothing.	t	0	13
2402	2010-03-11 09:04:10.674389	You search and find nothing.	t	0	13
2403	2010-03-11 09:04:10.674389	You search and find a Energy rifle.	t	0	13
1681	2010-02-21 23:43:00.463267	You search and find nothing.	t	0	13
1682	2010-02-21 23:43:00.463267	You search and find nothing.	t	0	13
1683	2010-02-21 23:43:00.463267	You search and find nothing.	t	0	13
1684	2010-02-21 23:43:00.463267	You search and find nothing.	t	0	13
1685	2010-02-21 23:43:00.463267	You search and find nothing.	t	0	13
1686	2010-02-21 23:43:01.167646	You search and find a MRE.	t	0	13
1687	2010-02-21 23:43:01.167646	You search and find nothing.	t	0	13
1688	2010-02-21 23:43:01.167646	You search and find nothing.	t	0	13
1689	2010-02-21 23:43:01.167646	You search and find nothing.	t	0	13
1690	2010-02-21 23:43:01.167646	You search and find a Energy pack .	t	0	13
1691	2010-02-21 23:43:01.575275	You search and find nothing.	t	0	13
1692	2010-02-21 23:43:01.575275	You search and find nothing.	t	0	13
1693	2010-02-21 23:43:01.575275	You search and find nothing.	t	0	13
2404	2010-03-11 09:04:19.347185	You switch your equipped weapon. You will now use your Energy rifle.	t	0	13
3054	2010-03-11 22:01:23.749642	You search and find nothing.	t	0	2
3055	2010-03-11 22:01:23.749642	You search and find nothing.	t	0	2
3056	2010-03-11 22:01:23.749642	You search and find a Energy pistol.	t	0	2
3057	2010-03-11 22:01:23.749642	You search and find nothing.	t	0	2
3058	2010-03-11 22:01:23.749642	You search and find nothing.	t	0	2
3059	2010-03-11 22:01:25.583373	You search and find nothing.	t	0	2
3060	2010-03-11 22:01:25.583373	You search and find nothing.	t	0	2
3061	2010-03-11 22:01:25.583373	You search and find nothing.	t	0	2
735	2010-02-10 09:13:12.489117	You search and find nothing.	t	0	12
736	2010-02-10 09:13:12.977304	You search and find a Energy rifle .	t	0	12
737	2010-02-10 09:13:12.977304	You search and find nothing.	t	0	12
738	2010-02-10 09:13:12.977304	You search and find nothing.	t	0	12
739	2010-02-10 09:13:12.977304	You search and find nothing.	t	0	12
740	2010-02-10 09:13:12.977304	You search and find a Energy pistol.	t	0	12
741	2010-02-10 09:13:12.977304	You search and find nothing.	t	0	12
742	2010-02-10 09:13:12.977304	You search and find nothing.	t	0	12
743	2010-02-10 09:13:12.977304	You search and find a MRE.	t	0	12
744	2010-02-10 09:13:12.977304	You search and find a Energy pack .	t	0	12
745	2010-02-10 09:13:12.977304	You search and find nothing.	t	0	12
746	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
747	2010-02-10 09:13:13.399919	You search and find a Energy rifle .	t	0	12
748	2010-02-10 09:13:13.399919	You search and find a Energy rifle .	t	0	12
749	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
750	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
751	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
752	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
753	2010-02-10 09:13:13.399919	You search and find a Energy pistol.	t	0	12
754	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
755	2010-02-10 09:13:13.399919	You search and find nothing.	t	0	12
756	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
757	2010-02-10 09:13:13.840567	You search and find a Energy pistol.	t	0	12
758	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
759	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
760	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
761	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
762	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
763	2010-02-10 09:13:13.840567	You search and find a Energy pistol.	t	0	12
764	2010-02-10 09:13:13.840567	You search and find a Vodka.	t	0	12
765	2010-02-10 09:13:13.840567	You search and find nothing.	t	0	12
766	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
767	2010-02-10 09:13:14.315324	You search and find a Vodka.	t	0	12
768	2010-02-10 09:13:14.315324	You search and find a Energy rifle .	t	0	12
769	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
770	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
771	2010-02-10 09:13:14.315324	You search and find a Energy pack .	t	0	12
772	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
773	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
774	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
775	2010-02-10 09:13:14.315324	You search and find nothing.	t	0	12
776	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
777	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
778	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
779	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
780	2010-02-10 09:13:14.655674	You search and find a Vodka.	t	0	12
781	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
782	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
783	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
784	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
785	2010-02-10 09:13:14.655674	You search and find nothing.	t	0	12
786	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
787	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
788	2010-02-10 09:13:15.048796	You search and find a MRE.	t	0	12
789	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
790	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
791	2010-02-10 09:13:15.048796	You search and find a Energy pistol.	t	0	12
792	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
793	2010-02-10 09:13:15.048796	You search and find a Energy rifle .	t	0	12
794	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
795	2010-02-10 09:13:15.048796	You search and find nothing.	t	0	12
796	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
797	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
798	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
799	2010-02-10 09:13:15.449502	You search and find a MRE.	t	0	12
800	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
801	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
802	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
803	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
804	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
805	2010-02-10 09:13:15.449502	You search and find nothing.	t	0	12
806	2010-02-17 15:31:37.393237	You search and find nothing.	t	0	2
807	2010-02-17 15:31:37.837339	You search and find a Energy pistol.	t	0	2
808	2010-02-17 15:31:37.837339	You search and find nothing.	t	0	2
809	2010-02-17 15:31:37.837339	You search and find nothing.	t	0	2
810	2010-02-17 15:31:37.837339	You search and find nothing.	t	0	2
811	2010-02-17 15:31:37.837339	You search and find nothing.	t	0	2
812	2010-02-17 15:31:39.058871	You search and find a Energy pack .	t	0	2
813	2010-02-17 15:31:39.058871	You search and find nothing.	t	0	2
814	2010-02-17 15:31:39.058871	You search and find nothing.	t	0	2
815	2010-02-17 15:31:39.058871	You search and find a Energy pack .	t	0	2
816	2010-02-17 15:31:39.058871	You search and find nothing.	t	0	2
817	2010-02-17 15:31:40.100362	You search and find nothing.	t	0	2
818	2010-02-17 15:31:40.100362	You search and find nothing.	t	0	2
819	2010-02-17 15:31:40.100362	You search and find nothing.	t	0	2
820	2010-02-17 15:31:40.100362	You search and find nothing.	t	0	2
821	2010-02-17 15:31:40.100362	You search and find a Vodka.	t	0	2
822	2010-02-17 15:31:41.27297	You search and find nothing.	t	0	2
823	2010-02-17 15:31:41.27297	You search and find a Energy rifle .	t	0	2
824	2010-02-17 15:31:41.27297	You search and find nothing.	t	0	2
825	2010-02-17 15:31:41.27297	You search and find nothing.	t	0	2
2405	2010-03-11 09:33:56.129022	You have unequipped your Energy rifle.	t	0	13
2406	2010-03-11 09:33:57.712013	You drop your Energy rifle.	t	0	13
1696	2010-02-21 23:43:02.013945	You search and find nothing.	t	0	13
826	2010-02-17 15:31:41.27297	You search and find nothing.	t	0	2
827	2010-02-17 15:31:42.007621	You search and find a Energy rifle .	t	0	2
828	2010-02-17 15:31:42.007621	You search and find nothing.	t	0	2
829	2010-02-17 15:31:42.007621	You search and find nothing.	t	0	2
830	2010-02-17 15:31:42.007621	You search and find nothing.	t	0	2
831	2010-02-17 15:31:42.007621	You search and find nothing.	t	0	2
832	2010-02-17 15:31:42.586809	You search and find nothing.	t	0	2
833	2010-02-17 15:31:42.586809	You search and find a Vodka.	t	0	2
834	2010-02-17 15:31:42.586809	You search and find a MRE.	t	0	2
835	2010-02-17 15:31:42.586809	You search and find nothing.	t	0	2
836	2010-02-17 15:31:42.586809	You search and find nothing.	t	0	2
837	2010-02-17 15:31:43.087399	You search and find nothing.	t	0	2
838	2010-02-17 15:31:43.087399	You search and find a Vodka.	t	0	2
839	2010-02-17 15:31:43.087399	You search and find nothing.	t	0	2
840	2010-02-17 15:31:43.087399	You search and find a Energy pack .	t	0	2
841	2010-02-17 15:31:43.087399	You search and find a MRE.	t	0	2
842	2010-02-17 15:31:43.519481	You search and find nothing.	t	0	2
843	2010-02-17 15:31:43.519481	You search and find nothing.	t	0	2
844	2010-02-17 15:31:43.519481	You search and find nothing.	t	0	2
845	2010-02-17 15:31:43.519481	You search and find nothing.	t	0	2
846	2010-02-17 15:31:43.519481	You search and find nothing.	t	0	2
847	2010-02-17 15:31:43.951896	You search and find nothing.	t	0	2
848	2010-02-17 15:31:43.951896	You search and find nothing.	t	0	2
849	2010-02-17 15:31:43.951896	You search and find nothing.	t	0	2
850	2010-02-17 15:31:43.951896	You search and find nothing.	t	0	2
851	2010-02-17 15:31:43.951896	You search and find a MRE.	t	0	2
852	2010-02-17 15:31:44.440261	You search and find nothing.	t	0	2
853	2010-02-17 15:31:44.440261	You search and find nothing.	t	0	2
854	2010-02-17 15:31:44.440261	You search and find a Vodka.	t	0	2
855	2010-02-17 15:31:44.440261	You search and find nothing.	t	0	2
856	2010-02-17 15:31:44.440261	You search and find a Vodka.	t	0	2
857	2010-02-17 15:31:44.871532	You search and find nothing.	t	0	2
858	2010-02-17 15:31:44.871532	You search and find nothing.	t	0	2
859	2010-02-17 15:31:44.871532	You search and find nothing.	t	0	2
860	2010-02-17 15:31:44.871532	You search and find nothing.	t	0	2
861	2010-02-17 15:31:44.871532	You search and find nothing.	t	0	2
862	2010-02-17 23:19:03.674017	You search and find nothing.	t	0	2
863	2010-02-17 23:19:03.674017	You search and find nothing.	t	0	2
864	2010-02-17 23:19:03.674017	You search and find nothing.	t	0	2
865	2010-02-17 23:19:03.674017	You search and find nothing.	t	0	2
866	2010-02-17 23:19:03.674017	You search and find a Vodka.	t	0	2
867	2010-02-17 23:19:03.783662	You search and find a MRE.	t	0	2
868	2010-02-17 23:19:03.783662	You search and find nothing.	t	0	2
869	2010-02-17 23:19:03.783662	You search and find nothing.	t	0	2
870	2010-02-17 23:19:03.783662	You search and find nothing.	t	0	2
871	2010-02-17 23:19:03.783662	You search and find nothing.	t	0	2
872	2010-02-17 23:19:03.886447	You search and find nothing.	t	0	2
873	2010-02-17 23:19:03.886447	You search and find nothing.	t	0	2
874	2010-02-17 23:19:03.886447	You search and find nothing.	t	0	2
875	2010-02-17 23:19:03.886447	You search and find nothing.	t	0	2
876	2010-02-17 23:19:03.886447	You search and find nothing.	t	0	2
877	2010-02-17 23:19:03.918075	You search and find nothing.	t	0	2
878	2010-02-17 23:19:03.918075	You search and find nothing.	t	0	2
879	2010-02-17 23:19:03.918075	You search and find nothing.	t	0	2
880	2010-02-17 23:19:03.918075	You search and find nothing.	t	0	2
881	2010-02-17 23:19:03.918075	You search and find nothing.	t	0	2
882	2010-02-17 23:19:04.076665	You search and find nothing.	t	0	2
883	2010-02-17 23:19:04.076665	You search and find nothing.	t	0	2
884	2010-02-17 23:19:04.076665	You search and find nothing.	t	0	2
885	2010-02-17 23:19:04.076665	You search and find nothing.	t	0	2
886	2010-02-17 23:19:04.076665	You search and find nothing.	t	0	2
887	2010-02-17 23:19:04.250462	You search and find nothing.	t	0	2
888	2010-02-17 23:19:04.250462	You search and find nothing.	t	0	2
889	2010-02-17 23:19:04.250462	You search and find nothing.	t	0	2
890	2010-02-17 23:19:04.250462	You search and find nothing.	t	0	2
891	2010-02-17 23:19:04.250462	You search and find nothing.	t	0	2
892	2010-02-17 23:19:06.386434	You search and find nothing.	t	0	2
893	2010-02-17 23:19:06.386434	You search and find nothing.	t	0	2
894	2010-02-17 23:19:06.386434	You search and find a Energy pack .	t	0	2
895	2010-02-17 23:19:06.386434	You search and find nothing.	t	0	2
896	2010-02-17 23:19:06.386434	You search and find nothing.	t	0	2
897	2010-02-17 23:19:06.71448	You search and find nothing.	t	0	2
898	2010-02-17 23:19:06.71448	You search and find nothing.	t	0	2
899	2010-02-17 23:19:06.71448	You search and find nothing.	t	0	2
900	2010-02-17 23:19:06.71448	You search and find nothing.	t	0	2
901	2010-02-17 23:19:06.71448	You search and find a MRE.	t	0	2
902	2010-02-17 23:19:07.161919	You search and find nothing.	t	0	2
903	2010-02-17 23:19:07.161919	You search and find nothing.	t	0	2
904	2010-02-17 23:19:07.161919	You search and find nothing.	t	0	2
905	2010-02-17 23:19:07.161919	You search and find nothing.	t	0	2
906	2010-02-17 23:19:07.161919	You search and find nothing.	t	0	2
907	2010-02-17 23:19:07.610456	You search and find nothing.	t	0	2
908	2010-02-17 23:19:07.610456	You search and find nothing.	t	0	2
909	2010-02-17 23:19:07.610456	You search and find nothing.	t	0	2
910	2010-02-17 23:19:07.610456	You search and find nothing.	t	0	2
911	2010-02-17 23:19:07.610456	You search and find a Energy rifle .	t	0	2
912	2010-02-17 23:19:07.99804	You search and find a Energy rifle .	t	0	2
913	2010-02-17 23:19:07.99804	You search and find nothing.	t	0	2
914	2010-02-17 23:19:07.99804	You search and find nothing.	t	0	2
915	2010-02-17 23:19:07.99804	You search and find nothing.	t	0	2
916	2010-02-17 23:19:07.99804	You search and find nothing.	t	0	2
917	2010-02-17 23:19:09.555103	You search and find nothing.	t	0	2
2407	2010-03-11 09:49:44.946814	You drop your null.	t	0	2
2408	2010-03-11 09:50:04.96749	You drop your Energy pack.	t	0	2
2409	2010-03-11 09:50:05.326877	You drop your Energy pack.	t	0	2
2410	2010-03-11 09:50:05.75545	You drop your Energy pack.	t	0	2
918	2010-02-17 23:19:09.555103	You search and find a Energy pistol.	t	0	2
919	2010-02-17 23:19:09.555103	You search and find a Vodka.	t	0	2
920	2010-02-17 23:19:09.555103	You search and find nothing.	t	0	2
921	2010-02-17 23:19:09.555103	You search and find nothing.	t	0	2
922	2010-02-17 23:19:09.961737	You search and find a Energy pack .	t	0	2
923	2010-02-17 23:19:09.961737	You search and find nothing.	t	0	2
924	2010-02-17 23:19:09.961737	You search and find a MRE.	t	0	2
925	2010-02-17 23:19:09.961737	You search and find nothing.	t	0	2
926	2010-02-17 23:19:09.961737	You search and find nothing.	t	0	2
927	2010-02-17 23:19:10.378071	You search and find nothing.	t	0	2
928	2010-02-17 23:19:10.378071	You search and find a Vodka.	t	0	2
929	2010-02-17 23:19:10.378071	You search and find nothing.	t	0	2
930	2010-02-17 23:19:10.378071	You search and find nothing.	t	0	2
931	2010-02-17 23:19:10.378071	You search and find a MRE.	t	0	2
932	2010-02-17 23:40:31.881122	You search and find a Energy rifle .	t	0	2
933	2010-02-17 23:40:31.881122	You search and find nothing.	t	0	2
934	2010-02-17 23:40:31.881122	You search and find nothing.	t	0	2
935	2010-02-17 23:40:31.881122	You search and find a Energy rifle .	t	0	2
936	2010-02-17 23:40:31.881122	You search and find nothing.	t	0	2
937	2010-02-17 23:58:15.72648	You search and find a Vodka.	t	0	2
938	2010-02-17 23:58:15.72648	You search and find a Vodka.	t	0	2
939	2010-02-17 23:58:15.72648	You search and find a Vodka.	t	0	2
940	2010-02-17 23:58:15.72648	You search and find nothing.	t	0	2
941	2010-02-17 23:58:15.72648	You search and find nothing.	t	0	2
942	2010-02-17 23:58:16.188662	You search and find nothing.	t	0	2
943	2010-02-17 23:58:16.188662	You search and find nothing.	t	0	2
944	2010-02-17 23:58:16.188662	You search and find nothing.	t	0	2
945	2010-02-17 23:58:16.188662	You search and find nothing.	t	0	2
946	2010-02-17 23:58:16.188662	You search and find a Vodka.	t	0	2
947	2010-02-17 23:58:16.73246	You search and find nothing.	t	0	2
948	2010-02-17 23:58:16.73246	You search and find nothing.	t	0	2
949	2010-02-17 23:58:16.73246	You search and find nothing.	t	0	2
950	2010-02-17 23:58:16.73246	You search and find nothing.	t	0	2
951	2010-02-17 23:58:16.73246	You search and find nothing.	t	0	2
952	2010-02-17 23:58:17.16455	You search and find nothing.	t	0	2
953	2010-02-17 23:58:17.16455	You search and find a MRE.	t	0	2
954	2010-02-17 23:58:17.16455	You search and find nothing.	t	0	2
955	2010-02-17 23:58:17.16455	You search and find nothing.	t	0	2
956	2010-02-17 23:58:17.16455	You search and find a Energy pistol.	t	0	2
957	2010-02-17 23:58:17.548504	You search and find nothing.	t	0	2
958	2010-02-17 23:58:17.548504	You search and find a Vodka.	t	0	2
959	2010-02-17 23:58:17.548504	You search and find nothing.	t	0	2
960	2010-02-17 23:58:17.548504	You search and find nothing.	t	0	2
961	2010-02-17 23:58:17.548504	You search and find a Vodka.	t	0	2
962	2010-02-17 23:58:17.900434	You search and find nothing.	t	0	2
963	2010-02-17 23:58:17.900434	You search and find a Energy rifle .	t	0	2
964	2010-02-17 23:58:17.900434	You search and find a Vodka.	t	0	2
965	2010-02-17 23:58:17.900434	You search and find a Energy pistol.	t	0	2
966	2010-02-17 23:58:17.900434	You search and find nothing.	t	0	2
967	2010-02-17 23:58:18.284902	You search and find nothing.	t	0	2
968	2010-02-17 23:58:18.284902	You search and find a Vodka.	t	0	2
969	2010-02-17 23:58:18.284902	You search and find nothing.	t	0	2
970	2010-02-17 23:58:18.284902	You search and find nothing.	t	0	2
971	2010-02-17 23:58:18.284902	You search and find nothing.	t	0	2
972	2010-02-17 23:58:18.61248	You search and find a MRE.	t	0	2
973	2010-02-17 23:58:18.61248	You search and find nothing.	t	0	2
974	2010-02-17 23:58:18.61248	You search and find nothing.	t	0	2
975	2010-02-17 23:58:18.61248	You search and find a Energy pack .	t	0	2
976	2010-02-17 23:58:18.61248	You search and find nothing.	t	0	2
977	2010-02-17 23:58:18.972458	You search and find nothing.	t	0	2
978	2010-02-17 23:58:18.972458	You search and find nothing.	t	0	2
979	2010-02-17 23:58:18.972458	You search and find nothing.	t	0	2
980	2010-02-17 23:58:18.972458	You search and find a MRE.	t	0	2
981	2010-02-17 23:58:18.972458	You search and find nothing.	t	0	2
982	2010-02-17 23:58:19.33248	You search and find nothing.	t	0	2
983	2010-02-17 23:58:19.33248	You search and find nothing.	t	0	2
984	2010-02-17 23:58:19.33248	You search and find nothing.	t	0	2
985	2010-02-17 23:58:19.33248	You search and find nothing.	t	0	2
986	2010-02-17 23:58:19.33248	You search and find nothing.	t	0	2
987	2010-02-18 16:27:52.637072	You search and find nothing.	t	0	2
988	2010-02-18 16:27:52.637072	You search and find nothing.	t	0	2
989	2010-02-18 16:27:52.637072	You search and find nothing.	t	0	2
990	2010-02-18 16:27:52.637072	You search and find nothing.	t	0	2
991	2010-02-18 16:27:52.637072	You search and find nothing.	t	0	2
992	2010-02-18 16:27:53.577198	You search and find nothing.	t	0	2
993	2010-02-18 16:27:53.577198	You search and find nothing.	t	0	2
994	2010-02-18 16:27:53.577198	You search and find nothing.	t	0	2
995	2010-02-18 16:27:53.577198	You search and find a Vodka.	t	0	2
996	2010-02-18 16:27:53.577198	You search and find nothing.	t	0	2
2411	2010-03-11 09:50:06.599289	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
997	2010-02-18 16:27:54.185039	You search and find nothing.	t	0	2
998	2010-02-18 16:27:54.185039	You search and find a Energy pack .	t	0	2
999	2010-02-18 16:27:54.185039	You search and find nothing.	t	0	2
2412	2010-03-11 09:50:07.043375	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2413	2010-03-11 09:50:07.631609	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2414	2010-03-11 09:50:08.23908	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2415	2010-03-11 09:50:09.23133	You drop your Energy pistol.	t	0	2
1701	2010-02-21 23:43:02.432815	You search and find nothing.	t	0	13
1702	2010-02-21 23:43:02.432815	You search and find a MRE.	t	0	13
1703	2010-02-21 23:43:02.432815	You search and find nothing.	t	0	13
1704	2010-02-21 23:43:02.432815	You search and find nothing.	t	0	13
1705	2010-02-21 23:43:02.432815	You search and find nothing.	t	0	13
2416	2010-03-11 09:50:09.980221	You have unequipped your Energy pistol.	t	0	2
2417	2010-03-11 09:50:11.007384	You drop your Energy pistol.	t	0	2
2418	2010-03-11 09:50:11.447146	You drop your Energy pistol.	t	0	2
2419	2010-03-11 09:50:11.859291	You drop your Energy pistol.	t	0	2
2420	2010-03-11 09:50:12.435335	You drop your Energy pistol.	t	0	2
2421	2010-03-11 09:50:12.944319	You drop your Energy rifle.	t	0	2
2422	2010-03-11 09:50:14.117601	You drop your null.	t	0	2
2423	2010-03-11 09:50:15.125031	You drop your null.	t	0	2
2424	2010-03-11 09:50:15.556795	You drop your null.	t	0	2
1000	2010-02-18 16:27:54.185039	You search and find nothing.	t	0	2
1001	2010-02-18 16:27:54.185039	You search and find nothing.	t	0	2
1002	2010-02-18 16:27:54.753002	You search and find nothing.	t	0	2
1003	2010-02-18 16:27:54.753002	You search and find a Vodka.	t	0	2
1004	2010-02-18 16:27:54.753002	You search and find nothing.	t	0	2
1005	2010-02-18 16:27:54.753002	You search and find nothing.	t	0	2
1006	2010-02-18 16:27:54.753002	You search and find nothing.	t	0	2
1007	2010-02-18 16:27:55.321029	You search and find nothing.	t	0	2
1008	2010-02-18 16:27:55.321029	You search and find nothing.	t	0	2
1009	2010-02-18 16:27:55.321029	You search and find nothing.	t	0	2
1010	2010-02-18 16:27:55.321029	You search and find nothing.	t	0	2
1011	2010-02-18 16:27:55.321029	You search and find a Energy pack .	t	0	2
2425	2010-03-11 09:50:15.780935	You drop your null.	t	0	2
2426	2010-03-11 09:50:15.980939	You drop your null.	t	0	2
2427	2010-03-11 09:50:16.203708	You drop your null.	t	0	2
2428	2010-03-11 09:50:16.373646	You drop your null.	t	0	2
2429	2010-03-11 09:50:16.572887	You drop your null.	t	0	2
2430	2010-03-11 09:50:16.756331	You drop your null.	t	0	2
2431	2010-03-11 09:50:16.933022	You drop your null.	t	0	2
2432	2010-03-11 09:50:17.116992	You drop your null.	t	0	2
2433	2010-03-11 09:50:17.284817	You drop your null.	t	0	2
1012	2010-02-18 16:28:04.50551	You search and find nothing.	t	0	2
1013	2010-02-18 16:28:04.50551	You search and find nothing.	t	0	2
1014	2010-02-18 16:28:04.50551	You search and find nothing.	t	0	2
1015	2010-02-18 16:28:04.50551	You search and find nothing.	t	0	2
1016	2010-02-18 16:28:04.50551	You search and find nothing.	t	0	2
1017	2010-02-18 16:28:04.697216	You search and find nothing.	t	0	2
1018	2010-02-18 16:28:04.697216	You search and find nothing.	t	0	2
1019	2010-02-18 16:28:04.697216	You search and find nothing.	t	0	2
1020	2010-02-18 16:28:04.697216	You search and find a Energy pack .	t	0	2
1021	2010-02-18 16:28:04.697216	You search and find a Energy pistol.	t	0	2
1022	2010-02-18 16:30:49.197187	You search and find nothing.	t	0	2
1023	2010-02-18 16:30:49.197187	You search and find nothing.	t	0	2
1024	2010-02-18 16:30:49.197187	You search and find nothing.	t	0	2
2434	2010-03-11 09:50:58.248519	You search and find nothing.	t	0	2
2435	2010-03-11 09:50:58.248519	You search and find nothing.	t	0	2
2436	2010-03-11 09:50:58.248519	You search and find nothing.	t	0	2
2437	2010-03-11 09:50:58.248519	You search and find a Vodka.	t	0	2
2438	2010-03-11 09:50:58.248519	You search and find nothing.	t	0	2
2439	2010-03-11 09:50:58.596059	You search and find nothing.	t	0	2
2440	2010-03-11 09:50:58.596059	You search and find nothing.	t	0	2
2441	2010-03-11 09:50:58.596059	You search and find nothing.	t	0	2
2442	2010-03-11 09:50:58.596059	You search and find nothing.	t	0	2
2443	2010-03-11 09:50:58.596059	You search and find nothing.	t	0	2
2444	2010-03-11 09:50:58.964868	You search and find nothing.	t	0	2
1706	2010-02-21 23:43:02.863609	You search and find nothing.	t	0	13
1707	2010-02-21 23:43:02.863609	You search and find nothing.	t	0	13
1708	2010-02-21 23:43:02.863609	You search and find a Vodka.	t	0	13
1709	2010-02-21 23:43:02.863609	You search and find nothing.	t	0	13
1710	2010-02-21 23:43:02.863609	You search and find nothing.	t	0	13
1711	2010-02-21 23:43:03.287293	You search and find nothing.	t	0	13
1712	2010-02-21 23:43:03.287293	You search and find a MRE.	t	0	13
1713	2010-02-21 23:43:03.287293	You search and find a Energy pistol.	t	0	13
1714	2010-02-21 23:43:03.287293	You search and find nothing.	t	0	13
1715	2010-02-21 23:43:03.287293	You search and find nothing.	t	0	13
1716	2010-02-21 23:43:03.671425	You search and find nothing.	t	0	13
1717	2010-02-21 23:43:03.671425	You search and find a Vodka.	t	0	13
1718	2010-02-21 23:43:03.671425	You search and find nothing.	t	0	13
1719	2010-02-21 23:43:03.671425	You search and find a Energy pistol.	t	0	13
1720	2010-02-21 23:43:03.671425	You search and find nothing.	t	0	13
1721	2010-02-21 23:43:04.087835	You search and find nothing.	t	0	13
1025	2010-02-18 16:30:49.197187	You search and find nothing.	t	0	2
1026	2010-02-18 16:30:49.197187	You search and find nothing.	t	0	2
1027	2010-02-18 16:45:43.147771	You search and find nothing.	t	0	12
1028	2010-02-18 16:45:43.147771	You search and find a Vodka.	t	0	12
1029	2010-02-18 16:45:43.147771	You search and find nothing.	t	0	12
1030	2010-02-18 16:45:43.147771	You search and find a Vodka.	t	0	12
1031	2010-02-18 16:45:43.147771	You search and find a Vodka.	t	0	12
1032	2010-02-18 16:45:43.753312	You search and find nothing.	t	0	12
1033	2010-02-18 16:45:43.753312	You search and find nothing.	t	0	12
1034	2010-02-18 16:45:43.753312	You search and find a Energy pack .	t	0	12
1035	2010-02-18 16:45:43.753312	You search and find nothing.	t	0	12
1036	2010-02-18 16:45:43.753312	You search and find nothing.	t	0	12
1037	2010-02-18 16:45:44.195993	You search and find nothing.	t	0	12
1038	2010-02-18 16:45:44.195993	You search and find nothing.	t	0	12
1039	2010-02-18 16:45:44.195993	You search and find nothing.	t	0	12
1040	2010-02-18 16:45:44.195993	You search and find a Vodka.	t	0	12
1041	2010-02-18 16:45:44.195993	You search and find nothing.	t	0	12
1042	2010-02-18 16:45:44.537068	You search and find nothing.	t	0	12
1043	2010-02-18 16:45:44.537068	You search and find nothing.	t	0	12
1044	2010-02-18 16:45:44.537068	You search and find a Energy pistol.	t	0	12
1045	2010-02-18 16:45:44.537068	You search and find nothing.	t	0	12
1046	2010-02-18 16:45:44.537068	You search and find a Energy pistol.	t	0	12
1047	2010-02-18 16:45:44.73681	You search and find nothing.	t	0	12
1048	2010-02-18 16:45:44.73681	You search and find a Vodka.	t	0	12
1049	2010-02-18 16:45:44.73681	You search and find nothing.	t	0	12
1050	2010-02-18 16:45:44.73681	You search and find nothing.	t	0	12
1051	2010-02-18 16:45:44.73681	You search and find nothing.	t	0	12
1738	2010-02-21 23:43:11.869257	You drop your Energy rifle.	t	0	13
1739	2010-02-21 23:43:12.788799	You drop your Energy pistol.	t	0	13
1740	2010-02-21 23:43:12.97699	You drop your Energy pistol.	t	0	13
1741	2010-02-21 23:43:13.261812	You drop your Energy pistol.	t	0	13
1680	2010-02-21 23:43:00.129311	You search and find nothing.	t	0	13
1694	2010-02-21 23:43:01.575275	You search and find nothing.	t	0	13
1695	2010-02-21 23:43:01.575275	You search and find nothing.	t	0	13
1697	2010-02-21 23:43:02.013945	You search and find nothing.	t	0	13
1698	2010-02-21 23:43:02.013945	You search and find a Energy rifle .	t	0	13
1699	2010-02-21 23:43:02.013945	You search and find a Energy rifle .	t	0	13
1700	2010-02-21 23:43:02.013945	You search and find a Energy pistol.	t	0	13
1722	2010-02-21 23:43:04.087835	You search and find nothing.	t	0	13
1723	2010-02-21 23:43:04.087835	You search and find nothing.	t	0	13
1724	2010-02-21 23:43:04.087835	You search and find a Vodka.	t	0	13
1725	2010-02-21 23:43:04.087835	You search and find nothing.	t	0	13
1726	2010-02-21 23:43:04.471104	You search and find nothing.	t	0	13
1727	2010-02-21 23:43:04.471104	You search and find nothing.	t	0	13
1728	2010-02-21 23:43:04.471104	You search and find nothing.	t	0	13
1729	2010-02-21 23:43:04.471104	You search and find nothing.	t	0	13
1730	2010-02-21 23:43:04.471104	You search and find nothing.	t	0	13
1731	2010-02-21 23:43:05.918602	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
1732	2010-02-21 23:43:06.278315	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
1733	2010-02-21 23:43:06.601475	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
1734	2010-02-21 23:43:06.922512	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
1735	2010-02-21 23:43:07.274442	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
1736	2010-02-21 23:43:07.565448	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
1737	2010-02-21 23:43:11.469133	You drop your Energy rifle.	t	0	13
1742	2010-02-21 23:43:13.573156	You drop your Energy pack.	t	0	13
2445	2010-03-11 09:50:58.964868	You search and find nothing.	t	0	2
2446	2010-03-11 09:50:58.964868	You search and find nothing.	t	0	2
2447	2010-03-11 09:50:58.964868	You search and find a Vodka.	t	0	2
2448	2010-03-11 09:50:58.964868	You search and find nothing.	t	0	2
2449	2010-03-11 09:50:59.503354	You search and find nothing.	t	0	2
2450	2010-03-11 09:50:59.503354	You search and find nothing.	t	0	2
2451	2010-03-11 09:50:59.503354	You search and find nothing.	t	0	2
2452	2010-03-11 09:50:59.503354	You search and find nothing.	t	0	2
2453	2010-03-11 09:50:59.503354	You search and find nothing.	t	0	2
2454	2010-03-11 09:50:59.533148	You search and find nothing.	t	0	2
2455	2010-03-11 09:50:59.533148	You search and find nothing.	t	0	2
2456	2010-03-11 09:50:59.533148	You search and find a MRE.	t	0	2
1052	2010-02-18 16:48:00.616408	You search and find nothing.	t	0	13
1053	2010-02-18 16:48:00.616408	You search and find nothing.	t	0	13
1054	2010-02-18 16:48:00.616408	You search and find nothing.	t	0	13
1055	2010-02-18 16:48:00.616408	You search and find nothing.	t	0	13
1056	2010-02-18 16:48:00.616408	You search and find a Vodka.	t	0	13
1057	2010-02-18 16:48:00.873795	You search and find a Energy rifle .	t	0	13
1058	2010-02-18 16:48:00.873795	You search and find nothing.	t	0	13
1059	2010-02-18 16:48:00.873795	You search and find nothing.	t	0	13
1060	2010-02-18 16:48:00.873795	You search and find nothing.	t	0	13
1061	2010-02-18 16:48:00.873795	You search and find a MRE.	t	0	13
1062	2010-02-18 16:48:00.923678	You search and find nothing.	t	0	13
1063	2010-02-18 16:48:00.923678	You search and find nothing.	t	0	13
1064	2010-02-18 16:48:00.923678	You search and find nothing.	t	0	13
1065	2010-02-18 16:48:00.923678	You search and find nothing.	t	0	13
1066	2010-02-18 16:48:00.923678	You search and find nothing.	t	0	13
1067	2010-02-18 16:48:00.949073	You search and find nothing.	t	0	13
1068	2010-02-18 16:48:00.949073	You search and find nothing.	t	0	13
1069	2010-02-18 16:48:00.949073	You search and find nothing.	t	0	13
1070	2010-02-18 16:48:00.949073	You search and find a MRE.	t	0	13
1071	2010-02-18 16:48:00.949073	You search and find nothing.	t	0	13
1072	2010-02-18 16:48:02.520137	You search and find a Energy rifle .	t	0	13
1073	2010-02-18 16:48:02.520137	You search and find nothing.	t	0	13
1074	2010-02-18 16:48:02.520137	You search and find nothing.	t	0	13
1075	2010-02-18 16:48:02.520137	You search and find nothing.	t	0	13
1076	2010-02-18 16:48:02.520137	You search and find a Energy pack .	t	0	13
2457	2010-03-11 09:50:59.533148	You search and find nothing.	t	0	2
2458	2010-03-11 09:50:59.533148	You search and find a Energy pistol.	t	0	2
2459	2010-03-11 09:50:59.858355	You search and find a Vodka.	t	0	2
2460	2010-03-11 09:50:59.858355	You search and find nothing.	t	0	2
2461	2010-03-11 09:50:59.858355	You search and find nothing.	t	0	2
2462	2010-03-11 09:50:59.858355	You search and find nothing.	t	0	2
2463	2010-03-11 09:50:59.858355	You search and find nothing.	t	0	2
2464	2010-03-11 09:51:01.240107	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2465	2010-03-11 09:51:01.408428	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2466	2010-03-11 09:51:01.679374	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2467	2010-03-11 09:51:02.08293	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2468	2010-03-11 09:51:02.511191	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
2469	2010-03-11 09:51:03.863285	You have unequipped your Energy pistol.	t	0	2
2470	2010-03-11 09:51:06.688469	You drop your Energy pistol.	t	0	2
2493	2010-03-11 09:54:17.095269	You drop your Energy rifle.	t	0	2
2494	2010-03-11 09:54:17.663268	You drop your Energy pack.	t	0	2
2502	2010-03-11 09:55:09.680266	You drop your Energy rifle.	t	0	2
2471	2010-03-11 09:54:00.790851	You search and find nothing.	t	0	2
2472	2010-03-11 09:54:00.790851	You search and find nothing.	t	0	2
2473	2010-03-11 09:54:00.790851	You search and find nothing.	t	0	2
2474	2010-03-11 09:54:00.790851	You search and find nothing.	t	0	2
2475	2010-03-11 09:54:00.790851	You search and find nothing.	t	0	2
2476	2010-03-11 09:54:02.354745	You search and find nothing.	t	0	2
2477	2010-03-11 09:54:02.354745	You search and find nothing.	t	0	2
2478	2010-03-11 09:54:02.354745	You search and find nothing.	t	0	2
2479	2010-03-11 09:54:02.354745	You search and find a Energy pack.	t	0	2
2480	2010-03-11 09:54:02.354745	You search and find nothing.	t	0	2
2481	2010-03-11 09:54:04.312081	You drop your Energy pack.	t	0	2
2495	2010-03-11 09:55:05.928721	You search and find nothing.	t	0	2
2482	2010-03-11 09:54:13.524397	You search and find a Energy pistol.	t	0	2
2483	2010-03-11 09:54:13.524397	You search and find nothing.	t	0	2
2484	2010-03-11 09:54:13.524397	You search and find nothing.	t	0	2
2485	2010-03-11 09:54:13.524397	You search and find nothing.	t	0	2
2486	2010-03-11 09:54:13.524397	You search and find nothing.	t	0	2
2487	2010-03-11 09:54:14.426839	You search and find nothing.	t	0	2
2488	2010-03-11 09:54:14.426839	You search and find nothing.	t	0	2
2489	2010-03-11 09:54:14.426839	You search and find a Energy rifle.	t	0	2
2490	2010-03-11 09:54:14.426839	You search and find nothing.	t	0	2
2491	2010-03-11 09:54:14.426839	You search and find a Energy pack.	t	0	2
2492	2010-03-11 09:54:16.591283	You drop your Energy pistol.	t	0	2
2496	2010-03-11 09:55:05.928721	You search and find nothing.	t	0	2
2497	2010-03-11 09:55:05.928721	You search and find a Energy rifle.	t	0	2
2498	2010-03-11 09:55:05.928721	You search and find a Vodka.	t	0	2
2499	2010-03-11 09:55:05.928721	You search and find a MRE.	t	0	2
2500	2010-03-11 09:55:08.180195	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2501	2010-03-11 09:55:08.715893	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2503	2010-03-11 09:55:14.81129	You search and find a Vodka.	t	0	2
2504	2010-03-11 09:55:14.81129	You search and find nothing.	t	0	2
2505	2010-03-11 09:55:14.81129	You search and find nothing.	t	0	2
2506	2010-03-11 09:55:14.81129	You search and find nothing.	t	0	2
2507	2010-03-11 09:55:14.81129	You search and find a MRE.	t	0	2
2508	2010-03-11 09:55:15.674369	You search and find a Vodka.	t	0	2
2509	2010-03-11 09:55:15.674369	You search and find nothing.	t	0	2
2510	2010-03-11 09:55:15.674369	You search and find nothing.	t	0	2
2511	2010-03-11 09:55:15.674369	You search and find nothing.	t	0	2
1077	2010-02-18 16:48:02.678538	You search and find a Vodka.	t	0	13
1078	2010-02-18 16:48:02.678538	You search and find nothing.	t	0	13
1079	2010-02-18 16:48:02.678538	You search and find nothing.	t	0	13
1080	2010-02-18 16:48:02.678538	You search and find nothing.	t	0	13
1081	2010-02-18 16:48:02.678538	You search and find nothing.	t	0	13
1082	2010-02-18 16:48:02.820947	You search and find nothing.	t	0	13
1083	2010-02-18 16:48:02.820947	You search and find nothing.	t	0	13
1084	2010-02-18 16:48:02.820947	You search and find a Energy pack .	t	0	13
1085	2010-02-18 16:48:02.820947	You search and find nothing.	t	0	13
1086	2010-02-18 16:48:02.820947	You search and find a Energy pack .	t	0	13
1087	2010-02-18 16:48:03.068772	You search and find nothing.	t	0	13
1088	2010-02-18 16:48:03.068772	You search and find nothing.	t	0	13
1089	2010-02-18 16:48:03.068772	You search and find nothing.	t	0	13
1090	2010-02-18 16:48:03.068772	You search and find nothing.	t	0	13
1091	2010-02-18 16:48:03.068772	You search and find nothing.	t	0	13
1173	2010-02-20 02:29:34.51753	You search and find nothing.	t	0	10
1172	2010-02-20 02:29:34.51753	You search and find nothing.	t	0	10
1171	2010-02-20 02:29:34.51753	You search and find nothing.	t	0	10
1170	2010-02-20 02:29:34.51753	You search and find nothing.	t	0	10
1169	2010-02-20 02:29:34.51753	You search and find nothing.	t	0	10
1168	2010-02-20 02:29:34.311724	You search and find a Vodka.	t	0	10
1167	2010-02-20 02:29:34.311724	You search and find nothing.	t	0	10
1166	2010-02-20 02:29:34.311724	You search and find nothing.	t	0	10
1165	2010-02-20 02:29:34.311724	You search and find a MRE.	t	0	10
1164	2010-02-20 02:29:34.311724	You search and find nothing.	t	0	10
1142	2010-02-20 01:27:31.67386	You search and find nothing.	t	0	12
1143	2010-02-20 01:27:31.67386	You search and find nothing.	t	0	12
1144	2010-02-20 01:27:31.67386	You search and find a Energy pistol.	t	0	12
1145	2010-02-20 01:27:31.67386	You search and find nothing.	t	0	12
1146	2010-02-20 01:27:31.67386	You search and find nothing.	t	0	12
1137	2010-02-20 01:27:31.490116	You search and find nothing.	t	0	12
1138	2010-02-20 01:27:31.490116	You search and find nothing.	t	0	12
1139	2010-02-20 01:27:31.490116	You search and find a Vodka.	t	0	12
1140	2010-02-20 01:27:31.490116	You search and find nothing.	t	0	12
1141	2010-02-20 01:27:31.490116	You search and find nothing.	t	0	12
1122	2010-02-20 01:27:23.325333	You search and find nothing.	t	0	12
1123	2010-02-20 01:27:23.325333	You search and find nothing.	t	0	12
1124	2010-02-20 01:27:23.325333	You search and find a Energy rifle .	t	0	12
1125	2010-02-20 01:27:23.325333	You search and find a Energy pack .	t	0	12
1126	2010-02-20 01:27:23.325333	You search and find a MRE.	t	0	12
1127	2010-02-20 01:27:23.778975	You search and find nothing.	t	0	12
1128	2010-02-20 01:27:23.778975	You search and find a MRE.	t	0	12
1129	2010-02-20 01:27:23.778975	You search and find a Energy pistol.	t	0	12
1130	2010-02-20 01:27:23.778975	You search and find nothing.	t	0	12
1131	2010-02-20 01:27:23.778975	You search and find nothing.	t	0	12
1132	2010-02-20 01:27:24.274123	You search and find nothing.	t	0	12
1133	2010-02-20 01:27:24.274123	You search and find nothing.	t	0	12
1134	2010-02-20 01:27:24.274123	You search and find nothing.	t	0	12
1135	2010-02-20 01:27:24.274123	You search and find nothing.	t	0	12
1136	2010-02-20 01:27:24.274123	You search and find nothing.	t	0	12
1163	2010-02-20 02:29:34.133306	You search and find nothing.	t	0	10
1162	2010-02-20 02:29:34.133306	You search and find nothing.	t	0	10
1161	2010-02-20 02:29:34.133306	You search and find nothing.	t	0	10
1160	2010-02-20 02:29:34.133306	You search and find a MRE.	t	0	10
1159	2010-02-20 02:29:34.133306	You search and find nothing.	t	0	10
1152	2010-02-20 02:26:05.808184	You switch your equipped weapon. You will now use your Energy rifle  when attacking your enemies.	t	0	10
1151	2010-02-20 02:21:23.357892	You search and find nothing.	t	0	10
1150	2010-02-20 02:21:23.357892	You search and find nothing.	t	0	10
1149	2010-02-20 02:21:23.357892	You search and find nothing.	t	0	10
1148	2010-02-20 02:21:23.357892	You search and find a Energy rifle .	t	0	10
1147	2010-02-20 02:21:23.357892	You search and find nothing.	t	0	10
1153	2010-02-20 02:26:09.9699	You switch your equipped weapon. You will now use your Energy rifle  when attacking your enemies.	t	0	10
1158	2010-02-20 02:29:34.083377	You search and find nothing.	t	0	10
1157	2010-02-20 02:29:34.083377	You search and find nothing.	t	0	10
1156	2010-02-20 02:29:34.083377	You search and find nothing.	t	0	10
1155	2010-02-20 02:29:34.083377	You search and find nothing.	t	0	10
1154	2010-02-20 02:29:34.083377	You search and find nothing.	t	0	10
1187	2010-02-20 02:29:40.699206	You search and find nothing.	t	0	10
1186	2010-02-20 02:29:40.699206	You search and find a Energy rifle .	t	0	10
1185	2010-02-20 02:29:40.699206	You search and find nothing.	t	0	10
1184	2010-02-20 02:29:40.699206	You search and find nothing.	t	0	10
1183	2010-02-20 02:29:40.499217	You search and find nothing.	t	0	10
1182	2010-02-20 02:29:40.499217	You search and find a Energy pack .	t	0	10
1181	2010-02-20 02:29:40.499217	You search and find nothing.	t	0	10
1180	2010-02-20 02:29:40.499217	You search and find nothing.	t	0	10
1179	2010-02-20 02:29:40.499217	You search and find nothing.	t	0	10
1178	2010-02-20 02:29:40.035752	You search and find a MRE.	t	0	10
1177	2010-02-20 02:29:40.035752	You search and find a MRE.	t	0	10
1176	2010-02-20 02:29:40.035752	You search and find nothing.	t	0	10
1175	2010-02-20 02:29:40.035752	You search and find nothing.	t	0	10
1174	2010-02-20 02:29:40.035752	You search and find nothing.	t	0	10
2512	2010-03-11 09:55:15.674369	You search and find nothing.	t	0	2
2513	2010-03-11 09:55:15.876812	You search and find nothing.	t	0	2
2514	2010-03-11 09:55:15.876812	You search and find a Energy rifle.	t	0	2
2515	2010-03-11 09:55:15.876812	You search and find nothing.	t	0	2
2516	2010-03-11 09:55:15.876812	You search and find nothing.	t	0	2
2517	2010-03-11 09:55:15.876812	You search and find a Energy rifle.	t	0	2
2518	2010-03-11 09:55:17.17505	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2519	2010-03-11 09:55:17.363313	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2520	2010-03-11 09:55:17.599365	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2521	2010-03-11 09:55:18.983237	You drop your Energy rifle.	t	0	2
2522	2010-03-11 09:56:04.067862	You search and find nothing.	t	0	2
1217	2010-02-20 11:03:19.170441	You open the null and start drinking.  All too soon, it's gone.	t	0	13
1218	2010-02-20 11:03:53.233259	You search and find nothing.	t	0	13
1193	2010-02-20 02:29:40.904635	You search and find nothing.	t	0	10
1192	2010-02-20 02:29:40.904635	You search and find nothing.	t	0	10
1191	2010-02-20 02:29:40.904635	You search and find a Energy pack .	t	0	10
1190	2010-02-20 02:29:40.904635	You search and find nothing.	t	0	10
1189	2010-02-20 02:29:40.904635	You search and find nothing.	t	0	10
1188	2010-02-20 02:29:40.699206	You search and find a Energy rifle .	t	0	10
1219	2010-02-20 11:03:53.233259	You search and find nothing.	t	0	13
1220	2010-02-20 11:03:53.233259	You search and find nothing.	t	0	13
1221	2010-02-20 11:03:53.233259	You search and find a Energy pistol.	t	0	13
1222	2010-02-20 11:03:53.233259	You search and find nothing.	t	0	13
1223	2010-02-20 11:03:53.419347	You search and find nothing.	t	0	13
1224	2010-02-20 11:03:53.419347	You search and find nothing.	t	0	13
1225	2010-02-20 11:03:53.419347	You search and find nothing.	t	0	13
1226	2010-02-20 11:03:53.419347	You search and find nothing.	t	0	13
1227	2010-02-20 11:03:53.419347	You search and find nothing.	t	0	13
1228	2010-02-20 11:03:54.759227	You search and find nothing.	t	0	13
1194	2010-02-20 11:02:00.168946	You search and find nothing.	t	0	13
1195	2010-02-20 11:02:00.168946	You search and find nothing.	t	0	13
1196	2010-02-20 11:02:00.168946	You search and find nothing.	t	0	13
1197	2010-02-20 11:02:00.168946	You search and find nothing.	t	0	13
1198	2010-02-20 11:02:00.168946	You search and find nothing.	t	0	13
1199	2010-02-20 11:02:00.371512	You search and find nothing.	t	0	13
1200	2010-02-20 11:02:00.371512	You search and find nothing.	t	0	13
1201	2010-02-20 11:02:00.371512	You search and find nothing.	t	0	13
1202	2010-02-20 11:02:00.371512	You search and find nothing.	t	0	13
1203	2010-02-20 11:02:00.371512	You search and find nothing.	t	0	13
1204	2010-02-20 11:03:06.57745	You open the null and start drinking.  All too soon, it's gone.	t	0	13
1205	2010-02-20 11:03:07.446048	You open the null and start drinking.  All too soon, it's gone.	t	0	13
1229	2010-02-20 11:03:54.759227	You search and find nothing.	t	0	13
1230	2010-02-20 11:03:54.759227	You search and find nothing.	t	0	13
1231	2010-02-20 11:03:54.759227	You search and find nothing.	t	0	13
1232	2010-02-20 11:03:54.759227	You search and find nothing.	t	0	13
1233	2010-02-20 11:03:54.93731	You search and find nothing.	t	0	13
1234	2010-02-20 11:03:54.93731	You search and find nothing.	t	0	13
1235	2010-02-20 11:03:54.93731	You search and find a MRE.	t	0	13
1236	2010-02-20 11:03:54.93731	You search and find nothing.	t	0	13
1237	2010-02-20 11:03:54.93731	You search and find nothing.	t	0	13
1206	2010-02-20 11:03:17.004323	You search and find a Vodka.	t	0	13
1207	2010-02-20 11:03:17.004323	You search and find nothing.	t	0	13
1208	2010-02-20 11:03:17.004323	You search and find nothing.	t	0	13
1209	2010-02-20 11:03:17.004323	You search and find nothing.	t	0	13
1210	2010-02-20 11:03:17.004323	You search and find a Vodka.	t	0	13
1211	2010-02-20 11:03:17.155402	You search and find nothing.	t	0	13
1212	2010-02-20 11:03:17.155402	You search and find nothing.	t	0	13
1213	2010-02-20 11:03:17.155402	You search and find a MRE.	t	0	13
1214	2010-02-20 11:03:17.155402	You search and find nothing.	t	0	13
1215	2010-02-20 11:03:17.155402	You search and find nothing.	t	0	13
1216	2010-02-20 11:03:18.518398	You open the null and start drinking.  All too soon, it's gone.	t	0	13
2539	2010-03-11 09:57:32.626545	You search and find a MRE.	t	0	2
2540	2010-03-11 09:57:32.626545	You search and find nothing.	t	0	2
2541	2010-03-11 09:57:32.626545	You search and find nothing.	t	0	2
2542	2010-03-11 09:57:32.626545	You search and find a MRE.	t	0	2
2543	2010-03-11 09:57:32.626545	You search and find nothing.	t	0	2
2534	2010-03-11 09:56:53.350531	You search and find nothing.	t	0	2
2535	2010-03-11 09:56:53.350531	You search and find nothing.	t	0	2
2536	2010-03-11 09:56:53.350531	You search and find nothing.	t	0	2
2523	2010-03-11 09:56:04.067862	You search and find nothing.	t	0	2
2524	2010-03-11 09:56:04.067862	You search and find nothing.	t	0	2
2525	2010-03-11 09:56:04.067862	You search and find nothing.	t	0	2
2526	2010-03-11 09:56:04.067862	You search and find nothing.	t	0	2
2527	2010-03-11 09:56:05.178182	You search and find nothing.	t	0	2
2528	2010-03-11 09:56:05.178182	You search and find a Vodka.	t	0	2
2529	2010-03-11 09:56:05.178182	You search and find nothing.	t	0	2
2530	2010-03-11 09:56:05.178182	You search and find nothing.	t	0	2
2531	2010-03-11 09:56:05.178182	You search and find nothing.	t	0	2
2532	2010-03-11 09:56:43.027773	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2533	2010-03-11 09:56:46.523254	You drop your Energy rifle.	t	0	2
2537	2010-03-11 09:56:53.350531	You search and find nothing.	t	0	2
2538	2010-03-11 09:56:53.350531	You search and find a Energy pistol.	t	0	2
2544	2010-03-11 09:58:05.59074	You search and find a Energy pack.	t	0	2
2545	2010-03-11 09:58:05.59074	You search and find nothing.	t	0	2
2546	2010-03-11 09:58:05.59074	You search and find a Energy pistol.	t	0	2
2547	2010-03-11 09:58:05.59074	You search and find nothing.	t	0	2
2548	2010-03-11 09:58:05.59074	You search and find nothing.	t	0	2
2549	2010-03-11 09:58:20.753485	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2550	2010-03-11 09:58:21.140378	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2551	2010-03-11 09:58:22.136209	You drop your Energy pack.	t	0	2
2552	2010-03-11 09:58:22.600295	You drop your Energy pistol.	t	0	2
2553	2010-03-11 09:58:23.160309	You drop your Energy pistol.	t	0	2
2554	2010-03-11 09:58:26.530307	You search and find nothing.	t	0	2
2555	2010-03-11 09:58:28.355025	You search and find a Vodka.	t	0	2
2556	2010-03-11 09:58:31.503077	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2557	2010-03-11 09:58:35.781657	You search and find nothing.	t	0	2
2558	2010-03-11 09:58:36.372899	You search and find nothing.	t	0	2
2559	2010-03-11 09:58:36.372899	You search and find nothing.	t	0	2
1245	2010-02-20 11:04:05.759921	You search and find nothing.	t	0	13
1246	2010-02-20 11:04:05.759921	You search and find a Energy pistol.	t	0	13
1247	2010-02-20 11:04:05.759921	You search and find nothing.	t	0	13
1248	2010-02-20 11:04:05.759921	You search and find a Energy rifle .	t	0	13
1238	2010-02-20 11:03:56.397988	You drop your null.	t	0	13
1239	2010-02-20 11:03:56.472518	You drop your null.	t	0	13
1240	2010-02-20 11:03:59.130402	You drop your null.	t	0	13
1241	2010-02-20 11:03:59.361662	You drop your null.	t	0	13
1242	2010-02-20 11:04:00.118385	You drop your null.	t	0	13
1243	2010-02-20 11:04:04.618302	You drop your null.	t	0	13
1244	2010-02-20 11:04:04.777438	You drop your null.	t	0	13
1249	2010-02-20 11:04:05.759921	You search and find nothing.	t	0	13
1250	2010-02-20 11:04:05.972242	You search and find nothing.	t	0	13
1251	2010-02-20 11:04:05.972242	You search and find a Energy pistol.	t	0	13
1252	2010-02-20 11:04:05.972242	You search and find nothing.	t	0	13
1253	2010-02-20 11:04:05.972242	You search and find nothing.	t	0	13
1254	2010-02-20 11:04:05.972242	You search and find nothing.	t	0	13
1255	2010-02-20 11:04:06.177099	You search and find nothing.	t	0	13
1256	2010-02-20 11:04:06.177099	You search and find nothing.	t	0	13
1257	2010-02-20 11:04:06.177099	You search and find nothing.	t	0	13
1258	2010-02-20 11:04:06.177099	You search and find nothing.	t	0	13
1259	2010-02-20 11:04:06.177099	You search and find nothing.	t	0	13
1270	2010-02-20 11:04:07.082455	You search and find nothing.	t	0	13
1271	2010-02-20 11:04:07.082455	You search and find nothing.	t	0	13
1272	2010-02-20 11:04:07.082455	You search and find nothing.	t	0	13
1273	2010-02-20 11:04:07.082455	You search and find nothing.	t	0	13
1274	2010-02-20 11:04:07.082455	You search and find nothing.	t	0	13
1260	2010-02-20 11:04:06.631271	You search and find nothing.	t	0	13
1261	2010-02-20 11:04:06.631271	You search and find nothing.	t	0	13
1262	2010-02-20 11:04:06.631271	You search and find nothing.	t	0	13
1263	2010-02-20 11:04:06.631271	You search and find a Energy pistol.	t	0	13
1264	2010-02-20 11:04:06.631271	You search and find nothing.	t	0	13
1280	2010-02-20 11:04:07.40322	You search and find nothing.	t	0	13
1281	2010-02-20 11:04:07.40322	You search and find nothing.	t	0	13
1282	2010-02-20 11:04:07.40322	You search and find a Energy pack .	t	0	13
1283	2010-02-20 11:04:07.40322	You search and find nothing.	t	0	13
1284	2010-02-20 11:04:07.40322	You search and find a Energy pack .	t	0	13
1265	2010-02-20 11:04:06.844821	You search and find nothing.	t	0	13
1266	2010-02-20 11:04:06.844821	You search and find a Vodka.	t	0	13
1267	2010-02-20 11:04:06.844821	You search and find a Energy pistol.	t	0	13
1268	2010-02-20 11:04:06.844821	You search and find a Energy rifle .	t	0	13
1269	2010-02-20 11:04:06.844821	You search and find nothing.	t	0	13
1275	2010-02-20 11:04:07.209335	You search and find nothing.	t	0	13
1276	2010-02-20 11:04:07.209335	You search and find a MRE.	t	0	13
1277	2010-02-20 11:04:07.209335	You search and find nothing.	t	0	13
1278	2010-02-20 11:04:07.209335	You search and find nothing.	t	0	13
1279	2010-02-20 11:04:07.209335	You search and find nothing.	t	0	13
2563	2010-03-11 09:58:36.826195	You search and find nothing.	t	0	2
2564	2010-03-11 09:58:36.826195	You search and find nothing.	t	0	2
2565	2010-03-11 09:58:36.826195	You search and find nothing.	t	0	2
2566	2010-03-11 09:58:36.826195	You search and find nothing.	t	0	2
2567	2010-03-11 09:58:36.826195	You search and find nothing.	t	0	2
2568	2010-03-11 09:58:37.038546	You search and find nothing.	t	0	2
2569	2010-03-11 09:58:37.038546	You search and find a Vodka.	t	0	2
2570	2010-03-11 09:58:37.038546	You search and find nothing.	t	0	2
2571	2010-03-11 09:58:37.038546	You search and find nothing.	t	0	2
2572	2010-03-11 09:58:37.038546	You search and find nothing.	t	0	2
2573	2010-03-11 09:58:37.268685	You search and find nothing.	t	0	2
2574	2010-03-11 09:58:37.268685	You search and find nothing.	t	0	2
2575	2010-03-11 09:58:37.268685	You search and find nothing.	t	0	2
2576	2010-03-11 09:58:37.268685	You search and find nothing.	t	0	2
2577	2010-03-11 09:58:37.268685	You search and find nothing.	t	0	2
1285	2010-02-20 11:04:07.625493	You search and find a Vodka.	t	0	13
1286	2010-02-20 11:04:07.625493	You search and find nothing.	t	0	13
1287	2010-02-20 11:04:07.625493	You search and find nothing.	t	0	13
1288	2010-02-20 11:04:07.625493	You search and find nothing.	t	0	13
1289	2010-02-20 11:04:07.625493	You search and find nothing.	t	0	13
1290	2010-02-20 21:32:08.589025	You search and find nothing.	t	0	2
1291	2010-02-20 21:32:08.589025	You search and find nothing.	t	0	2
1292	2010-02-20 21:32:08.589025	You search and find nothing.	t	0	2
1293	2010-02-20 21:32:08.589025	You search and find nothing.	t	0	2
1294	2010-02-20 21:32:08.589025	You search and find nothing.	t	0	2
1295	2010-02-20 21:32:11.180237	You search and find nothing.	t	0	2
1296	2010-02-20 21:32:11.180237	You search and find a Energy pistol.	t	0	2
1297	2010-02-20 21:32:11.180237	You search and find nothing.	t	0	2
1298	2010-02-20 21:32:11.180237	You search and find nothing.	t	0	2
1299	2010-02-20 21:32:11.180237	You search and find nothing.	t	0	2
1300	2010-02-20 21:32:12.548212	You search and find nothing.	t	0	2
1301	2010-02-20 21:32:12.548212	You search and find nothing.	t	0	2
1302	2010-02-20 21:32:12.548212	You search and find nothing.	t	0	2
1303	2010-02-20 21:32:12.548212	You search and find nothing.	t	0	2
1304	2010-02-20 21:32:12.548212	You search and find nothing.	t	0	2
1305	2010-02-20 21:32:13.924235	You search and find nothing.	t	0	2
1306	2010-02-20 21:32:13.924235	You search and find nothing.	t	0	2
1307	2010-02-20 21:32:13.924235	You search and find nothing.	t	0	2
1308	2010-02-20 21:32:13.924235	You search and find nothing.	t	0	2
1309	2010-02-20 21:32:13.924235	You search and find nothing.	t	0	2
2578	2010-03-11 09:58:37.785631	You search and find nothing.	t	0	2
2579	2010-03-11 09:58:37.785631	You search and find nothing.	t	0	2
2580	2010-03-11 09:58:37.785631	You search and find nothing.	t	0	2
2581	2010-03-11 09:58:37.785631	You search and find nothing.	t	0	2
2582	2010-03-11 09:58:37.785631	You search and find nothing.	t	0	2
2583	2010-03-11 09:58:38.202606	You search and find nothing.	t	0	2
2584	2010-03-11 09:58:38.202606	You search and find nothing.	t	0	2
2585	2010-03-11 09:58:38.202606	You search and find nothing.	t	0	2
2586	2010-03-11 09:58:38.202606	You search and find nothing.	t	0	2
2587	2010-03-11 09:58:38.202606	You search and find nothing.	t	0	2
2588	2010-03-11 09:58:38.418567	You search and find nothing.	t	0	2
2589	2010-03-11 09:58:38.418567	You search and find nothing.	t	0	2
2590	2010-03-11 09:58:38.418567	You search and find nothing.	t	0	2
2591	2010-03-11 09:58:38.418567	You search and find a Energy rifle.	t	0	2
2592	2010-03-11 09:58:38.418567	You search and find nothing.	t	0	2
2598	2010-03-11 09:58:39.170691	You search and find nothing.	t	0	2
2599	2010-03-11 09:58:39.170691	You search and find nothing.	t	0	2
2600	2010-03-11 09:58:39.170691	You search and find nothing.	t	0	2
2601	2010-03-11 09:58:39.170691	You search and find nothing.	t	0	2
2602	2010-03-11 09:58:39.170691	You search and find a Vodka.	t	0	2
2593	2010-03-11 09:58:38.627238	You search and find nothing.	t	0	2
2594	2010-03-11 09:58:38.627238	You search and find nothing.	t	0	2
2595	2010-03-11 09:58:38.627238	You search and find a Energy rifle.	t	0	2
2596	2010-03-11 09:58:38.627238	You search and find nothing.	t	0	2
1310	2010-02-20 21:32:15.230021	You search and find nothing.	t	0	2
1311	2010-02-20 21:32:15.230021	You search and find a MRE.	t	0	2
1312	2010-02-20 21:32:15.230021	You search and find nothing.	t	0	2
1313	2010-02-20 21:32:15.230021	You search and find a Vodka.	t	0	2
1314	2010-02-20 21:32:15.230021	You search and find nothing.	t	0	2
1315	2010-02-20 21:32:27.71695	You search and find a Energy pistol.	t	0	2
1316	2010-02-20 21:32:27.71695	You search and find nothing.	t	0	2
1317	2010-02-20 21:32:27.71695	You search and find nothing.	t	0	2
1318	2010-02-20 21:32:27.71695	You search and find nothing.	t	0	2
1319	2010-02-20 21:32:27.71695	You search and find nothing.	t	0	2
1320	2010-02-20 21:32:29.43543	You search and find nothing.	t	0	2
1321	2010-02-20 21:32:29.43543	You search and find nothing.	t	0	2
1322	2010-02-20 21:32:29.43543	You search and find nothing.	t	0	2
1323	2010-02-20 21:32:29.43543	You search and find nothing.	t	0	2
1324	2010-02-20 21:32:29.43543	You search and find a Energy pistol.	t	0	2
1325	2010-02-20 21:36:09.954427	You open the null and start drinking.  All too soon, it's gone.	t	0	12
3064	2010-03-11 22:01:26.301538	You search and find nothing.	t	0	2
3065	2010-03-11 22:01:26.301538	You search and find nothing.	t	0	2
3066	2010-03-11 22:01:26.301538	You search and find nothing.	t	0	2
1346	2010-02-20 21:36:16.445236	You search and find nothing.	t	0	12
1347	2010-02-20 21:36:16.445236	You search and find nothing.	t	0	12
1348	2010-02-20 21:36:16.445236	You search and find nothing.	t	0	12
1349	2010-02-20 21:36:16.445236	You search and find a Energy pistol.	t	0	12
1350	2010-02-20 21:36:16.445236	You search and find a Vodka.	t	0	12
1326	2010-02-20 21:36:13.46766	You search and find a Energy rifle .	t	0	12
1327	2010-02-20 21:36:13.46766	You search and find a Energy pack .	t	0	12
1328	2010-02-20 21:36:13.46766	You search and find nothing.	t	0	12
1329	2010-02-20 21:36:13.46766	You search and find nothing.	t	0	12
1330	2010-02-20 21:36:13.46766	You search and find nothing.	t	0	12
1331	2010-02-20 21:36:14.710613	You search and find nothing.	t	0	12
1332	2010-02-20 21:36:14.710613	You search and find a Energy rifle .	t	0	12
1333	2010-02-20 21:36:14.710613	You search and find nothing.	t	0	12
1334	2010-02-20 21:36:14.710613	You search and find nothing.	t	0	12
1335	2010-02-20 21:36:14.710613	You search and find nothing.	t	0	12
2560	2010-03-11 09:58:36.372899	You search and find nothing.	t	0	2
1336	2010-02-20 21:36:15.267886	You search and find nothing.	t	0	12
1337	2010-02-20 21:36:15.267886	You search and find nothing.	t	0	12
1338	2010-02-20 21:36:15.267886	You search and find nothing.	t	0	12
1339	2010-02-20 21:36:15.267886	You search and find nothing.	t	0	12
1340	2010-02-20 21:36:15.267886	You search and find nothing.	t	0	12
2561	2010-03-11 09:58:36.372899	You search and find nothing.	t	0	2
2562	2010-03-11 09:58:36.372899	You search and find nothing.	t	0	2
2597	2010-03-11 09:58:38.627238	You search and find nothing.	t	0	2
2603	2010-03-11 09:58:39.350772	You search and find nothing.	t	0	2
2604	2010-03-11 09:58:39.350772	You search and find a Vodka.	t	0	2
1351	2010-02-20 21:36:16.924693	You search and find nothing.	t	0	12
1352	2010-02-20 21:36:16.924693	You search and find nothing.	t	0	12
1353	2010-02-20 21:36:16.924693	You search and find nothing.	t	0	12
1354	2010-02-20 21:36:16.924693	You search and find nothing.	t	0	12
2605	2010-03-11 09:58:39.350772	You search and find nothing.	t	0	2
2606	2010-03-11 09:58:39.350772	You search and find nothing.	t	0	2
2607	2010-03-11 09:58:39.350772	You search and find nothing.	t	0	2
2608	2010-03-11 09:58:40.495358	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2609	2010-03-11 09:58:40.847365	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2610	2010-03-11 09:58:41.344201	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2611	2010-03-11 09:58:44.871323	You drop your Energy rifle.	t	0	2
3067	2010-03-11 22:01:26.301538	You search and find nothing.	t	0	2
3068	2010-03-11 22:01:26.301538	You search and find nothing.	t	0	2
3069	2010-03-11 22:01:26.909463	You search and find nothing.	t	0	2
3070	2010-03-11 22:01:26.909463	You search and find nothing.	t	0	2
3071	2010-03-11 22:01:26.909463	You search and find nothing.	t	0	2
3072	2010-03-11 22:01:26.909463	You search and find nothing.	t	0	2
3073	2010-03-11 22:01:26.909463	You search and find a Energy pack.	t	0	2
3074	2010-03-11 22:01:27.541587	You search and find a MRE.	t	0	2
3075	2010-03-11 22:01:27.541587	You search and find nothing.	t	0	2
3076	2010-03-11 22:01:27.541587	You search and find a Energy pack.	t	0	2
3077	2010-03-11 22:01:27.541587	You search and find nothing.	t	0	2
3078	2010-03-11 22:01:27.541587	You search and find nothing.	t	0	2
1355	2010-02-20 21:36:16.924693	You search and find a MRE.	t	0	12
1341	2010-02-20 21:36:15.907737	You search and find nothing.	t	0	12
1342	2010-02-20 21:36:15.907737	You search and find nothing.	t	0	12
1343	2010-02-20 21:36:15.907737	You search and find nothing.	t	0	12
1344	2010-02-20 21:36:15.907737	You search and find nothing.	t	0	12
1345	2010-02-20 21:36:15.907737	You search and find nothing.	t	0	12
1356	2010-02-20 21:36:19.530477	You open the null and start drinking.  All too soon, it's gone.	t	0	12
1357	2010-02-20 21:37:02.351686	You search and find nothing.	t	0	12
1358	2010-02-20 21:37:03.037945	You search and find nothing.	t	0	12
1359	2010-02-20 21:37:03.764323	You search and find a Energy pistol.	t	0	12
1360	2010-02-20 21:37:04.916264	You search and find nothing.	t	0	12
1361	2010-02-20 21:37:05.62824	You search and find nothing.	t	0	12
1362	2010-02-20 21:37:06.804427	You search and find a Energy rifle .	t	0	12
1363	2010-02-20 21:37:06.804427	You search and find nothing.	t	0	12
1364	2010-02-20 21:37:06.804427	You search and find nothing.	t	0	12
1365	2010-02-20 21:37:06.804427	You search and find nothing.	t	0	12
1366	2010-02-20 21:37:06.804427	You search and find nothing.	t	0	12
1367	2010-02-20 21:37:07.653302	You search and find a Energy pack .	t	0	12
1368	2010-02-20 21:37:07.653302	You search and find nothing.	t	0	12
1369	2010-02-20 21:37:07.653302	You search and find nothing.	t	0	12
1370	2010-02-20 21:37:07.653302	You search and find a Energy rifle .	t	0	12
1371	2010-02-20 21:37:07.653302	You search and find nothing.	t	0	12
1382	2010-02-20 21:37:10.531816	You search and find nothing.	t	0	12
1383	2010-02-20 21:37:10.531816	You search and find a MRE.	t	0	12
1384	2010-02-20 21:37:10.531816	You search and find nothing.	t	0	12
1385	2010-02-20 21:37:10.531816	You search and find nothing.	t	0	12
1386	2010-02-20 21:37:10.531816	You search and find nothing.	t	0	12
1372	2010-02-20 21:37:08.668312	You search and find nothing.	t	0	12
1373	2010-02-20 21:37:08.668312	You search and find nothing.	t	0	12
1374	2010-02-20 21:37:08.668312	You search and find nothing.	t	0	12
1375	2010-02-20 21:37:08.668312	You search and find nothing.	t	0	12
1376	2010-02-20 21:37:08.668312	You search and find nothing.	t	0	12
1377	2010-02-20 21:37:09.459248	You search and find nothing.	t	0	12
1378	2010-02-20 21:37:09.459248	You search and find a Vodka.	t	0	12
1379	2010-02-20 21:37:09.459248	You search and find a Vodka.	t	0	12
1380	2010-02-20 21:37:09.459248	You search and find nothing.	t	0	12
1381	2010-02-20 21:37:09.459248	You search and find a Energy pack .	t	0	12
1387	2010-02-20 21:37:12.554407	You drop your null.	t	0	12
1388	2010-02-20 21:37:15.50233	You drop your null.	t	0	12
1389	2010-02-20 21:37:16.111095	You drop your null.	t	0	12
1390	2010-02-20 21:37:16.637507	You drop your null.	t	0	12
1391	2010-02-20 21:37:16.96642	You drop your null.	t	0	12
1392	2010-02-20 21:37:17.798957	You drop your null.	t	0	12
1393	2010-02-20 21:37:48.188236	You open the null and start drinking.  All too soon, it's gone.	t	0	12
1399	2010-02-20 21:40:55.390813	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
1398	2010-02-20 21:40:53.564292	You search and find a Vodka.	t	0	9
1397	2010-02-20 21:40:53.564292	You search and find nothing.	t	0	9
1396	2010-02-20 21:40:53.564292	You search and find nothing.	t	0	9
1395	2010-02-20 21:40:53.564292	You search and find nothing.	t	0	9
1394	2010-02-20 21:40:53.564292	You search and find nothing.	t	0	9
1400	2010-02-20 21:41:03.617389	You drop your null.	t	0	9
1401	2010-02-20 21:41:04.986403	You drop your null.	t	0	9
1402	2010-02-20 21:41:06.002677	You drop your null.	t	0	9
1403	2010-02-20 21:41:06.698271	You drop your null.	t	0	9
1404	2010-02-20 21:41:07.490271	You drop your null.	t	0	9
1405	2010-02-20 21:41:08.326346	You drop your null.	t	0	9
1406	2010-02-20 21:41:43.514414	You drop your null.	t	0	9
1407	2010-02-20 21:41:43.930334	You drop your null.	t	0	9
1408	2010-02-20 21:41:44.164556	You drop your null.	t	0	9
2612	2010-03-11 10:01:16.691386	You drop your Energy rifle.	t	0	2
2613	2010-03-11 10:03:11.276	You search and find nothing.	t	0	2
2614	2010-03-11 10:03:13.154933	You search and find nothing.	t	0	2
2615	2010-03-11 10:03:13.795875	You search and find nothing.	t	0	2
2616	2010-03-11 10:03:14.33175	You search and find nothing.	t	0	2
2617	2010-03-11 10:03:14.33175	You search and find nothing.	t	0	2
2618	2010-03-11 10:03:14.33175	You search and find a Energy rifle.	t	0	2
1419	2010-02-20 21:46:10.8678	You search and find nothing.	t	0	9
1418	2010-02-20 21:46:10.43696	You search and find nothing.	t	0	9
1417	2010-02-20 21:46:10.43696	You search and find nothing.	t	0	9
1416	2010-02-20 21:46:10.43696	You search and find nothing.	t	0	9
1415	2010-02-20 21:46:10.43696	You search and find nothing.	t	0	9
1414	2010-02-20 21:46:10.43696	You search and find nothing.	t	0	9
1413	2010-02-20 21:46:10.092054	You search and find a MRE.	t	0	9
1412	2010-02-20 21:46:10.092054	You search and find nothing.	t	0	9
1411	2010-02-20 21:46:10.092054	You search and find nothing.	t	0	9
1410	2010-02-20 21:46:10.092054	You search and find a Vodka.	t	0	9
1409	2010-02-20 21:46:10.092054	You search and find nothing.	t	0	9
2619	2010-03-11 10:03:14.33175	You search and find nothing.	t	0	2
2620	2010-03-11 10:03:14.33175	You search and find nothing.	t	0	2
2621	2010-03-11 10:03:15.680312	You drop your Energy rifle.	t	0	2
2622	2010-03-11 10:03:58.300361	You search and find nothing.	t	0	2
2623	2010-03-11 10:04:00.021503	You search and find nothing.	t	0	2
2624	2010-03-11 10:04:00.586606	You search and find nothing.	t	0	2
2626	2010-03-11 10:04:01.25004	You search and find nothing.	t	0	2
2625	2010-03-11 10:04:00.995208	You search and find nothing.	t	0	2
2627	2010-03-11 10:04:01.738762	You search and find nothing.	t	0	2
2628	2010-03-11 10:04:01.738762	You search and find nothing.	t	0	2
2629	2010-03-11 10:04:01.738762	You search and find nothing.	t	0	2
3229	2010-03-11 22:36:31.847706	You search and find a Vodka.	t	0	13
3224	2010-03-11 22:36:31.639972	You search and find nothing.	t	0	13
3225	2010-03-11 22:36:31.639972	You search and find nothing.	t	0	13
3226	2010-03-11 22:36:31.639972	You search and find nothing.	t	0	13
3227	2010-03-11 22:36:31.639972	You search and find nothing.	t	0	13
3228	2010-03-11 22:36:31.639972	You search and find nothing.	t	0	13
3230	2010-03-11 22:36:31.847706	You search and find nothing.	t	0	13
3231	2010-03-11 22:36:31.847706	You search and find nothing.	t	0	13
3232	2010-03-11 22:36:31.847706	You search and find a Vodka.	t	0	13
3233	2010-03-11 22:36:31.847706	You search and find nothing.	t	0	13
2662	2010-03-11 10:05:57.275306	You drop your Energy pistol.	t	0	2
2656	2010-03-11 10:05:53.948674	You search and find nothing.	t	0	2
2657	2010-03-11 10:05:55.826986	You search and find nothing.	t	0	2
1433	2010-02-20 21:46:11.246099	You search and find nothing.	t	0	9
1432	2010-02-20 21:46:11.246099	You search and find nothing.	t	0	9
1431	2010-02-20 21:46:11.246099	You search and find nothing.	t	0	9
1430	2010-02-20 21:46:11.246099	You search and find nothing.	t	0	9
1429	2010-02-20 21:46:11.246099	You search and find nothing.	t	0	9
1428	2010-02-20 21:46:11.06073	You search and find nothing.	t	0	9
1427	2010-02-20 21:46:11.06073	You search and find a Energy pistol.	t	0	9
1426	2010-02-20 21:46:11.06073	You search and find nothing.	t	0	9
1425	2010-02-20 21:46:11.06073	You search and find nothing.	t	0	9
1424	2010-02-20 21:46:11.06073	You search and find nothing.	t	0	9
1423	2010-02-20 21:46:10.8678	You search and find nothing.	t	0	9
1422	2010-02-20 21:46:10.8678	You search and find nothing.	t	0	9
1421	2010-02-20 21:46:10.8678	You search and find nothing.	t	0	9
1420	2010-02-20 21:46:10.8678	You search and find nothing.	t	0	9
1434	2010-02-20 21:46:45.711563	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
2653	2010-03-11 10:04:55.475406	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2643	2010-03-11 10:04:52.732764	You search and find nothing.	t	0	2
2644	2010-03-11 10:04:52.732764	You search and find nothing.	t	0	2
1449	2010-02-20 21:47:42.907758	You search and find nothing.	t	0	9
1448	2010-02-20 21:47:42.907758	You search and find nothing.	t	0	9
1447	2010-02-20 21:47:42.907758	You search and find nothing.	t	0	9
1446	2010-02-20 21:47:42.907758	You search and find nothing.	t	0	9
1445	2010-02-20 21:47:42.907758	You search and find nothing.	t	0	9
1444	2010-02-20 21:47:42.710152	You search and find nothing.	t	0	9
1443	2010-02-20 21:47:42.710152	You search and find nothing.	t	0	9
1442	2010-02-20 21:47:42.710152	You search and find nothing.	t	0	9
1441	2010-02-20 21:47:42.710152	You search and find nothing.	t	0	9
1440	2010-02-20 21:47:42.710152	You search and find nothing.	t	0	9
1439	2010-02-20 21:47:42.634008	You search and find nothing.	t	0	9
1438	2010-02-20 21:47:42.634008	You search and find nothing.	t	0	9
1437	2010-02-20 21:47:42.634008	You search and find nothing.	t	0	9
1436	2010-02-20 21:47:42.634008	You search and find nothing.	t	0	9
1435	2010-02-20 21:47:42.634008	You search and find nothing.	t	0	9
2645	2010-03-11 10:04:52.732764	You search and find nothing.	t	0	2
2630	2010-03-11 10:04:01.738762	You search and find nothing.	t	0	2
2631	2010-03-11 10:04:01.738762	You search and find nothing.	t	0	2
2632	2010-03-11 10:04:02.371182	You search and find nothing.	t	0	2
2633	2010-03-11 10:04:02.371182	You search and find nothing.	t	0	2
2634	2010-03-11 10:04:02.371182	You search and find nothing.	t	0	2
2635	2010-03-11 10:04:02.371182	You search and find nothing.	t	0	2
2636	2010-03-11 10:04:02.371182	You search and find nothing.	t	0	2
2637	2010-03-11 10:04:02.891798	You search and find a Energy rifle.	t	0	2
2638	2010-03-11 10:04:02.891798	You search and find nothing.	t	0	2
2639	2010-03-11 10:04:02.891798	You search and find nothing.	t	0	2
2640	2010-03-11 10:04:02.891798	You search and find nothing.	t	0	2
2641	2010-03-11 10:04:02.891798	You search and find nothing.	t	0	2
2642	2010-03-11 10:04:04.835631	You drop your Energy rifle.	t	0	2
2646	2010-03-11 10:04:52.732764	You search and find nothing.	t	0	2
2647	2010-03-11 10:04:52.732764	You search and find nothing.	t	0	2
2648	2010-03-11 10:04:53.818911	You search and find nothing.	t	0	2
2649	2010-03-11 10:04:53.818911	You search and find nothing.	t	0	2
2650	2010-03-11 10:04:53.818911	You search and find a MRE.	t	0	2
2651	2010-03-11 10:04:53.818911	You search and find a Energy pistol.	t	0	2
2652	2010-03-11 10:04:53.818911	You search and find a Vodka.	t	0	2
2654	2010-03-11 10:04:56.303366	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2655	2010-03-11 10:05:30.667321	You drop your Energy pistol.	t	0	2
2658	2010-03-11 10:05:55.826986	You search and find a Energy rifle.	t	0	2
2659	2010-03-11 10:05:55.826986	You search and find nothing.	t	0	2
2660	2010-03-11 10:05:55.826986	You search and find a Energy pistol.	t	0	2
2661	2010-03-11 10:05:55.826986	You search and find nothing.	t	0	2
2663	2010-03-11 10:05:57.591216	You drop your Energy rifle.	t	0	2
3062	2010-03-11 22:01:25.583373	You search and find nothing.	t	0	2
3063	2010-03-11 22:01:25.583373	You search and find nothing.	t	0	2
3079	2010-03-11 22:12:40.824144	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
3083	2010-03-11 22:12:45.30243	You have unequipped your Energy pistol.	t	0	2
3084	2010-03-11 22:12:46.613794	You drop your Energy pistol.	t	0	2
3085	2010-03-11 22:12:46.970345	You drop your Energy rifle.	t	0	2
2664	2010-03-11 10:09:06.729806	You search and find nothing.	t	0	2
2665	2010-03-11 10:09:06.729806	You search and find a Energy rifle.	t	0	2
2666	2010-03-11 10:09:06.729806	You search and find nothing.	t	0	2
2667	2010-03-11 10:09:06.729806	You search and find nothing.	t	0	2
2668	2010-03-11 10:09:06.729806	You search and find nothing.	t	0	2
2669	2010-03-11 10:09:08.188085	You drop your Energy rifle.	t	0	2
1459	2010-02-20 21:47:43.321495	You search and find nothing.	t	0	9
1458	2010-02-20 21:47:43.321495	You search and find a Energy pack .	t	0	9
1457	2010-02-20 21:47:43.321495	You search and find nothing.	t	0	9
1456	2010-02-20 21:47:43.321495	You search and find nothing.	t	0	9
1455	2010-02-20 21:47:43.321495	You search and find a Energy pistol.	t	0	9
1454	2010-02-20 21:47:43.102091	You search and find nothing.	t	0	9
1453	2010-02-20 21:47:43.102091	You search and find nothing.	t	0	9
1452	2010-02-20 21:47:43.102091	You search and find nothing.	t	0	9
1451	2010-02-20 21:47:43.102091	You search and find a MRE.	t	0	9
1450	2010-02-20 21:47:43.102091	You search and find nothing.	t	0	9
1479	2010-02-20 21:47:47.635879	You search and find nothing.	t	0	9
1478	2010-02-20 21:47:47.635879	You search and find nothing.	t	0	9
1477	2010-02-20 21:47:47.635879	You search and find a Energy rifle .	t	0	9
1476	2010-02-20 21:47:47.635879	You search and find nothing.	t	0	9
1475	2010-02-20 21:47:47.635879	You search and find nothing.	t	0	9
1474	2010-02-20 21:47:47.417545	You search and find nothing.	t	0	9
1473	2010-02-20 21:47:47.417545	You search and find nothing.	t	0	9
1472	2010-02-20 21:47:47.417545	You search and find nothing.	t	0	9
1471	2010-02-20 21:47:47.417545	You search and find nothing.	t	0	9
1470	2010-02-20 21:47:47.417545	You search and find nothing.	t	0	9
1469	2010-02-20 21:47:47.205209	You search and find nothing.	t	0	9
1468	2010-02-20 21:47:47.205209	You search and find nothing.	t	0	9
1467	2010-02-20 21:47:47.205209	You search and find nothing.	t	0	9
1466	2010-02-20 21:47:47.205209	You search and find nothing.	t	0	9
1465	2010-02-20 21:47:47.205209	You search and find nothing.	t	0	9
1464	2010-02-20 21:47:46.990496	You search and find nothing.	t	0	9
1463	2010-02-20 21:47:46.990496	You search and find a Vodka.	t	0	9
1462	2010-02-20 21:47:46.990496	You search and find nothing.	t	0	9
1461	2010-02-20 21:47:46.990496	You search and find a Energy pack .	t	0	9
1460	2010-02-20 21:47:46.990496	You search and find nothing.	t	0	9
3086	2010-03-11 22:12:47.388501	You drop your Energy rifle.	t	0	2
3087	2010-03-11 22:12:48.059254	You drop your Energy pack.	t	0	2
2691	2010-03-11 10:09:14.376425	You drop your Energy pack.	t	0	2
2681	2010-03-11 10:09:12.953252	You search and find nothing.	t	0	2
2682	2010-03-11 10:09:12.953252	You search and find nothing.	t	0	2
2683	2010-03-11 10:09:12.953252	You search and find nothing.	t	0	2
2684	2010-03-11 10:09:12.953252	You search and find nothing.	t	0	2
2685	2010-03-11 10:09:12.953252	You search and find nothing.	t	0	2
2686	2010-03-11 10:09:13.203466	You search and find a Energy pack.	t	0	2
2687	2010-03-11 10:09:13.203466	You search and find nothing.	t	0	2
2688	2010-03-11 10:09:13.203466	You search and find nothing.	t	0	2
2670	2010-03-11 10:09:09.684586	You search and find nothing.	t	0	2
2671	2010-03-11 10:09:09.684586	You search and find nothing.	t	0	2
2672	2010-03-11 10:09:09.684586	You search and find nothing.	t	0	2
2673	2010-03-11 10:09:09.684586	You search and find nothing.	t	0	2
2674	2010-03-11 10:09:09.684586	You search and find nothing.	t	0	2
2675	2010-03-11 10:09:10.059991	You search and find nothing.	t	0	2
2676	2010-03-11 10:09:10.059991	You search and find a Energy pack.	t	0	2
2677	2010-03-11 10:09:10.059991	You search and find nothing.	t	0	2
2678	2010-03-11 10:09:10.059991	You search and find nothing.	t	0	2
2679	2010-03-11 10:09:10.059991	You search and find nothing.	t	0	2
2680	2010-03-11 10:09:11.224384	You drop your Energy pack.	t	0	2
2689	2010-03-11 10:09:13.203466	You search and find a Energy pistol.	t	0	2
2690	2010-03-11 10:09:13.203466	You search and find nothing.	t	0	2
2692	2010-03-11 10:09:15.143472	You drop your Energy pistol.	t	0	2
3080	2010-03-11 22:12:40.835785	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
3081	2010-03-11 22:12:43.750792	You drop your Energy pack.	t	0	2
3082	2010-03-11 22:12:44.178445	You drop your Energy pack.	t	0	2
3088	2010-03-11 22:18:50.486228	You search and find nothing.	t	0	2
3089	2010-03-11 22:18:50.486228	You search and find nothing.	t	0	2
3090	2010-03-11 22:18:50.486228	You search and find nothing.	t	0	2
3091	2010-03-11 22:18:50.486228	You search and find a Energy rifle.	t	0	2
3092	2010-03-11 22:18:50.486228	You search and find a MRE.	t	0	2
3093	2010-03-11 22:18:50.90971	You search and find nothing.	t	0	2
3094	2010-03-11 22:18:50.90971	You search and find nothing.	t	0	2
3095	2010-03-11 22:18:50.90971	You search and find nothing.	t	0	2
3096	2010-03-11 22:18:50.90971	You search and find a MRE.	t	0	2
3097	2010-03-11 22:18:50.90971	You search and find nothing.	t	0	2
1490	2010-02-21 23:10:10.276127	You search and find nothing.	t	0	12
1491	2010-02-21 23:10:10.276127	You search and find nothing.	t	0	12
1492	2010-02-21 23:10:10.276127	You search and find nothing.	t	0	12
1493	2010-02-21 23:10:10.276127	You search and find nothing.	t	0	12
1494	2010-02-21 23:10:10.276127	You search and find nothing.	t	0	12
1485	2010-02-20 21:47:49.011294	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
1484	2010-02-20 21:47:47.862071	You search and find nothing.	t	0	9
1483	2010-02-20 21:47:47.862071	You search and find nothing.	t	0	9
1482	2010-02-20 21:47:47.862071	You search and find nothing.	t	0	9
1481	2010-02-20 21:47:47.862071	You search and find nothing.	t	0	9
1480	2010-02-20 21:47:47.862071	You search and find nothing.	t	0	9
1486	2010-02-21 23:06:01.510839	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1487	2010-02-21 23:08:04.955096	You drop your null.	t	0	12
1488	2010-02-21 23:08:05.572318	You drop your null.	t	0	12
1489	2010-02-21 23:08:06.058691	You drop your null.	t	0	12
1495	2010-02-21 23:10:10.503218	You search and find nothing.	t	0	12
1496	2010-02-21 23:10:10.503218	You search and find nothing.	t	0	12
1497	2010-02-21 23:10:10.503218	You search and find nothing.	t	0	12
1498	2010-02-21 23:10:10.503218	You search and find nothing.	t	0	12
1499	2010-02-21 23:10:10.503218	You search and find nothing.	t	0	12
1500	2010-02-21 23:10:10.735206	You search and find nothing.	t	0	12
1501	2010-02-21 23:10:10.735206	You search and find nothing.	t	0	12
1502	2010-02-21 23:10:10.735206	You search and find nothing.	t	0	12
1503	2010-02-21 23:10:10.735206	You search and find nothing.	t	0	12
1504	2010-02-21 23:10:10.735206	You search and find nothing.	t	0	12
1505	2010-02-21 23:10:10.975151	You search and find nothing.	t	0	12
1506	2010-02-21 23:10:10.975151	You search and find nothing.	t	0	12
1507	2010-02-21 23:10:10.975151	You search and find nothing.	t	0	12
1508	2010-02-21 23:10:10.975151	You search and find nothing.	t	0	12
1509	2010-02-21 23:10:10.975151	You search and find nothing.	t	0	12
2693	2010-03-11 10:16:09.374267	You search and find nothing.	t	0	13
2694	2010-03-11 10:16:09.374267	You search and find nothing.	t	0	13
2695	2010-03-11 10:16:09.374267	You search and find nothing.	t	0	13
2696	2010-03-11 10:16:09.374267	You search and find nothing.	t	0	13
2697	2010-03-11 10:16:09.374267	You search and find nothing.	t	0	13
2698	2010-03-11 10:16:13.044763	You search and find nothing.	t	0	13
2699	2010-03-11 10:16:13.044763	You search and find nothing.	t	0	13
2700	2010-03-11 10:16:13.044763	You search and find nothing.	t	0	13
2701	2010-03-11 10:16:13.044763	You search and find nothing.	t	0	13
2702	2010-03-11 10:16:13.044763	You search and find nothing.	t	0	13
2703	2010-03-11 10:16:13.59119	You search and find nothing.	t	0	13
2704	2010-03-11 10:16:13.59119	You search and find nothing.	t	0	13
2705	2010-03-11 10:16:13.59119	You search and find nothing.	t	0	13
2706	2010-03-11 10:16:13.59119	You search and find nothing.	t	0	13
2707	2010-03-11 10:16:13.59119	You search and find nothing.	t	0	13
2708	2010-03-11 10:16:14.007671	You search and find nothing.	t	0	13
2709	2010-03-11 10:16:14.007671	You search and find nothing.	t	0	13
2710	2010-03-11 10:16:14.007671	You search and find a Vodka.	t	0	13
2711	2010-03-11 10:16:14.007671	You search and find nothing.	t	0	13
2712	2010-03-11 10:16:14.007671	You search and find a Vodka.	t	0	13
2721	2010-03-11 11:35:51.284489	You search and find nothing.	t	0	12
2713	2010-03-11 10:16:15.147778	You search and find nothing.	t	0	13
2714	2010-03-11 10:16:16.940183	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2715	2010-03-11 10:16:17.104027	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2716	2010-03-11 10:18:54.715783	You search and find nothing.	f	0	1
2717	2010-03-11 10:18:54.715783	You search and find nothing.	f	0	1
2718	2010-03-11 10:18:54.715783	You search and find a Energy rifle.	f	0	1
2719	2010-03-11 10:18:54.715783	You search and find nothing.	f	0	1
2720	2010-03-11 10:18:54.715783	You search and find nothing.	f	0	1
2722	2010-03-11 11:35:51.284489	You search and find a Vodka.	t	0	12
2723	2010-03-11 11:35:51.284489	You search and find nothing.	t	0	12
2724	2010-03-11 11:35:51.284489	You search and find nothing.	t	0	12
2725	2010-03-11 11:35:51.284489	You search and find a MRE.	t	0	12
2726	2010-03-11 11:35:52.843876	You search and find nothing.	t	0	12
2727	2010-03-11 11:35:52.843876	You search and find nothing.	t	0	12
2728	2010-03-11 11:35:52.843876	You search and find nothing.	t	0	12
2729	2010-03-11 11:35:52.843876	You search and find a Energy rifle.	t	0	12
2730	2010-03-11 11:35:52.843876	You search and find nothing.	t	0	12
2741	2010-03-11 11:35:54.214175	You search and find nothing.	t	0	12
2731	2010-03-11 11:35:53.668788	You search and find nothing.	t	0	12
2732	2010-03-11 11:35:53.668788	You search and find nothing.	t	0	12
2733	2010-03-11 11:35:53.668788	You search and find a Energy pack.	t	0	12
2734	2010-03-11 11:35:53.668788	You search and find a Vodka.	t	0	12
2735	2010-03-11 11:35:53.668788	You search and find nothing.	t	0	12
2742	2010-03-11 11:35:54.214175	You search and find nothing.	t	0	12
2743	2010-03-11 11:35:54.214175	You search and find a Vodka.	t	0	12
2744	2010-03-11 11:35:54.214175	You search and find nothing.	t	0	12
2745	2010-03-11 11:35:54.214175	You search and find nothing.	t	0	12
2736	2010-03-11 11:35:54.073367	You search and find nothing.	t	0	12
2737	2010-03-11 11:35:54.073367	You search and find nothing.	t	0	12
2738	2010-03-11 11:35:54.073367	You search and find nothing.	t	0	12
2739	2010-03-11 11:35:54.073367	You search and find nothing.	t	0	12
2740	2010-03-11 11:35:54.073367	You search and find nothing.	t	0	12
1510	2010-02-21 23:10:11.190846	You search and find nothing.	t	0	12
1511	2010-02-21 23:10:11.190846	You search and find nothing.	t	0	12
1512	2010-02-21 23:10:11.190846	You search and find nothing.	t	0	12
1513	2010-02-21 23:10:11.190846	You search and find nothing.	t	0	12
1514	2010-02-21 23:10:11.190846	You search and find nothing.	t	0	12
1515	2010-02-21 23:10:11.70659	You search and find a Vodka.	t	0	12
1516	2010-02-21 23:10:11.70659	You search and find nothing.	t	0	12
1517	2010-02-21 23:10:11.70659	You search and find nothing.	t	0	12
1518	2010-02-21 23:10:11.70659	You search and find a Vodka.	t	0	12
1519	2010-02-21 23:10:11.70659	You search and find nothing.	t	0	12
1520	2010-02-21 23:10:12.418127	You search and find nothing.	t	0	12
1521	2010-02-21 23:10:12.418127	You search and find nothing.	t	0	12
1522	2010-02-21 23:10:12.418127	You search and find nothing.	t	0	12
1523	2010-02-21 23:10:12.418127	You search and find nothing.	t	0	12
1524	2010-02-21 23:10:12.418127	You search and find nothing.	t	0	12
1525	2010-02-21 23:10:12.950772	You search and find nothing.	t	0	12
1526	2010-02-21 23:10:12.950772	You search and find nothing.	t	0	12
1527	2010-02-21 23:10:12.950772	You search and find nothing.	t	0	12
1528	2010-02-21 23:10:12.950772	You search and find a Vodka.	t	0	12
1529	2010-02-21 23:10:12.950772	You search and find a Vodka.	t	0	12
1530	2010-02-21 23:10:13.511343	You search and find nothing.	t	0	12
1531	2010-02-21 23:10:13.511343	You search and find nothing.	t	0	12
1532	2010-02-21 23:10:13.511343	You search and find nothing.	t	0	12
1533	2010-02-21 23:10:13.511343	You search and find nothing.	t	0	12
1534	2010-02-21 23:10:13.511343	You search and find nothing.	t	0	12
1535	2010-02-21 23:10:14.111553	You search and find a Energy pistol.	t	0	12
1536	2010-02-21 23:10:14.111553	You search and find a Energy pack .	t	0	12
1537	2010-02-21 23:10:14.111553	You search and find nothing.	t	0	12
1538	2010-02-21 23:10:14.111553	You search and find a Energy pack .	t	0	12
1539	2010-02-21 23:10:14.111553	You search and find nothing.	t	0	12
1540	2010-02-21 23:10:14.695436	You search and find nothing.	t	0	12
1541	2010-02-21 23:10:14.695436	You search and find nothing.	t	0	12
1542	2010-02-21 23:10:14.695436	You search and find a Vodka.	t	0	12
1543	2010-02-21 23:10:14.695436	You search and find nothing.	t	0	12
1544	2010-02-21 23:10:14.695436	You search and find nothing.	t	0	12
1545	2010-02-21 23:10:15.41506	You search and find a Vodka.	t	0	12
1546	2010-02-21 23:10:15.41506	You search and find nothing.	t	0	12
1547	2010-02-21 23:10:15.41506	You search and find a Energy rifle .	t	0	12
1548	2010-02-21 23:10:15.41506	You search and find nothing.	t	0	12
1549	2010-02-21 23:10:15.41506	You search and find nothing.	t	0	12
1550	2010-02-21 23:10:16.006932	You search and find nothing.	t	0	12
1551	2010-02-21 23:10:16.006932	You search and find a Energy pack .	t	0	12
1552	2010-02-21 23:10:16.006932	You search and find nothing.	t	0	12
1553	2010-02-21 23:10:16.006932	You search and find nothing.	t	0	12
1554	2010-02-21 23:10:16.006932	You search and find a Energy pack .	t	0	12
1555	2010-02-21 23:10:16.566861	You search and find nothing.	t	0	12
1556	2010-02-21 23:10:16.566861	You search and find a Vodka.	t	0	12
1557	2010-02-21 23:10:16.566861	You search and find a Energy rifle .	t	0	12
1558	2010-02-21 23:10:16.566861	You search and find nothing.	t	0	12
1559	2010-02-21 23:10:16.566861	You search and find nothing.	t	0	12
2746	2010-03-11 11:36:16.308356	You search and find nothing.	t	0	2
2747	2010-03-11 11:36:16.308356	You search and find nothing.	t	0	2
2748	2010-03-11 11:36:16.308356	You search and find nothing.	t	0	2
2749	2010-03-11 11:36:16.308356	You search and find nothing.	t	0	2
2750	2010-03-11 11:36:16.308356	You search and find a Energy pack.	t	0	2
2751	2010-03-11 11:36:16.771135	You search and find nothing.	t	0	2
2752	2010-03-11 11:36:16.771135	You search and find nothing.	t	0	2
2753	2010-03-11 11:36:16.771135	You search and find nothing.	t	0	2
2754	2010-03-11 11:36:16.771135	You search and find nothing.	t	0	2
2755	2010-03-11 11:36:16.771135	You search and find nothing.	t	0	2
2756	2010-03-11 11:36:18.674747	You search and find nothing.	t	0	2
2757	2010-03-11 11:36:18.674747	You search and find nothing.	t	0	2
2758	2010-03-11 11:36:18.674747	You search and find nothing.	t	0	2
2759	2010-03-11 11:36:18.674747	You search and find nothing.	t	0	2
1560	2010-02-21 23:10:17.183862	You search and find nothing.	t	0	12
1561	2010-02-21 23:10:17.183862	You search and find nothing.	t	0	12
1562	2010-02-21 23:10:17.183862	You search and find nothing.	t	0	12
1563	2010-02-21 23:10:17.183862	You search and find nothing.	t	0	12
1564	2010-02-21 23:10:17.183862	You search and find nothing.	t	0	12
1565	2010-02-21 23:10:17.833586	You search and find nothing.	t	0	12
1566	2010-02-21 23:10:17.833586	You search and find a Energy pistol.	t	0	12
1567	2010-02-21 23:10:17.833586	You search and find nothing.	t	0	12
1568	2010-02-21 23:10:17.833586	You search and find nothing.	t	0	12
1569	2010-02-21 23:10:17.833586	You search and find a Energy pistol.	t	0	12
1570	2010-02-21 23:10:18.446763	You search and find nothing.	t	0	12
1571	2010-02-21 23:10:18.446763	You search and find nothing.	t	0	12
1572	2010-02-21 23:10:18.446763	You search and find nothing.	t	0	12
1573	2010-02-21 23:10:18.446763	You search and find nothing.	t	0	12
1574	2010-02-21 23:10:18.446763	You search and find nothing.	t	0	12
1575	2010-02-21 23:10:19.143367	You search and find nothing.	t	0	12
1576	2010-02-21 23:10:19.143367	You search and find nothing.	t	0	12
1577	2010-02-21 23:10:19.143367	You search and find a Energy pistol.	t	0	12
1578	2010-02-21 23:10:19.143367	You search and find a Energy pistol.	t	0	12
1579	2010-02-21 23:10:19.143367	You search and find a Energy rifle .	t	0	12
1580	2010-02-21 23:10:19.791412	You search and find a MRE.	t	0	12
1581	2010-02-21 23:10:19.791412	You search and find nothing.	t	0	12
1582	2010-02-21 23:10:19.791412	You search and find nothing.	t	0	12
1583	2010-02-21 23:10:19.791412	You search and find a MRE.	t	0	12
1584	2010-02-21 23:10:19.791412	You search and find a Energy pistol.	t	0	12
2766	2010-03-11 11:36:20.277909	You search and find nothing.	t	0	2
2767	2010-03-11 11:36:20.277909	You search and find nothing.	t	0	2
2768	2010-03-11 11:36:20.277909	You search and find nothing.	t	0	2
2769	2010-03-11 11:36:20.277909	You search and find nothing.	t	0	2
2770	2010-03-11 11:36:20.277909	You search and find nothing.	t	0	2
2771	2010-03-11 11:36:21.020375	You search and find nothing.	t	0	2
2772	2010-03-11 11:36:21.020375	You search and find nothing.	t	0	2
2773	2010-03-11 11:36:21.020375	You search and find nothing.	t	0	2
2774	2010-03-11 11:36:21.020375	You search and find nothing.	t	0	2
2775	2010-03-11 11:36:21.020375	You search and find nothing.	t	0	2
2776	2010-03-11 11:36:21.726162	You search and find nothing.	t	0	2
2777	2010-03-11 11:36:21.726162	You search and find nothing.	t	0	2
2778	2010-03-11 11:36:21.726162	You search and find nothing.	t	0	2
2779	2010-03-11 11:36:21.726162	You search and find nothing.	t	0	2
2780	2010-03-11 11:36:21.726162	You search and find nothing.	t	0	2
2781	2010-03-11 11:36:22.394766	You search and find nothing.	t	0	2
2782	2010-03-11 11:36:22.394766	You search and find nothing.	t	0	2
2783	2010-03-11 11:36:22.394766	You search and find nothing.	t	0	2
2784	2010-03-11 11:36:22.394766	You search and find nothing.	t	0	2
2785	2010-03-11 11:36:22.394766	You search and find a Energy pack.	t	0	2
1743	2010-03-08 17:25:30.968962	You switch your equipped weapon. You will now use yournull.	t	0	12
1744	2010-03-08 17:27:39.978774	You switch your equipped weapon. You will now use yournull.	t	0	12
1745	2010-03-09 22:46:28.978442	You switch your equipped weapon. You will now use yournull.	t	0	2
1746	2010-03-09 22:46:53.198594	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
1747	2010-03-09 22:46:54.183132	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
1748	2010-03-09 22:51:08.52184	You switch your equipped weapon. You will now use your null.	t	0	2
1749	2010-03-09 22:59:53.125864	You switch your equipped weapon. You will now use your null.	t	0	2
1750	2010-03-09 22:59:55.435528	You switch your equipped weapon. You will now use your null.	t	0	2
1751	2010-03-09 22:59:57.310651	You switch your equipped weapon. You will now use your null.	t	0	2
1585	2010-02-21 23:10:20.511388	You search and find a MRE.	t	0	12
1586	2010-02-21 23:10:20.511388	You search and find nothing.	t	0	12
1587	2010-02-21 23:10:20.511388	You search and find nothing.	t	0	12
1588	2010-02-21 23:10:20.511388	You search and find nothing.	t	0	12
1589	2010-02-21 23:10:20.511388	You search and find nothing.	t	0	12
1590	2010-02-21 23:10:22.060897	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1591	2010-02-21 23:10:23.025783	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1592	2010-02-21 23:10:23.405535	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1593	2010-02-21 23:10:24.264744	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1594	2010-02-21 23:10:24.553589	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1595	2010-02-21 23:10:25.18955	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1596	2010-02-21 23:10:26.857505	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1752	2010-03-09 23:01:00.227746	You switch your equipped weapon. You will now use your null.	t	0	2
1753	2010-03-09 23:01:01.834428	You switch your equipped weapon. You will now use your null.	t	0	2
1754	2010-03-09 23:01:03.646712	You switch your equipped weapon. You will now use your null.	t	0	2
1755	2010-03-09 23:01:24.517693	You switch your equipped weapon. You will now use your null.	t	0	2
1756	2010-03-09 23:01:25.554715	You switch your equipped weapon. You will now use your null.	t	0	2
1757	2010-03-09 23:02:24.791483	You switch your equipped weapon. You will now use your null.	t	0	2
1758	2010-03-09 23:02:25.559731	You switch your equipped weapon. You will now use your null.	t	0	2
1759	2010-03-09 23:02:26.632671	You switch your equipped weapon. You will now use your null.	t	0	2
1760	2010-03-09 23:02:27.608346	You switch your equipped weapon. You will now use your null.	t	0	2
1761	2010-03-09 23:02:28.990682	You switch your equipped weapon. You will now use your null.	t	0	2
1762	2010-03-09 23:03:52.542728	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
1763	2010-03-09 23:03:55.298844	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
1764	2010-03-09 23:04:35.175306	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
1765	2010-03-09 23:04:36.005628	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
1766	2010-03-09 23:05:48.143927	You switch your equipped weapon. You will now use your Energy pistol.	t	0	12
1767	2010-03-09 23:05:49.462927	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
1768	2010-03-09 23:05:50.496232	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
1769	2010-03-09 23:05:51.650878	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
2786	2010-03-11 11:36:23.116242	You search and find a Vodka.	t	0	2
2787	2010-03-11 11:36:23.116242	You search and find nothing.	t	0	2
2788	2010-03-11 11:36:23.116242	You search and find nothing.	t	0	2
2789	2010-03-11 11:36:23.116242	You search and find nothing.	t	0	2
2790	2010-03-11 11:36:23.116242	You search and find nothing.	t	0	2
1770	2010-03-09 23:05:59.160189	You search and find nothing.	t	0	12
1771	2010-03-09 23:05:59.160189	You search and find a Vodka.	t	0	12
1772	2010-03-09 23:05:59.160189	You search and find nothing.	t	0	12
1773	2010-03-09 23:05:59.160189	You search and find a Energy pack.	t	0	12
1774	2010-03-09 23:05:59.160189	You search and find nothing.	t	0	12
1775	2010-03-09 23:05:59.991619	You search and find nothing.	t	0	12
1776	2010-03-09 23:05:59.991619	You search and find nothing.	t	0	12
1777	2010-03-09 23:05:59.991619	You search and find nothing.	t	0	12
1778	2010-03-09 23:05:59.991619	You search and find nothing.	t	0	12
1779	2010-03-09 23:05:59.991619	You search and find nothing.	t	0	12
1780	2010-03-09 23:06:02.567226	You search and find nothing.	t	0	12
1781	2010-03-09 23:06:02.567226	You search and find nothing.	t	0	12
1782	2010-03-09 23:06:02.567226	You search and find nothing.	t	0	12
1783	2010-03-09 23:06:02.567226	You search and find nothing.	t	0	12
1784	2010-03-09 23:06:02.567226	You search and find a Energy pack.	t	0	12
3384	2010-03-11 22:37:13.183035	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3385	2010-03-11 22:37:13.623022	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3386	2010-03-11 22:37:14.107363	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2791	2010-03-11 11:36:23.876447	You search and find nothing.	t	0	2
2792	2010-03-11 11:36:23.876447	You search and find a Vodka.	t	0	2
2793	2010-03-11 11:36:23.876447	You search and find nothing.	t	0	2
2794	2010-03-11 11:36:23.876447	You search and find nothing.	t	0	2
2795	2010-03-11 11:36:23.876447	You search and find nothing.	t	0	2
2796	2010-03-11 11:36:25.363161	You search and find a Vodka.	t	0	2
2797	2010-03-11 11:36:25.363161	You search and find nothing.	t	0	2
2798	2010-03-11 11:36:25.363161	You search and find nothing.	t	0	2
2799	2010-03-11 11:36:25.363161	You search and find nothing.	t	0	2
3387	2010-03-11 22:37:14.706284	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3388	2010-03-11 22:37:15.278304	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3389	2010-03-11 22:37:15.854615	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3390	2010-03-11 22:37:16.412256	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3391	2010-03-11 22:37:16.986409	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3392	2010-03-11 22:37:17.609598	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3393	2010-03-11 22:37:18.23928	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3394	2010-03-11 22:37:18.832062	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3395	2010-03-11 22:37:19.44982	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3106	2010-03-11 22:21:00.503239	<a href="/viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;&#046;this is diefferent"	t	0	2
3107	2010-03-11 22:21:21.335025	You search and find nothing.	t	0	2
2760	2010-03-11 11:36:18.674747	You search and find nothing.	t	0	2
2761	2010-03-11 11:36:19.483599	You search and find nothing.	t	0	2
2762	2010-03-11 11:36:19.483599	You search and find nothing.	t	0	2
2763	2010-03-11 11:36:19.483599	You search and find nothing.	t	0	2
2764	2010-03-11 11:36:19.483599	You search and find nothing.	t	0	2
2765	2010-03-11 11:36:19.483599	You search and find a Energy rifle.	t	0	2
2800	2010-03-11 11:36:25.363161	You search and find nothing.	t	0	2
2801	2010-03-11 11:36:26.083821	You search and find nothing.	t	0	2
2802	2010-03-11 11:36:26.083821	You search and find nothing.	t	0	2
2803	2010-03-11 11:36:26.083821	You search and find nothing.	t	0	2
2804	2010-03-11 11:36:26.083821	You search and find a Energy pack.	t	0	2
2805	2010-03-11 11:36:26.083821	You search and find nothing.	t	0	2
2806	2010-03-11 11:36:28.472226	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2807	2010-03-11 11:36:28.784643	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2808	2010-03-11 11:36:29.292352	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2809	2010-03-11 11:36:29.925105	You drop your Energy pack.	t	0	2
2810	2010-03-11 11:36:30.176342	You drop your Energy pack.	t	0	2
3098	2010-03-11 22:18:52.823783	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
3099	2010-03-11 22:18:53.183323	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
3100	2010-03-11 22:19:06.314039	You switch your equipped weapon. You will now use your Energy rifle.	t	0	2
3101	2010-03-11 22:19:09.502365	You have unequipped your Energy rifle.	t	0	2
3103	2010-03-11 22:21:00.503239	<a href="/viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;&#046;this is diefferent"	f	0	1
1785	2010-03-09 23:06:03.992204	You search and find nothing.	t	0	12
1786	2010-03-09 23:06:03.992204	You search and find a Energy pistol.	t	0	12
1787	2010-03-09 23:06:03.992204	You search and find nothing.	t	0	12
1788	2010-03-09 23:06:03.992204	You search and find a MRE.	t	0	12
1789	2010-03-09 23:06:03.992204	You search and find nothing.	t	0	12
1790	2010-03-09 23:06:05.510954	You search and find nothing.	t	0	12
1791	2010-03-09 23:06:05.510954	You search and find a Vodka.	t	0	12
1792	2010-03-09 23:06:05.510954	You search and find nothing.	t	0	12
1793	2010-03-09 23:06:05.510954	You search and find a Energy rifle.	t	0	12
1794	2010-03-09 23:06:05.510954	You search and find nothing.	t	0	12
1795	2010-03-09 23:06:06.703733	You search and find nothing.	t	0	12
1796	2010-03-09 23:06:06.703733	You search and find a Vodka.	t	0	12
1797	2010-03-09 23:06:06.703733	You search and find nothing.	t	0	12
1798	2010-03-09 23:06:06.703733	You search and find nothing.	t	0	12
1799	2010-03-09 23:06:06.703733	You search and find a Vodka.	t	0	12
1800	2010-03-09 23:06:07.631429	You search and find nothing.	t	0	12
1801	2010-03-09 23:06:07.631429	You search and find nothing.	t	0	12
1802	2010-03-09 23:06:07.631429	You search and find a MRE.	t	0	12
1803	2010-03-09 23:06:07.631429	You search and find nothing.	t	0	12
1804	2010-03-09 23:06:07.631429	You search and find nothing.	t	0	12
1805	2010-03-09 23:06:08.520294	You search and find nothing.	t	0	12
1806	2010-03-09 23:06:08.520294	You search and find nothing.	t	0	12
1807	2010-03-09 23:06:08.520294	You search and find nothing.	t	0	12
1808	2010-03-09 23:06:08.520294	You search and find nothing.	t	0	12
1809	2010-03-09 23:06:08.520294	You search and find nothing.	t	0	12
3104	2010-03-11 22:21:00.503239	<a href="/viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;&#046;this is diefferent"	f	0	9
3108	2010-03-11 22:21:21.335025	You search and find nothing.	t	0	2
3109	2010-03-11 22:21:21.335025	You search and find nothing.	t	0	2
3110	2010-03-11 22:21:21.335025	You search and find nothing.	t	0	2
3111	2010-03-11 22:21:21.335025	You search and find nothing.	t	0	2
3112	2010-03-11 22:21:22.766568	You search and find nothing.	t	0	2
3113	2010-03-11 22:21:22.766568	You search and find nothing.	t	0	2
3114	2010-03-11 22:21:22.766568	You search and find nothing.	t	0	2
3115	2010-03-11 22:21:22.766568	You search and find nothing.	t	0	2
3116	2010-03-11 22:21:22.766568	You search and find nothing.	t	0	2
3117	2010-03-11 22:21:23.378216	You search and find nothing.	t	0	2
3118	2010-03-11 22:21:23.378216	You search and find nothing.	t	0	2
3119	2010-03-11 22:21:23.378216	You search and find nothing.	t	0	2
3120	2010-03-11 22:21:23.378216	You search and find nothing.	t	0	2
3121	2010-03-11 22:21:23.378216	You search and find nothing.	t	0	2
3122	2010-03-11 22:21:23.884602	You search and find a MRE.	t	0	2
3123	2010-03-11 22:21:23.884602	You search and find nothing.	t	0	2
3124	2010-03-11 22:21:23.884602	You search and find nothing.	t	0	2
3125	2010-03-11 22:21:23.884602	You search and find nothing.	t	0	2
3126	2010-03-11 22:21:23.884602	You search and find nothing.	t	0	2
3396	2010-03-11 22:37:20.046334	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3397	2010-03-11 22:37:20.650335	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3398	2010-03-11 22:37:21.218433	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3399	2010-03-11 22:37:26.703073	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3400	2010-03-11 22:37:27.10329	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3401	2010-03-11 22:37:27.6313	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3402	2010-03-11 22:37:28.111286	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3105	2010-03-11 22:21:00.503239	<a href="/viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;&#046;this is diefferent"	t	0	12
3102	2010-03-11 22:21:00.503239	<a href="/viewCharacter.jsp?id=2">A lonely kitten</a> said, "Well&#046;&#046;&#046;this is diefferent"	t	0	10
3403	2010-03-11 22:37:28.607305	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3404	2010-03-11 22:37:29.279335	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3405	2010-03-11 22:37:29.815512	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3406	2010-03-11 22:37:30.547245	You drop your Energy pistol.	t	0	13
3407	2010-03-11 22:37:30.987219	You drop your Energy pistol.	t	0	13
3408	2010-03-11 22:37:31.469935	You drop your Energy pistol.	t	0	13
3409	2010-03-11 22:37:31.979264	You drop your Energy pistol.	t	0	13
3410	2010-03-11 22:37:32.467249	You drop your Energy pistol.	t	0	13
3411	2010-03-11 22:37:32.979262	You drop your Energy pistol.	t	0	13
3412	2010-03-11 22:37:33.395372	You drop your Energy pistol.	t	0	13
3413	2010-03-11 22:37:33.86222	You drop your Energy rifle.	t	0	13
3414	2010-03-11 22:37:34.302482	You drop your Energy rifle.	t	0	13
2811	2010-03-11 14:26:41.523747	You search and find a Vodka.	t	0	2
2812	2010-03-11 14:26:41.523747	You search and find a Energy pistol.	t	0	2
2813	2010-03-11 14:26:41.523747	You search and find nothing.	t	0	2
2814	2010-03-11 14:26:41.523747	You search and find nothing.	t	0	2
1810	2010-03-09 23:06:13.032481	You search and find nothing.	t	0	12
1811	2010-03-09 23:06:13.032481	You search and find nothing.	t	0	12
1812	2010-03-09 23:06:13.032481	You search and find a Energy rifle.	t	0	12
1813	2010-03-09 23:06:13.032481	You search and find nothing.	t	0	12
1814	2010-03-09 23:06:13.032481	You search and find nothing.	t	0	12
1815	2010-03-09 23:06:14.594123	You search and find nothing.	t	0	12
1816	2010-03-09 23:06:14.594123	You search and find nothing.	t	0	12
1817	2010-03-09 23:06:14.594123	You search and find nothing.	t	0	12
1818	2010-03-09 23:06:14.594123	You search and find nothing.	t	0	12
1819	2010-03-09 23:06:14.594123	You search and find a Energy pistol.	t	0	12
1820	2010-03-09 23:06:17.424745	You search and find nothing.	t	0	12
1821	2010-03-09 23:06:18.24399	You search and find nothing.	t	0	12
1822	2010-03-09 23:07:32.807077	You search and find nothing.	t	0	12
1823	2010-03-09 23:07:32.807077	You search and find a Vodka.	t	0	12
1824	2010-03-09 23:07:32.807077	You search and find nothing.	t	0	12
1825	2010-03-09 23:07:32.807077	You search and find nothing.	t	0	12
1826	2010-03-09 23:07:32.807077	You search and find a Energy rifle.	t	0	12
1827	2010-03-09 23:07:33.543993	You search and find nothing.	t	0	12
1828	2010-03-09 23:07:33.543993	You search and find nothing.	t	0	12
1829	2010-03-09 23:07:33.543993	You search and find nothing.	t	0	12
1830	2010-03-09 23:07:33.543993	You search and find nothing.	t	0	12
1831	2010-03-09 23:07:33.543993	You search and find nothing.	t	0	12
1832	2010-03-09 23:07:34.439451	You search and find a Energy rifle.	t	0	12
2815	2010-03-11 14:26:41.523747	You search and find nothing.	t	0	2
2816	2010-03-11 14:26:43.534306	You search and find nothing.	t	0	2
2817	2010-03-11 14:26:43.534306	You search and find nothing.	t	0	2
2818	2010-03-11 14:26:43.534306	You search and find nothing.	t	0	2
2819	2010-03-11 14:26:43.534306	You search and find nothing.	t	0	2
2820	2010-03-11 14:26:43.534306	You search and find a Energy rifle.	t	0	2
2821	2010-03-11 14:26:44.116664	You search and find a Energy pack.	t	0	2
2822	2010-03-11 14:26:44.116664	You search and find nothing.	t	0	2
2823	2010-03-11 14:26:44.116664	You search and find nothing.	t	0	2
2824	2010-03-11 14:26:44.116664	You search and find nothing.	t	0	2
2825	2010-03-11 14:26:44.116664	You search and find a Vodka.	t	0	2
2836	2010-03-11 14:26:46.639252	You drop your Energy pack.	t	0	2
2826	2010-03-11 14:26:44.646486	You search and find nothing.	t	0	2
2827	2010-03-11 14:26:44.646486	You search and find nothing.	t	0	2
2828	2010-03-11 14:26:44.646486	You search and find nothing.	t	0	2
2829	2010-03-11 14:26:44.646486	You search and find nothing.	t	0	2
2830	2010-03-11 14:26:44.646486	You search and find nothing.	t	0	2
2831	2010-03-11 14:26:45.198318	You search and find nothing.	t	0	2
2832	2010-03-11 14:26:45.198318	You search and find nothing.	t	0	2
2833	2010-03-11 14:26:45.198318	You search and find nothing.	t	0	2
3415	2010-03-11 22:37:34.751197	You drop your Energy rifle.	t	0	13
2834	2010-03-11 14:26:45.198318	You search and find nothing.	t	0	2
3416	2010-03-11 22:37:35.07416	You drop your Energy rifle.	t	0	13
3417	2010-03-11 22:37:36.310264	You drop your Energy rifle.	t	0	13
3418	2010-03-11 22:37:36.626405	You drop your Energy rifle.	t	0	13
3419	2010-03-11 22:37:36.938255	You drop your Energy rifle.	t	0	13
3420	2010-03-11 22:37:37.54719	You drop your Energy pack.	t	0	13
3421	2010-03-11 22:37:37.842901	You drop your Energy pack.	t	0	13
3422	2010-03-11 22:37:38.154978	You drop your Energy pack.	t	0	13
3423	2010-03-11 22:37:38.510212	You drop your Energy pack.	t	0	13
3424	2010-03-11 22:37:38.858251	You drop your Energy pack.	t	0	13
3425	2010-03-11 22:37:39.146238	You drop your Energy pack.	t	0	13
3426	2010-03-11 22:37:39.45825	You drop your Energy pack.	t	0	13
3427	2010-03-11 22:37:39.746084	You drop your Energy pack.	t	0	13
3428	2010-03-11 22:37:40.033909	You drop your Energy pack.	t	0	13
3429	2010-03-11 22:37:40.730059	You drop your Energy rifle.	t	0	13
3430	2010-03-11 22:37:41.362257	You drop your Energy rifle.	t	0	13
3431	2010-03-11 22:37:42.758304	You search and find nothing.	t	0	13
3432	2010-03-11 22:37:42.758304	You search and find nothing.	t	0	13
3433	2010-03-11 22:37:42.758304	You search and find nothing.	t	0	13
3434	2010-03-11 22:37:42.758304	You search and find nothing.	t	0	13
3435	2010-03-11 22:37:42.758304	You search and find nothing.	t	0	13
3436	2010-03-11 22:37:42.952475	You search and find nothing.	t	0	13
3437	2010-03-11 22:37:42.952475	You search and find a Vodka.	t	0	13
3438	2010-03-11 22:37:42.952475	You search and find nothing.	t	0	13
3439	2010-03-11 22:37:42.952475	You search and find nothing.	t	0	13
1861	2010-03-10 06:53:56.402562	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	12
1862	2010-03-10 06:53:56.719603	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	12
1863	2010-03-10 12:07:45.919766	You drop your Energy pack.	t	0	12
1864	2010-03-10 12:07:46.623449	You drop your Energy pack.	t	0	12
1865	2010-03-10 12:07:47.194606	You drop your Energy pack.	t	0	12
1866	2010-03-10 12:07:47.731468	You drop your Energy pack.	t	0	12
1867	2010-03-10 12:07:49.347396	You drop your Energy pistol.	t	0	12
1833	2010-03-09 23:07:34.439451	You search and find a Energy pack.	t	0	12
1834	2010-03-09 23:07:34.439451	You search and find nothing.	t	0	12
1835	2010-03-09 23:07:34.439451	You search and find nothing.	t	0	12
1836	2010-03-09 23:07:34.439451	You search and find nothing.	t	0	12
1837	2010-03-09 23:07:35.159229	You search and find nothing.	t	0	12
1838	2010-03-09 23:07:35.159229	You search and find nothing.	t	0	12
1839	2010-03-09 23:07:35.159229	You search and find nothing.	t	0	12
1840	2010-03-09 23:07:35.159229	You search and find nothing.	t	0	12
1841	2010-03-09 23:07:35.159229	You search and find nothing.	t	0	12
1842	2010-03-10 06:45:30.4819	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
1843	2010-03-10 06:45:32.030922	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
1844	2010-03-10 06:45:33.702894	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
1845	2010-03-10 06:45:36.043615	You switch your equipped weapon. You will now use your Energy rifle.	t	0	12
1868	2010-03-10 12:07:49.931534	You drop your Energy pistol.	t	0	12
1869	2010-03-10 12:07:50.475436	You drop your Energy pistol.	t	0	12
1870	2010-03-10 12:07:52.130458	You drop your Energy rifle.	t	0	12
1871	2010-03-10 12:07:52.610527	You drop your Energy rifle.	t	0	12
1872	2010-03-10 12:07:53.042393	You drop your Energy rifle.	t	0	12
1873	2010-03-10 12:07:53.450421	You drop your Energy rifle.	t	0	12
1874	2010-03-10 12:07:53.87444	You drop your Energy rifle.	t	0	12
1846	2010-03-10 06:53:03.39648	You search and find nothing.	t	0	12
1847	2010-03-10 06:53:03.39648	You search and find nothing.	t	0	12
1848	2010-03-10 06:53:03.39648	You search and find nothing.	t	0	12
1849	2010-03-10 06:53:03.39648	You search and find nothing.	t	0	12
1850	2010-03-10 06:53:03.39648	You search and find a Energy rifle.	t	0	12
1851	2010-03-10 06:53:04.2353	You search and find nothing.	t	0	12
1852	2010-03-10 06:53:04.2353	You search and find nothing.	t	0	12
1853	2010-03-10 06:53:04.2353	You search and find nothing.	t	0	12
1854	2010-03-10 06:53:04.2353	You search and find nothing.	t	0	12
1855	2010-03-10 06:53:04.2353	You search and find nothing.	t	0	12
1856	2010-03-10 06:53:53.3787	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1857	2010-03-10 06:53:53.983591	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1858	2010-03-10 06:53:54.559681	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1859	2010-03-10 06:53:55.331649	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1860	2010-03-10 06:53:55.735634	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
1875	2010-03-10 12:07:54.330639	You drop your Energy rifle.	t	0	12
1876	2010-03-10 12:07:55.006414	You drop your Energy rifle.	t	0	12
1885	2010-03-10 12:12:24.958458	You switch your equipped weapon. You will now use your Energy rifle.	t	0	9
1886	2010-03-10 12:12:27.238136	You drop your Energy pistol.	t	0	9
1887	2010-03-10 12:12:27.783435	You drop your Energy pistol.	t	0	9
1877	2010-03-10 12:09:21.600793	You search and find nothing.	t	0	12
1878	2010-03-10 12:09:21.600793	You search and find a Energy pistol.	t	0	12
1879	2010-03-10 12:09:21.600793	You search and find nothing.	t	0	12
1880	2010-03-10 12:09:21.600793	You search and find nothing.	t	0	12
1881	2010-03-10 12:09:21.600793	You search and find nothing.	t	0	12
1882	2010-03-10 12:09:27.014182	You drop your Energy pistol.	t	0	12
1883	2010-03-10 12:12:22.610892	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1884	2010-03-10 12:12:23.775765	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1888	2010-03-10 12:12:28.587641	You drop your Energy pack.	t	0	9
1889	2010-03-10 12:12:29.586417	You drop your Energy pack.	t	0	9
1890	2010-03-10 12:13:24.547624	You search and find nothing.	t	0	9
1891	2010-03-10 12:13:24.547624	You search and find a Energy pack.	t	0	9
1892	2010-03-10 12:13:24.547624	You search and find nothing.	t	0	9
1893	2010-03-10 12:13:24.547624	You search and find nothing.	t	0	9
1894	2010-03-10 12:13:24.547624	You search and find a Energy pack.	t	0	9
1895	2010-03-10 12:13:25.156799	You search and find nothing.	t	0	9
1896	2010-03-10 12:13:25.156799	You search and find nothing.	t	0	9
1897	2010-03-10 12:13:25.156799	You search and find nothing.	t	0	9
1898	2010-03-10 12:13:25.156799	You search and find nothing.	t	0	9
1899	2010-03-10 12:13:25.156799	You search and find nothing.	t	0	9
1900	2010-03-10 12:13:25.804638	You search and find nothing.	t	0	9
1901	2010-03-10 12:13:25.804638	You search and find nothing.	t	0	9
1902	2010-03-10 12:13:25.804638	You search and find nothing.	t	0	9
1903	2010-03-10 12:13:25.804638	You search and find nothing.	t	0	9
2835	2010-03-11 14:26:45.198318	You search and find nothing.	t	0	2
2837	2010-03-11 14:26:47.043986	You drop your Energy pack.	t	0	2
2838	2010-03-11 14:26:47.632467	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2839	2010-03-11 14:26:47.976197	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2840	2010-03-11 14:26:49.179545	You drop your Energy pistol.	t	0	2
2841	2010-03-11 14:26:49.638415	You drop your Energy rifle.	t	0	2
2842	2010-03-11 14:26:50.416128	You switch your equipped weapon. You will now use your Energy rifle.	t	0	2
2843	2010-03-11 14:26:59.435068	You switch your equipped weapon. You will now use your Energy rifle.	t	0	2
2844	2010-03-11 14:27:12.532281	You search and find nothing.	t	0	2
2845	2010-03-11 14:27:14.787659	You have unequipped your Energy rifle.	t	0	2
2846	2010-03-11 14:27:16.974404	You search and find nothing.	t	0	2
2847	2010-03-11 14:27:18.291871	You drop your Energy rifle.	t	0	2
2848	2010-03-11 14:38:55.603141	You search and find nothing.	t	0	2
2849	2010-03-11 14:38:55.603141	You search and find nothing.	t	0	2
3441	2010-03-11 22:37:43.133188	You search and find nothing.	t	0	13
1904	2010-03-10 12:13:25.804638	You search and find nothing.	t	0	9
1905	2010-03-10 12:13:26.532416	You search and find nothing.	t	0	9
1906	2010-03-10 12:13:26.532416	You search and find nothing.	t	0	9
1907	2010-03-10 12:13:26.532416	You search and find nothing.	t	0	9
1908	2010-03-10 12:13:26.532416	You search and find nothing.	t	0	9
1909	2010-03-10 12:13:26.532416	You search and find nothing.	t	0	9
1910	2010-03-10 12:13:27.2867	You search and find nothing.	t	0	9
1911	2010-03-10 12:13:27.2867	You search and find nothing.	t	0	9
1912	2010-03-10 12:13:27.2867	You search and find nothing.	t	0	9
1913	2010-03-10 12:13:27.2867	You search and find nothing.	t	0	9
1914	2010-03-10 12:13:27.2867	You search and find a Energy pack.	t	0	9
1915	2010-03-10 12:13:27.948589	You search and find a MRE.	t	0	9
1916	2010-03-10 12:13:27.948589	You search and find nothing.	t	0	9
1917	2010-03-10 12:13:27.948589	You search and find nothing.	t	0	9
1918	2010-03-10 12:13:27.948589	You search and find nothing.	t	0	9
1919	2010-03-10 12:13:27.948589	You search and find nothing.	t	0	9
1920	2010-03-10 12:13:28.773764	You search and find nothing.	t	0	9
1921	2010-03-10 12:13:28.773764	You search and find nothing.	t	0	9
1922	2010-03-10 12:13:28.773764	You search and find nothing.	t	0	9
1923	2010-03-10 12:13:28.773764	You search and find nothing.	t	0	9
1924	2010-03-10 12:13:28.773764	You search and find nothing.	t	0	9
1925	2010-03-10 12:13:30.764138	You search and find a Energy pack.	t	0	9
1926	2010-03-10 12:13:30.764138	You search and find nothing.	t	0	9
1927	2010-03-10 12:13:30.764138	You search and find nothing.	t	0	9
1928	2010-03-10 12:13:30.764138	You search and find a Vodka.	t	0	9
1929	2010-03-10 12:13:30.764138	You search and find nothing.	t	0	9
2854	2010-03-11 14:41:15.457246	You search and find nothing.	t	0	2
2855	2010-03-11 14:41:15.990035	You search and find nothing.	t	0	2
2850	2010-03-11 14:38:55.603141	You search and find nothing.	t	0	2
2851	2010-03-11 14:38:55.603141	You search and find a MRE.	t	0	2
2852	2010-03-11 14:38:55.603141	You search and find nothing.	t	0	2
2853	2010-03-11 14:38:58.211041	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2856	2010-03-11 14:41:15.990035	You search and find nothing.	t	0	2
2857	2010-03-11 14:41:15.990035	You search and find nothing.	t	0	2
2858	2010-03-11 14:41:15.990035	You search and find nothing.	t	0	2
2859	2010-03-11 14:41:15.990035	You search and find nothing.	t	0	2
2860	2010-03-11 14:41:16.477069	You search and find nothing.	t	0	2
2861	2010-03-11 14:41:16.477069	You search and find nothing.	t	0	2
2862	2010-03-11 14:41:16.477069	You search and find a Vodka.	t	0	2
2863	2010-03-11 14:41:16.477069	You search and find nothing.	t	0	2
2864	2010-03-11 14:41:16.477069	You search and find nothing.	t	0	2
2865	2010-03-11 14:41:16.893142	You search and find nothing.	t	0	2
2866	2010-03-11 14:41:16.893142	You search and find nothing.	t	0	2
2867	2010-03-11 14:41:16.893142	You search and find nothing.	t	0	2
2868	2010-03-11 14:41:16.893142	You search and find nothing.	t	0	2
2869	2010-03-11 14:41:16.893142	You search and find nothing.	t	0	2
2875	2010-03-11 14:41:17.796829	You search and find a Energy pistol.	t	0	2
2876	2010-03-11 14:41:17.796829	You search and find a Energy pistol.	t	0	2
2877	2010-03-11 14:41:17.796829	You search and find a Energy pack.	t	0	2
2878	2010-03-11 14:41:17.796829	You search and find nothing.	t	0	2
2879	2010-03-11 14:41:17.796829	You search and find a Energy rifle.	t	0	2
2870	2010-03-11 14:41:17.365457	You search and find a Vodka.	t	0	2
2871	2010-03-11 14:41:17.365457	You search and find nothing.	t	0	2
2872	2010-03-11 14:41:17.365457	You search and find a Vodka.	t	0	2
2873	2010-03-11 14:41:17.365457	You search and find nothing.	t	0	2
2874	2010-03-11 14:41:17.365457	You search and find a Energy pistol.	t	0	2
3440	2010-03-11 22:37:42.952475	You search and find nothing.	t	0	13
3442	2010-03-11 22:37:43.133188	You search and find nothing.	t	0	13
3443	2010-03-11 22:37:43.133188	You search and find nothing.	t	0	13
3444	2010-03-11 22:37:43.133188	You search and find nothing.	t	0	13
3445	2010-03-11 22:37:43.133188	You search and find nothing.	t	0	13
3446	2010-03-11 22:37:43.348753	You search and find nothing.	t	0	13
3447	2010-03-11 22:37:43.348753	You search and find nothing.	t	0	13
3448	2010-03-11 22:37:43.348753	You search and find nothing.	t	0	13
3449	2010-03-11 22:37:43.348753	You search and find nothing.	t	0	13
3450	2010-03-11 22:37:43.348753	You search and find nothing.	t	0	13
3451	2010-03-11 22:38:07.811305	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
1954	2010-03-10 12:14:30.15247	You drop your Energy rifle.	t	0	9
1955	2010-03-10 12:14:30.71603	You drop your Energy rifle.	t	0	9
1972	2010-03-10 12:17:47.065693	You search and find nothing.	t	0	9
1973	2010-03-10 12:17:47.065693	You search and find a Vodka.	t	0	9
1974	2010-03-10 12:17:47.065693	You search and find nothing.	t	0	9
1975	2010-03-10 12:17:47.065693	You search and find nothing.	t	0	9
1976	2010-03-10 12:17:47.065693	You search and find nothing.	t	0	9
2880	2010-03-11 14:41:19.084893	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
1977	2010-03-10 12:17:49.166193	You drop your Energy pack.	t	0	9
1978	2010-03-10 12:17:49.3662	You drop your Energy pack.	t	0	9
1979	2010-03-10 12:17:50.434751	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
1980	2010-03-10 12:17:51.181136	You drop your Energy rifle.	t	0	9
1930	2010-03-10 12:13:31.652154	You search and find a Energy pack.	t	0	9
1931	2010-03-10 12:13:31.652154	You search and find nothing.	t	0	9
1932	2010-03-10 12:13:31.652154	You search and find nothing.	t	0	9
1933	2010-03-10 12:13:31.652154	You search and find nothing.	t	0	9
1934	2010-03-10 12:13:31.652154	You search and find nothing.	t	0	9
1935	2010-03-10 12:13:32.732723	You search and find nothing.	t	0	9
1936	2010-03-10 12:13:32.732723	You search and find a Energy rifle.	t	0	9
1937	2010-03-10 12:13:32.732723	You search and find nothing.	t	0	9
1938	2010-03-10 12:13:32.732723	You search and find a Vodka.	t	0	9
1939	2010-03-10 12:13:32.732723	You search and find nothing.	t	0	9
1940	2010-03-10 12:13:33.813419	You search and find nothing.	t	0	9
1941	2010-03-10 12:13:33.813419	You search and find nothing.	t	0	9
1942	2010-03-10 12:13:33.813419	You search and find nothing.	t	0	9
1943	2010-03-10 12:13:33.813419	You search and find a Energy pistol.	t	0	9
1944	2010-03-10 12:13:33.813419	You search and find nothing.	t	0	9
1945	2010-03-10 12:13:36.038748	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
1946	2010-03-10 12:13:36.699656	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
1947	2010-03-10 12:13:37.421165	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	9
1948	2010-03-10 12:13:39.166132	You drop your Energy pack.	t	0	9
1949	2010-03-10 12:13:39.610964	You drop your Energy pack.	t	0	9
1950	2010-03-10 12:13:40.082312	You drop your Energy pack.	t	0	9
1951	2010-03-10 12:13:41.131841	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1952	2010-03-10 12:13:42.465057	You switch your equipped weapon. You will now use your Energy rifle.	t	0	9
1953	2010-03-10 12:13:44.272684	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1956	2010-03-10 12:14:40.743598	You search and find nothing.	t	0	9
1957	2010-03-10 12:14:40.743598	You search and find nothing.	t	0	9
1958	2010-03-10 12:14:40.743598	You search and find a Energy rifle.	t	0	9
1959	2010-03-10 12:14:40.743598	You search and find nothing.	t	0	9
1960	2010-03-10 12:14:40.743598	You search and find nothing.	t	0	9
1961	2010-03-10 12:14:41.748323	You search and find nothing.	t	0	9
1962	2010-03-10 12:14:41.748323	You search and find nothing.	t	0	9
1963	2010-03-10 12:14:41.748323	You search and find nothing.	t	0	9
1964	2010-03-10 12:14:41.748323	You search and find nothing.	t	0	9
1965	2010-03-10 12:14:41.748323	You search and find nothing.	t	0	9
1966	2010-03-10 12:14:48.059114	You switch your equipped weapon. You will now use your Energy rifle.	t	0	9
1967	2010-03-10 12:14:52.455567	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1968	2010-03-10 12:16:35.878561	You switch your equipped weapon. You will now use your Energy rifle.	t	0	9
1969	2010-03-10 12:16:41.307699	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1970	2010-03-10 12:16:49.603106	You switch your equipped weapon. You will now use your Energy rifle.	t	0	9
1971	2010-03-10 12:16:50.995709	You switch your equipped weapon. You will now use your Energy pistol.	t	0	9
1981	2010-03-10 12:17:52.349304	You search and find a Energy pistol.	t	0	9
1982	2010-03-10 12:17:52.349304	You search and find a Vodka.	t	0	9
1983	2010-03-10 12:17:52.349304	You search and find nothing.	t	0	9
1984	2010-03-10 12:17:52.349304	You search and find nothing.	t	0	9
1985	2010-03-10 12:17:52.349304	You search and find nothing.	t	0	9
1986	2010-03-10 12:17:53.461223	You search and find nothing.	t	0	9
1987	2010-03-10 12:17:53.461223	You search and find a Energy pack.	t	0	9
1988	2010-03-10 12:17:53.461223	You search and find nothing.	t	0	9
1989	2010-03-10 12:17:53.461223	You search and find nothing.	t	0	9
1990	2010-03-10 12:17:53.461223	You search and find nothing.	t	0	9
1991	2010-03-10 12:17:55.095852	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	9
1992	2010-03-10 13:38:58.886768	You search and find nothing.	t	0	2
1993	2010-03-10 13:38:58.886768	You search and find nothing.	t	0	2
1994	2010-03-10 13:38:58.886768	You search and find a MRE.	t	0	2
1995	2010-03-10 13:38:58.886768	You search and find nothing.	t	0	2
1996	2010-03-10 13:38:58.886768	You search and find nothing.	t	0	2
1997	2010-03-10 13:38:58.900709	You search and find nothing.	t	0	2
1998	2010-03-10 13:38:58.900709	You search and find a MRE.	t	0	2
1999	2010-03-10 13:38:58.900709	You search and find nothing.	t	0	2
2000	2010-03-10 13:38:58.900709	You search and find nothing.	t	0	2
2001	2010-03-10 13:38:58.900709	You search and find a Energy pack.	t	0	2
2881	2010-03-11 14:41:19.791303	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2002	2010-03-10 13:38:59.638609	You search and find nothing.	t	0	2
2003	2010-03-10 13:38:59.638609	You search and find nothing.	t	0	2
2004	2010-03-10 13:38:59.638609	You search and find nothing.	t	0	2
2005	2010-03-10 13:38:59.638609	You search and find nothing.	t	0	2
2882	2010-03-11 14:41:20.364976	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
2883	2010-03-11 14:41:22.184362	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
2884	2010-03-11 14:41:25.820998	You search and find nothing.	t	0	2
2885	2010-03-11 14:41:25.820998	You search and find a Vodka.	t	0	2
2886	2010-03-11 14:41:25.820998	You search and find nothing.	t	0	2
2014	2010-03-10 13:39:11.135889	You search and find nothing.	t	0	1
2015	2010-03-10 13:39:11.135889	You search and find nothing.	t	0	1
2016	2010-03-10 13:39:11.135889	You search and find nothing.	t	0	1
2017	2010-03-10 13:39:11.135889	You search and find nothing.	t	0	1
2018	2010-03-10 13:39:11.135889	You search and find nothing.	t	0	1
2006	2010-03-10 13:38:59.638609	You search and find nothing.	t	0	2
2007	2010-03-10 13:39:00.277147	You search and find nothing.	t	0	2
2008	2010-03-10 13:39:00.277147	You search and find nothing.	t	0	2
2009	2010-03-10 13:39:00.277147	You search and find nothing.	t	0	2
2010	2010-03-10 13:39:00.277147	You search and find nothing.	t	0	2
2011	2010-03-10 13:39:00.277147	You search and find nothing.	t	0	2
2012	2010-03-10 13:39:03.542668	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2013	2010-03-10 13:39:03.70257	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2019	2010-03-10 13:39:11.831381	You search and find nothing.	t	0	1
2020	2010-03-10 13:39:11.831381	You search and find nothing.	t	0	1
2021	2010-03-10 13:39:11.831381	You search and find a Vodka.	t	0	1
2022	2010-03-10 13:39:11.831381	You search and find nothing.	t	0	1
2023	2010-03-10 13:39:11.831381	You search and find nothing.	t	0	1
2024	2010-03-10 13:39:12.429044	You search and find nothing.	t	0	1
2025	2010-03-10 13:39:12.429044	You search and find nothing.	t	0	1
2026	2010-03-10 13:39:12.429044	You search and find nothing.	t	0	1
2027	2010-03-10 13:39:12.429044	You search and find nothing.	t	0	1
2028	2010-03-10 13:39:12.429044	You search and find nothing.	t	0	1
2039	2010-03-10 13:39:14.069341	You search and find nothing.	t	0	1
2040	2010-03-10 13:39:14.069341	You search and find nothing.	t	0	1
2041	2010-03-10 13:39:14.069341	You search and find nothing.	t	0	1
2042	2010-03-10 13:39:14.069341	You search and find a Vodka.	t	0	1
2043	2010-03-10 13:39:14.069341	You search and find nothing.	t	0	1
2029	2010-03-10 13:39:12.957386	You search and find nothing.	t	0	1
2030	2010-03-10 13:39:12.957386	You search and find nothing.	t	0	1
2031	2010-03-10 13:39:12.957386	You search and find a Energy rifle.	t	0	1
2032	2010-03-10 13:39:12.957386	You search and find nothing.	t	0	1
2033	2010-03-10 13:39:12.957386	You search and find nothing.	t	0	1
2049	2010-03-10 13:39:15.358026	You search and find nothing.	t	0	1
2050	2010-03-10 13:39:15.358026	You search and find nothing.	t	0	1
2051	2010-03-10 13:39:15.358026	You search and find nothing.	t	0	1
2052	2010-03-10 13:39:15.358026	You search and find nothing.	t	0	1
2053	2010-03-10 13:39:15.358026	You search and find nothing.	t	0	1
2034	2010-03-10 13:39:13.45326	You search and find nothing.	t	0	1
2035	2010-03-10 13:39:13.45326	You search and find nothing.	t	0	1
2036	2010-03-10 13:39:13.45326	You search and find a Vodka.	t	0	1
2037	2010-03-10 13:39:13.45326	You search and find nothing.	t	0	1
2038	2010-03-10 13:39:13.45326	You search and find nothing.	t	0	1
2044	2010-03-10 13:39:14.701483	You search and find nothing.	t	0	1
2045	2010-03-10 13:39:14.701483	You search and find nothing.	t	0	1
2046	2010-03-10 13:39:14.701483	You search and find nothing.	t	0	1
2047	2010-03-10 13:39:14.701483	You search and find a Energy rifle.	t	0	1
2048	2010-03-10 13:39:14.701483	You search and find nothing.	t	0	1
2887	2010-03-11 14:41:25.820998	You search and find nothing.	t	0	2
2888	2010-03-11 14:41:25.820998	You search and find a Energy pistol.	t	0	2
2889	2010-03-11 14:41:27.74119	You have unequipped your Energy pistol.	t	0	2
3127	2010-03-11 22:21:24.362451	You search and find nothing.	t	0	2
3128	2010-03-11 22:21:24.362451	You search and find a MRE.	t	0	2
3129	2010-03-11 22:21:24.362451	You search and find nothing.	t	0	2
3130	2010-03-11 22:21:24.362451	You search and find nothing.	t	0	2
3131	2010-03-11 22:21:24.362451	You search and find a Energy pack.	t	0	2
2890	2010-03-11 14:41:29.781527	You search and find nothing.	t	0	2
2891	2010-03-11 14:41:29.781527	You search and find nothing.	t	0	2
2892	2010-03-11 14:41:29.781527	You search and find nothing.	t	0	2
2893	2010-03-11 14:41:29.781527	You search and find a Energy rifle.	t	0	2
2894	2010-03-11 14:41:29.781527	You search and find nothing.	t	0	2
2895	2010-03-11 14:41:31.436375	You drop your Energy pistol.	t	0	2
2896	2010-03-11 14:41:32.020349	You drop your Energy pistol.	t	0	2
2897	2010-03-11 14:41:32.516739	You drop your Energy pistol.	t	0	2
2898	2010-03-11 14:41:33.036514	You drop your Energy pistol.	t	0	2
2899	2010-03-11 14:41:33.585131	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
3132	2010-03-11 22:21:24.894543	You search and find nothing.	t	0	2
3133	2010-03-11 22:21:24.894543	You search and find nothing.	t	0	2
3134	2010-03-11 22:21:24.894543	You search and find nothing.	t	0	2
3135	2010-03-11 22:21:24.894543	You search and find nothing.	t	0	2
3136	2010-03-11 22:21:24.894543	You search and find nothing.	t	0	2
3137	2010-03-11 22:21:25.386427	You search and find a Vodka.	t	0	2
3138	2010-03-11 22:21:25.386427	You search and find nothing.	t	0	2
3139	2010-03-11 22:21:25.386427	You search and find nothing.	t	0	2
3140	2010-03-11 22:21:25.386427	You search and find nothing.	t	0	2
3141	2010-03-11 22:21:25.386427	You search and find nothing.	t	0	2
3456	2010-03-11 22:38:53.715749	You search and find nothing.	t	0	13
3452	2010-03-11 22:38:53.715749	You search and find nothing.	t	0	13
3453	2010-03-11 22:38:53.715749	You search and find nothing.	t	0	13
3454	2010-03-11 22:38:53.715749	You search and find nothing.	t	0	13
3455	2010-03-11 22:38:53.715749	You search and find a Energy pistol.	t	0	13
3457	2010-03-11 22:38:59.459456	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3458	2010-03-11 22:39:38.665321	You search and find nothing.	t	0	13
3459	2010-03-11 22:39:38.665321	You search and find nothing.	t	0	13
3460	2010-03-11 22:39:38.665321	You search and find nothing.	t	0	13
3461	2010-03-11 22:39:38.665321	You search and find nothing.	t	0	13
3462	2010-03-11 22:39:38.665321	You search and find nothing.	t	0	13
3463	2010-03-11 22:39:40.842207	You have unequipped your Energy pistol.	t	0	13
2927	2010-03-11 15:04:37.676399	You drop your Energy pack.	t	0	13
2928	2010-03-11 15:04:38.448822	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
2929	2010-03-11 15:04:40.02027	You have unequipped your Energy pistol.	t	0	13
2900	2010-03-11 15:04:31.962258	You search and find nothing.	t	0	13
2901	2010-03-11 15:04:31.962258	You search and find a Energy pack.	t	0	13
2902	2010-03-11 15:04:31.962258	You search and find nothing.	t	0	13
2903	2010-03-11 15:04:31.962258	You search and find nothing.	t	0	13
2904	2010-03-11 15:04:31.962258	You search and find nothing.	t	0	13
2905	2010-03-11 15:04:33.202975	You drop your Energy pack.	t	0	13
2930	2010-03-11 15:04:41.031221	You drop your Energy pistol.	t	0	13
2054	2010-03-10 13:39:16.622593	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	1
2055	2010-03-10 13:39:16.907698	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	1
2056	2010-03-10 13:39:17.250734	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	1
2057	2010-03-10 13:39:19.021591	You search and find nothing.	t	0	1
2058	2010-03-10 13:39:19.021591	You search and find a Energy pistol.	t	0	1
2059	2010-03-10 13:39:19.021591	You search and find nothing.	t	0	1
2060	2010-03-10 13:39:19.021591	You search and find nothing.	t	0	1
2061	2010-03-10 13:39:19.021591	You search and find nothing.	t	0	1
2062	2010-03-10 13:39:19.525812	You search and find nothing.	t	0	1
2063	2010-03-10 13:39:19.525812	You search and find a Energy rifle.	t	0	1
2064	2010-03-10 13:39:19.525812	You search and find nothing.	t	0	1
2065	2010-03-10 13:39:19.525812	You search and find nothing.	t	0	1
2066	2010-03-10 13:39:19.525812	You search and find nothing.	t	0	1
2067	2010-03-10 13:39:19.997283	You search and find nothing.	t	0	1
2068	2010-03-10 13:39:19.997283	You search and find a Energy pistol.	t	0	1
2069	2010-03-10 13:39:19.997283	You search and find nothing.	t	0	1
2070	2010-03-10 13:39:19.997283	You search and find nothing.	t	0	1
2071	2010-03-10 13:39:19.997283	You search and find nothing.	t	0	1
2072	2010-03-10 13:39:20.533505	You search and find nothing.	t	0	1
2073	2010-03-10 13:39:20.533505	You search and find a Vodka.	t	0	1
2074	2010-03-10 13:39:20.533505	You search and find nothing.	t	0	1
2075	2010-03-10 13:39:20.533505	You search and find a Energy pack.	t	0	1
2076	2010-03-10 13:39:20.533505	You search and find nothing.	t	0	1
2931	2010-03-11 15:04:41.788526	You drop your Energy pistol.	t	0	13
2932	2010-03-11 15:04:45.991277	You search and find nothing.	t	0	13
2933	2010-03-11 15:04:45.991277	You search and find nothing.	t	0	13
2934	2010-03-11 15:04:45.991277	You search and find a MRE.	t	0	13
2935	2010-03-11 15:04:45.991277	You search and find nothing.	t	0	13
2936	2010-03-11 15:04:45.991277	You search and find nothing.	t	0	13
2906	2010-03-11 15:04:34.664555	You search and find nothing.	t	0	13
2907	2010-03-11 15:04:34.664555	You search and find nothing.	t	0	13
2908	2010-03-11 15:04:34.664555	You search and find nothing.	t	0	13
2909	2010-03-11 15:04:34.664555	You search and find nothing.	t	0	13
2910	2010-03-11 15:04:34.664555	You search and find nothing.	t	0	13
2911	2010-03-11 15:04:35.045052	You search and find nothing.	t	0	13
2912	2010-03-11 15:04:35.045052	You search and find nothing.	t	0	13
2913	2010-03-11 15:04:35.045052	You search and find nothing.	t	0	13
2914	2010-03-11 15:04:35.045052	You search and find nothing.	t	0	13
2915	2010-03-11 15:04:35.045052	You search and find nothing.	t	0	13
2916	2010-03-11 15:04:35.269411	You search and find nothing.	t	0	13
2917	2010-03-11 15:04:35.269411	You search and find nothing.	t	0	13
2918	2010-03-11 15:04:35.269411	You search and find nothing.	t	0	13
2919	2010-03-11 15:04:35.269411	You search and find a Energy pistol.	t	0	13
2920	2010-03-11 15:04:35.269411	You search and find a Energy pistol.	t	0	13
2926	2010-03-11 15:04:37.20044	You drop your Energy pack.	t	0	13
2921	2010-03-11 15:04:35.46327	You search and find nothing.	t	0	13
2922	2010-03-11 15:04:35.46327	You search and find a Energy pack.	t	0	13
2923	2010-03-11 15:04:35.46327	You search and find a Energy pack.	t	0	13
2924	2010-03-11 15:04:35.46327	You search and find nothing.	t	0	13
2925	2010-03-11 15:04:35.46327	You search and find nothing.	t	0	13
2937	2010-03-11 15:04:46.445429	You search and find nothing.	t	0	13
2938	2010-03-11 15:04:46.445429	You search and find nothing.	t	0	13
2939	2010-03-11 15:04:46.445429	You search and find nothing.	t	0	13
2940	2010-03-11 15:04:46.445429	You search and find nothing.	t	0	13
2941	2010-03-11 15:04:46.445429	You search and find nothing.	t	0	13
2942	2010-03-11 15:04:48.560289	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2943	2010-03-11 15:05:28.488119	You search and find a MRE.	t	0	13
2944	2010-03-11 15:05:28.488119	You search and find nothing.	t	0	13
2945	2010-03-11 15:05:28.488119	You search and find nothing.	t	0	13
2946	2010-03-11 15:05:28.488119	You search and find nothing.	t	0	13
2947	2010-03-11 15:05:28.488119	You search and find a Vodka.	t	0	13
2948	2010-03-11 15:05:29.220674	You search and find nothing.	t	0	13
2949	2010-03-11 15:05:29.220674	You search and find nothing.	t	0	13
2950	2010-03-11 15:05:29.220674	You search and find a Energy pistol.	t	0	13
2951	2010-03-11 15:05:29.220674	You search and find nothing.	t	0	13
2952	2010-03-11 15:05:29.220674	You search and find a Energy rifle.	t	0	13
2953	2010-03-11 15:05:29.701162	You search and find nothing.	t	0	13
2954	2010-03-11 15:05:29.701162	You search and find nothing.	t	0	13
2955	2010-03-11 15:05:29.701162	You search and find nothing.	t	0	13
2956	2010-03-11 15:05:29.701162	You search and find nothing.	t	0	13
3464	2010-03-11 22:39:42.26602	You drop your Energy pistol.	t	0	13
3465	2010-03-11 22:39:43.688863	You search and find nothing.	t	0	13
3466	2010-03-11 22:39:43.688863	You search and find nothing.	t	0	13
3467	2010-03-11 22:39:43.688863	You search and find a Vodka.	t	0	13
3468	2010-03-11 22:39:43.688863	You search and find a Energy pack.	t	0	13
3469	2010-03-11 22:39:43.688863	You search and find nothing.	t	0	13
3470	2010-03-11 22:39:45.575273	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3471	2010-03-11 22:39:46.443295	You drop your Energy pack.	t	0	13
2967	2010-03-11 15:05:34.502288	You search and find a Energy pistol.	t	0	13
2968	2010-03-11 15:05:34.502288	You search and find nothing.	t	0	13
2969	2010-03-11 15:05:34.502288	You search and find nothing.	t	0	13
2970	2010-03-11 15:05:34.502288	You search and find nothing.	t	0	13
2971	2010-03-11 15:05:34.502288	You search and find nothing.	t	0	13
2957	2010-03-11 15:05:29.701162	You search and find nothing.	t	0	13
2958	2010-03-11 15:05:29.894925	You search and find nothing.	t	0	13
2959	2010-03-11 15:05:29.894925	You search and find nothing.	t	0	13
2960	2010-03-11 15:05:29.894925	You search and find nothing.	t	0	13
2961	2010-03-11 15:05:29.894925	You search and find nothing.	t	0	13
2962	2010-03-11 15:05:29.894925	You search and find nothing.	t	0	13
2963	2010-03-11 15:05:31.748241	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2964	2010-03-11 15:05:32.17506	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2965	2010-03-11 15:05:32.987208	You drop your Energy pistol.	t	0	13
2966	2010-03-11 15:05:33.472768	You drop your Energy rifle.	t	0	13
2972	2010-03-11 15:05:34.685099	You search and find nothing.	t	0	13
2973	2010-03-11 15:05:34.685099	You search and find nothing.	t	0	13
2974	2010-03-11 15:05:34.685099	You search and find nothing.	t	0	13
2975	2010-03-11 15:05:34.685099	You search and find nothing.	t	0	13
2976	2010-03-11 15:05:34.685099	You search and find nothing.	t	0	13
2977	2010-03-11 15:05:34.877614	You search and find nothing.	t	0	13
2978	2010-03-11 15:05:34.877614	You search and find nothing.	t	0	13
2979	2010-03-11 15:05:34.877614	You search and find nothing.	t	0	13
2980	2010-03-11 15:05:34.877614	You search and find a Vodka.	t	0	13
2981	2010-03-11 15:05:34.877614	You search and find nothing.	t	0	13
2987	2010-03-11 15:05:35.287282	You search and find nothing.	t	0	13
2988	2010-03-11 15:05:35.287282	You search and find nothing.	t	0	13
2989	2010-03-11 15:05:35.287282	You search and find nothing.	t	0	13
2990	2010-03-11 15:05:35.287282	You search and find nothing.	t	0	13
2991	2010-03-11 15:05:35.287282	You search and find nothing.	t	0	13
2077	2010-03-10 13:39:21.021806	You search and find a Energy pack.	t	0	1
2078	2010-03-10 13:39:21.021806	You search and find nothing.	t	0	1
2079	2010-03-10 13:39:21.021806	You search and find a MRE.	t	0	1
2080	2010-03-10 13:39:21.021806	You search and find nothing.	t	0	1
2081	2010-03-10 13:39:21.021806	You search and find nothing.	t	0	1
2082	2010-03-10 13:39:21.493496	You search and find nothing.	t	0	1
2083	2010-03-10 13:39:21.493496	You search and find nothing.	t	0	1
2084	2010-03-10 13:39:21.493496	You search and find a Vodka.	t	0	1
2085	2010-03-10 13:39:21.493496	You search and find nothing.	t	0	1
2086	2010-03-10 13:39:21.493496	You search and find nothing.	t	0	1
2087	2010-03-10 13:39:21.981364	You search and find a Vodka.	t	0	1
2088	2010-03-10 13:39:21.981364	You search and find nothing.	t	0	1
2089	2010-03-10 13:39:21.981364	You search and find nothing.	t	0	1
2090	2010-03-10 13:39:21.981364	You search and find nothing.	t	0	1
2091	2010-03-10 13:39:21.981364	You search and find nothing.	t	0	1
2092	2010-03-10 13:39:22.461484	You search and find nothing.	t	0	1
2093	2010-03-10 13:39:22.461484	You search and find nothing.	t	0	1
2094	2010-03-10 13:39:22.461484	You search and find nothing.	t	0	1
2095	2010-03-10 13:39:22.461484	You search and find nothing.	t	0	1
2096	2010-03-10 13:39:22.461484	You search and find a Energy pack.	t	0	1
2982	2010-03-11 15:05:35.079364	You search and find a Energy pack.	t	0	13
2983	2010-03-11 15:05:35.079364	You search and find a Vodka.	t	0	13
2984	2010-03-11 15:05:35.079364	You search and find a Energy pistol.	t	0	13
2985	2010-03-11 15:05:35.079364	You search and find nothing.	t	0	13
2986	2010-03-11 15:05:35.079364	You search and find nothing.	t	0	13
3483	2010-03-11 22:58:32.447619	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3484	2010-03-11 22:58:33.874669	You have unequipped your Energy pistol.	t	0	13
3472	2010-03-11 22:39:47.234506	You search and find nothing.	t	0	13
3473	2010-03-11 22:39:47.234506	You search and find nothing.	t	0	13
3474	2010-03-11 22:39:47.234506	You search and find nothing.	t	0	13
3475	2010-03-11 22:39:47.234506	You search and find a Energy pistol.	t	0	13
3476	2010-03-11 22:39:47.234506	You search and find nothing.	t	0	13
3477	2010-03-11 22:39:48.718137	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3478	2010-03-11 22:39:50.143329	You have unequipped your Energy pistol.	t	0	13
3479	2010-03-11 22:57:22.731438	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3480	2010-03-11 22:57:25.507269	You have unequipped your Energy pistol.	t	0	13
3481	2010-03-11 22:58:02.507055	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3482	2010-03-11 22:58:04.370085	You have unequipped your Energy pistol.	t	0	13
3485	2010-03-11 23:00:10.747161	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3486	2010-03-11 23:00:21.644614	You have unequipped your Energy pistol.	t	0	13
3487	2010-03-11 23:04:57.08467	You search and find nothing.	t	0	13
3488	2010-03-11 23:09:04.383082	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
3489	2010-03-11 23:09:09.407417	You have unequipped your Energy pistol.	t	0	13
2097	2010-03-10 13:39:23.720741	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	1
2098	2010-03-10 13:39:24.248755	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	1
2099	2010-03-10 13:39:24.592728	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	1
2100	2010-03-10 13:39:24.996667	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	1
2992	2010-03-11 15:05:37.095324	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2993	2010-03-11 15:05:37.831325	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2994	2010-03-11 15:05:38.475348	You drop your Energy pistol.	t	0	13
2995	2010-03-11 15:05:41.164368	You drop your Energy pistol.	t	0	13
2996	2010-03-11 15:06:11.547023	You drop your Energy pack.	t	0	13
2997	2010-03-11 15:06:19.19542	You search and find nothing.	t	0	13
2998	2010-03-11 15:06:19.19542	You search and find nothing.	t	0	13
2999	2010-03-11 15:06:19.19542	You search and find nothing.	t	0	13
3000	2010-03-11 15:06:19.19542	You search and find nothing.	t	0	13
3001	2010-03-11 15:06:19.19542	You search and find nothing.	t	0	13
3002	2010-03-11 15:06:19.951829	You search and find nothing.	t	0	13
3003	2010-03-11 15:06:19.951829	You search and find nothing.	t	0	13
3004	2010-03-11 15:06:19.951829	You search and find nothing.	t	0	13
3005	2010-03-11 15:06:19.951829	You search and find nothing.	t	0	13
3006	2010-03-11 15:06:19.951829	You search and find nothing.	t	0	13
3007	2010-03-11 15:06:20.337259	You search and find nothing.	t	0	13
3008	2010-03-11 15:06:20.337259	You search and find a Vodka.	t	0	13
3009	2010-03-11 15:06:20.337259	You search and find nothing.	t	0	13
3010	2010-03-11 15:06:20.337259	You search and find nothing.	t	0	13
3011	2010-03-11 15:06:20.337259	You search and find nothing.	t	0	13
3012	2010-03-11 15:06:20.669668	You search and find a Energy pistol.	t	0	13
3013	2010-03-11 15:06:20.669668	You search and find a Energy pack.	t	0	13
3014	2010-03-11 15:06:20.669668	You search and find nothing.	t	0	13
3015	2010-03-11 15:06:20.669668	You search and find a MRE.	t	0	13
3016	2010-03-11 15:06:20.669668	You search and find nothing.	t	0	13
3490	2010-03-11 23:49:46.908226	You search and find nothing.	t	0	2
3491	2010-03-11 23:49:46.908226	You search and find nothing.	t	0	2
3492	2010-03-11 23:49:46.908226	You search and find a Energy pistol.	t	0	2
3493	2010-03-11 23:49:46.908226	You search and find nothing.	t	0	2
3494	2010-03-11 23:49:46.908226	You search and find a Vodka.	t	0	2
2101	2010-03-10 15:54:52.459554	You search and find nothing.	t	0	13
2102	2010-03-10 15:54:52.459554	You search and find nothing.	t	0	13
2103	2010-03-10 15:54:52.459554	You search and find nothing.	t	0	13
2104	2010-03-10 15:54:52.459554	You search and find nothing.	t	0	13
2105	2010-03-10 15:54:52.459554	You search and find a Energy rifle.	t	0	13
2106	2010-03-10 15:54:53.118749	You search and find nothing.	t	0	13
2107	2010-03-10 15:54:53.118749	You search and find nothing.	t	0	13
2108	2010-03-10 15:54:53.118749	You search and find nothing.	t	0	13
2109	2010-03-10 15:54:53.118749	You search and find nothing.	t	0	13
2110	2010-03-10 15:54:53.118749	You search and find nothing.	t	0	13
2111	2010-03-10 15:54:53.758701	You search and find nothing.	t	0	13
2112	2010-03-10 15:54:53.758701	You search and find a Vodka.	t	0	13
2113	2010-03-10 15:54:53.758701	You search and find nothing.	t	0	13
2114	2010-03-10 15:54:53.758701	You search and find a Energy pistol.	t	0	13
2115	2010-03-10 15:54:53.758701	You search and find a Vodka.	t	0	13
2116	2010-03-10 15:54:54.390074	You search and find nothing.	t	0	13
2117	2010-03-10 15:54:54.390074	You search and find nothing.	t	0	13
2118	2010-03-10 15:54:54.390074	You search and find nothing.	t	0	13
2119	2010-03-10 15:54:54.390074	You search and find nothing.	t	0	13
2120	2010-03-10 15:54:54.390074	You search and find nothing.	t	0	13
3495	2010-03-11 23:49:47.390894	You search and find nothing.	t	0	2
3496	2010-03-11 23:49:47.390894	You search and find nothing.	t	0	2
3497	2010-03-11 23:49:47.390894	You search and find nothing.	t	0	2
3498	2010-03-11 23:49:47.390894	You search and find a Vodka.	t	0	2
3499	2010-03-11 23:49:47.390894	You search and find nothing.	t	0	2
3500	2010-03-11 23:49:47.918961	You search and find nothing.	t	0	2
3501	2010-03-11 23:49:47.918961	You search and find nothing.	t	0	2
3502	2010-03-11 23:49:47.918961	You search and find nothing.	t	0	2
3503	2010-03-11 23:49:47.918961	You search and find nothing.	t	0	2
3504	2010-03-11 23:49:47.918961	You search and find nothing.	t	0	2
3505	2010-03-11 23:49:48.437874	You search and find a MRE.	t	0	2
3506	2010-03-11 23:49:48.437874	You search and find nothing.	t	0	2
3520	2010-03-11 23:51:29.574576	You search and find nothing.	t	0	10
3521	2010-03-11 23:51:29.574576	You search and find nothing.	t	0	10
3522	2010-03-11 23:51:29.574576	You search and find nothing.	t	0	10
2121	2010-03-10 15:54:54.998972	You search and find nothing.	t	0	13
2122	2010-03-10 15:54:54.998972	You search and find a MRE.	t	0	13
2123	2010-03-10 15:54:54.998972	You search and find nothing.	t	0	13
2124	2010-03-10 15:54:54.998972	You search and find nothing.	t	0	13
2125	2010-03-10 15:54:54.998972	You search and find nothing.	t	0	13
2126	2010-03-10 15:54:55.565961	You search and find nothing.	t	0	13
2127	2010-03-10 15:54:55.565961	You search and find nothing.	t	0	13
2128	2010-03-10 15:54:55.565961	You search and find nothing.	t	0	13
2129	2010-03-10 15:54:55.565961	You search and find nothing.	t	0	13
2130	2010-03-10 15:54:55.565961	You search and find a MRE.	t	0	13
2131	2010-03-10 15:54:56.120898	You search and find nothing.	t	0	13
2132	2010-03-10 15:54:56.120898	You search and find nothing.	t	0	13
2133	2010-03-10 15:54:56.120898	You search and find a Energy pack.	t	0	13
2134	2010-03-10 15:54:56.120898	You search and find nothing.	t	0	13
2135	2010-03-10 15:54:56.120898	You search and find nothing.	t	0	13
2136	2010-03-10 15:54:57.331363	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2137	2010-03-10 15:54:57.527319	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2138	2010-03-10 15:54:58.095346	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2139	2010-03-10 15:54:58.098575	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3523	2010-03-11 23:51:29.574576	You search and find nothing.	t	0	10
3524	2010-03-11 23:51:29.574576	You search and find a Energy pistol.	t	0	10
3515	2010-03-11 23:51:29.095059	You search and find nothing.	t	0	10
2140	2010-03-10 15:54:59.559708	You search and find nothing.	t	0	13
2141	2010-03-10 15:54:59.559708	You search and find nothing.	t	0	13
2142	2010-03-10 15:54:59.559708	You search and find a Vodka.	t	0	13
2143	2010-03-10 15:54:59.559708	You search and find nothing.	t	0	13
2144	2010-03-10 15:54:59.559708	You search and find nothing.	t	0	13
2155	2010-03-10 15:55:01.078167	You search and find nothing.	t	0	13
2156	2010-03-10 15:55:01.078167	You search and find nothing.	t	0	13
2157	2010-03-10 15:55:01.078167	You search and find nothing.	t	0	13
2158	2010-03-10 15:55:01.078167	You search and find a Energy rifle.	t	0	13
2159	2010-03-10 15:55:01.078167	You search and find a Vodka.	t	0	13
2145	2010-03-10 15:55:00.066128	You search and find nothing.	t	0	13
2146	2010-03-10 15:55:00.066128	You search and find nothing.	t	0	13
2147	2010-03-10 15:55:00.066128	You search and find nothing.	t	0	13
2148	2010-03-10 15:55:00.066128	You search and find nothing.	t	0	13
2149	2010-03-10 15:55:00.066128	You search and find nothing.	t	0	13
2150	2010-03-10 15:55:00.558372	You search and find nothing.	t	0	13
2151	2010-03-10 15:55:00.558372	You search and find a MRE.	t	0	13
2152	2010-03-10 15:55:00.558372	You search and find nothing.	t	0	13
2153	2010-03-10 15:55:00.558372	You search and find nothing.	t	0	13
2154	2010-03-10 15:55:00.558372	You search and find nothing.	t	0	13
2160	2010-03-10 15:55:01.566052	You search and find a Energy rifle.	t	0	13
2161	2010-03-10 15:55:01.566052	You search and find nothing.	t	0	13
2162	2010-03-10 15:55:01.566052	You search and find nothing.	t	0	13
2163	2010-03-10 15:55:01.566052	You search and find nothing.	t	0	13
2164	2010-03-10 15:55:01.566052	You search and find nothing.	t	0	13
3017	2010-03-11 15:06:20.940981	You search and find nothing.	t	0	13
3018	2010-03-11 15:06:20.940981	You search and find nothing.	t	0	13
3019	2010-03-11 15:06:20.940981	You search and find nothing.	t	0	13
3020	2010-03-11 15:06:20.940981	You search and find nothing.	t	0	13
3021	2010-03-11 15:06:20.940981	You search and find nothing.	t	0	13
3022	2010-03-11 15:06:21.103207	You search and find nothing.	t	0	13
3023	2010-03-11 15:06:21.103207	You search and find nothing.	t	0	13
3024	2010-03-11 15:06:21.103207	You search and find nothing.	t	0	13
3025	2010-03-11 15:06:21.103207	You search and find nothing.	t	0	13
3026	2010-03-11 15:06:21.103207	You search and find a Vodka.	t	0	13
3027	2010-03-11 15:06:21.292644	You search and find nothing.	t	0	13
3028	2010-03-11 15:06:21.292644	You search and find nothing.	t	0	13
3029	2010-03-11 15:06:21.292644	You search and find a Energy rifle.	t	0	13
3030	2010-03-11 15:06:21.292644	You search and find nothing.	t	0	13
3031	2010-03-11 15:06:21.292644	You search and find a Vodka.	t	0	13
3516	2010-03-11 23:51:29.095059	You search and find nothing.	t	0	10
3517	2010-03-11 23:51:29.095059	You search and find nothing.	t	0	10
3518	2010-03-11 23:51:29.095059	You search and find nothing.	t	0	10
3519	2010-03-11 23:51:29.095059	You search and find nothing.	t	0	10
3525	2010-03-11 23:51:30.045939	You search and find nothing.	t	0	10
3526	2010-03-11 23:51:30.045939	You search and find nothing.	t	0	10
3527	2010-03-11 23:51:30.045939	You search and find nothing.	t	0	10
3528	2010-03-11 23:51:30.045939	You search and find nothing.	t	0	10
3507	2010-03-11 23:49:48.437874	You search and find a Energy pack.	t	0	2
3508	2010-03-11 23:49:48.437874	You search and find nothing.	t	0	2
3509	2010-03-11 23:49:48.437874	You search and find nothing.	t	0	2
3510	2010-03-11 23:49:49.082261	You search and find nothing.	t	0	2
3511	2010-03-11 23:49:49.082261	You search and find nothing.	t	0	2
3512	2010-03-11 23:49:49.082261	You search and find a Vodka.	t	0	2
3513	2010-03-11 23:49:49.082261	You search and find nothing.	t	0	2
3514	2010-03-11 23:49:49.082261	You search and find nothing.	t	0	2
3529	2010-03-11 23:51:30.045939	You search and find nothing.	t	0	10
2190	2010-03-10 15:55:09.371027	You drop your Energy rifle.	t	0	13
2191	2010-03-10 15:55:10.843367	You drop your Energy pack.	t	0	13
2192	2010-03-10 15:55:13.771387	You drop your Energy rifle.	t	0	13
2193	2010-03-10 15:55:29.323127	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
2194	2010-03-10 15:55:38.539141	You switch your equipped weapon. You will now use your Energy pistol.	t	0	13
2195	2010-03-10 23:01:37.002745	Your wounds are so grevious even breathing causes more damage	t	4	2
2196	2010-03-10 23:01:42.252466	Your wounds are so grevious even breathing causes more damage	t	4	2
2197	2010-03-10 23:01:42.758502	Your wounds are so grevious even breathing causes more damage	t	4	2
2198	2010-03-10 23:01:43.22006	Your wounds are so grevious even breathing causes more damage	t	4	2
2199	2010-03-10 23:01:43.631903	Your wounds are so grevious even breathing causes more damage	t	4	2
2200	2010-03-10 23:01:43.977994	Your wounds are so grevious even breathing causes more damage	t	4	2
2201	2010-03-10 23:01:46.092849	Your wounds are so grevious even breathing causes more damage	t	4	2
2202	2010-03-10 23:01:46.485808	Your wounds are so grevious even breathing causes more damage	t	4	2
2203	2010-03-10 23:01:46.99817	Your wounds are so grevious even breathing causes more damage	t	4	2
2204	2010-03-10 23:05:57.317942	You switch your equipped weapon. You will now use your Energy pistol.	t	0	2
2165	2010-03-10 15:55:02.04578	You search and find nothing.	t	0	13
2166	2010-03-10 15:55:02.04578	You search and find a Energy rifle.	t	0	13
2167	2010-03-10 15:55:02.04578	You search and find nothing.	t	0	13
2168	2010-03-10 15:55:02.04578	You search and find a Energy pistol.	t	0	13
2169	2010-03-10 15:55:02.04578	You search and find nothing.	t	0	13
2170	2010-03-10 15:55:02.549807	You search and find nothing.	t	0	13
2171	2010-03-10 15:55:02.549807	You search and find a Energy pistol.	t	0	13
2172	2010-03-10 15:55:02.549807	You search and find nothing.	t	0	13
2173	2010-03-10 15:55:02.549807	You search and find nothing.	t	0	13
2174	2010-03-10 15:55:02.549807	You search and find a Vodka.	t	0	13
2175	2010-03-10 15:55:03.006569	You search and find nothing.	t	0	13
2176	2010-03-10 15:55:03.006569	You search and find nothing.	t	0	13
2177	2010-03-10 15:55:03.006569	You search and find nothing.	t	0	13
2178	2010-03-10 15:55:03.006569	You search and find nothing.	t	0	13
2179	2010-03-10 15:55:03.006569	You search and find nothing.	t	0	13
2180	2010-03-10 15:55:04.255075	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2181	2010-03-10 15:55:04.431369	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2182	2010-03-10 15:55:04.811531	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2183	2010-03-10 15:55:05.235401	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2184	2010-03-10 15:55:05.891075	You drop your Energy pistol.	t	0	13
2185	2010-03-10 15:55:06.11119	You drop your Energy pistol.	t	0	13
2186	2010-03-10 15:55:06.295366	You drop your Energy pistol.	t	0	13
2187	2010-03-10 15:55:07.963411	You drop your Energy rifle.	t	0	13
2188	2010-03-10 15:55:08.507269	You drop your Energy rifle.	t	0	13
2189	2010-03-10 15:55:08.803326	You drop your Energy rifle.	t	0	13
2205	2010-03-10 23:06:01.785758	You search and find a Vodka.	t	0	2
2206	2010-03-10 23:06:01.785758	You search and find nothing.	t	0	2
2207	2010-03-10 23:06:01.785758	You search and find nothing.	t	0	2
2208	2010-03-10 23:06:01.785758	You search and find nothing.	t	0	2
2209	2010-03-10 23:06:01.785758	You search and find nothing.	t	0	2
2210	2010-03-10 23:06:04.605715	You search and find nothing.	t	0	2
2213	2010-03-10 23:06:09.189542	You search and find nothing.	t	0	2
2211	2010-03-10 23:06:07.134115	You search and find a Energy rifle.	t	0	2
2217	2010-03-10 23:06:12.333592	You search and find nothing.	t	0	2
2212	2010-03-10 23:06:08.205662	You search and find nothing.	t	0	2
2214	2010-03-10 23:06:10.021391	You search and find a Vodka.	t	0	2
2223	2010-03-10 23:06:14.012021	You search and find nothing.	t	0	2
2224	2010-03-10 23:06:14.012021	You search and find nothing.	t	0	2
2225	2010-03-10 23:06:14.012021	You search and find nothing.	t	0	2
2226	2010-03-10 23:06:14.012021	You search and find nothing.	t	0	2
2227	2010-03-10 23:06:14.012021	You search and find nothing.	t	0	2
2218	2010-03-10 23:06:13.118957	You search and find nothing.	t	0	2
2215	2010-03-10 23:06:10.814187	You search and find a Energy pistol.	t	0	2
2219	2010-03-10 23:06:13.118957	You search and find a MRE.	t	0	2
2220	2010-03-10 23:06:13.118957	You search and find a Vodka.	t	0	2
2221	2010-03-10 23:06:13.118957	You search and find nothing.	t	0	2
2222	2010-03-10 23:06:13.118957	You search and find nothing.	t	0	2
2216	2010-03-10 23:06:11.605804	You search and find nothing.	t	0	2
3032	2010-03-11 15:06:21.490707	You search and find nothing.	t	0	13
3033	2010-03-11 15:06:21.490707	You search and find nothing.	t	0	13
3034	2010-03-11 15:06:21.490707	You search and find nothing.	t	0	13
3035	2010-03-11 15:06:21.490707	You search and find nothing.	t	0	13
3036	2010-03-11 15:06:21.490707	You search and find nothing.	t	0	13
3037	2010-03-11 15:06:21.764499	You search and find nothing.	t	0	13
3038	2010-03-11 15:06:21.764499	You search and find nothing.	t	0	13
3039	2010-03-11 15:06:21.764499	You search and find nothing.	t	0	13
3040	2010-03-11 15:06:21.764499	You search and find a MRE.	t	0	13
3041	2010-03-11 15:06:21.764499	You search and find nothing.	t	0	13
3042	2010-03-11 15:06:21.782469	You search and find nothing.	t	0	13
3530	2010-03-11 23:51:30.525827	You search and find a Vodka.	t	0	10
3531	2010-03-11 23:51:30.525827	You search and find a Vodka.	t	0	10
3532	2010-03-11 23:51:30.525827	You search and find nothing.	t	0	10
3533	2010-03-11 23:51:30.525827	You search and find nothing.	t	0	10
3534	2010-03-11 23:51:30.525827	You search and find nothing.	t	0	10
3043	2010-03-11 15:06:21.782469	You search and find nothing.	t	0	13
3044	2010-03-11 15:06:21.782469	You search and find nothing.	t	0	13
3045	2010-03-11 15:06:21.782469	You search and find nothing.	t	0	13
3046	2010-03-11 15:06:21.782469	You search and find nothing.	t	0	13
3543	2010-03-11 23:54:16.486492	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	10
3535	2010-03-11 23:51:31.094564	You search and find nothing.	t	0	10
3536	2010-03-11 23:51:31.094564	You search and find a Vodka.	t	0	10
3537	2010-03-11 23:51:31.094564	You search and find nothing.	t	0	10
3538	2010-03-11 23:51:31.094564	You search and find nothing.	t	0	10
2228	2010-03-10 23:06:14.906558	You search and find nothing.	t	0	2
2229	2010-03-10 23:06:14.906558	You search and find nothing.	t	0	2
2230	2010-03-10 23:06:14.906558	You search and find nothing.	t	0	2
2231	2010-03-10 23:06:14.906558	You search and find nothing.	t	0	2
2232	2010-03-10 23:06:14.906558	You search and find nothing.	t	0	2
2233	2010-03-10 23:06:15.715763	You search and find nothing.	t	0	2
2234	2010-03-10 23:06:15.715763	You search and find nothing.	t	0	2
2235	2010-03-10 23:06:15.715763	You search and find nothing.	t	0	2
2236	2010-03-10 23:06:15.715763	You search and find nothing.	t	0	2
2237	2010-03-10 23:06:15.715763	You search and find nothing.	t	0	2
3539	2010-03-11 23:51:31.094564	You search and find nothing.	t	0	10
3540	2010-03-11 23:54:15.406488	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	10
3541	2010-03-11 23:54:15.764512	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	10
2238	2010-03-10 23:22:20.419597	You search and find a Energy pack.	t	0	13
2239	2010-03-10 23:22:20.419597	You search and find a Vodka.	t	0	13
2240	2010-03-10 23:22:20.419597	You search and find a Vodka.	t	0	13
2241	2010-03-10 23:22:20.419597	You search and find nothing.	t	0	13
2242	2010-03-10 23:22:20.419597	You search and find nothing.	t	0	13
2243	2010-03-10 23:22:20.436676	You search and find nothing.	t	0	13
2244	2010-03-10 23:22:20.436676	You search and find nothing.	t	0	13
2245	2010-03-10 23:22:20.436676	You search and find nothing.	t	0	13
2246	2010-03-10 23:22:20.436676	You search and find nothing.	t	0	13
2247	2010-03-10 23:22:20.436676	You search and find nothing.	t	0	13
2248	2010-03-10 23:22:22.204496	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2249	2010-03-10 23:22:22.344351	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3542	2010-03-11 23:54:16.102446	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	10
3544	2010-03-11 23:54:16.986898	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	10
2255	2010-03-10 23:22:24.28803	You search and find a Vodka.	t	0	13
2256	2010-03-10 23:22:24.28803	You search and find nothing.	t	0	13
2257	2010-03-10 23:22:24.28803	You search and find nothing.	t	0	13
2258	2010-03-10 23:22:24.28803	You search and find nothing.	t	0	13
2259	2010-03-10 23:22:24.28803	You search and find a Vodka.	t	0	13
2260	2010-03-10 23:22:24.469023	You search and find nothing.	t	0	13
2261	2010-03-10 23:22:24.469023	You search and find nothing.	t	0	13
2262	2010-03-10 23:22:24.469023	You search and find nothing.	t	0	13
2263	2010-03-10 23:22:24.469023	You search and find nothing.	t	0	13
2264	2010-03-10 23:22:24.469023	You search and find a Vodka.	t	0	13
2250	2010-03-10 23:22:23.96571	You search and find nothing.	t	0	13
2251	2010-03-10 23:22:23.96571	You search and find nothing.	t	0	13
2252	2010-03-10 23:22:23.96571	You search and find nothing.	t	0	13
2253	2010-03-10 23:22:23.96571	You search and find nothing.	t	0	13
2254	2010-03-10 23:22:23.96571	You search and find a Vodka.	t	0	13
2275	2010-03-10 23:22:25.904706	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2265	2010-03-10 23:22:24.639498	You search and find nothing.	t	0	13
2266	2010-03-10 23:22:24.639498	You search and find nothing.	t	0	13
2267	2010-03-10 23:22:24.639498	You search and find nothing.	t	0	13
2268	2010-03-10 23:22:24.639498	You search and find nothing.	t	0	13
2269	2010-03-10 23:22:24.639498	You search and find nothing.	t	0	13
2270	2010-03-10 23:22:24.828918	You search and find nothing.	t	0	13
2271	2010-03-10 23:22:24.828918	You search and find nothing.	t	0	13
2272	2010-03-10 23:22:24.828918	You search and find nothing.	t	0	13
2273	2010-03-10 23:22:24.828918	You search and find nothing.	t	0	13
3142	2010-03-11 22:21:25.869918	You search and find nothing.	t	0	2
3143	2010-03-11 22:21:25.869918	You search and find nothing.	t	0	2
3144	2010-03-11 22:21:25.869918	You search and find a Energy pistol.	t	0	2
3545	2010-03-11 23:54:19.331063	You drop your Energy rifle.	t	0	10
3145	2010-03-11 22:21:25.869918	You search and find a MRE.	t	0	2
3146	2010-03-11 22:21:25.869918	You search and find nothing.	t	0	2
3147	2010-03-11 22:21:26.37542	You search and find nothing.	t	0	2
3148	2010-03-11 22:21:26.37542	You search and find nothing.	t	0	2
3149	2010-03-11 22:21:26.37542	You search and find nothing.	t	0	2
3150	2010-03-11 22:21:26.37542	You search and find nothing.	t	0	2
3151	2010-03-11 22:21:26.37542	You search and find nothing.	t	0	2
3157	2010-03-11 22:23:47.566418	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
3152	2010-03-11 22:21:26.844448	You search and find a Vodka.	t	0	2
3153	2010-03-11 22:21:26.844448	You search and find nothing.	t	0	2
3154	2010-03-11 22:21:26.844448	You search and find nothing.	t	0	2
3546	2010-03-11 23:54:19.675251	You drop your Energy rifle.	t	0	10
3547	2010-03-11 23:56:58.381944	You search and find a Energy pack.	f	0	10
3548	2010-03-11 23:56:58.381944	You search and find nothing.	f	0	10
3549	2010-03-11 23:56:58.381944	You search and find nothing.	f	0	10
3550	2010-03-11 23:56:58.381944	You search and find nothing.	f	0	10
3551	2010-03-11 23:56:58.381944	You search and find nothing.	f	0	10
3552	2010-03-11 23:56:59.742429	You search and find nothing.	f	0	10
3553	2010-03-11 23:56:59.742429	You search and find nothing.	f	0	10
3554	2010-03-11 23:56:59.742429	You search and find nothing.	f	0	10
3555	2010-03-11 23:56:59.742429	You search and find nothing.	f	0	10
3556	2010-03-11 23:56:59.742429	You search and find nothing.	f	0	10
2274	2010-03-10 23:22:24.828918	You search and find nothing.	t	0	13
2276	2010-03-10 23:22:26.272018	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2277	2010-03-10 23:22:26.439474	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2278	2010-03-10 23:22:26.632674	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3047	2010-03-11 15:06:23.156341	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3048	2010-03-11 15:06:23.489083	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3049	2010-03-11 15:06:24.056352	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
3050	2010-03-11 15:06:24.532571	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3051	2010-03-11 15:06:24.968336	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
3052	2010-03-11 15:06:25.500469	You drop your Energy pistol.	t	0	13
3053	2010-03-11 15:06:25.996152	You drop your Energy pack.	t	0	13
3155	2010-03-11 22:21:26.844448	You search and find nothing.	t	0	2
3156	2010-03-11 22:21:26.844448	You search and find nothing.	t	0	2
3158	2010-03-11 22:23:47.734141	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	2
3159	2010-03-11 22:23:48.13439	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
3160	2010-03-11 22:23:48.523653	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
3161	2010-03-11 22:23:48.887077	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	2
2279	2010-03-10 23:22:28.163979	You search and find nothing.	t	0	13
2280	2010-03-10 23:22:28.163979	You search and find nothing.	t	0	13
2281	2010-03-10 23:22:28.163979	You search and find nothing.	t	0	13
2282	2010-03-10 23:22:28.163979	You search and find nothing.	t	0	13
2283	2010-03-10 23:22:28.163979	You search and find nothing.	t	0	13
2284	2010-03-10 23:22:28.183203	You search and find nothing.	t	0	13
2285	2010-03-10 23:22:28.183203	You search and find nothing.	t	0	13
2286	2010-03-10 23:22:28.183203	You search and find nothing.	t	0	13
2287	2010-03-10 23:22:28.183203	You search and find nothing.	t	0	13
2288	2010-03-10 23:22:28.183203	You search and find nothing.	t	0	13
2289	2010-03-10 23:22:28.3732	You search and find nothing.	t	0	13
2290	2010-03-10 23:22:28.3732	You search and find nothing.	t	0	13
2291	2010-03-10 23:22:28.3732	You search and find nothing.	t	0	13
2292	2010-03-10 23:22:28.3732	You search and find nothing.	t	0	13
2293	2010-03-10 23:22:28.3732	You search and find a Energy pistol.	t	0	13
2294	2010-03-10 23:22:28.541612	You search and find nothing.	t	0	13
2295	2010-03-10 23:22:28.541612	You search and find nothing.	t	0	13
2296	2010-03-10 23:22:28.541612	You search and find nothing.	t	0	13
2297	2010-03-10 23:22:28.541612	You search and find nothing.	t	0	13
2298	2010-03-10 23:22:28.541612	You search and find nothing.	t	0	13
2299	2010-03-10 23:22:28.717396	You search and find nothing.	t	0	13
2300	2010-03-10 23:22:28.717396	You search and find nothing.	t	0	13
2301	2010-03-10 23:22:28.717396	You search and find nothing.	t	0	13
2302	2010-03-10 23:22:28.717396	You search and find nothing.	t	0	13
2303	2010-03-10 23:22:28.717396	You search and find nothing.	t	0	13
3162	2010-03-11 22:29:50.355497	You drop your Energy rifle.	t	0	2
3163	2010-03-11 22:36:26.246529	You drop your Energy rifle.	t	0	13
3164	2010-03-11 22:36:28.474535	You search and find nothing.	t	0	13
3165	2010-03-11 22:36:28.474535	You search and find nothing.	t	0	13
3166	2010-03-11 22:36:28.474535	You search and find nothing.	t	0	13
3167	2010-03-11 22:36:28.474535	You search and find nothing.	t	0	13
3168	2010-03-11 22:36:28.474535	You search and find nothing.	t	0	13
3169	2010-03-11 22:36:28.884153	You search and find nothing.	t	0	13
3170	2010-03-11 22:36:28.884153	You search and find nothing.	t	0	13
3171	2010-03-11 22:36:28.884153	You search and find nothing.	t	0	13
3172	2010-03-11 22:36:28.884153	You search and find nothing.	t	0	13
3173	2010-03-11 22:36:28.884153	You search and find nothing.	t	0	13
3174	2010-03-11 22:36:29.549698	You search and find nothing.	t	0	13
3175	2010-03-11 22:36:29.549698	You search and find nothing.	t	0	13
3176	2010-03-11 22:36:29.549698	You search and find a Vodka.	t	0	13
3177	2010-03-11 22:36:29.549698	You search and find nothing.	t	0	13
3178	2010-03-11 22:36:29.549698	You search and find nothing.	t	0	13
3179	2010-03-11 22:36:29.77362	You search and find a MRE.	t	0	13
3180	2010-03-11 22:36:29.77362	You search and find nothing.	t	0	13
3181	2010-03-11 22:36:29.77362	You search and find nothing.	t	0	13
3182	2010-03-11 22:36:29.77362	You search and find nothing.	t	0	13
3183	2010-03-11 22:36:29.77362	You search and find nothing.	t	0	13
3557	2010-03-11 23:57:48.230811	You drop your Energy pack.	t	0	12
3558	2010-03-11 23:57:48.914429	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
3559	2010-03-11 23:57:49.090614	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
3560	2010-03-11 23:57:49.450348	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
3561	2010-03-11 23:57:50.123378	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	12
3562	2010-03-11 23:57:51.538573	You drop your Energy rifle.	t	0	12
3563	2010-03-11 23:57:52.496056	You have unequipped your Energy rifle.	t	0	12
3564	2010-03-11 23:57:53.775269	You drop your Energy rifle.	t	0	12
3565	2010-03-11 23:57:55.528801	You search and find nothing.	t	0	12
3566	2010-03-11 23:57:55.528801	You search and find a Vodka.	t	0	12
3567	2010-03-11 23:57:55.528801	You search and find nothing.	t	0	12
3568	2010-03-11 23:57:55.528801	You search and find a Energy rifle.	t	0	12
3569	2010-03-11 23:57:55.528801	You search and find nothing.	t	0	12
3570	2010-03-11 23:57:58.13475	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
3571	2010-03-11 23:58:00.375473	You drop your Energy rifle.	t	0	12
3572	2010-03-11 23:58:01.558493	You search and find nothing.	t	0	12
3573	2010-03-11 23:58:01.558493	You search and find a Vodka.	t	0	12
3574	2010-03-11 23:58:01.558493	You search and find nothing.	t	0	12
3575	2010-03-11 23:58:01.558493	You search and find nothing.	t	0	12
3184	2010-03-11 22:36:29.981586	You search and find nothing.	t	0	13
3185	2010-03-11 22:36:29.981586	You search and find nothing.	t	0	13
3186	2010-03-11 22:36:29.981586	You search and find nothing.	t	0	13
3187	2010-03-11 22:36:29.981586	You search and find nothing.	t	0	13
3188	2010-03-11 22:36:29.981586	You search and find nothing.	t	0	13
3189	2010-03-11 22:36:30.189685	You search and find a Vodka.	t	0	13
3190	2010-03-11 22:36:30.189685	You search and find nothing.	t	0	13
3191	2010-03-11 22:36:30.189685	You search and find nothing.	t	0	13
3192	2010-03-11 22:36:30.189685	You search and find nothing.	t	0	13
3193	2010-03-11 22:36:30.189685	You search and find nothing.	t	0	13
3194	2010-03-11 22:36:30.391694	You search and find a Vodka.	t	0	13
3195	2010-03-11 22:36:30.391694	You search and find a Energy pack.	t	0	13
3196	2010-03-11 22:36:30.391694	You search and find a Energy pack.	t	0	13
3197	2010-03-11 22:36:30.391694	You search and find nothing.	t	0	13
3198	2010-03-11 22:36:30.391694	You search and find nothing.	t	0	13
3199	2010-03-11 22:36:30.653273	You search and find nothing.	t	0	13
3200	2010-03-11 22:36:30.653273	You search and find nothing.	t	0	13
3201	2010-03-11 22:36:30.653273	You search and find nothing.	t	0	13
3202	2010-03-11 22:36:30.653273	You search and find nothing.	t	0	13
3203	2010-03-11 22:36:30.653273	You search and find nothing.	t	0	13
3576	2010-03-11 23:58:01.558493	You search and find nothing.	t	0	12
3577	2010-03-11 23:58:03.055371	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
3584	2010-03-11 23:58:10.210325	You drop your Energy rifle.	t	0	12
3585	2010-03-11 23:58:11.272748	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	12
3578	2010-03-11 23:58:03.886504	You search and find a Energy pistol.	t	0	12
3579	2010-03-11 23:58:03.886504	You search and find a Energy rifle.	t	0	12
3580	2010-03-11 23:58:03.886504	You search and find nothing.	t	0	12
3581	2010-03-11 23:58:03.886504	You search and find a Vodka.	t	0	12
3582	2010-03-11 23:58:03.886504	You search and find nothing.	t	0	12
3583	2010-03-11 23:58:09.071447	You switch your equipped weapon. You will now use your Energy pistol.	t	0	12
2304	2010-03-10 23:22:28.884628	You search and find nothing.	t	0	13
2305	2010-03-10 23:22:28.884628	You search and find nothing.	t	0	13
2306	2010-03-10 23:22:28.884628	You search and find nothing.	t	0	13
2307	2010-03-10 23:22:28.884628	You search and find nothing.	t	0	13
2308	2010-03-10 23:22:28.884628	You search and find nothing.	t	0	13
2309	2010-03-10 23:22:29.061	You search and find nothing.	t	0	13
2310	2010-03-10 23:22:29.061	You search and find a MRE.	t	0	13
2311	2010-03-10 23:22:29.061	You search and find nothing.	t	0	13
2312	2010-03-10 23:22:29.061	You search and find nothing.	t	0	13
2313	2010-03-10 23:22:29.061	You search and find nothing.	t	0	13
2314	2010-03-10 23:22:29.223366	You search and find nothing.	t	0	13
2315	2010-03-10 23:22:29.223366	You search and find nothing.	t	0	13
2316	2010-03-10 23:22:29.223366	You search and find a Energy pack.	t	0	13
2317	2010-03-10 23:22:29.223366	You search and find a Energy pistol.	t	0	13
2318	2010-03-10 23:22:29.223366	You search and find nothing.	t	0	13
2319	2010-03-10 23:22:29.74739	You search and find nothing.	t	0	13
2320	2010-03-10 23:22:29.74739	You search and find nothing.	t	0	13
2321	2010-03-10 23:22:29.74739	You search and find a Vodka.	t	0	13
2322	2010-03-10 23:22:29.74739	You search and find a Energy rifle.	t	0	13
2323	2010-03-10 23:22:29.74739	You search and find nothing.	t	0	13
2324	2010-03-10 23:22:29.934521	You search and find a Energy pack.	t	0	13
2325	2010-03-10 23:22:29.934521	You search and find a MRE.	t	0	13
2326	2010-03-10 23:22:29.934521	You search and find a Vodka.	t	0	13
2327	2010-03-10 23:22:29.934521	You search and find a Vodka.	t	0	13
2328	2010-03-10 23:22:29.934521	You search and find a Energy pack.	t	0	13
3204	2010-03-11 22:36:30.807859	You search and find nothing.	t	0	13
3205	2010-03-11 22:36:30.807859	You search and find a Energy pistol.	t	0	13
3206	2010-03-11 22:36:30.807859	You search and find nothing.	t	0	13
3207	2010-03-11 22:36:30.807859	You search and find nothing.	t	0	13
3208	2010-03-11 22:36:30.807859	You search and find nothing.	t	0	13
3209	2010-03-11 22:36:31.023797	You search and find nothing.	t	0	13
3210	2010-03-11 22:36:31.023797	You search and find nothing.	t	0	13
3211	2010-03-11 22:36:31.023797	You search and find nothing.	t	0	13
3212	2010-03-11 22:36:31.023797	You search and find nothing.	t	0	13
3213	2010-03-11 22:36:31.023797	You search and find nothing.	t	0	13
3214	2010-03-11 22:36:31.237099	You search and find nothing.	t	0	13
3215	2010-03-11 22:36:31.237099	You search and find a Energy pack.	t	0	13
3216	2010-03-11 22:36:31.237099	You search and find nothing.	t	0	13
3217	2010-03-11 22:36:31.237099	You search and find nothing.	t	0	13
3218	2010-03-11 22:36:31.237099	You search and find a Energy rifle.	t	0	13
3219	2010-03-11 22:36:31.439748	You search and find nothing.	t	0	13
3220	2010-03-11 22:36:31.439748	You search and find a Vodka.	t	0	13
2329	2010-03-10 23:22:30.324643	You search and find nothing.	t	0	13
2330	2010-03-10 23:22:30.324643	You search and find nothing.	t	0	13
2331	2010-03-10 23:22:30.324643	You search and find nothing.	t	0	13
2332	2010-03-10 23:22:30.324643	You search and find nothing.	t	0	13
2333	2010-03-10 23:22:30.324643	You search and find a Energy pack.	t	0	13
2334	2010-03-10 23:22:30.543628	You search and find a Vodka.	t	0	13
2335	2010-03-10 23:22:30.543628	You search and find nothing.	t	0	13
2336	2010-03-10 23:22:30.543628	You search and find a Energy pack.	t	0	13
2337	2010-03-10 23:22:30.543628	You search and find nothing.	t	0	13
2338	2010-03-10 23:22:30.543628	You search and find nothing.	t	0	13
2339	2010-03-10 23:22:32.105377	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2340	2010-03-10 23:22:33.098532	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2341	2010-03-10 23:22:33.521714	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2342	2010-03-10 23:22:33.945687	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2343	2010-03-10 23:22:34.34166	You open the Vodka and start drinking.  All too soon, it's gone.	t	0	13
2344	2010-03-10 23:22:34.753518	You open the MRE and  start eating.  It tastes horrible, but you must keep your strength up.	t	0	13
2345	2010-03-10 23:22:35.793372	You drop your Energy pack.	t	0	13
2346	2010-03-10 23:22:36.021694	You drop your Energy pack.	t	0	13
2347	2010-03-10 23:22:36.409734	You drop your Energy pack.	t	0	13
2348	2010-03-10 23:22:36.821661	You drop your Energy pack.	t	0	13
2349	2010-03-10 23:22:38.261636	You drop your Energy pistol.	t	0	13
2350	2010-03-10 23:22:53.041758	You drop your Energy rifle.	t	0	13
3221	2010-03-11 22:36:31.439748	You search and find nothing.	t	0	13
3222	2010-03-11 22:36:31.439748	You search and find nothing.	t	0	13
3223	2010-03-11 22:36:31.439748	You search and find nothing.	t	0	13
3586	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	f	4	1
3587	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	f	4	9
3589	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	f	4	10
3591	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	f	4	8
3592	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	f	4	13
3590	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	t	4	12
3234	2010-03-11 22:36:32.063698	You search and find a Energy rifle.	t	0	13
3235	2010-03-11 22:36:32.063698	You search and find nothing.	t	0	13
3236	2010-03-11 22:36:32.063698	You search and find nothing.	t	0	13
3237	2010-03-11 22:36:32.063698	You search and find nothing.	t	0	13
3238	2010-03-11 22:36:32.063698	You search and find nothing.	t	0	13
3239	2010-03-11 22:36:32.255738	You search and find nothing.	t	0	13
3240	2010-03-11 22:36:32.255738	You search and find nothing.	t	0	13
3241	2010-03-11 22:36:32.255738	You search and find nothing.	t	0	13
3242	2010-03-11 22:36:32.255738	You search and find nothing.	t	0	13
3243	2010-03-11 22:36:32.255738	You search and find nothing.	t	0	13
3244	2010-03-11 22:36:32.470819	You search and find nothing.	t	0	13
3245	2010-03-11 22:36:32.470819	You search and find nothing.	t	0	13
3246	2010-03-11 22:36:32.470819	You search and find nothing.	t	0	13
3247	2010-03-11 22:36:32.470819	You search and find nothing.	t	0	13
3248	2010-03-11 22:36:32.470819	You search and find nothing.	t	0	13
3259	2010-03-11 22:36:33.072163	You search and find nothing.	t	0	13
3260	2010-03-11 22:36:33.072163	You search and find nothing.	t	0	13
3261	2010-03-11 22:36:33.072163	You search and find nothing.	t	0	13
3262	2010-03-11 22:36:33.072163	You search and find nothing.	t	0	13
3263	2010-03-11 22:36:33.072163	You search and find nothing.	t	0	13
3249	2010-03-11 22:36:32.656182	You search and find nothing.	t	0	13
3250	2010-03-11 22:36:32.656182	You search and find nothing.	t	0	13
3251	2010-03-11 22:36:32.656182	You search and find a MRE.	t	0	13
3252	2010-03-11 22:36:32.656182	You search and find nothing.	t	0	13
3253	2010-03-11 22:36:32.656182	You search and find a MRE.	t	0	13
3254	2010-03-11 22:36:32.880424	You search and find nothing.	t	0	13
3255	2010-03-11 22:36:32.880424	You search and find nothing.	t	0	13
3256	2010-03-11 22:36:32.880424	You search and find a Energy rifle.	t	0	13
3257	2010-03-11 22:36:32.880424	You search and find nothing.	t	0	13
3258	2010-03-11 22:36:32.880424	You search and find nothing.	t	0	13
3269	2010-03-11 22:36:33.505807	You search and find nothing.	t	0	13
3270	2010-03-11 22:36:33.505807	You search and find a Energy pack.	t	0	13
3271	2010-03-11 22:36:33.505807	You search and find nothing.	t	0	13
3272	2010-03-11 22:36:33.505807	You search and find a Energy pack.	t	0	13
3273	2010-03-11 22:36:33.505807	You search and find nothing.	t	0	13
3264	2010-03-11 22:36:33.289566	You search and find nothing.	t	0	13
3265	2010-03-11 22:36:33.289566	You search and find a Energy pistol.	t	0	13
3266	2010-03-11 22:36:33.289566	You search and find nothing.	t	0	13
3267	2010-03-11 22:36:33.289566	You search and find nothing.	t	0	13
3268	2010-03-11 22:36:33.289566	You search and find nothing.	t	0	13
3274	2010-03-11 22:36:33.690999	You search and find nothing.	t	0	13
3275	2010-03-11 22:36:33.690999	You search and find nothing.	t	0	13
3276	2010-03-11 22:36:33.690999	You search and find nothing.	t	0	13
3277	2010-03-11 22:36:33.690999	You search and find nothing.	t	0	13
3278	2010-03-11 22:36:33.690999	You search and find nothing.	t	0	13
3279	2010-03-11 22:36:33.897932	You search and find a Energy pack.	t	0	13
3280	2010-03-11 22:36:33.897932	You search and find nothing.	t	0	13
3281	2010-03-11 22:36:33.897932	You search and find nothing.	t	0	13
3282	2010-03-11 22:36:33.897932	You search and find nothing.	t	0	13
3283	2010-03-11 22:36:33.897932	You search and find nothing.	t	0	13
3284	2010-03-11 22:36:34.095709	You search and find nothing.	t	0	13
3285	2010-03-11 22:36:34.095709	You search and find nothing.	t	0	13
3286	2010-03-11 22:36:34.095709	You search and find a Energy rifle.	t	0	13
3287	2010-03-11 22:36:34.095709	You search and find nothing.	t	0	13
3288	2010-03-11 22:36:34.095709	You search and find a Energy rifle.	t	0	13
3289	2010-03-11 22:36:34.281869	You search and find a MRE.	t	0	13
3290	2010-03-11 22:36:34.281869	You search and find nothing.	t	0	13
3291	2010-03-11 22:36:34.281869	You search and find nothing.	t	0	13
3292	2010-03-11 22:36:34.281869	You search and find nothing.	t	0	13
3293	2010-03-11 22:36:34.281869	You search and find nothing.	t	0	13
3294	2010-03-11 22:36:34.479716	You search and find nothing.	t	0	13
3295	2010-03-11 22:36:34.479716	You search and find nothing.	t	0	13
3296	2010-03-11 22:36:34.479716	You search and find a MRE.	t	0	13
3297	2010-03-11 22:36:34.479716	You search and find nothing.	t	0	13
3298	2010-03-11 22:36:34.479716	You search and find nothing.	t	0	13
3299	2010-03-11 22:36:34.671734	You search and find nothing.	t	0	13
3300	2010-03-11 22:36:34.671734	You search and find a Energy pack.	t	0	13
3301	2010-03-11 22:36:34.671734	You search and find a Energy pistol.	t	0	13
3302	2010-03-11 22:36:34.671734	You search and find nothing.	t	0	13
3303	2010-03-11 22:36:34.671734	You search and find a Energy rifle.	t	0	13
3304	2010-03-11 22:36:34.87975	You search and find nothing.	t	0	13
3305	2010-03-11 22:36:34.87975	You search and find nothing.	t	0	13
3306	2010-03-11 22:36:34.87975	You search and find a Energy rifle.	t	0	13
3307	2010-03-11 22:36:34.87975	You search and find nothing.	t	0	13
3308	2010-03-11 22:36:34.87975	You search and find nothing.	t	0	13
3309	2010-03-11 22:36:35.130847	You search and find nothing.	t	0	13
3310	2010-03-11 22:36:35.130847	You search and find nothing.	t	0	13
3311	2010-03-11 22:36:35.130847	You search and find nothing.	t	0	13
3312	2010-03-11 22:36:35.130847	You search and find a MRE.	t	0	13
3313	2010-03-11 22:36:35.130847	You search and find nothing.	t	0	13
3314	2010-03-11 22:36:35.308027	You search and find nothing.	t	0	13
3315	2010-03-11 22:36:35.308027	You search and find nothing.	t	0	13
3316	2010-03-11 22:36:35.308027	You search and find nothing.	t	0	13
3317	2010-03-11 22:36:35.308027	You search and find nothing.	t	0	13
3318	2010-03-11 22:36:35.308027	You search and find nothing.	t	0	13
3319	2010-03-11 22:36:35.481497	You search and find nothing.	t	0	13
3320	2010-03-11 22:36:35.481497	You search and find nothing.	t	0	13
3321	2010-03-11 22:36:35.481497	You search and find nothing.	t	0	13
3322	2010-03-11 22:36:35.481497	You search and find a Vodka.	t	0	13
3323	2010-03-11 22:36:35.481497	You search and find nothing.	t	0	13
3324	2010-03-11 22:36:35.676159	You search and find nothing.	t	0	13
3325	2010-03-11 22:36:35.676159	You search and find nothing.	t	0	13
3326	2010-03-11 22:36:35.676159	You search and find nothing.	t	0	13
3327	2010-03-11 22:36:35.676159	You search and find nothing.	t	0	13
3328	2010-03-11 22:36:35.676159	You search and find a Vodka.	t	0	13
3329	2010-03-11 22:36:35.871854	You search and find a Vodka.	t	0	13
3330	2010-03-11 22:36:35.871854	You search and find a Vodka.	t	0	13
3331	2010-03-11 22:36:35.871854	You search and find a Energy pistol.	t	0	13
3332	2010-03-11 22:36:35.871854	You search and find nothing.	t	0	13
3333	2010-03-11 22:36:35.871854	You search and find a Energy pack.	t	0	13
3334	2010-03-11 22:36:36.10397	You search and find a Energy pistol.	t	0	13
3335	2010-03-11 22:36:36.10397	You search and find nothing.	t	0	13
3336	2010-03-11 22:36:36.10397	You search and find a Energy pistol.	t	0	13
3337	2010-03-11 22:36:36.10397	You search and find nothing.	t	0	13
3338	2010-03-11 22:36:36.10397	You search and find nothing.	t	0	13
3339	2010-03-11 22:36:36.269679	You search and find nothing.	t	0	13
3340	2010-03-11 22:36:36.269679	You search and find nothing.	t	0	13
3341	2010-03-11 22:36:36.269679	You search and find a Vodka.	t	0	13
3342	2010-03-11 22:36:36.269679	You search and find nothing.	t	0	13
3343	2010-03-11 22:36:36.269679	You search and find nothing.	t	0	13
3344	2010-03-11 22:36:36.495477	You search and find nothing.	t	0	13
3345	2010-03-11 22:36:36.495477	You search and find nothing.	t	0	13
3346	2010-03-11 22:36:36.495477	You search and find nothing.	t	0	13
3347	2010-03-11 22:36:36.495477	You search and find nothing.	t	0	13
3348	2010-03-11 22:36:36.495477	You search and find nothing.	t	0	13
3349	2010-03-11 22:36:36.705475	You search and find nothing.	t	0	13
3350	2010-03-11 22:36:36.705475	You search and find nothing.	t	0	13
3351	2010-03-11 22:36:36.705475	You search and find nothing.	t	0	13
3352	2010-03-11 22:36:36.705475	You search and find nothing.	t	0	13
3353	2010-03-11 22:36:36.705475	You search and find a Vodka.	t	0	13
3354	2010-03-11 22:36:36.926767	You search and find nothing.	t	0	13
3355	2010-03-11 22:36:36.926767	You search and find nothing.	t	0	13
3356	2010-03-11 22:36:36.926767	You search and find nothing.	t	0	13
3357	2010-03-11 22:36:36.926767	You search and find a MRE.	t	0	13
3358	2010-03-11 22:36:36.926767	You search and find a Energy pack.	t	0	13
3359	2010-03-11 22:36:37.165523	You search and find a Energy pistol.	t	0	13
3360	2010-03-11 22:36:37.165523	You search and find nothing.	t	0	13
3361	2010-03-11 22:36:37.165523	You search and find nothing.	t	0	13
3362	2010-03-11 22:36:37.165523	You search and find nothing.	t	0	13
3363	2010-03-11 22:36:37.165523	You search and find nothing.	t	0	13
3364	2010-03-11 22:36:37.450245	You search and find a Vodka.	t	0	13
3365	2010-03-11 22:36:37.450245	You search and find nothing.	t	0	13
3366	2010-03-11 22:36:37.450245	You search and find nothing.	t	0	13
3367	2010-03-11 22:36:37.450245	You search and find a Energy rifle.	t	0	13
3368	2010-03-11 22:36:37.450245	You search and find a Vodka.	t	0	13
3369	2010-03-11 22:36:37.478144	You search and find nothing.	t	0	13
3370	2010-03-11 22:36:37.478144	You search and find nothing.	t	0	13
3371	2010-03-11 22:36:37.478144	You search and find nothing.	t	0	13
3372	2010-03-11 22:36:37.478144	You search and find nothing.	t	0	13
3373	2010-03-11 22:36:37.478144	You search and find nothing.	t	0	13
3374	2010-03-11 22:36:37.713457	You search and find nothing.	t	0	13
3375	2010-03-11 22:36:37.713457	You search and find nothing.	t	0	13
3376	2010-03-11 22:36:37.713457	You search and find nothing.	t	0	13
3377	2010-03-11 22:36:37.713457	You search and find nothing.	t	0	13
3378	2010-03-11 22:36:37.713457	You search and find nothing.	t	0	13
3379	2010-03-11 22:36:38.095754	You search and find nothing.	t	0	13
3380	2010-03-11 22:36:38.095754	You search and find a Vodka.	t	0	13
3381	2010-03-11 22:36:38.095754	You search and find nothing.	t	0	13
3382	2010-03-11 22:36:38.095754	You search and find a Energy rifle.	t	0	13
3383	2010-03-11 22:36:38.095754	You search and find nothing.	t	0	13
3588	2010-03-12 09:29:43.303891	There will be random smitings as I start to work out attacking, death, respawn, etc.  Don't take it personally.  I hate you all evenly.  <3  Invasion	t	4	2
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY player (username, password, emailaddress, timezone, credits, maxslots, accesslevel) FROM stdin;
Purveyor	43a73eebd3d97a001ea6fc43e518531f244672d3	jchoyt@gmail.com	0	0	2	1
EugeneKay	1da6ed9b4e08042274183f18f8bb2b8aca5ecbd1	eugene@kashpureff.org	0	0	2	1
SamSmart	25af6b1d83b518c69cddf5ed7e66cc122a49fda8	samsmartjr@yahoo.com	0	0	2	1
Gladys	a94a8fe5ccb19ba61c4c0873d391e987982fbbd3	f@f.f	0	0	2	1
asd	da39a3ee5e6b4b0d3255bfef95601890afd80709		0	0	2	1
\.


--
-- Data for Name: playermessages; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY playermessages (charid, messageid) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY roles (rolename) FROM stdin;
Player
Tester
Admin
\.


--
-- Data for Name: searchodds; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY searchodds (locationtype, odds, return) FROM stdin;
2	0.20000000000000001	26
2	0.20000000000000001	27
2	0.20000000000000001	28
2	0.20000000000000001	44
2	0.40000000000000002	37
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY skill (id, name, maxlevel) FROM stdin;
\.


--
-- Data for Name: skillbought; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY skillbought (charid, skillid) FROM stdin;
\.


--
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY station (id, name) FROM stdin;
0	Crescent
-1	Dead
1337	Chaos
\.


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY stats (altid, statid, count) FROM stdin;
8	0	0
8	1	0
8	2	0
8	3	0
8	4	0
8	5	0
8	6	0
8	7	0
8	8	0
8	9	0
8	10	0
8	11	0
9	0	0
9	3	0
9	4	0
9	5	0
9	6	0
9	7	0
9	8	0
9	9	0
9	10	0
9	11	0
2	0	0
2	3	0
2	4	0
2	5	0
2	6	0
2	7	0
2	8	0
2	9	0
2	10	0
2	11	0
10	0	0
10	3	0
10	4	0
10	5	0
10	6	0
10	7	0
10	8	0
10	9	0
10	10	0
10	11	0
12	0	0
12	3	0
12	4	0
12	5	0
12	6	0
12	7	0
12	8	0
12	9	0
12	10	0
12	11	0
13	0	0
13	3	0
13	4	0
13	5	0
13	6	0
13	7	0
13	8	0
13	9	0
13	10	0
13	11	0
1	0	0
1	3	0
1	4	0
1	5	0
1	6	0
1	7	0
1	8	0
1	9	0
1	10	0
1	11	0
10	1	4
10	2	4
12	2	11
12	1	29
2	1	59
2	2	19
9	2	3
9	1	7
1	1	61
1	2	3
13	2	25
13	1	50
\.


--
-- Data for Name: statstype; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY statstype (statid, statname) FROM stdin;
0	Locations Hacked
1	Alcohol Consumed
2	Food Consumed
3	Damage Inflicted
4	Damage Suffered
5	Survival Streak
6	Books Read
7	Items Repaired
8	Items Crafted
9	Murder-Death-Kills
10	Trips to the Mainframe
11	Items Buffed
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY user_roles (username, rolename) FROM stdin;
Purveyor	Player
SamSmart	Player
SamSmart	Admin
SamSmart	Tester
Purveyor	Admin
EugeneKay	Player
EugeneKay	Admin
Gladys	Player
asd	Player
\.


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

