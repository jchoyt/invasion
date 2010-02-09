--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

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
    speciality integer
);


ALTER TABLE public.alt OWNER TO jchoyt;

--
-- Name: alt_id_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE alt_id_seq
    START WITH 1
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

SELECT pg_catalog.setval('alt_id_seq', 1, false);


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
-- Name: item; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE item (
    itemid integer NOT NULL,
    typeid integer,
    locid integer
);


ALTER TABLE public.item OWNER TO jchoyt;

--
-- Name: item_itemid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE item_itemid_seq
    START WITH 1
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

SELECT pg_catalog.setval('item_itemid_seq', 1, false);


--
-- Name: itemtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE itemtype (
    typeid integer NOT NULL,
    name character varying(255),
    type character varying(50)
);


ALTER TABLE public.itemtype OWNER TO jchoyt;

--
-- Name: itemtype_typeid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE itemtype_typeid_seq
    START WITH 1
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

SELECT pg_catalog.setval('itemtype_typeid_seq', 1, false);


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

SELECT pg_catalog.setval('location_id_seq', 1006841, true);


--
-- Name: locationtype; Type: TABLE; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE TABLE locationtype (
    typeid integer NOT NULL,
    name character varying(50),
    cssname character varying(12)
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
    message text
);


ALTER TABLE public.messages OWNER TO jchoyt;

--
-- Name: messages_messageid_seq; Type: SEQUENCE; Schema: public; Owner: jchoyt
--

CREATE SEQUENCE messages_messageid_seq
    START WITH 1
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

SELECT pg_catalog.setval('messages_messageid_seq', 1, false);


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
-- Data for Name: alt; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY alt (id, name, ap, apmax, ip, cp, hp, hpmax, location, speciality) FROM stdin;
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
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY item (itemid, typeid, locid) FROM stdin;
\.


--
-- Data for Name: itemtype; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY itemtype (typeid, name, type) FROM stdin;
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
1002994	2	0	1	21	17	null	null
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
1006434	2	0	1	37	12	null	null
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
1002512	8	0	1	15	15	North-West Axis	North-West Axis
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
1001888	0	0	1	7	31	\N	\N
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
1002043	2	0	1	9	26	\N	\N
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
1002293	2	0	1	12	36	\N	\N
1002294	2	0	1	12	37	\N	\N
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
1002373	2	0	1	13	36	\N	\N
1002374	2	0	1	13	37	\N	\N
1002375	2	0	1	13	38	\N	\N
1002452	2	0	1	14	35	\N	\N
1002453	2	0	1	14	36	\N	\N
1002454	2	0	1	14	37	\N	\N
1002455	2	0	1	14	38	\N	\N
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
1002189	38	0	1	11	12	null	null
1002429	15	0	1	14	12	null	null
1002765	17	0	1	18	28	The Pirate's Plank	null
1002430	1	0	1	14	13	null	null
1002270	8	0	1	12	13	null	null
1002190	41	0	1	11	13	null	null
1002191	41	0	1	11	14	null	null
1002428	2	0	1	14	11		Security Depot
1002193	21	0	1	11	16	null	null
1002837	16	0	1	19	20	Club Eugene	null
1002272	3	0	1	12	15		
1002908	24	0	1	20	11	Zachary's Xenobiology	null
1002278	17	0	1	12	21	The White Van	null
1002205	12	0	1	11	28	Polychrome's Peace Palace	null
1002199	14	0	1	11	22	Children's Lightbulbs Electronic Emporium	null
1002759	2	0	1	18	22		
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
1003069	2	0	1	22	12	\N	\N
1003070	2	0	1	22	13	\N	\N
1003076	2	0	1	22	19	\N	\N
1003077	2	0	1	22	20	\N	\N
1003083	2	0	1	22	26	\N	\N
1003085	2	0	1	22	28	\N	\N
1003086	2	0	1	22	29	\N	\N
1003087	2	0	1	22	30	\N	\N
1003088	2	0	1	22	31	\N	\N
1003089	2	0	1	22	32	\N	\N
1003090	2	0	1	22	33	\N	\N
1003093	2	0	1	22	36	\N	\N
1003094	2	0	1	22	37	\N	\N
1003095	2	0	1	22	38	\N	\N
1003096	2	0	1	22	39	\N	\N
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
1003724	2	0	1	30	27	\N	\N
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
1003887	2	0	1	32	30		
1002934	14	0	1	20	37	Mir's Corporate Crystals	null
1003649	18	0	1	29	32	The Balance Beam	null
1003487	34	0	1	27	30	Church of the Resurrection	null
1003080	40	0	1	22	23	The Border Clinic	null
1003075	2	0	1	22	18	null	null
1004055	2	0	1	34	38	\N	\N
1004134	2	0	1	35	37	\N	\N
1004135	2	0	1	35	38	\N	\N
1004204	2	0	1	36	27	\N	\N
1004205	2	0	1	36	28	\N	\N
1004207	2	0	1	36	30	\N	\N
1004208	2	0	1	36	31	\N	\N
1004209	2	0	1	36	32	\N	\N
1004213	2	0	1	36	36	\N	\N
1004214	2	0	1	36	37	\N	\N
1004215	2	0	1	36	38	\N	\N
1004283	2	0	1	37	26	\N	\N
1004284	2	0	1	37	27	\N	\N
1004285	2	0	1	37	28	\N	\N
1004286	2	0	1	37	29	\N	\N
1004287	2	0	1	37	30	\N	\N
1004288	2	0	1	37	31	\N	\N
1004290	2	0	1	37	33	\N	\N
1004292	2	0	1	37	35	\N	\N
1004293	2	0	1	37	36	\N	\N
1004294	2	0	1	37	37	\N	\N
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
1006435	2	0	1	36	12	\N	\N
1006436	2	0	1	35	12	\N	\N
1006437	2	0	1	34	12	\N	\N
1006438	2	0	1	31	12	\N	\N
1006439	2	0	1	30	12	\N	\N
1006441	2	0	1	28	12	\N	\N
1006442	2	0	1	27	12	\N	\N
1006443	2	0	1	26	12	\N	\N
1006444	2	0	1	38	13	\N	\N
1006445	2	0	1	37	13	\N	\N
1006446	2	0	1	36	13	\N	\N
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
1006467	2	0	1	37	15	\N	\N
1006476	2	0	1	38	16	\N	\N
1006479	2	0	1	32	16	\N	\N
1006480	2	0	1	31	16	\N	\N
1006481	2	0	1	30	16	\N	\N
1006482	2	0	1	29	16	\N	\N
1006483	2	0	1	28	16	\N	\N
1006486	2	0	1	36	17	\N	\N
1006489	2	0	1	33	17	\N	\N
1006491	2	0	1	31	17	\N	\N
1006492	2	0	1	30	17	\N	\N
1006496	2	0	1	26	17	\N	\N
1006497	2	0	1	37	18	\N	\N
1006498	2	0	1	36	18	\N	\N
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
1006514	2	0	1	32	19	\N	\N
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
1006553	2	0	1	39	22	\N	\N
1006554	2	0	1	38	22	\N	\N
1006555	2	0	1	37	22	\N	\N
1006556	2	0	1	36	22	\N	\N
1002273	21	0	1	12	16	null	null
1002431	1	0	1	14	14	null	null
1006494	2	0	1	28	17	null	null
1006539	14	0	1	37	21	March Credit Company	null
1006495	2	0	1	27	17	null	null
1006485	2	0	1	26	16	null	null
1006516	13	0	1	29	19	Masumi Gardens	null
1004203	48	0	1	36	26	Black Goat BBQ	null
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
1003733	2	0	1	30	36	null	null
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
1003170	2	0	1	23	33	null	null
1002025	0	0	1	9	8	Observation Deck	Observation Deck
1002364	2	0	1	13	27		
1003153	2	0	1	23	16	null	null
1006484	2	0	1	27	16	null	null
1002026	0	0	1	9	9		
1002106	0	0	1	10	9		
1006505	2	0	1	28	18	null	null
1002687	2	0	1	17	30		
1002939	0	0	1	20	42	null	null
1003897	0	0	1	32	40	null	null
1003977	0	0	1	33	40	null	null
1002925	2	0	1	20	28		
1003575	16	0	1	28	38	The Merry Men	null
1002188	2	0	1	11	11		
1002350	8	0	1	13	13	null	null
1004365	2	0	1	38	28		
1006560	17	0	1	32	22	Rock the Barhah	
1006552	16	0	1	40	22	The Oubliette	
1006431	51	0	1	27	11	Channel 4	null
1002349	15	0	1	13	12	null	null
1002269	38	0	1	12	12	null	null
1002271	32	0	1	12	14	null	null
1002351	36	0	1	13	14	null	null
1002192	3	0	1	11	15		
1003066	7	0	1	22	9	Rachel's Roses	null
1002600	2	0	1	16	23		
1002916	34	0	1	20	19	Convento das Althèna	Convento das Althèna
1002995	46	0	1	21	18	Dunnell Station	Dunnell Station
1002597	48	0	1	16	20	Heart of Oak	Heart of Oak
\.


--
-- Data for Name: locationtype; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY locationtype (typeid, name, cssname) FROM stdin;
0	Deep Space	space
1	Medbay	medbay
2	Living Quarters	living
3	Security Outpost	security
4	Corridor	corridor
6	Warehouse	warehs
8	Command Center	cmd
9	Elevator	elev
10	Airlock	airlk
11	Shuttle Bay	shutbay
12	Mall	mall
14	Commercial District	commer
15	Armory	armory
16	Nightclub	nc
17	Bar	bar
18	Gymnasium	gym
21	Brig	brig
23	Locker room	delete
24	Biology Lab	biolab
25	Physics lab	phylab
26	Astronomy Lab	astrlab
27	Psionic Lab	psilab
28	Geology lab	geolab
29	Robotics lab	roblab
30	Fenetics lab	genlab
31	Cryogenics lab	cryolab
32	Generator Room	generator
33	Observation Deck	observdk
35	Arena	arena
36	Life Support	lifespt
22	Solar Panels	delete
37	Education Center	edu
34	Worhship Facility	church
38	Damage Control	damage
39	Supply Depot	supply
40	Infirmary	infirm
41	Waste Processing Center	waste
42	Information Distribution	lib
43	Grocery Depot	grocery
44	Vocational Training Center	votech
45	Power Distribution	power
7	Hydroponics Bay	greenhs
5	Manufacturing Area	manu
19	Meditation Commune	medrm
13	Nature Park	park
20	Arcade	recrm
46	Security Depot	secdep
47	Amusement Park	coaster
48	Commercial Food Dispensary	food
49	Slums	slum
50	Manor Quarters	manor
51	Infotainment Theater	theatre
52	Office Space	office
53	Raw Processing Facility	raw
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY messages (messageid, messagedate, message) FROM stdin;
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: jchoyt
--

COPY player (username, password, emailaddress, timezone, credits, maxslots, accesslevel) FROM stdin;
Purveyor	43a73eebd3d97a001ea6fc43e518531f244672d3	jchoyt@gmail.com	0	0	2	1
SamSmart	eadd6e6423e34707f921268ad7c89b893409cef5	samsmartjr@yahoo.com	0	0	2	1
EugeneKay	1da6ed9b4e08042274183f18f8bb2b8aca5ecbd1	eugene@kashpureff.org	0	0	2	1
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
-- Name: user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jchoyt; Tablespace: 
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (username, rolename);


--
-- Name: locxy; Type: INDEX; Schema: public; Owner: jchoyt; Tablespace: 
--

CREATE INDEX locxy ON location USING btree (x, y);


--
-- Name: enable_player; Type: RULE; Schema: public; Owner: jchoyt
--

CREATE RULE enable_player AS ON INSERT TO player DO INSERT INTO user_roles (username, rolename) VALUES (new.username, 'Player'::character varying);


--
-- Name: alt_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jchoyt
--

ALTER TABLE ONLY alt
    ADD CONSTRAINT alt_location_fkey FOREIGN KEY (location) REFERENCES location(id);


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

