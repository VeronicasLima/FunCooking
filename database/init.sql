--
-- PostgreSQL database dump
--

\restrict PeajPmJjeBkw1jH1kiBx9zcNtdJAulO0cvjJgVvEzciLTNipDjzZrHqpdtKLwYg

-- Dumped from database version 18.7
-- Dumped by pg_dump version 18.7

-- Started on 2026-11-24 15:05:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 16592)
-- Name: alerta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alerta (
    id_alerta integer NOT NULL,
    id_utilizador integer NOT NULL,
    id_despensa integer NOT NULL,
    tipo character varying(50) NOT NULL,
    mensagem text NOT NULL,
    data_alerta timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 231 (class 1259 OID 16591)
-- Name: alerta_id_alerta_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alerta_id_alerta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 231
-- Name: alerta_id_alerta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alerta_id_alerta_seq OWNED BY public.alerta.id_alerta;


--
-- TOC entry 234 (class 1259 OID 16617)
-- Name: conteudo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conteudo (
    id_conteudo integer NOT NULL,
    id_utilizador integer NOT NULL,
    titulo character varying(150) NOT NULL,
    descricao text,
    tipo_publicacao character varying(50),
    data_publicacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 233 (class 1259 OID 16616)
-- Name: conteudo_id_conteudo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conteudo_id_conteudo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 233
-- Name: conteudo_id_conteudo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conteudo_id_conteudo_seq OWNED BY public.conteudo.id_conteudo;


--
-- TOC entry 227 (class 1259 OID 16535)
-- Name: despensa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.despensa (
    id_despensa integer NOT NULL,
    id_ingrediente integer NOT NULL,
    id_utilizador integer NOT NULL,
    quantidade numeric(10,2) NOT NULL,
    data_validade date
);


--
-- TOC entry 226 (class 1259 OID 16534)
-- Name: despensa_id_despensa_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.despensa_id_despensa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 226
-- Name: despensa_id_despensa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.despensa_id_despensa_seq OWNED BY public.despensa.id_despensa;


--
-- TOC entry 224 (class 1259 OID 16447)
-- Name: ingrediente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingrediente (
    id_ingrediente integer CONSTRAINT ingredientes_id_ingredientes_not_null NOT NULL,
    nome character varying(100) CONSTRAINT ingredientes_nome_not_null NOT NULL,
    unidade_medida character varying(30) CONSTRAINT ingredientes_unidade_medida_not_null NOT NULL,
    categoria character varying(100)
);


--
-- TOC entry 223 (class 1259 OID 16446)
-- Name: ingredientes_id_ingredientes_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredientes_id_ingredientes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 223
-- Name: ingredientes_id_ingredientes_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredientes_id_ingredientes_seq OWNED BY public.ingrediente.id_ingrediente;


--
-- TOC entry 230 (class 1259 OID 16572)
-- Name: item_lista; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_lista (
    id_lista integer NOT NULL,
    id_ingrediente integer NOT NULL,
    quantidade numeric(10,2) NOT NULL,
    comprado boolean DEFAULT false
);


--
-- TOC entry 229 (class 1259 OID 16556)
-- Name: lista_compras; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lista_compras (
    id_lista integer NOT NULL,
    id_utilizador integer NOT NULL,
    nome character varying(100) NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(30) DEFAULT 'ativa'::character varying
);


--
-- TOC entry 228 (class 1259 OID 16555)
-- Name: lista_compras_id_lista_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lista_compras_id_lista_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 228
-- Name: lista_compras_id_lista_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lista_compras_id_lista_seq OWNED BY public.lista_compras.id_lista;


--
-- TOC entry 222 (class 1259 OID 16429)
-- Name: receita; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.receita (
    id_receita integer NOT NULL,
    id_utilizador integer NOT NULL,
    nome character varying(150) NOT NULL,
    descricao text,
    tempo_preparacao integer,
    conteudo text,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    numero_pessoas integer,
    fotografia text,
    CONSTRAINT receita_numero_pessoas_check CHECK ((numero_pessoas > 0))
);


--
-- TOC entry 221 (class 1259 OID 16428)
-- Name: receita_id_receita_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.receita_id_receita_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 221
-- Name: receita_id_receita_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.receita_id_receita_seq OWNED BY public.receita.id_receita;


--
-- TOC entry 225 (class 1259 OID 16515)
-- Name: receita_ingrediente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.receita_ingrediente (
    id_receita integer NOT NULL,
    id_ingrediente integer NOT NULL,
    quantidade numeric(10,2) NOT NULL,
    unidade character varying(30) NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16411)
-- Name: utilizador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utilizador (
    id_utilizador integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(255) NOT NULL,
    tipo_utilizador character varying(20) DEFAULT 'utilizador'::character varying NOT NULL,
    data_registo timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 219 (class 1259 OID 16410)
-- Name: utilizador_id_utilizador_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.utilizador_id_utilizador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 219
-- Name: utilizador_id_utilizador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.utilizador_id_utilizador_seq OWNED BY public.utilizador.id_utilizador;


--
-- TOC entry 4905 (class 2604 OID 16595)
-- Name: alerta id_alerta; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerta ALTER COLUMN id_alerta SET DEFAULT nextval('public.alerta_id_alerta_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 16620)
-- Name: conteudo id_conteudo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conteudo ALTER COLUMN id_conteudo SET DEFAULT nextval('public.conteudo_id_conteudo_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 16538)
-- Name: despensa id_despensa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.despensa ALTER COLUMN id_despensa SET DEFAULT nextval('public.despensa_id_despensa_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 16450)
-- Name: ingrediente id_ingrediente; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingrediente ALTER COLUMN id_ingrediente SET DEFAULT nextval('public.ingredientes_id_ingredientes_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 16559)
-- Name: lista_compras id_lista; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_compras ALTER COLUMN id_lista SET DEFAULT nextval('public.lista_compras_id_lista_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 16432)
-- Name: receita id_receita; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita ALTER COLUMN id_receita SET DEFAULT nextval('public.receita_id_receita_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 16414)
-- Name: utilizador id_utilizador; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilizador ALTER COLUMN id_utilizador SET DEFAULT nextval('public.utilizador_id_utilizador_seq'::regclass);


--
-- TOC entry 4927 (class 2606 OID 16605)
-- Name: alerta alerta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerta
    ADD CONSTRAINT alerta_pkey PRIMARY KEY (id_alerta);


--
-- TOC entry 4929 (class 2606 OID 16628)
-- Name: conteudo conteudo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conteudo
    ADD CONSTRAINT conteudo_pkey PRIMARY KEY (id_conteudo);


--
-- TOC entry 4921 (class 2606 OID 16544)
-- Name: despensa despensa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.despensa
    ADD CONSTRAINT despensa_pkey PRIMARY KEY (id_despensa);


--
-- TOC entry 4917 (class 2606 OID 16455)
-- Name: ingrediente ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingrediente
    ADD CONSTRAINT ingredientes_pkey PRIMARY KEY (id_ingrediente);


--
-- TOC entry 4925 (class 2606 OID 16580)
-- Name: item_lista item_lista_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_lista
    ADD CONSTRAINT item_lista_pkey PRIMARY KEY (id_lista, id_ingrediente);


--
-- TOC entry 4923 (class 2606 OID 16566)
-- Name: lista_compras lista_compras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_compras
    ADD CONSTRAINT lista_compras_pkey PRIMARY KEY (id_lista);


--
-- TOC entry 4919 (class 2606 OID 16523)
-- Name: receita_ingrediente receita_ingrediente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita_ingrediente
    ADD CONSTRAINT receita_ingrediente_pkey PRIMARY KEY (id_receita, id_ingrediente);


--
-- TOC entry 4915 (class 2606 OID 16440)
-- Name: receita receita_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT receita_pkey PRIMARY KEY (id_receita);


--
-- TOC entry 4911 (class 2606 OID 16427)
-- Name: utilizador utilizador_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilizador
    ADD CONSTRAINT utilizador_email_key UNIQUE (email);


--
-- TOC entry 4913 (class 2606 OID 16425)
-- Name: utilizador utilizador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilizador
    ADD CONSTRAINT utilizador_pkey PRIMARY KEY (id_utilizador);


--
-- TOC entry 4938 (class 2606 OID 16611)
-- Name: alerta alerta_id_despensa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerta
    ADD CONSTRAINT alerta_id_despensa_fkey FOREIGN KEY (id_despensa) REFERENCES public.despensa(id_despensa);


--
-- TOC entry 4939 (class 2606 OID 16606)
-- Name: alerta alerta_id_utilizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alerta
    ADD CONSTRAINT alerta_id_utilizador_fkey FOREIGN KEY (id_utilizador) REFERENCES public.utilizador(id_utilizador);


--
-- TOC entry 4940 (class 2606 OID 16629)
-- Name: conteudo conteudo_id_utilizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conteudo
    ADD CONSTRAINT conteudo_id_utilizador_fkey FOREIGN KEY (id_utilizador) REFERENCES public.utilizador(id_utilizador);


--
-- TOC entry 4933 (class 2606 OID 16545)
-- Name: despensa despensa_id_ingrediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.despensa
    ADD CONSTRAINT despensa_id_ingrediente_fkey FOREIGN KEY (id_ingrediente) REFERENCES public.ingrediente(id_ingrediente);


--
-- TOC entry 4934 (class 2606 OID 16550)
-- Name: despensa despensa_id_utilizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.despensa
    ADD CONSTRAINT despensa_id_utilizador_fkey FOREIGN KEY (id_utilizador) REFERENCES public.utilizador(id_utilizador);


--
-- TOC entry 4931 (class 2606 OID 16529)
-- Name: receita_ingrediente fk_receita_ingrediente_ingrediente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita_ingrediente
    ADD CONSTRAINT fk_receita_ingrediente_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES public.ingrediente(id_ingrediente);


--
-- TOC entry 4932 (class 2606 OID 16524)
-- Name: receita_ingrediente fk_receita_ingrediente_receita; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita_ingrediente
    ADD CONSTRAINT fk_receita_ingrediente_receita FOREIGN KEY (id_receita) REFERENCES public.receita(id_receita);


--
-- TOC entry 4930 (class 2606 OID 16441)
-- Name: receita fk_receita_utilizador; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT fk_receita_utilizador FOREIGN KEY (id_utilizador) REFERENCES public.utilizador(id_utilizador);


--
-- TOC entry 4936 (class 2606 OID 16586)
-- Name: item_lista item_lista_id_ingrediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_lista
    ADD CONSTRAINT item_lista_id_ingrediente_fkey FOREIGN KEY (id_ingrediente) REFERENCES public.ingrediente(id_ingrediente);


--
-- TOC entry 4937 (class 2606 OID 16581)
-- Name: item_lista item_lista_id_lista_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_lista
    ADD CONSTRAINT item_lista_id_lista_fkey FOREIGN KEY (id_lista) REFERENCES public.lista_compras(id_lista);


--
-- TOC entry 4935 (class 2606 OID 16567)
-- Name: lista_compras lista_compras_id_utilizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_compras
    ADD CONSTRAINT lista_compras_id_utilizador_fkey FOREIGN KEY (id_utilizador) REFERENCES public.utilizador(id_utilizador);


-- Completed on 2026-11-24 15:05:24

--
-- PostgreSQL database dump complete
--

\unrestrict PeajPmJjeBkw1jH1kiBx9zcNtdJAulO0cvjJgVvEzciLTNipDjzZrHqpdtKLwYg

INSERT INTO public.ingrediente
    (nome, unidade_medida, categoria)
VALUES
    ('Leite', 'ml', 'Laticinios'),
    ('Ovos', 'unidade', 'Ovos'),
    ('Arroz', 'g', 'Cereais'),
    ('Massa', 'g', 'Cereais'),
    ('Natas', 'ml', 'Laticinios'),
    ('Cenoura', 'g', 'Legumes'),
    ('Cebola', 'g', 'Legumes'),
    ('Batata', 'g', 'Legumes'),
    ('Queijo', 'g', 'Laticinios'),
    ('Atum', 'g', 'Peixe');
    