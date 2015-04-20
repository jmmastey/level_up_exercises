--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regions (
    region_id integer NOT NULL,
    country character varying(255),
    state character varying(255),
    city text
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE regions_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_region_id_seq OWNER TO postgres;

--
-- Name: regions_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE regions_region_id_seq OWNED BY regions.region_id;


--
-- Name: region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY regions ALTER COLUMN region_id SET DEFAULT nextval('regions_region_id_seq'::regclass);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY regions (region_id, country, state, city) FROM stdin;
1	USA	Alabama	\N
2	USA	Alaska	\N
3	USA	Arizona	\N
4	USA	Arkansas	\N
5	USA	California	\N
6	USA	Colorado	\N
7	USA	Connecticut	\N
8	USA	Delaware	\N
9	USA	Florida	\N
10	USA	Georgia	\N
11	USA	Hawaii	\N
12	USA	Idaho	\N
14	USA	Indiana	\N
15	USA	Iowa	\N
16	USA	Kansas	\N
17	USA	Kentucky	\N
18	USA	Louisiana	\N
19	USA	Maine	\N
20	USA	Maryland	\N
21	USA	Massachusetts	\N
22	USA	Michigan	\N
23	USA	Minnesota	\N
24	USA	Mississippi	\N
25	USA	Missouri	\N
26	USA	Montana	\N
27	USA	Nebraska	\N
28	USA	Nevada	\N
29	USA	New Hampshire	\N
30	USA	New Jersey	\N
31	USA	New Mexico	\N
32	USA	New York	\N
33	USA	North Carolina	\N
34	USA	North Dakota	\N
35	USA	Ohio	\N
36	USA	Oklahoma	\N
37	USA	Oregon	\N
38	USA	Pennsylvania	\N
39	USA	Rhode Island	\N
40	USA	South Carolina	\N
41	USA	South Dakota	\N
42	USA	Tennessee	\N
43	USA	Texas	\N
44	USA	Utah	\N
45	USA	Vermont	\N
46	USA	Virginia	\N
47	USA	Washington	\N
48	USA	West Virginia	\N
49	USA	Wisconsin	\N
50	USA	Wyoming	\N
13	USA	Illinois	Chicago
\.


--
-- Name: regions_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('regions_region_id_seq', 50, true);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);


--
-- PostgreSQL database dump complete
--

