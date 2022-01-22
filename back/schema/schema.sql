--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: database_1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE database_1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE database_1 OWNER TO postgres;

\connect database_1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: database_1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE database_1 SET search_path TO 'csci341', 'public';


\connect database_1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: class_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class_time (name, "time", id) FROM stdin;
calculus	13:00, M-W-F	1
chemistry	9:00, M-W-F	2
geometry	11:30, M-W-F	3
informatics	10:00 M-W-F	4
kazakh literature	15:30, T-R	5
physics	9:00, T-R	6
biology	12:30, T-R	7
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, name, username, password) FROM stdin;
1	Marat N	gstrangeways0	\N
2	Ikarat T	abridat1	\N
3	Keken	astone2	\N
4	Duran	sallen3	\N
5	Kashiwa	jfishpool4	\N
6	Tokoro	gcaslett5	\N
7	Fergus Swinn	mphilip6	\N
8	Lainey Swafford	asitch7	\N
9	Letti Kimpton	tmcsharry8	\N
10	Stanton Poel	mmacgilmartin9	\N
11	Rollin Davidsohn	frawstrona	\N
12	Estell Parsall	bexpositob	\N
13	Boyd Counihan	dshevellc	\N
14	Jannel Shearston	tmackelworthd	\N
15	Werner Trayford	msamplese	\N
16	Sonny Chrismas	tchellenhamf	\N
17	Angelle Jecks	dmccagueg	\N
18	Ely Wethers	tcritophh	\N
19	Raymund Menear	lskiplornei	\N
20	Roxi McIlmurray	candrassyj	\N
21	Dusty Randell	ktumilityk	\N
22	Kincaid Gierek	kmoppettl	\N
23	Abelard Bursnall	cduffetm	\N
24	Charil Flahy	cchampkinn	\N
25	Osborne Thoma	amckuneo	\N
26	Ekaterina Dukesbury	ofullep	\N
27	Clary Chifney	mwatersonq	\N
28	Roxi Shenton	sgardnerr	\N
29	Alexander Corkitt	lpalisers	\N
30	Amandy Lysaght	bmconiet	\N
31	Hoyt Von Helmholtz	fmccrainoru	\N
32	Sergio Slide	lpowersv	\N
33	Pippa Coulthard	ngristockw	\N
34	Ali Kopecka	bmacmaykinx	\N
35	Carlynne Foxton	kpadlyy	\N
36	Lorelle Rosenfield	flichfieldz	\N
37	shiroi nami	shironami0	\N
38	kokorono tokoro	koratora2	\N
43	l k	kirakira	\N
45	koch moch	kochmoch	\N
69	akira ore	kamakira	\N
70	yagami light	kirawakireta	\N
72	kazuya kirito	topasuna	\N
74	myke tyson	boxbox	\N
75	mike wazovsky	monster	\N
91	kel thalas	allience	\N
95	hitomi pupil	hitomi	\N
96	anshinshite ku	dasai	\N
97	yoruni ke	kake	\N
102	john doe	johndoe@mail.com	$2a$06$UptPoefQld2m.j7kxa4AYu0JrdNMVDGLGYpnSIhpYJiTFkqr0JPHS
108	omae wa	mou	$2a$14$/k5kWT2Zb64PIJLJZaqYnukpAXI5kvn0pvesZjeK.pdbqEjmvMSlS
110	shiroi nami	shiro	$2a$14$WOrvi6I9gVHr1qRckZkQL.ig04U4fChRWpUmAALR8yuW4LFuNauQm
\.


--
-- Data for Name: class_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class_participants (id_class, id_students) FROM stdin;
4	23
6	7
2	12
2	27
1	9
2	18
3	30
4	19
7	8
5	5
1	5
5	21
5	24
4	13
1	1
5	17
2	20
2	11
1	23
5	23
3	25
3	8
1	17
7	12
1	16
2	13
1	24
2	2
7	2
4	5
4	33
2	10
5	25
6	30
2	6
4	18
6	8
3	2
1	12
6	2
7	5
5	27
5	33
6	27
3	10
5	13
6	14
3	6
4	20
2	34
5	16
7	29
2	32
4	31
3	20
1	33
3	13
6	3
3	34
5	4
3	18
1	13
1	69
3	69
1	70
2	70
1	72
4	72
7	74
5	74
7	75
7	91
4	91
7	95
3	95
6	96
5	97
6	108
3	108
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name) FROM stdin;
1	x
2	y
3	z
\.


--
-- Data for Name: groups_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups_students (id_groups, id_students) FROM stdin;
1	1
1	2
1	3
3	4
2	5
2	6
2	7
3	8
3	9
2	10
1	11
3	12
2	13
1	14
1	15
3	16
3	17
1	18
1	19
2	20
2	21
2	22
2	23
1	24
3	25
2	26
3	27
1	28
1	29
2	30
1	31
2	32
3	33
2	34
2	35
2	36
3	37
1	38
1	39
2	40
2	69
3	70
2	72
3	74
1	75
1	85
2	91
1	95
3	96
2	97
1	98
2	100
3	103
1	104
1	106
1	107
1	108
3	111
3	118
3	119
3	120
1	128
1	129
2	130
\.


--
-- Name: class_time_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.class_time_id_seq', 7, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 3, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 130, true);


--
-- PostgreSQL database dump complete
--
