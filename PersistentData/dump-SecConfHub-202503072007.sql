--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2025-03-07 20:07:05

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
-- TOC entry 5 (class 2615 OID 203329)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 867 (class 1247 OID 203375)
-- Name: gender_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender_enum AS ENUM (
    'мужской',
    'женский'
);


ALTER TYPE public.gender_enum OWNER TO postgres;

--
-- TOC entry 870 (class 1247 OID 203380)
-- Name: role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role_enum AS ENUM (
    'moderator',
    'jury',
    'organizer',
    'member'
);


ALTER TYPE public.role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 203456)
-- Name: activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity (
    id integer NOT NULL,
    event_id integer NOT NULL,
    winner_id integer,
    days integer DEFAULT 1 NOT NULL,
    CONSTRAINT days_check CHECK ((days > 0))
);


ALTER TABLE public.activity OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 203475)
-- Name: activity_day; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_day (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    day_num integer DEFAULT 1 NOT NULL,
    start_time time without time zone NOT NULL,
    moderator_id integer,
    activity_id integer NOT NULL,
    CONSTRAINT day_num_check CHECK ((day_num > 0))
);


ALTER TABLE public.activity_day OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 203474)
-- Name: activity_day_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_day_id_seq OWNER TO postgres;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 230
-- Name: activity_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_day_id_seq OWNED BY public.activity_day.id;


--
-- TOC entry 232 (class 1259 OID 203488)
-- Name: activity_day_jouriors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_day_jouriors (
    activity_day_id integer NOT NULL,
    jury_id integer NOT NULL
);


ALTER TABLE public.activity_day_jouriors OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 203357)
-- Name: activity_directions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_directions (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.activity_directions OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 203356)
-- Name: activity_directions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_directions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_directions_id_seq OWNER TO postgres;

--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 218
-- Name: activity_directions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_directions_id_seq OWNED BY public.activity_directions.id;


--
-- TOC entry 228 (class 1259 OID 203455)
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_id_seq OWNER TO postgres;

--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 228
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_id_seq OWNED BY public.activity.id;


--
-- TOC entry 215 (class 1259 OID 203331)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    photo_path character varying(500)
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 203330)
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_id_seq OWNER TO postgres;

--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 214
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- TOC entry 217 (class 1259 OID 203342)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    uniform_name character varying(150) NOT NULL,
    code character varying(2) NOT NULL,
    num_code integer NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 203341)
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO postgres;

--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 216
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- TOC entry 227 (class 1259 OID 203440)
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id integer NOT NULL,
    title text NOT NULL,
    start_date date NOT NULL,
    days integer DEFAULT 1 NOT NULL,
    city_id integer NOT NULL,
    photo_path character varying,
    event_type_id integer,
    CONSTRAINT days_check CHECK ((days > 0))
);


ALTER TABLE public.event OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 203439)
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 226
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;


--
-- TOC entry 221 (class 1259 OID 203366)
-- Name: event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.event_types OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 203365)
-- Name: event_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_types_id_seq OWNER TO postgres;

--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 220
-- Name: event_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_types_id_seq OWNED BY public.event_types.id;


--
-- TOC entry 225 (class 1259 OID 203424)
-- Name: jury; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jury (
    user_id integer NOT NULL,
    activity_direction_id integer
);


ALTER TABLE public.jury OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 203404)
-- Name: moderator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moderator (
    user_id integer NOT NULL,
    activity_direction_id integer,
    event_type_id integer
);


ALTER TABLE public.moderator OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 203390)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    gender public.gender_enum NOT NULL,
    birth date NOT NULL,
    country_id integer,
    phone text NOT NULL,
    pass character varying NOT NULL,
    photo_path character varying,
    role_discriminator public.role_enum,
    email text,
    CONSTRAINT user_email_check CHECK ((email ~~ '%@%._%'::text))
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 203389)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 222
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 3233 (class 2604 OID 203459)
-- Name: activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity ALTER COLUMN id SET DEFAULT nextval('public.activity_id_seq'::regclass);


--
-- TOC entry 3235 (class 2604 OID 203478)
-- Name: activity_day id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day ALTER COLUMN id SET DEFAULT nextval('public.activity_day_id_seq'::regclass);


--
-- TOC entry 3228 (class 2604 OID 203360)
-- Name: activity_directions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_directions ALTER COLUMN id SET DEFAULT nextval('public.activity_directions_id_seq'::regclass);


--
-- TOC entry 3226 (class 2604 OID 203334)
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- TOC entry 3227 (class 2604 OID 203345)
-- Name: country id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- TOC entry 3231 (class 2604 OID 203443)
-- Name: event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 203369)
-- Name: event_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_types ALTER COLUMN id SET DEFAULT nextval('public.event_types_id_seq'::regclass);


--
-- TOC entry 3230 (class 2604 OID 203393)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3450 (class 0 OID 203456)
-- Dependencies: 229
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity (id, event_id, winner_id, days) FROM stdin;
1	2	45	2
2	5	47	2
3	6	49	3
4	7	51	2
5	8	52	3
6	12	53	2
7	15	54	2
8	17	57	1
9	20	59	3
10	20	61	3
11	12	\N	1
12	13	\N	1
13	14	\N	1
14	15	\N	1
15	16	\N	1
16	17	\N	1
17	18	\N	1
18	19	\N	1
19	20	\N	1
20	21	\N	1
\.


--
-- TOC entry 3452 (class 0 OID 203475)
-- Dependencies: 231
-- Data for Name: activity_day; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_day (id, title, day_num, start_time, moderator_id, activity_id) FROM stdin;
1	ТОП 50	1	09:00:00	14	1
2	Перспективные направления IT	2	10:45:00	15	1
3	Современные технологии	2	12:30:00	16	1
4	Что такое IOT?	1	09:00:00	17	2
5	Для чего это нужно?	2	10:45:00	18	2
6	Новые продукты и версии	2	12:30:00	19	2
7	Как составить план?	1	09:00:00	20	3
8	Что такое план?	2	10:45:00	21	3
9	Must Have 21 века	2	12:30:00	22	3
10	Управление знаниями	1	09:00:00	23	4
11	Коммуникативные неудачи	1	10:45:00	24	4
12	Дизайн-мышление	2	12:30:00	25	4
13	Технические собеседования	1	09:00:00	26	5
14	Исследование рынка	2	10:45:00	27	5
15	Подготовка специалистов	3	12:30:00	28	5
16	Секреты успеха	1	09:00:00	29	6
17	Способы поиска специалистов	1	10:45:00	30	6
18	Что нужно пользователям?	1	12:30:00	31	6
19	Осознанность личных целей	1	09:00:00	32	7
20	Soft skills	1	10:45:00	34	7
21	Развитие проактивности	2	12:30:00	34	7
22	Введение в IT-субкультуру	1	09:00:00	15	8
23	Основы ООП	1	10:45:00	16	8
24	Что нужно знать начинающему спецалисту	1	16:00:00	17	8
25	Идельный результат	1	09:00:00	21	9
26	Тайны и секреты	2	10:45:00	22	9
27	Какрой язык программирования выбрать?	2	12:30:00	23	9
28	Войти в ТОП	1	09:00:00	24	10
29	Секреты продвижения	1	10:45:00	25	10
30	Руководство проектами	2	12:30:00	26	10
\.


--
-- TOC entry 3453 (class 0 OID 203488)
-- Dependencies: 232
-- Data for Name: activity_day_jouriors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_day_jouriors (activity_day_id, jury_id) FROM stdin;
1	11
1	10
1	9
2	9
2	8
2	6
3	11
3	12
3	7
4	13
4	6
4	11
5	6
5	12
5	10
6	8
6	5
6	4
7	13
7	11
7	12
8	10
8	9
8	13
9	7
9	11
9	12
10	11
10	7
10	10
11	4
11	9
11	13
12	7
12	10
12	8
13	9
13	13
13	10
14	12
14	6
14	11
15	5
15	6
15	12
16	5
16	9
16	10
17	8
17	6
17	9
18	13
18	8
18	12
19	11
19	8
19	7
20	9
20	13
20	6
21	12
21	9
21	6
22	6
22	8
22	7
23	6
23	5
23	7
24	5
24	10
24	6
25	5
25	6
25	9
26	8
26	10
26	11
27	5
27	10
27	6
28	12
28	8
28	9
29	12
29	11
29	6
30	12
30	9
30	5
\.


--
-- TOC entry 3440 (class 0 OID 203357)
-- Dependencies: 219
-- Data for Name: activity_directions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_directions (id, name) FROM stdin;
1	Информационная безопасность
2	Биг Дата
3	ИТ
4	Дизайн
5	Аналитика
\.


--
-- TOC entry 3436 (class 0 OID 203331)
-- Dependencies: 215
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, name, photo_path) FROM stdin;
297	Абаза	\N
298	Абакан	\N
299	Абдулино	\N
300	Агидель	\N
301	Агрыз	\N
302	Азнакаево	\N
303	Азов	\N
304	Ак-Довурак	\N
305	Аксай	\N
306	Алагир	\N
307	Алапаевск	\N
308	Алатырь	\N
309	Алдан	\N
310	Алейск	\N
311	Александров	\N
312	Александровск	\N
313	Александровск-Сахалинский	\N
314	Алексеевка	\N
315	Алексин	\N
316	Алзамай	\N
317	Алупкане призн.	\N
318	Алуштане призн.	\N
319	Альметьевск	\N
320	Амурск	\N
321	Анадырь	\N
322	Анапа	\N
323	Ангарск	\N
324	Андреаполь	\N
325	Анжеро-Судженск	\N
326	Апатиты	\N
327	Апрелевка	\N
328	Апшеронск	\N
329	Арамиль	\N
330	Ардатов	\N
331	Ардон	\N
332	Арзамас	\N
333	Аркадак	\N
334	Армянскне призн.	\N
335	Арсеньев	\N
336	Арск	\N
337	Артём	\N
338	Артёмовск	\N
339	Артёмовский	\N
340	Архангельск	\N
341	Асбест	\N
342	Асино	\N
343	Астрахань	\N
344	Аткарск	\N
345	Ахтубинск	\N
346	Ачинск	\N
347	Аша	\N
348	Бабаево	\N
349	Бавлы	\N
350	Багратионовск	\N
351	Байкальск	\N
352	Баймак	\N
353	Бакал	\N
354	Балабаново	\N
355	Балаково	\N
356	Балахна	\N
357	Балашиха	\N
358	Балашов	\N
359	Балей	\N
360	Балтийск	\N
361	Барабинск	\N
362	Барнаул	\N
363	Барыш	\N
364	Батайск	\N
365	Бахчисарайне призн.	\N
366	Бежецк	\N
367	Белая Калитва	\N
368	Белая Холуница	\N
369	Белгород	\N
370	Белебей	\N
371	Белёв	\N
372	Белинский	\N
373	Белово	\N
374	Белогорскне призн.	\N
375	Белозерск	\N
376	Белокуриха	\N
377	Беломорск	\N
378	Белоозёрский	\N
379	Белорецк	\N
380	Белореченск	\N
381	Белоусово	\N
382	Белоярский	\N
383	Белый	\N
384	Березники	\N
385	Берёзовский	\N
386	Бийск	\N
387	Бикин	\N
388	Билибино	\N
389	Биробиджан	\N
390	Бирск	\N
391	Бирюсинск	\N
392	Благовещенск	\N
393	Благодарный	\N
394	Бобров	\N
395	Богданович	\N
396	Богородицк	\N
397	Богородск	\N
398	Боготол	\N
399	Богучар	\N
400	Бодайбо	\N
401	Бокситогорск	\N
402	Бологое	\N
403	Болотное	\N
404	Болохово	\N
405	Болхов	\N
406	Большой Камень	\N
407	Бор	\N
408	Борзя	\N
409	Борисоглебск	\N
410	Боровичи	\N
411	Боровск	\N
412	Бородино	\N
413	Братск	\N
414	Бронницы	\N
415	Брянск	\N
416	Бугульма	\N
417	Бугуруслан	\N
418	Бузулук	\N
419	Буинск	\N
420	Буй	\N
421	Буйнакск	\N
422	Бутурлиновка	\N
423	Валдай	\N
424	Валуйки	\N
425	Велиж	\N
426	Великие Луки	\N
427	Великий Новгород	\N
428	Великий Устюг	\N
429	Вельск	\N
430	Венёв	\N
431	Верея	\N
432	Верхний Тагил	\N
433	Верхний Уфалей	\N
434	Верхняя Салда	\N
435	Верхняя Тура	\N
436	Верхотурье	\N
437	Верхоянск	\N
438	Весьегонск	\N
439	Ветлуга	\N
440	Видное	\N
441	Вилюйск	\N
442	Вихоревка	\N
443	Вичуга	\N
444	Владивосток	\N
445	Владимир	\N
446	Волгодонск	\N
447	Волгореченск	\N
448	Волжск	\N
449	Волжский	\N
450	Вологда	\N
451	Волоколамск	\N
452	Волосово	\N
453	Волчанск	\N
454	Вольск	\N
455	Воркута	\N
456	Воронеж	\N
457	Ворсма	\N
458	Воскресенск	\N
459	Воткинск	\N
460	Всеволожск	\N
461	Вуктыл	\N
462	Выборг	\N
463	Выкса	\N
464	Высоковск	\N
465	Вытегра	\N
466	Вышний Волочёк	\N
467	Вяземский	\N
468	Вязники	\N
469	Вязьма	\N
470	Вятские Поляны	\N
471	Гаврилов Посад	\N
472	Гаврилов-Ям	\N
473	Гагарин	\N
474	Гай	\N
475	Галич	\N
476	Гвардейск	\N
477	Гдов	\N
478	Геленджик	\N
479	Георгиевск	\N
480	Глазов	\N
481	Голицыно	\N
482	Горбатов	\N
483	Горнозаводск	\N
484	Горняк	\N
485	Городец	\N
486	Городище	\N
487	Городовиковск	\N
488	Гороховец	\N
489	Горячий Ключ	\N
490	Грайворон	\N
491	Гремячинск	\N
492	Грозный	\N
493	Грязи	\N
494	Грязовец	\N
495	Губаха	\N
496	Губкин	\N
497	Губкинский	\N
498	Гудермес	\N
499	Гуково	\N
500	Гулькевичи	\N
501	Гурьевск	\N
502	Гусиноозёрск	\N
503	Давлеканово	\N
504	Дагестанские Огни	\N
505	Дальнегорск	\N
506	Дальнереченск	\N
507	Данилов	\N
508	Данков	\N
509	Дегтярск	\N
510	Дедовск	\N
511	Демидов	\N
512	Дербент	\N
513	Десногорск	\N
514	Джанкойне призн.	\N
515	Дзержинский	\N
516	Дивногорск	\N
517	Дигора	\N
518	Димитровград	\N
519	Дмитриев	\N
520	Дмитров	\N
521	Дно	\N
522	Добрянка	\N
523	Долгопрудный	\N
524	Домодедово	\N
525	Дорогобуж	\N
526	Дрезна	\N
527	Дубна	\N
528	Дубовка	\N
529	Дудинка	\N
530	Духовщина	\N
531	Дюртюли	\N
532	Дятьково	\N
533	Евпаторияне призн.	\N
534	Егорьевск	\N
535	Ейск	\N
536	Екатеринбург	\N
537	Елабуга	\N
538	Елец	\N
539	Ельня	\N
540	Еманжелинск	\N
541	Енисейск	\N
542	Ермолино	\N
543	Ершов	\N
544	Ессентуки	\N
545	Ефремов	\N
546	Железноводск	\N
547	Железногорск	\N
548	Жердевка	\N
549	Жигулёвск	\N
550	Жиздра	\N
551	Жуковка	\N
552	Жуковский	\N
553	Завитинск	\N
554	Заволжье	\N
555	Задонск	\N
556	Заинск	\N
557	Заозёрный	\N
558	Западная Двина	\N
559	Заполярный	\N
560	Зарайск	\N
561	Заречный	\N
562	Заринск	\N
563	Звенигово	\N
564	Звенигород	\N
565	Зверево	\N
566	Зеленогорск	\N
567	Зеленоградск	\N
568	Зерноград	\N
569	Зима	\N
570	Златоуст	\N
571	Злынка	\N
572	Змеиногорск	\N
573	Знаменск	\N
574	Зубцов	\N
575	Зуевка	\N
576	Ивангород	\N
577	Иваново	\N
578	Ивантеевка	\N
579	Ивдель	\N
580	Игарка	\N
581	Избербаш	\N
582	Иланский	\N
583	Инза	\N
584	Иннополис	\N
585	Инсар	\N
586	Инта	\N
587	Ирбит	\N
588	Иркутск	\N
589	Исилькуль	\N
590	Искитим	\N
591	Ишим	\N
592	Ишимбай	\N
593	Кадников	\N
594	Казань	\N
595	Калач	\N
596	Калач-на-Дону	\N
597	Калачинск	\N
598	Калининск	\N
599	Калтан	\N
600	Калуга	\N
601	Калязин	\N
602	Камбарка	\N
603	Каменка	\N
604	Каменногорск	\N
605	Камень-на-Оби	\N
606	Камешково	\N
607	Камызяк	\N
608	Камышин	\N
609	Камышлов	\N
610	Канаш	\N
611	Кандалакша	\N
612	Канск	\N
613	Карабаново	\N
614	Карабаш	\N
615	Карабулак	\N
616	Карасук	\N
617	Карачев	\N
618	Каргат	\N
619	Каргополь	\N
620	Карталы	\N
621	Касли	\N
622	Каспийск	\N
623	Катав-Ивановск	\N
624	Катайск	\N
625	Качканар	\N
626	Кашин	\N
627	Кашира	\N
628	Кедровый	\N
629	Кемь	\N
630	Керчьне призн.	\N
631	Кизел	\N
632	Кизилюрт	\N
633	Кизляр	\N
634	Кимовск	\N
635	Кимры	\N
636	Кинель	\N
637	Кинешма	\N
638	Киреевск	\N
639	Киренск	\N
640	Киржач	\N
641	Кириллов	\N
642	Кириши	\N
643	Киров	\N
644	Кировград	\N
645	Кировск	\N
646	Кирс	\N
647	Кирсанов	\N
648	Киселёвск	\N
649	Кисловодск	\N
650	Клин	\N
651	Клинцы	\N
652	Княгинино	\N
653	Ковдор	\N
654	Ковров	\N
655	Ковылкино	\N
656	Когалым	\N
657	Кодинск	\N
658	Козельск	\N
659	Козловка	\N
660	Козьмодемьянск	\N
661	Кола	\N
662	Кологрив	\N
663	Коломна	\N
664	Колпашево	\N
665	Кольчугино	\N
666	Коммунар	\N
667	Комсомольск	\N
668	Комсомольск-на-Амуре	\N
669	Конаково	\N
670	Кондопога	\N
671	Кондрово	\N
672	Копейск	\N
673	Кораблино	\N
674	Кореновск	\N
675	Коркино	\N
676	Короча	\N
677	Коряжма	\N
678	Костерёво	\N
679	Костомукша	\N
680	Кострома	\N
681	Котельники	\N
682	Котельнич	\N
683	Котлас	\N
684	Котово	\N
685	Кохма	\N
686	Красавино	\N
687	Красновишерск	\N
688	Красногорск	\N
689	Краснодар	\N
690	Краснознаменск	\N
691	Краснокаменск	\N
692	Краснокамск	\N
693	Красноперекопскне призн.	\N
694	Краснослободск	\N
695	Краснотурьинск	\N
696	Красноуфимск	\N
697	Красный Кут	\N
698	Красный Сулин	\N
699	Красный Холм	\N
700	Кремёнки	\N
701	Кропоткин	\N
702	Крымск	\N
703	Кстово	\N
704	Кубинка	\N
705	Кувандык	\N
706	Кувшиново	\N
707	Кудрово	\N
708	Кудымкар	\N
709	Кузнецк	\N
710	Куйбышев	\N
711	Кукмор	\N
712	Кулебаки	\N
713	Кумертау	\N
714	Кунгур	\N
715	Купино	\N
716	Курганинск	\N
717	Курильск	\N
718	Курлово	\N
719	Куровское	\N
720	Курск	\N
721	Куртамыш	\N
722	Курчалой	\N
723	Курчатов	\N
724	Куса	\N
725	Кушва	\N
726	Кыштым	\N
727	Кяхта	\N
728	Лабинск	\N
729	Лабытнанги	\N
730	Лагань	\N
731	Ладушкин	\N
732	Лаишево	\N
733	Лангепас	\N
734	Лахденпохья	\N
735	Лебедянь	\N
736	Лениногорск	\N
737	Ленинск	\N
738	Ленск	\N
739	Лесозаводск	\N
740	Лесосибирск	\N
741	Ливны	\N
742	Ликино-Дулёво	\N
743	Липецк	\N
744	Липки	\N
745	Лихославль	\N
746	Лобня	\N
747	Лодейное Поле	\N
748	Лосино-Петровский	\N
749	Луга	\N
750	Луза	\N
751	Лукоянов	\N
752	Луховицы	\N
753	Лысково	\N
754	Лысьва	\N
755	Лыткарино	\N
756	Льгов	\N
757	Любань	\N
758	Люберцы	\N
759	Любим	\N
760	Людиново	\N
761	Лянтор	\N
762	Магадан	\N
763	Магас	\N
764	Магнитогорск	\N
765	Майкоп	\N
766	Майский	\N
767	Макарьев	\N
768	Макушино	\N
769	Малая Вишера	\N
770	Малгобек	\N
771	Малмыж	\N
772	Малоархангельск	\N
773	Малоярославец	\N
774	Мамадыш	\N
775	Мамоново	\N
776	Мантурово	\N
777	Мариинск	\N
778	Мариинский Посад	\N
779	Мглин	\N
780	Мегион	\N
781	Медвежьегорск	\N
782	Медногорск	\N
783	Медынь	\N
784	Межгорье	\N
785	Междуреченск	\N
786	Мезень	\N
787	Меленки	\N
788	Мелеуз	\N
789	Мензелинск	\N
790	Мещовск	\N
791	Миасс	\N
792	Микунь	\N
793	Миллерово	\N
794	Минусинск	\N
795	Миньяр	\N
796	Мирный	\N
797	Михайлов	\N
798	Михайловка	\N
799	Михайловск	\N
800	Мичуринск	\N
801	Могоча	\N
802	Можайск	\N
803	Моздок	\N
804	Мончегорск	\N
805	Моршанск	\N
806	Мосальск	\N
807	Москва	\N
808	Муравленко	\N
809	Мураши	\N
810	Мурино	\N
811	Мурманск	\N
812	Муром	\N
813	Мценск	\N
814	Мыски	\N
815	Мытищи	\N
816	Мышкин	\N
817	Набережные Челны	\N
818	Навашино	\N
819	Наволоки	\N
820	Надым	\N
821	Назарово	\N
822	Назрань	\N
823	Нальчик	\N
824	Нариманов	\N
825	Наро-Фоминск	\N
826	Нарткала	\N
827	Нарьян-Мар	\N
828	Находка	\N
829	Невель	\N
830	Невинномысск	\N
831	Невьянск	\N
832	Нелидово	\N
833	Неман	\N
834	Нерехта	\N
835	Нерчинск	\N
836	Нерюнгри	\N
837	Нефтегорск	\N
838	Нефтекамск	\N
839	Нефтекумск	\N
840	Нефтеюганск	\N
841	Нея	\N
842	Нижневартовск	\N
843	Нижнекамск	\N
844	Нижнеудинск	\N
845	Нижние Серги	\N
846	Нижний Ломов	\N
847	Нижний Новгород	\N
848	Нижний Тагил	\N
849	Нижняя Салда	\N
850	Николаевск	\N
851	Николаевск-на-Амуре	\N
852	Никольск	\N
853	Никольское	\N
854	Новая Ладога	\N
855	Новая Ляля	\N
856	Новоалександровск	\N
857	Новоалтайск	\N
858	Новоаннинский	\N
859	Нововоронеж	\N
860	Новозыбков	\N
861	Новокуйбышевск	\N
862	Новомичуринск	\N
863	Новопавловск	\N
864	Новоржев	\N
865	Новороссийск	\N
866	Новосиль	\N
867	Новосокольники	\N
868	Новотроицк	\N
869	Новоузенск	\N
870	Новоульяновск	\N
871	Новоуральск	\N
872	Новохопёрск	\N
873	Новочебоксарск	\N
874	Новочеркасск	\N
875	Новошахтинск	\N
876	Новый Оскол	\N
877	Новый Уренгой	\N
878	Нолинск	\N
879	Норильск	\N
880	Ноябрьск	\N
881	Нурлат	\N
882	Нытва	\N
883	Нюрба	\N
884	Нягань	\N
885	Нязепетровск	\N
886	Няндома	\N
887	Облучье	\N
888	Обнинск	\N
889	Обоянь	\N
890	Обь	\N
891	Одинцово	\N
892	Озёры	\N
893	Октябрьск	\N
894	Октябрьский	\N
895	Окуловка	\N
896	Олёкминск	\N
897	Оленегорск	\N
898	Олонец	\N
899	Омск	\N
900	Омутнинск	\N
901	Опочка	\N
902	Орёл	\N
903	Оренбург	\N
904	Орехово-Зуево	\N
905	Орлов	\N
906	Орск	\N
907	Оса	\N
908	Осинники	\N
909	Осташков	\N
910	Остров	\N
911	Острогожск	\N
912	Отрадное	\N
913	Отрадный	\N
914	Оха	\N
915	Оханск	\N
916	Очёр	\N
917	Павлово	\N
918	Павловск	\N
919	Павловский Посад	\N
920	Палласовка	\N
921	Певек	\N
922	Пенза	\N
923	Первомайск	\N
924	Первоуральск	\N
925	Перевоз	\N
926	Пересвет	\N
927	Переславль-Залесский	\N
928	Пестово	\N
929	Петров Вал	\N
930	Петровск	\N
931	Петровск-Забайкальский	\N
932	Петухово	\N
933	Петушки	\N
934	Печора	\N
935	Пикалёво	\N
936	Пионерский	\N
937	Питкяранта	\N
938	Плавск	\N
939	Пласт	\N
940	Плёс	\N
941	Поворино	\N
942	Подольск	\N
943	Подпорожье	\N
944	Покачи	\N
945	Покров	\N
946	Покровск	\N
947	Полевской	\N
948	Полесск	\N
949	Полысаево	\N
950	Полярные Зори	\N
951	Порхов	\N
952	Похвистнево	\N
953	Почеп	\N
954	Починок	\N
955	Правдинск	\N
956	Приморск	\N
957	Приморско-Ахтарск	\N
958	Прокопьевск	\N
959	Протвино	\N
960	Прохладный	\N
961	Псков	\N
962	Пугачёв	\N
963	Пудож	\N
964	Пустошка	\N
965	Пучеж	\N
966	Пушкино	\N
967	Пущино	\N
968	Пыть-Ях	\N
969	Пятигорск	\N
970	Радужный	\N
971	Райчихинск	\N
972	Раменское	\N
973	Рассказово	\N
974	Ревда	\N
975	Реж	\N
976	Реутов	\N
977	Ржев	\N
978	Родники	\N
979	Рославль	\N
980	Россошь	\N
981	Ростов-на-Дону	\N
982	Ростов	\N
983	Рошаль	\N
984	Ртищево	\N
985	Рубцовск	\N
986	Рудня	\N
987	Руза	\N
988	Рузаевка	\N
989	Рыбное	\N
990	Рыльск	\N
991	Ряжск	\N
992	Рязань	\N
993	Сакине призн.	\N
994	Салават	\N
995	Салаир	\N
996	Салехард	\N
997	Самара	\N
998	Саранск	\N
999	Сарапул	\N
1000	Саратов	\N
1001	Сасово	\N
1002	Сатка	\N
1003	Сафоново	\N
1004	Саяногорск	\N
1005	Саянск	\N
1006	Светлогорск	\N
1007	Светлоград	\N
1008	Светлый	\N
1009	Светогорск	\N
1010	Свирск	\N
1011	Свободный	\N
1012	Себеж	\N
1013	Северо-Курильск	\N
1014	Северобайкальск	\N
1015	Североморск	\N
1016	Североуральск	\N
1017	Северск	\N
1018	Севск	\N
1019	Сегежа	\N
1020	Сельцо	\N
1021	Семёнов	\N
1022	Семикаракорск	\N
1023	Семилуки	\N
1024	Сенгилей	\N
1025	Серафимович	\N
1026	Сергач	\N
1027	Сердобск	\N
1028	Серпухов	\N
1029	Сертолово	\N
1030	Сибай	\N
1031	Сим	\N
1032	Симферопольне призн.	\N
1033	Скопин	\N
1034	Славгород	\N
1035	Славск	\N
1036	Славянск-на-Кубани	\N
1037	Сланцы	\N
1038	Слободской	\N
1039	Слюдянка	\N
1040	Смоленск	\N
1041	Собинка	\N
1042	Советск	\N
1043	Советский	\N
1044	Сокол	\N
1045	Солигалич	\N
1046	Соликамск	\N
1047	Сольвычегодск	\N
1048	Сольцы	\N
1049	Сорочинск	\N
1050	Сорск	\N
1051	Сортавала	\N
1052	Сосенский	\N
1053	Сосновка	\N
1054	Сосновоборск	\N
1055	Сосновый Бор	\N
1056	Сосногорск	\N
1057	Сочи	\N
1058	Спас-Деменск	\N
1059	Спас-Клепики	\N
1060	Спасск-Рязанский	\N
1061	Среднеколымск	\N
1062	Среднеуральск	\N
1063	Сретенск	\N
1064	Старая Купавна	\N
1065	Старая Русса	\N
1066	Старица	\N
1067	Стародуб	\N
1068	Старый Крымне призн.	\N
1069	Старый Оскол	\N
1070	Стерлитамак	\N
1071	Стрежевой	\N
1072	Строитель	\N
1073	Струнино	\N
1074	Ступино	\N
1075	Суворов	\N
1076	Судакне призн.	\N
1077	Суджа	\N
1078	Судогда	\N
1079	Суздаль	\N
1080	Суоярви	\N
1081	Сураж	\N
1082	Сургут	\N
1083	Суровикино	\N
1084	Сурск	\N
1085	Сусуман	\N
1086	Сухиничи	\N
1087	Сухой Лог	\N
1088	Сызрань	\N
1089	Сыктывкар	\N
1090	Сысерть	\N
1091	Сычёвка	\N
1092	Сясьстрой	\N
1093	Тавда	\N
1094	Таганрог	\N
1095	Тайга	\N
1096	Тайшет	\N
1097	Талдом	\N
1098	Талица	\N
1099	Тамбов	\N
1100	Тара	\N
1101	Тарко-Сале	\N
1102	Таруса	\N
1103	Татарск	\N
1104	Таштагол	\N
1105	Тверь	\N
1106	Теберда	\N
1107	Тейково	\N
1108	Темников	\N
1109	Темрюк	\N
1110	Терек	\N
1111	Тетюши	\N
1112	Тимашёвск	\N
1113	Тихвин	\N
1114	Тихорецк	\N
1115	Тобольск	\N
1116	Тогучин	\N
1117	Тольятти	\N
1118	Томари	\N
1119	Томмот	\N
1120	Томск	\N
1121	Топки	\N
1122	Торжок	\N
1123	Торопец	\N
1124	Тосно	\N
1125	Тотьма	\N
1126	Трёхгорный	\N
1127	Троицк	\N
1128	Трубчевск	\N
1129	Туапсе	\N
1130	Туймазы	\N
1131	Тула	\N
1132	Тулун	\N
1133	Туран	\N
1134	Туринск	\N
1135	Тутаев	\N
1136	Тюкалинск	\N
1137	Тюмень	\N
1138	Уварово	\N
1139	Углегорск	\N
1140	Углич	\N
1141	Удачный	\N
1142	Удомля	\N
1143	Ужур	\N
1144	Узловая	\N
1145	Унеча	\N
1146	Урай	\N
1147	Урень	\N
1148	Уржум	\N
1149	Урус-Мартан	\N
1150	Урюпинск	\N
1151	Усинск	\N
1152	Усмань	\N
1153	Усолье-Сибирское	\N
1154	Усолье	\N
1155	Усть-Джегута	\N
1156	Усть-Илимск	\N
1157	Усть-Катав	\N
1158	Усть-Кут	\N
1159	Усть-Лабинск	\N
1160	Устюжна	\N
1161	Уфа	\N
1162	Ухта	\N
1163	Учалы	\N
1164	Уяр	\N
1165	Фатеж	\N
1166	Феодосияне призн.	\N
1167	Фокино	\N
1168	Фролово	\N
1169	Фрязино	\N
1170	Хадыженск	\N
1171	Ханты-Мансийск	\N
1172	Харабали	\N
1173	Харовск	\N
1174	Хасавюрт	\N
1175	Хилок	\N
1176	Химки	\N
1177	Холм	\N
1178	Хотьково	\N
1179	Цивильск	\N
1180	Чадан	\N
1181	Чайковский	\N
1182	Чебаркуль	\N
1183	Чебоксары	\N
1184	Чекалин	\N
1185	Челябинск	\N
1186	Чердынь	\N
1187	Черемхово	\N
1188	Черепаново	\N
1189	Череповец	\N
1190	Чёрмоз	\N
1191	Черноголовка	\N
1192	Черногорск	\N
1193	Чернушка	\N
1194	Черняховск	\N
1195	Чехов	\N
1196	Чистополь	\N
1197	Чита	\N
1198	Чкаловск	\N
1199	Чудово	\N
1200	Чулым	\N
1201	Чусовой	\N
1202	Чухлома	\N
1203	Шагонар	\N
1204	Шали	\N
1205	Шарыпово	\N
1206	Шарья	\N
1207	Шатура	\N
1208	Шахунья	\N
1209	Шацк	\N
1210	Шебекино	\N
1211	Шелехов	\N
1212	Шенкурск	\N
1213	Шилка	\N
1214	Шиханы	\N
1215	Шумерля	\N
1216	Шумиха	\N
1217	Шуя	\N
1218	Щёкино	\N
1219	Щёлкиноне призн.	\N
1220	Щёлково	\N
1221	Щигры	\N
1222	Щучье	\N
1223	Электрогорск	\N
1224	Электросталь	\N
1225	Электроугли	\N
1226	Элиста	\N
1227	Эртиль	\N
1228	Югорск	\N
1229	Южа	\N
1230	Южно-Сухокумск	\N
1231	Южноуральск	\N
1232	Юрга	\N
1233	Юрьев-Польский	\N
1234	Юрьевец	\N
1235	Юрюзань	\N
1236	Юхнов	\N
1237	Ядрин	\N
1238	Якутск	\N
1239	Ялтане призн.	\N
1240	Ялуторовск	\N
1241	Янаул	\N
1242	Яранск	\N
1243	Яровое	\N
1244	Ярославль	\N
1245	Ярцево	\N
1246	Ясногорск	\N
1247	Ясный	\N
1248	Яхрома	\N
\.


--
-- TOC entry 3438 (class 0 OID 203342)
-- Dependencies: 217
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (id, name, uniform_name, code, num_code) FROM stdin;
1	Абхазия	Abkhazia	AB	895
2	Австралия	Australia	AU	36
3	Австрия	Austria	AT	40
4	Азербайджан	Azerbaijan	AZ	31
5	Албания	Albania	AL	8
6	Алжир	Algeria	DZ	12
7	Американское Самоа	American Samoa	AS	16
8	Ангилья	Anguilla	AI	660
9	Ангола	Angola	AO	24
10	Андорра	Andorra	AD	20
11	Антарктида	Antarctica	AQ	10
12	Антигуа и Барбуда	Antigua and Barbuda	AG	28
13	Аргентина	Argentina	AR	32
14	Армения	Armenia	AM	51
15	Аруба	Aruba	AW	533
16	Афганистан	Afghanistan	AF	4
17	Багамы	Bahamas	BS	44
18	Бангладеш	Bangladesh	BD	50
19	Барбадос	Barbados	BB	52
20	Бахрейн	Bahrain	BH	48
21	Беларусь	Belarus	BY	112
22	Белиз	Belize	BZ	84
23	Бельгия	Belgium	BE	56
24	Бенин	Benin	BJ	204
25	Бермуды	Bermuda	BM	60
26	Болгария	Bulgaria	BG	100
27	Боливия, Многонациональное Государство	Bolivia, plurinational state of	BO	68
28	Бонайре, Саба и Синт-Эстатиус	Bonaire, Sint Eustatius and Saba	BQ	535
29	Босния и Герцеговина	Bosnia and Herzegovina	BA	70
30	Ботсвана	Botswana	BW	72
31	Бразилия	Brazil	BR	76
32	Британская территория в Индийском океане	British Indian Ocean Territory	IO	86
33	Бруней-Даруссалам	Brunei Darussalam	BN	96
34	Буркина-Фасо	Burkina Faso	BF	854
35	Бурунди	Burundi	BI	108
36	Бутан	Bhutan	BT	64
37	Вануату	Vanuatu	VU	548
38	Венгрия	Hungary	HU	348
39	Венесуэла Боливарианская Республика	Venezuela	VE	862
40	Виргинские острова, Британские	Virgin Islands, British	VG	92
41	Виргинские острова, США	Virgin Islands, U.S.	VI	850
42	Вьетнам	Vietnam	VN	704
43	Габон	Gabon	GA	266
44	Гаити	Haiti	HT	332
45	Гайана	Guyana	GY	328
46	Гамбия	Gambia	GM	270
47	Гана	Ghana	GH	288
48	Гваделупа	Guadeloupe	GP	312
49	Гватемала	Guatemala	GT	320
50	Гвинея	Guinea	GN	324
51	Гвинея-Бисау	Guinea-Bissau	GW	624
52	Германия	Germany	DE	276
53	Гернси	Guernsey	GG	831
54	Гибралтар	Gibraltar	GI	292
55	Гондурас	Honduras	HN	340
56	Гонконг	Hong Kong	HK	344
57	Гренада	Grenada	GD	308
58	Гренландия	Greenland	GL	304
59	Греция	Greece	GR	300
60	Грузия	Georgia	GE	268
61	Гуам	Guam	GU	316
62	Дания	Denmark	DK	208
63	Джерси	Jersey	JE	832
64	Джибути	Djibouti	DJ	262
65	Доминика	Dominica	DM	212
66	Доминиканская Республика	Dominican Republic	DO	214
67	Египет	Egypt	EG	818
68	Замбия	Zambia	ZM	894
69	Западная Сахара	Western Sahara	EH	732
70	Зимбабве	Zimbabwe	ZW	716
71	Израиль	Israel	IL	376
72	Индия	India	IN	356
73	Индонезия	Indonesia	ID	360
74	Иордания	Jordan	JO	400
75	Ирак	Iraq	IQ	368
76	Иран, Исламская Республика	Iran, Islamic Republic of	IR	364
77	Ирландия	Ireland	IE	372
78	Исландия	Iceland	IS	352
79	Испания	Spain	ES	724
80	Италия	Italy	IT	380
81	Йемен	Yemen	YE	887
82	Кабо-Верде	Cape Verde	CV	132
83	Казахстан	Kazakhstan	KZ	398
84	Камбоджа	Cambodia	KH	116
85	Камерун	Cameroon	CM	120
86	Канада	Canada	CA	124
87	Катар	Qatar	QA	634
88	Кения	Kenya	KE	404
89	Кипр	Cyprus	CY	196
90	Киргизия	Kyrgyzstan	KG	417
91	Кирибати	Kiribati	KI	296
92	Китай	China	CN	156
93	Кокосовые (Килинг) острова	Cocos (Keeling) Islands	CC	166
94	Колумбия	Colombia	CO	170
95	Коморы	Comoros	KM	174
96	Конго	Congo	CG	178
97	Конго, Демократическая Республика	Congo, Democratic Republic of the	CD	180
98	Корея, Народно-Демократическая Республика	Korea, Democratic People's republic of	KP	408
99	Корея, Республика	Korea, Republic of	KR	410
100	Коста-Рика	Costa Rica	CR	188
101	Кот д'Ивуар	Cote d'Ivoire	CI	384
102	Куба	Cuba	CU	192
103	Кувейт	Kuwait	KW	414
104	Кюрасао	Curaçao	CW	531
105	Лаос	Lao People's Democratic Republic	LA	418
106	Латвия	Latvia	LV	428
107	Лесото	Lesotho	LS	426
108	Ливан	Lebanon	LB	422
109	Ливийская Арабская Джамахирия	Libyan Arab Jamahiriya	LY	434
110	Либерия	Liberia	LR	430
111	Лихтенштейн	Liechtenstein	LI	438
112	Литва	Lithuania	LT	440
113	Люксембург	Luxembourg	LU	442
114	Маврикий	Mauritius	MU	480
115	Мавритания	Mauritania	MR	478
116	Мадагаскар	Madagascar	MG	450
117	Майотта	Mayotte	YT	175
118	Макао	Macao	MO	446
119	Малави	Malawi	MW	454
120	Малайзия	Malaysia	MY	458
121	Мали	Mali	ML	466
122	Малые Тихоокеанские отдаленные острова Соединенных Штатов	United States Minor Outlying Islands	UM	581
123	Мальдивы	Maldives	MV	462
124	Мальта	Malta	MT	470
125	Марокко	Morocco	MA	504
126	Мартиника	Martinique	MQ	474
127	Маршалловы острова	Marshall Islands	MH	584
128	Мексика	Mexico	MX	484
129	Микронезия, Федеративные Штаты	Micronesia, Federated States of	FM	583
130	Мозамбик	Mozambique	MZ	508
131	Молдова, Республика	Moldova	MD	498
132	Монако	Monaco	MC	492
133	Монголия	Mongolia	MN	496
134	Монтсеррат	Montserrat	MS	500
135	Мьянма	Myanmar	MM	104
136	Намибия	Namibia	NA	516
137	Науру	Nauru	NR	520
138	Непал	Nepal	NP	524
139	Нигер	Niger	NE	562
140	Нигерия	Nigeria	NG	566
141	Нидерланды	Netherlands	NL	528
142	Никарагуа	Nicaragua	NI	558
143	Ниуэ	Niue	NU	570
144	Новая Зеландия	New Zealand	NZ	554
145	Новая Каледония	New Caledonia	NC	540
146	Норвегия	Norway	NO	578
147	Объединенные Арабские Эмираты	United Arab Emirates	AE	784
148	Оман	Oman	OM	512
149	Остров Буве	Bouvet Island	BV	74
150	Остров Мэн	Isle of Man	IM	833
151	Остров Норфолк	Norfolk Island	NF	574
152	Остров Рождества	Christmas Island	CX	162
153	Остров Херд и острова Макдональд	Heard Island and McDonald Islands	HM	334
154	Острова Кайман	Cayman Islands	KY	136
155	Острова Кука	Cook Islands	CK	184
156	Острова Теркс и Кайкос	Turks and Caicos Islands	TC	796
157	Пакистан	Pakistan	PK	586
158	Палау	Palau	PW	585
159	Палестинская территория, оккупированная	Palestinian Territory, Occupied	PS	275
160	Панама	Panama	PA	591
161	Папский Престол (Государство — город Ватикан)	Holy See (Vatican City State)	VA	336
162	Папуа-Новая Гвинея	Papua New Guinea	PG	598
163	Парагвай	Paraguay	PY	600
164	Перу	Peru	PE	604
165	Питкерн	Pitcairn	PN	612
166	Польша	Poland	PL	616
167	Португалия	Portugal	PT	620
168	Пуэрто-Рико	Puerto Rico	PR	630
169	Республика Македония	Macedonia, The Former Yugoslav Republic Of	MK	807
170	Реюньон	Reunion	RE	638
171	Россия	Russian Federation	RU	643
172	Руанда	Rwanda	RW	646
173	Румыния	Romania	RO	642
174	Самоа	Samoa	WS	882
175	Сан-Марино	San Marino	SM	674
176	Сан-Томе и Принсипи	Sao Tome and Principe	ST	678
177	Саудовская Аравия	Saudi Arabia	SA	682
178	Свазиленд	Swaziland	SZ	748
179	Святая Елена, Остров вознесения, Тристан-да-Кунья	Saint Helena, Ascension And Tristan Da Cunha	SH	654
180	Северные Марианские острова	Northern Mariana Islands	MP	580
181	Сен-Бартельми	Saint Barthélemy	BL	652
182	Сен-Мартен	Saint Martin (French Part)	MF	663
183	Сенегал	Senegal	SN	686
184	Сент-Винсент и Гренадины	Saint Vincent and the Grenadines	VC	670
185	Сент-Люсия	Saint Lucia	LC	662
186	Сент-Китс и Невис	Saint Kitts and Nevis	KN	659
187	Сент-Пьер и Микелон	Saint Pierre and Miquelon	PM	666
188	Сербия	Serbia	RS	688
189	Сейшелы	Seychelles	SC	690
190	Сингапур	Singapore	SG	702
191	Синт-Мартен	Sint Maarten	SX	534
192	Сирийская Арабская Республика	Syrian Arab Republic	SY	760
193	Словакия	Slovakia	SK	703
194	Словения	Slovenia	SI	705
195	Соединенное Королевство	United Kingdom	GB	826
196	Соединенные Штаты	United States	US	840
197	Соломоновы острова	Solomon Islands	SB	90
198	Сомали	Somalia	SO	706
199	Судан	Sudan	SD	729
200	Суринам	Suriname	SR	740
201	Сьерра-Леоне	Sierra Leone	SL	694
202	Таджикистан	Tajikistan	TJ	762
203	Таиланд	Thailand	TH	764
204	Тайвань (Китай)	Taiwan, Province of China	TW	158
205	Танзания, Объединенная Республика	Tanzania, United Republic Of	TZ	834
206	Тимор-Лесте	Timor-Leste	TL	626
207	Того	Togo	TG	768
208	Токелау	Tokelau	TK	772
209	Тонга	Tonga	TO	776
210	Тринидад и Тобаго	Trinidad and Tobago	TT	780
211	Тувалу	Tuvalu	TV	798
212	Тунис	Tunisia	TN	788
213	Туркмения	Turkmenistan	TM	795
214	Турция	Turkey	TR	792
215	Уганда	Uganda	UG	800
216	Узбекистан	Uzbekistan	UZ	860
217	Украина	Ukraine	UA	804
218	Уоллис и Футуна	Wallis and Futuna	WF	876
219	Уругвай	Uruguay	UY	858
220	Фарерские острова	Faroe Islands	FO	234
221	Фиджи	Fiji	FJ	242
222	Филиппины	Philippines	PH	608
223	Финляндия	Finland	FI	246
224	Фолклендские острова (Мальвинские)	Falkland Islands (Malvinas)	FK	238
225	Франция	France	FR	250
226	Французская Гвиана	French Guiana	GF	254
227	Французская Полинезия	French Polynesia	PF	258
228	Французские Южные территории	French Southern Territories	TF	260
229	Хорватия	Croatia	HR	191
230	Центрально-Африканская Республика	Central African Republic	CF	140
231	Чад	Chad	TD	148
232	Черногория	Montenegro	ME	499
233	Чешская Республика	Czech Republic	CZ	203
234	Чили	Chile	CL	152
235	Швейцария	Switzerland	CH	756
236	Швеция	Sweden	SE	752
237	Шпицберген и Ян Майен	Svalbard and Jan Mayen	SJ	744
238	Шри-Ланка	Sri Lanka	LK	144
239	Эквадор	Ecuador	EC	218
240	Экваториальная Гвинея	Equatorial Guinea	GQ	226
241	Эландские острова	Åland Islands	AX	248
242	Эль-Сальвадор	El Salvador	SV	222
243	Эритрея	Eritrea	ER	232
244	Эстония	Estonia	EE	233
245	Эфиопия	Ethiopia	ET	231
246	Южная Африка	South Africa	ZA	710
247	Южная Джорджия и Южные Сандвичевы острова	South Georgia and the South Sandwich Islands	GS	239
248	Южная Осетия	South Ossetia	OS	896
249	Южный Судан	South Sudan	SS	728
250	Ямайка	Jamaica	JM	388
251	Япония	Japan	JP	392
\.


--
-- TOC entry 3448 (class 0 OID 203440)
-- Dependencies: 227
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (id, title, start_date, days, city_id, photo_path, event_type_id) FROM stdin;
2	Первая встреча клуба «Leader stories»	2022-03-15	1	330	1.jpeg	1
3	Первый в России JAVABOOTCAMP	2022-10-25	3	352	2.jpeg	1
4	Встреча клуба Leader Stories «Зачем развивать сотрудников? Они же уйдут»	2023-04-18	3	302	3.jpeg	1
5	Первый IoT-Forum в Санкт-Петербурге	2023-05-30	3	304	4.jpeg	1
6	План проекта: практические советы, типичные ошибки	2023-07-11	2	305	5.png	1
7	Планирование проекта: что делать после того, как выяснили цель	2022-03-20	1	366	6.jpg	1
8	Поисковая оптимизация (SEO)	2022-08-10	1	386	7.jpg	1
9	Поисковая оптимизация. SEO оптимизация	2022-08-15	2	376	8.jpeg	2
10	Поликом Про и InfoWatch: круглый стол по информационной безопасности в Санкт-Петербурге	2022-02-02	2	374	9.jpg	2
11	Получи «100500» лидов в первые 5 секунд	2023-09-02	3	374	10.jpg	2
12	Пользовательские требования	2023-08-08	2	363	11.jpg	3
13	Постоянно доступен: Налаживаем омниканальную коммуникацию с клиентами	2023-10-29	3	352	12.jpg	3
14	Построение гиперконвергентной инфраструктуры и VDI-решения	2023-10-28	3	341	13.jpg	3
15	Практикум «Обогнать конкурентов: усиливаем продажи и создаем клиентский сервис»	2022-07-28	2	374	14.png	4
16	Практикум по Customer Development с экспертом ФРИИ: грамотные продажи за 4 часа	2022-06-03	3	363	15.jpg	4
17	Практический воркшоп по созданию договоренностей в Scrum-команде	2022-05-16	1	303	16.jpg	4
18	Практическое применение диаграммы потоков данных (DFD, Data Flow Diagram)	2023-11-27	3	304	17.jpg	4
19	Практическое применение диаграммы состояний (UML StateChart)	2022-06-17	3	305	18.jpeg	5
20	Презентационная сессия «TTD: технологии для жизни 2022»	2022-01-30	2	299	19.jpg	5
21	Презентация курса «Методы, технологии, инструменты обучения персонала в технических, продуктовых и IT-компаниях»	2023-10-01	3	301	20.jpg	5
\.


--
-- TOC entry 3442 (class 0 OID 203366)
-- Dependencies: 221
-- Data for Name: event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_types (id, name) FROM stdin;
1	IT в бизнесе
2	Разработка приложений
3	IT-инфраструктура
4	Стартапы
5	Информационная безопасность
\.


--
-- TOC entry 3446 (class 0 OID 203424)
-- Dependencies: 225
-- Data for Name: jury; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jury (user_id, activity_direction_id) FROM stdin;
4	1
5	1
6	2
7	2
8	3
9	1
10	1
11	4
12	2
13	4
\.


--
-- TOC entry 3445 (class 0 OID 203404)
-- Dependencies: 224
-- Data for Name: moderator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.moderator (user_id, activity_direction_id, event_type_id) FROM stdin;
14	3	1
15	3	1
16	2	2
17	4	3
18	2	2
19	5	4
20	3	1
21	1	5
22	2	2
23	5	4
24	5	4
25	1	5
26	4	3
27	4	3
28	4	3
29	1	5
30	1	5
31	2	2
32	5	4
33	1	5
34	2	2
\.


--
-- TOC entry 3444 (class 0 OID 203390)
-- Dependencies: 223
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, full_name, gender, birth, country_id, phone, pass, photo_path, role_discriminator, email) FROM stdin;
33	Шульгина Елизавета Денисовна	женский	1989-01-13	20	7(596)221-45-84	6VM3r9jmS5	foto28.jpg	moderator	1os2bmtpg6nv@mail.com
63	Мамонтов Прохор Созонович	мужской	1975-12-30	61	7(821)760-71-19	STSVII	foto30.jpg	member	yn6pfe4kasbo@outlook.com
47	Симонов Остап Федотович	мужской	1989-01-14	91	7(821)779-78-75	PtwSEA	foto14.jpg	member	m73dobuzn6jc@gmail.com
55	Субботин Мартин Пантелеймонович	мужской	1989-04-26	86	7(821)149-13-09	v5MxkG	foto22.jpg	member	6opkrq9n87d1@outlook.com
21	Прохорова Анна Фёдоровна	женский	1982-05-24	72	7(037)333-08-17	D44jjR45gH	foto16.jpg	moderator	wg9h3ixavl25@tutanota.com
27	Тарасова Валерия Егоровна	женский	1975-12-24	79	7(575)142-09-75	eC445cE8Yd	foto22.jpg	moderator	a8071jvd2m6z@tutanota.com
20	Майоров Александр Михайлович	мужской	1998-05-01	63	7(605)246-65-83	8jZ5LL2a2n	foto14.jpg	moderator	rzsj6wqd42vt@yahoo.com
29	Иванова Виктория Павловна	женский	1973-05-09	72	7(901)002-16-80	34nYAv56Cs	foto24.jpg	moderator	ixut6e0cnd84@gmail.com
44	Соловьев Демид Артёмович	мужской	1981-12-21	63	7(053)696-95-19	42xF46LVkh	foto10.jpg	organizer	tkgduj6na1hm@gmail.com
58	Петухов Алан Пётрович	мужской	1987-01-29	44	7(821)749-53-09	GYlXDR	foto25.jpg	member	kd64ino5fcx3@outlook.com
18	Покровский Марк Максимович	мужской	1968-09-23	79	7(312)920-22-96	f7S5zxH58B	foto12.jpg	moderator	m93nsaih4kl8@yahoo.com
52	Ермаков Клемент Проклович	мужской	1972-12-04	66	7(821)007-84-60	HLAFQB	foto19.jpg	member	t1dg96ikvorc@tutanota.com
43	Рябова Алиса Викторовна	женский	1989-01-14	57	7(500)841-51-43	JS4K8pr54u	foto9.jpg	organizer	vy3ajxkge8p7@mail.com
56	Рожков Демьян Эдуардович	мужской	1995-11-09	45	7(821)162-52-21	8MkKg6	foto23.jpg	member	epflsy9iobdx@tutanota.com
17	Лосева Аделина Георгиевна	женский	1996-08-11	96	7(699)704-90-18	P8c83u5fUR	foto11.jpg	moderator	qz901omryb7j@mail.com
14	Покровский Роман Дмитриевич	мужской	1974-01-22	73	7(416)870-22-00	4VUmGj4t36	foto9.jpg	moderator	i8brhz2gyx4j@gmail.com
42	Мешков Даниил Николаевич	мужской	1984-11-20	28	7(640)704-75-62	d6UAu83Sd8	foto8.jpg	organizer	70rkvgtfjswm@gmail.com
49	Фокин Клемент Игнатьевич	мужской	1973-01-15	18	7(821)177-06-74	pEVpH3	foto16.jpg	member	wxey0gmcjuz2@mail.com
19	Акимова София Александровна	женский	1989-01-20	72	7(714)693-32-92	c2vGi532VN	foto13.jpg	moderator	qgb9ea8wnl50@mail.com
23	Лебедева Виктория Марковна	женский	1980-10-30	48	7(596)301-43-97	69S6fMzeM2	foto18.jpg	moderator	wbs3znh5uxfr@tutanota.com
34	Петрова Василиса Георгиевна	женский	1987-04-25	7	7(588)448-48-41	c6m4L2ZD9j	foto29.jpg	moderator	vbpjslo28w6d@mail.com
54	Петров Геннадий Даниилович	мужской	1989-08-06	45	7(821)685-48-91	xM5QB5	foto21.jpg	member	fskhuw2oxgev@outlook.com
10	Игнатьев Мирослав Тарасович	мужской	1973-03-07	64	7(346)523-76-14	j7WWL5	foto17.jpg	jury	jadon85@gmail.com
64	Баранов Венедикт Ефимович	мужской	1988-07-15	22	7(821)478-05-95	DsEhqN	foto31.jpg	member	vny26gsmxu9k@tutanota.com
31	Иванов Фёдор Тимофеевич	мужской	1988-11-23	39	7(812)026-33-34	a7pXZ78a2J	foto26.jpg	moderator	0kmd26jfi859@mail.com
62	Комиссаров Антон Протасьевич	мужской	1996-11-15	13	7(821)277-58-70	4rSPmK	foto29.jpg	member	96o7iwszty5n@tutanota.com
9	Брагин Осип Владиславович	мужской	1963-03-06	24	7(276)229-95-45	AA6JS6	foto16.jpg	jury	trace.lindgren@beahan.com
46	Трофимов Любомир Русланович	мужской	1980-02-11	71	7(821)611-43-32	TImO7k	foto13.jpg	member	4sqplurb5eki@gmail.com
15	Чернышев Ярослав Андреевич	мужской	1957-06-12	47	7(278)138-47-92	b9zAs99XD3	foto10.jpg	moderator	dic8qah9zbot@mail.com
16	Суворова Ева Алексеевна	женский	1960-05-29	21	7(093)787-84-57	n6cx69AM4T	foto8.jpg	moderator	o3gmly907wcn@mail.com
57	Емельянов Анатолий Авксентьевич	мужской	1982-10-17	93	7(821)976-48-88	COZkSO	foto24.jpg	member	zy8tom2bxnuk@mail.com
5	Белова Инга Прокловна	женский	1972-09-15	43	7(215)064-59-70	TsCX7X	foto12.jpg	jury	olson.shanny@gmail.com
3	admin	мужской	1978-03-02	82	7(186)808-50-99	password	foto11.jpg	moderator	kirillgroshev52@gmail.com
30	Богданова Олеся Евгеньевна	женский	1962-08-26	98	7(272)350-20-30	ru6x7PT2V4	foto25.jpg	moderator	es06joah3pfu@gmail.com
8	Некрасова Лаура Богдановна	женский	1950-08-19	89	7(138)268-54-96	XQZbTX	foto15.jpg	jury	pkutch@hotmail.com
4	Одинцов Дмитрий Лаврентьевич	мужской	1978-03-02	82	7(186)808-50-25	ugWkzE	foto11.jpg	jury	oconnell.steve@feest.com
22	Соловьев Иван Дмитриевич	мужской	1969-03-28	64	7(594)615-77-80	2c73vxTLP9	foto17.jpg	moderator	2nib6c5vl18k@outlook.com
32	Кузнецов Семён Владиславович	мужской	1962-05-05	13	7(550)677-95-09	8uTv4L8Cg4	foto27.jpg	moderator	mn7bawsorg51@outlook.com
6	Соловьёва Аюна Станиславовна	женский	1950-02-21	36	7(810)322-94-05	R2buBG	foto13.jpg	jury	whirthe@beer.info
48	Захаров Арнольд Германнович	мужской	1994-07-30	81	7(821)819-98-39	EzwyiP	foto15.jpg	member	9mtkjdsrhp2c@yahoo.com
25	Юдина Татьяна Максимовна	женский	1978-01-27	76	7(442)333-89-12	XU5b8N42th	foto20.jpg	moderator	4rqfa385p9gz@mail.com
7	Зайцев Иван Артемович	мужской	1950-07-20	75	7(963)659-08-16	6Kuk9B	foto14.jpg	jury	rerdman@gmail.com
12	Пестова Ева Альбертовна	женский	1980-09-24	75	7(089)418-02-33	kFwax6	foto19.jpg	jury	graham.robb@boyer.com
36	Романова Анастасия Тимофеевна	женский	1980-09-01	87	7(226)494-15-47	8fb3RJT8c6	foto2.jpg	organizer	wukm6dacf7v0@gmail.com
26	Рябинин Григорий Матвеевич	мужской	1953-05-31	24	7(377)251-56-96	6R82k4nFnX	foto21.jpg	moderator	ox7k5w6l04mi@gmail.com
11	Матвеева Вера Митрофановна	женский	1952-09-11	75	7(742)194-06-10	2QCbSj	foto18.jpg	jury	mathilde77@yahoo.com
39	Громова Виктория Матвеевна	женский	1983-07-14	69	7(581)960-76-73	Ka74TC2r7m	foto5.jpg	organizer	dlm7wocnzhtp@mail.com
41	Прохоров Максим Серафимович	мужской	1995-11-10	59	7(466)705-98-66	9nM7A9Mtv5	foto7.jpg	organizer	ekibvrcm71a6@gmail.com
51	Егоров Афанасий Тарасович	мужской	1977-06-26	45	7(821)623-59-80	0Utzck	foto18.jpg	member	p473g2jlcmhi@outlook.com
13	Фомичёв Варлаам Дмитрьевич	мужской	1994-09-26	8	7(097)858-38-14	SqJHTL	foto20.jpg	jury	cleveland.hamill@gmail.com
61	Максимов Егор Дамирович	мужской	1975-11-30	81	7(821)579-45-88	9YNtvb	foto28.jpg	member	tacixb04vh5g@gmail.com
24	Шишкина Светлана Александровна	женский	1998-02-08	46	7(181)588-68-39	j7TMm92s9X	foto19.jpg	moderator	yl9hxt5dzajv@tutanota.com
40	Карпов Алексей Артёмович	мужской	1980-08-06	78	7(959)240-88-47	fk9BHN2g96	foto6.jpg	organizer	mwlny4zqtc65@outlook.com
50	Захаров Аверкий Альбертович	мужской	1981-06-24	80	7(821)856-28-93	eEJ83V	foto17.jpg	member	lqih53fw9ryx@tutanota.com
60	Александров Варлаам Робертович	мужской	1999-05-18	73	7(821)137-45-80	uNRgsg	foto27.jpg	member	qsnyrwodje0k@outlook.com
37	Белкин Дмитрий Александрович	мужской	1981-03-02	10	7(725)164-24-56	2T2xCYef86	foto3.jpg	organizer	5ku2w7nqzvot@gmail.com
45	Корнилов Владимир Степанович	мужской	1991-02-08	68	7(821)277-59-90	nOEBrK	foto12.jpg	member	uw846cn27x9k@outlook.com
53	Лазарев Марк Юлианович	мужской	1996-05-11	87	7(821)376-94-02	nrBfHG	foto20.jpg	member	ah91upwo7xfl@mail.com
35	Скворцов Михаил Артёмович	мужской	1989-01-05	1	7(329)246-20-13	JyP2M2ji63	foto1.jpg	organizer	3swfq0n756y1@mail.com
59	Бобров Марк Юрьевич	мужской	1993-12-08	20	7(821)496-70-50	10PHSE	foto26.jpg	member	i4ex5whc7dqk@gmail.com
38	Лаврова Анастасия Маратовна	женский	1981-09-12	63	7(388)191-50-31	nG7xGVi892	foto4.jpg	organizer	8s54jayek2mt@outlook.com
28	Алексеев Михаил Глебович	мужской	1976-05-12	6	7(979)385-40-57	8T69Vef8Er	foto23.jpg	moderator	qxel0og2ps4t@gmail.com
\.


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 230
-- Name: activity_day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_day_id_seq', 30, true);


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 218
-- Name: activity_directions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_directions_id_seq', 5, true);


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 228
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_id_seq', 20, true);


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 214
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_id_seq', 1248, true);


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 216
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 251, true);


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 226
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 21, true);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 220
-- Name: event_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_types_id_seq', 5, true);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 222
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 64, true);


--
-- TOC entry 3276 (class 2606 OID 203482)
-- Name: activity_day activity_day_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day
    ADD CONSTRAINT activity_day_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 203364)
-- Name: activity_directions activity_directions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_directions
    ADD CONSTRAINT activity_directions_name_key UNIQUE (name);


--
-- TOC entry 3258 (class 2606 OID 203362)
-- Name: activity_directions activity_directions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_directions
    ADD CONSTRAINT activity_directions_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 203463)
-- Name: activity activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 203492)
-- Name: activity_day_jouriors ativity_day_jouriors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day_jouriors
    ADD CONSTRAINT ativity_day_jouriors_pkey PRIMARY KEY (activity_day_id, jury_id);


--
-- TOC entry 3242 (class 2606 OID 203340)
-- Name: city city_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_name_key UNIQUE (name);


--
-- TOC entry 3244 (class 2606 OID 203338)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 203353)
-- Name: country country_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_code_key UNIQUE (code);


--
-- TOC entry 3248 (class 2606 OID 203349)
-- Name: country country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_name_key UNIQUE (name);


--
-- TOC entry 3250 (class 2606 OID 203355)
-- Name: country country_num_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_num_code_key UNIQUE (num_code);


--
-- TOC entry 3252 (class 2606 OID 203347)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 203351)
-- Name: country country_uniform_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_uniform_name_key UNIQUE (uniform_name);


--
-- TOC entry 3272 (class 2606 OID 203449)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 203373)
-- Name: event_types event_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_types
    ADD CONSTRAINT event_types_name_key UNIQUE (name);


--
-- TOC entry 3262 (class 2606 OID 203371)
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 203428)
-- Name: jury jury_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jury
    ADD CONSTRAINT jury_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3268 (class 2606 OID 203408)
-- Name: moderator moderator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderator
    ADD CONSTRAINT moderator_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3264 (class 2606 OID 203707)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3266 (class 2606 OID 203398)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3289 (class 2606 OID 203499)
-- Name: activity_day activity_day_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day
    ADD CONSTRAINT activity_day_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activity(id) ON DELETE CASCADE;


--
-- TOC entry 3291 (class 2606 OID 203510)
-- Name: activity_day_jouriors activity_day_jouriors_activity_day_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day_jouriors
    ADD CONSTRAINT activity_day_jouriors_activity_day_id_fkey FOREIGN KEY (activity_day_id) REFERENCES public.activity_day(id);


--
-- TOC entry 3290 (class 2606 OID 203483)
-- Name: activity_day activity_day_moderator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day
    ADD CONSTRAINT activity_day_moderator_id_fkey FOREIGN KEY (moderator_id) REFERENCES public.moderator(user_id) ON DELETE SET NULL;


--
-- TOC entry 3287 (class 2606 OID 203464)
-- Name: activity activity_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id) ON DELETE CASCADE;


--
-- TOC entry 3288 (class 2606 OID 203469)
-- Name: activity activity_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public."user"(id) ON DELETE SET NULL;


--
-- TOC entry 3292 (class 2606 OID 203493)
-- Name: activity_day_jouriors ativity_day_jouriors_jury_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_day_jouriors
    ADD CONSTRAINT ativity_day_jouriors_jury_id_fkey FOREIGN KEY (jury_id) REFERENCES public.jury(user_id) ON DELETE CASCADE;


--
-- TOC entry 3285 (class 2606 OID 203450)
-- Name: event event_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) ON DELETE CASCADE;


--
-- TOC entry 3286 (class 2606 OID 203517)
-- Name: event event_event_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_event_type_id_fkey FOREIGN KEY (event_type_id) REFERENCES public.event_types(id) ON DELETE CASCADE;


--
-- TOC entry 3283 (class 2606 OID 203434)
-- Name: jury jury_activity_direction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jury
    ADD CONSTRAINT jury_activity_direction_id_fkey FOREIGN KEY (activity_direction_id) REFERENCES public.activity_directions(id) ON DELETE SET NULL;


--
-- TOC entry 3284 (class 2606 OID 203429)
-- Name: jury jury_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jury
    ADD CONSTRAINT jury_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3280 (class 2606 OID 203409)
-- Name: moderator moderator_activity_direction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderator
    ADD CONSTRAINT moderator_activity_direction_id_fkey FOREIGN KEY (activity_direction_id) REFERENCES public.activity_directions(id) ON DELETE SET NULL;


--
-- TOC entry 3281 (class 2606 OID 203414)
-- Name: moderator moderator_event_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderator
    ADD CONSTRAINT moderator_event_type_id_fkey FOREIGN KEY (event_type_id) REFERENCES public.event_types(id) ON DELETE SET NULL;


--
-- TOC entry 3282 (class 2606 OID 203419)
-- Name: moderator moderator_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderator
    ADD CONSTRAINT moderator_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- TOC entry 3279 (class 2606 OID 203399)
-- Name: user user_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id) ON DELETE SET DEFAULT;


-- Completed on 2025-03-07 20:07:05

--
-- PostgreSQL database dump complete
--

