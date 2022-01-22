--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

-- Started on 2021-12-04 23:25:04 +06

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

DROP DATABASE database_1;
--
-- TOC entry 3889 (class 1262 OID 16396)
-- Name: database_1; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE database_1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


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
-- TOC entry 3890 (class 0 OID 0)
-- Name: database_1; Type: DATABASE PROPERTIES; Schema: -; Owner: -
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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16628)
-- Name: class_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.class_participants (
    id_class integer NOT NULL,
    id_students integer
);


--
-- TOC entry 215 (class 1259 OID 16574)
-- Name: class_time; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.class_time (
    name text,
    "time" text,
    id integer NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16613)
-- Name: class_time_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.class_time_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3891 (class 0 OID 0)
-- Dependencies: 216
-- Name: class_time_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.class_time_id_seq OWNED BY public.class_time.id;


--
-- TOC entry 219 (class 1259 OID 16643)
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16641)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3892 (class 0 OID 0)
-- Dependencies: 218
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 220 (class 1259 OID 16652)
-- Name: groups_students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groups_students (
    id_groups integer NOT NULL,
    id_students integer
);


--
-- TOC entry 204 (class 1259 OID 16433)
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id integer NOT NULL,
    name text NOT NULL,
    username text NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 16431)
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3893 (class 0 OID 0)
-- Dependencies: 203
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- TOC entry 3737 (class 2604 OID 16615)
-- Name: class_time id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_time ALTER COLUMN id SET DEFAULT nextval('public.class_time_id_seq'::regclass);


--
-- TOC entry 3738 (class 2604 OID 16646)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 3736 (class 2604 OID 16436)
-- Name: students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- TOC entry 3880 (class 0 OID 16628)
-- Dependencies: 217
-- Data for Name: class_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 23);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 7);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 12);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 27);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 9);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 18);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 30);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 19);
INSERT INTO public.class_participants (id_class, id_students) VALUES (7, 8);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 5);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 5);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 21);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 24);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 13);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 1);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 17);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 20);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 11);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 23);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 23);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 25);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 8);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 17);
INSERT INTO public.class_participants (id_class, id_students) VALUES (7, 12);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 16);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 13);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 24);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 2);
INSERT INTO public.class_participants (id_class, id_students) VALUES (7, 2);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 5);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 33);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 10);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 25);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 30);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 6);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 18);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 8);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 2);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 12);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 2);
INSERT INTO public.class_participants (id_class, id_students) VALUES (7, 5);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 27);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 33);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 27);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 10);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 13);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 14);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 6);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 20);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 34);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 16);
INSERT INTO public.class_participants (id_class, id_students) VALUES (7, 29);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 32);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 31);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 20);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 33);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 13);
INSERT INTO public.class_participants (id_class, id_students) VALUES (6, 3);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 34);
INSERT INTO public.class_participants (id_class, id_students) VALUES (5, 4);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 18);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 13);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 69);
INSERT INTO public.class_participants (id_class, id_students) VALUES (3, 69);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 70);
INSERT INTO public.class_participants (id_class, id_students) VALUES (2, 70);
INSERT INTO public.class_participants (id_class, id_students) VALUES (1, 72);
INSERT INTO public.class_participants (id_class, id_students) VALUES (4, 72);


--
-- TOC entry 3878 (class 0 OID 16574)
-- Dependencies: 215
-- Data for Name: class_time; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.class_time (name, "time", id) VALUES ('calculus', '13:00, M-W-F', 1);
INSERT INTO public.class_time (name, "time", id) VALUES ('chemistry', '9:00, M-W-F', 2);
INSERT INTO public.class_time (name, "time", id) VALUES ('geometry', '11:30, M-W-F', 3);
INSERT INTO public.class_time (name, "time", id) VALUES ('informatics', '10:00 M-W-F', 4);
INSERT INTO public.class_time (name, "time", id) VALUES ('kazakh literature', '15:30, T-R', 5);
INSERT INTO public.class_time (name, "time", id) VALUES ('physics', '9:00, T-R', 6);
INSERT INTO public.class_time (name, "time", id) VALUES ('biology', '12:30, T-R', 7);


--
-- TOC entry 3882 (class 0 OID 16643)
-- Dependencies: 219
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.groups (id, name) VALUES (1, 'x');
INSERT INTO public.groups (id, name) VALUES (2, 'y');
INSERT INTO public.groups (id, name) VALUES (3, 'z');


--
-- TOC entry 3883 (class 0 OID 16652)
-- Dependencies: 220
-- Data for Name: groups_students; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 1);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 2);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 3);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 4);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 5);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 6);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 7);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 8);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 9);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 10);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 11);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 12);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 13);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 14);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 15);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 16);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 17);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 18);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 19);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 20);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 21);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 22);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 23);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 24);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 25);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 26);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 27);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 28);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 29);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 30);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 31);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 32);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 33);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 34);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 35);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 36);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 37);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 38);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (1, 39);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 40);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 69);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (3, 70);
INSERT INTO public.groups_students (id_groups, id_students) VALUES (2, 72);


--
-- TOC entry 3877 (class 0 OID 16433)
-- Dependencies: 204
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.students (id, name, username) VALUES (1, 'Marat N', 'gstrangeways0');
INSERT INTO public.students (id, name, username) VALUES (2, 'Ikarat T', 'abridat1');
INSERT INTO public.students (id, name, username) VALUES (3, 'Keken', 'astone2');
INSERT INTO public.students (id, name, username) VALUES (4, 'Duran', 'sallen3');
INSERT INTO public.students (id, name, username) VALUES (5, 'Kashiwa', 'jfishpool4');
INSERT INTO public.students (id, name, username) VALUES (6, 'Tokoro', 'gcaslett5');
INSERT INTO public.students (id, name, username) VALUES (7, 'Fergus Swinn', 'mphilip6');
INSERT INTO public.students (id, name, username) VALUES (8, 'Lainey Swafford', 'asitch7');
INSERT INTO public.students (id, name, username) VALUES (9, 'Letti Kimpton', 'tmcsharry8');
INSERT INTO public.students (id, name, username) VALUES (10, 'Stanton Poel', 'mmacgilmartin9');
INSERT INTO public.students (id, name, username) VALUES (11, 'Rollin Davidsohn', 'frawstrona');
INSERT INTO public.students (id, name, username) VALUES (12, 'Estell Parsall', 'bexpositob');
INSERT INTO public.students (id, name, username) VALUES (13, 'Boyd Counihan', 'dshevellc');
INSERT INTO public.students (id, name, username) VALUES (14, 'Jannel Shearston', 'tmackelworthd');
INSERT INTO public.students (id, name, username) VALUES (15, 'Werner Trayford', 'msamplese');
INSERT INTO public.students (id, name, username) VALUES (16, 'Sonny Chrismas', 'tchellenhamf');
INSERT INTO public.students (id, name, username) VALUES (17, 'Angelle Jecks', 'dmccagueg');
INSERT INTO public.students (id, name, username) VALUES (18, 'Ely Wethers', 'tcritophh');
INSERT INTO public.students (id, name, username) VALUES (19, 'Raymund Menear', 'lskiplornei');
INSERT INTO public.students (id, name, username) VALUES (20, 'Roxi McIlmurray', 'candrassyj');
INSERT INTO public.students (id, name, username) VALUES (21, 'Dusty Randell', 'ktumilityk');
INSERT INTO public.students (id, name, username) VALUES (22, 'Kincaid Gierek', 'kmoppettl');
INSERT INTO public.students (id, name, username) VALUES (23, 'Abelard Bursnall', 'cduffetm');
INSERT INTO public.students (id, name, username) VALUES (24, 'Charil Flahy', 'cchampkinn');
INSERT INTO public.students (id, name, username) VALUES (25, 'Osborne Thoma', 'amckuneo');
INSERT INTO public.students (id, name, username) VALUES (26, 'Ekaterina Dukesbury', 'ofullep');
INSERT INTO public.students (id, name, username) VALUES (27, 'Clary Chifney', 'mwatersonq');
INSERT INTO public.students (id, name, username) VALUES (28, 'Roxi Shenton', 'sgardnerr');
INSERT INTO public.students (id, name, username) VALUES (29, 'Alexander Corkitt', 'lpalisers');
INSERT INTO public.students (id, name, username) VALUES (30, 'Amandy Lysaght', 'bmconiet');
INSERT INTO public.students (id, name, username) VALUES (31, 'Hoyt Von Helmholtz', 'fmccrainoru');
INSERT INTO public.students (id, name, username) VALUES (32, 'Sergio Slide', 'lpowersv');
INSERT INTO public.students (id, name, username) VALUES (33, 'Pippa Coulthard', 'ngristockw');
INSERT INTO public.students (id, name, username) VALUES (34, 'Ali Kopecka', 'bmacmaykinx');
INSERT INTO public.students (id, name, username) VALUES (35, 'Carlynne Foxton', 'kpadlyy');
INSERT INTO public.students (id, name, username) VALUES (36, 'Lorelle Rosenfield', 'flichfieldz');
INSERT INTO public.students (id, name, username) VALUES (37, 'shiroi nami', 'shironami0');
INSERT INTO public.students (id, name, username) VALUES (38, 'kokorono tokoro', 'koratora2');
INSERT INTO public.students (id, name, username) VALUES (43, 'l k', 'kirakira');
INSERT INTO public.students (id, name, username) VALUES (45, 'koch moch', 'kochmoch');
INSERT INTO public.students (id, name, username) VALUES (69, 'akira ore', 'kamakira');
INSERT INTO public.students (id, name, username) VALUES (70, 'yagami light', 'kirawakireta');
INSERT INTO public.students (id, name, username) VALUES (72, 'kazuya kirito', 'topasuna');


--
-- TOC entry 3894 (class 0 OID 0)
-- Dependencies: 216
-- Name: class_time_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.class_time_id_seq', 7, true);


--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 218
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.groups_id_seq', 3, true);


--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 203
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.students_id_seq', 73, true);


--
-- TOC entry 3743 (class 2606 OID 16627)
-- Name: class_time class_time_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_time
    ADD CONSTRAINT class_time_pk PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 16651)
-- Name: groups groups_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pk PRIMARY KEY (id);


--
-- TOC entry 3740 (class 2606 OID 16441)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- TOC entry 3741 (class 1259 OID 16600)
-- Name: students_username_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX students_username_uindex ON public.students USING btree (username);


--
-- TOC entry 3746 (class 2606 OID 16631)
-- Name: class_participants class_participants_class_time_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_participants
    ADD CONSTRAINT class_participants_class_time_id_fk FOREIGN KEY (id_class) REFERENCES public.class_time(id) ON DELETE CASCADE;


--
-- TOC entry 3747 (class 2606 OID 16636)
-- Name: class_participants class_participants_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_participants
    ADD CONSTRAINT class_participants_students_id_fk FOREIGN KEY (id_students) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- TOC entry 3748 (class 2606 OID 16655)
-- Name: groups_students groups_students_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups_students
    ADD CONSTRAINT groups_students_groups_id_fk FOREIGN KEY (id_groups) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 3749 (class 2606 OID 16660)
-- Name: groups_students groups_students_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups_students
    ADD CONSTRAINT groups_students_students_id_fk FOREIGN KEY (id_groups) REFERENCES public.students(id) ON DELETE CASCADE;


-- Completed on 2021-12-04 23:25:19 +06

--
-- PostgreSQL database dump complete
--

