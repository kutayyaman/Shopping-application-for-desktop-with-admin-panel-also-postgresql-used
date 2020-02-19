--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 12rc1

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
-- Name: FaturaOlusturFONKSIYON(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."FaturaOlusturFONKSIYON"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Fatura"("UrunUyeID","Tarih")
    VALUES(NEW."UrunUyeID",CURRENT_TIMESTAMP::TIMESTAMP);
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."FaturaOlusturFONKSIYON"() OWNER TO postgres;

--
-- Name: KategoriEkle(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."KategoriEkle"(kategoriadi character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Kategori"("KategoriAdi") VALUES(kategoriAdi);
    
END
$$;


ALTER FUNCTION public."KategoriEkle"(kategoriadi character varying) OWNER TO postgres;

--
-- Name: NeZamanUyeOlduFONKSIYON(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."NeZamanUyeOlduFONKSIYON"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "NeZamanUyeOldu"("UyeID","UyeOlmaTarihi")
    VALUES(NEW."UyeID",CURRENT_TIMESTAMP::TIMESTAMP);
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."NeZamanUyeOlduFONKSIYON"() OWNER TO postgres;

--
-- Name: YeniUyeKullanici(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."YeniUyeKullanici"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Kullanici"("UyeID") VALUES(NEW."UyeID");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."YeniUyeKullanici"() OWNER TO postgres;

--
-- Name: aldigiUrunMiktariniGetir(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."aldigiUrunMiktariniGetir"(uyeid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
miktar INTEGER;
BEGIN
    miktar:= (SELECT count(*) FROM "UrunUye" WHERE "UyeID"=uyeID);
    RETURN miktar;
END
$$;


ALTER FUNCTION public."aldigiUrunMiktariniGetir"(uyeid integer) OWNER TO postgres;

--
-- Name: urunYuzdeIndirimliHaliGetir(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunYuzdeIndirimliHaliGetir"(yuzdeindirim double precision) RETURNS TABLE("urunAdi" character varying, fiyati double precision, "indirimliFiyati" double precision)
    LANGUAGE plpgsql
    AS $$
DECLARE
miktar DOUBLE PRECISION;
BEGIN
miktar:=yuzdeIndirim*0.01;
    RETURN QUERY SELECT "UrunAdi","Fiyati","Fiyati"*miktar FROM "Urun";
END
$$;


ALTER FUNCTION public."urunYuzdeIndirimliHaliGetir"(yuzdeindirim double precision) OWNER TO postgres;

--
-- Name: uyeIletisimGetir(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."uyeIletisimGetir"(id integer) RETURNS TABLE(kullaniciadi character varying, adres character varying, telefon character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "KullaniciAdi", "Adres", "Telefon" FROM "Uye" WHERE "UyeID"=id;
END
$$;


ALTER FUNCTION public."uyeIletisimGetir"(id integer) OWNER TO postgres;

--
-- Name: uyeSilindi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."uyeSilindi"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "SilinenUye" ("KullaniciAdi","Sifre","Telefon","Adres","Bakiye","Eposta","UyeTuru","UyeID","SilinmeTarihi") VALUES(OLD."KullaniciAdi",OLD."Sifre",OLD."Telefon",OLD."Adres",OLD."Bakiye",OLD."Eposta",OLD."UyeTuru",OLD."UyeID",CURRENT_TIMESTAMP::TIMESTAMP);
    RETURN OLD;
END
$$;


ALTER FUNCTION public."uyeSilindi"() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: Admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Admin" (
    "UyeID" integer NOT NULL
);


ALTER TABLE public."Admin" OWNER TO postgres;

--
-- Name: AlisverisSepeti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AlisverisSepeti" (
    "AlisverisSepetiID" integer NOT NULL
);


ALTER TABLE public."AlisverisSepeti" OWNER TO postgres;

--
-- Name: AlisverisSepeti_AlisverisSepetiID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AlisverisSepeti_AlisverisSepetiID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AlisverisSepeti_AlisverisSepetiID_seq" OWNER TO postgres;

--
-- Name: AlisverisSepeti_AlisverisSepetiID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AlisverisSepeti_AlisverisSepetiID_seq" OWNED BY public."AlisverisSepeti"."AlisverisSepetiID";


--
-- Name: Duyurular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Duyurular" (
    "DuyuruID" integer NOT NULL,
    "Aciklama" character varying(240),
    "Baslik" character varying(60)
);


ALTER TABLE public."Duyurular" OWNER TO postgres;

--
-- Name: Duyurular_DuyuruID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Duyurular_DuyuruID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Duyurular_DuyuruID_seq" OWNER TO postgres;

--
-- Name: Duyurular_DuyuruID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Duyurular_DuyuruID_seq" OWNED BY public."Duyurular"."DuyuruID";


--
-- Name: Fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Fatura" (
    "FaturaID" integer NOT NULL,
    "UrunUyeID" integer,
    "Tarih" timestamp without time zone
);


ALTER TABLE public."Fatura" OWNER TO postgres;

--
-- Name: Fatura_FaturaID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Fatura_FaturaID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Fatura_FaturaID_seq" OWNER TO postgres;

--
-- Name: Fatura_FaturaID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Fatura_FaturaID_seq" OWNED BY public."Fatura"."FaturaID";


--
-- Name: KargoFirmasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KargoFirmasi" (
    "KargoFirmasiID" integer NOT NULL,
    "Adi" character varying(40) NOT NULL,
    "Adresi" character varying(240)
);


ALTER TABLE public."KargoFirmasi" OWNER TO postgres;

--
-- Name: KargoFirmasi_KargoFirmasiID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KargoFirmasi_KargoFirmasiID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KargoFirmasi_KargoFirmasiID_seq" OWNER TO postgres;

--
-- Name: KargoFirmasi_KargoFirmasiID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KargoFirmasi_KargoFirmasiID_seq" OWNED BY public."KargoFirmasi"."KargoFirmasiID";


--
-- Name: Kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kategori" (
    "KategoriID" integer NOT NULL,
    "KategoriAdi" character varying(50) NOT NULL
);


ALTER TABLE public."Kategori" OWNER TO postgres;

--
-- Name: KategoriUrun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KategoriUrun" (
    "KategoriUrunID" integer NOT NULL,
    "KategoriID" integer,
    "UrunID" integer
);


ALTER TABLE public."KategoriUrun" OWNER TO postgres;

--
-- Name: KategoriUrun_KategoriUrunID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KategoriUrun_KategoriUrunID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KategoriUrun_KategoriUrunID_seq" OWNER TO postgres;

--
-- Name: KategoriUrun_KategoriUrunID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KategoriUrun_KategoriUrunID_seq" OWNED BY public."KategoriUrun"."KategoriUrunID";


--
-- Name: Kategori_KategoriID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kategori_KategoriID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kategori_KategoriID_seq" OWNER TO postgres;

--
-- Name: Kategori_KategoriID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kategori_KategoriID_seq" OWNED BY public."Kategori"."KategoriID";


--
-- Name: Kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kullanici" (
    "UyeID" integer NOT NULL
);


ALTER TABLE public."Kullanici" OWNER TO postgres;

--
-- Name: NeZamanUyeOldu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."NeZamanUyeOldu" (
    "NeZamanUyeOlduPK" integer NOT NULL,
    "UyeID" integer,
    "UyeOlmaTarihi" timestamp without time zone
);


ALTER TABLE public."NeZamanUyeOldu" OWNER TO postgres;

--
-- Name: NeZamanUyeOldu_NeZamanUyeOlduPK_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."NeZamanUyeOldu_NeZamanUyeOlduPK_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."NeZamanUyeOldu_NeZamanUyeOlduPK_seq" OWNER TO postgres;

--
-- Name: NeZamanUyeOldu_NeZamanUyeOlduPK_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."NeZamanUyeOldu_NeZamanUyeOlduPK_seq" OWNED BY public."NeZamanUyeOldu"."NeZamanUyeOlduPK";


--
-- Name: SilinenUye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SilinenUye" (
    "SilinenUyeID" integer NOT NULL,
    "KullaniciAdi" character varying(40),
    "Sifre" character varying(40),
    "Telefon" character varying(40),
    "Adres" character varying(240),
    "Bakiye" double precision,
    "Eposta" character varying(120),
    "UyeTuru" character(1),
    "UyeID" integer,
    "SilinmeTarihi" timestamp without time zone
);


ALTER TABLE public."SilinenUye" OWNER TO postgres;

--
-- Name: SilinenUye_SilinenUyeID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SilinenUye_SilinenUyeID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SilinenUye_SilinenUyeID_seq" OWNER TO postgres;

--
-- Name: SilinenUye_SilinenUyeID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SilinenUye_SilinenUyeID_seq" OWNED BY public."SilinenUye"."SilinenUyeID";


--
-- Name: Urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Urun" (
    "UrunID" integer NOT NULL,
    "UrunAdi" character varying(100) NOT NULL,
    "Aciklama" character varying(240),
    "Stok" character varying(10),
    "Fiyati" double precision NOT NULL
);


ALTER TABLE public."Urun" OWNER TO postgres;

--
-- Name: UrunAlisverisSepeti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunAlisverisSepeti" (
    "UrunAlisverisSepetiID" integer NOT NULL,
    "UrunID" integer,
    "AlisverisSepetiID" integer
);


ALTER TABLE public."UrunAlisverisSepeti" OWNER TO postgres;

--
-- Name: UrunAlisverisSepeti_UrunAlisverisSepetiID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunAlisverisSepeti_UrunAlisverisSepetiID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunAlisverisSepeti_UrunAlisverisSepetiID_seq" OWNER TO postgres;

--
-- Name: UrunAlisverisSepeti_UrunAlisverisSepetiID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunAlisverisSepeti_UrunAlisverisSepetiID_seq" OWNED BY public."UrunAlisverisSepeti"."UrunAlisverisSepetiID";


--
-- Name: UrunUye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunUye" (
    "UrunUyeID" integer NOT NULL,
    "UrunID" integer,
    "UyeID" integer,
    "KargoFirmasiID" integer
);


ALTER TABLE public."UrunUye" OWNER TO postgres;

--
-- Name: UrunUye_UrunUyeID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunUye_UrunUyeID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunUye_UrunUyeID_seq" OWNER TO postgres;

--
-- Name: UrunUye_UrunUyeID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunUye_UrunUyeID_seq" OWNED BY public."UrunUye"."UrunUyeID";


--
-- Name: Urun_UrunID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Urun_UrunID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Urun_UrunID_seq" OWNER TO postgres;

--
-- Name: Urun_UrunID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Urun_UrunID_seq" OWNED BY public."Urun"."UrunID";


--
-- Name: Uye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Uye" (
    "UyeID" integer NOT NULL,
    "KullaniciAdi" character varying(40) NOT NULL,
    "Sifre" character varying(40) NOT NULL,
    "Telefon" character varying(40),
    "Adres" character varying(240),
    "Bakiye" double precision DEFAULT 0,
    "Eposta" character varying(120),
    "UyeTuru" character varying(1),
    "AlisverisSepetiID" integer NOT NULL
);


ALTER TABLE public."Uye" OWNER TO postgres;

--
-- Name: Uye_UyeID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Uye_UyeID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Uye_UyeID_seq" OWNER TO postgres;

--
-- Name: Uye_UyeID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Uye_UyeID_seq" OWNED BY public."Uye"."UyeID";


--
-- Name: AlisverisSepeti AlisverisSepetiID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlisverisSepeti" ALTER COLUMN "AlisverisSepetiID" SET DEFAULT nextval('public."AlisverisSepeti_AlisverisSepetiID_seq"'::regclass);


--
-- Name: Duyurular DuyuruID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Duyurular" ALTER COLUMN "DuyuruID" SET DEFAULT nextval('public."Duyurular_DuyuruID_seq"'::regclass);


--
-- Name: Fatura FaturaID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura" ALTER COLUMN "FaturaID" SET DEFAULT nextval('public."Fatura_FaturaID_seq"'::regclass);


--
-- Name: KargoFirmasi KargoFirmasiID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KargoFirmasi" ALTER COLUMN "KargoFirmasiID" SET DEFAULT nextval('public."KargoFirmasi_KargoFirmasiID_seq"'::regclass);


--
-- Name: Kategori KategoriID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategori" ALTER COLUMN "KategoriID" SET DEFAULT nextval('public."Kategori_KategoriID_seq"'::regclass);


--
-- Name: KategoriUrun KategoriUrunID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KategoriUrun" ALTER COLUMN "KategoriUrunID" SET DEFAULT nextval('public."KategoriUrun_KategoriUrunID_seq"'::regclass);


--
-- Name: NeZamanUyeOldu NeZamanUyeOlduPK; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."NeZamanUyeOldu" ALTER COLUMN "NeZamanUyeOlduPK" SET DEFAULT nextval('public."NeZamanUyeOldu_NeZamanUyeOlduPK_seq"'::regclass);


--
-- Name: SilinenUye SilinenUyeID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SilinenUye" ALTER COLUMN "SilinenUyeID" SET DEFAULT nextval('public."SilinenUye_SilinenUyeID_seq"'::regclass);


--
-- Name: Urun UrunID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Urun" ALTER COLUMN "UrunID" SET DEFAULT nextval('public."Urun_UrunID_seq"'::regclass);


--
-- Name: UrunAlisverisSepeti UrunAlisverisSepetiID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunAlisverisSepeti" ALTER COLUMN "UrunAlisverisSepetiID" SET DEFAULT nextval('public."UrunAlisverisSepeti_UrunAlisverisSepetiID_seq"'::regclass);


--
-- Name: UrunUye UrunUyeID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunUye" ALTER COLUMN "UrunUyeID" SET DEFAULT nextval('public."UrunUye_UrunUyeID_seq"'::regclass);


--
-- Name: Uye UyeID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye" ALTER COLUMN "UyeID" SET DEFAULT nextval('public."Uye_UyeID_seq"'::regclass);


--
-- Data for Name: Admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Admin" VALUES (3);
INSERT INTO public."Admin" VALUES (14);


--
-- Data for Name: AlisverisSepeti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AlisverisSepeti" VALUES (1);
INSERT INTO public."AlisverisSepeti" VALUES (2);
INSERT INTO public."AlisverisSepeti" VALUES (3);
INSERT INTO public."AlisverisSepeti" VALUES (4);
INSERT INTO public."AlisverisSepeti" VALUES (5);
INSERT INTO public."AlisverisSepeti" VALUES (6);
INSERT INTO public."AlisverisSepeti" VALUES (7);
INSERT INTO public."AlisverisSepeti" VALUES (8);
INSERT INTO public."AlisverisSepeti" VALUES (9);
INSERT INTO public."AlisverisSepeti" VALUES (10);
INSERT INTO public."AlisverisSepeti" VALUES (11);
INSERT INTO public."AlisverisSepeti" VALUES (12);
INSERT INTO public."AlisverisSepeti" VALUES (22);
INSERT INTO public."AlisverisSepeti" VALUES (23);
INSERT INTO public."AlisverisSepeti" VALUES (24);
INSERT INTO public."AlisverisSepeti" VALUES (25);
INSERT INTO public."AlisverisSepeti" VALUES (26);
INSERT INTO public."AlisverisSepeti" VALUES (38);
INSERT INTO public."AlisverisSepeti" VALUES (39);
INSERT INTO public."AlisverisSepeti" VALUES (40);
INSERT INTO public."AlisverisSepeti" VALUES (41);
INSERT INTO public."AlisverisSepeti" VALUES (42);
INSERT INTO public."AlisverisSepeti" VALUES (43);
INSERT INTO public."AlisverisSepeti" VALUES (44);
INSERT INTO public."AlisverisSepeti" VALUES (45);
INSERT INTO public."AlisverisSepeti" VALUES (46);
INSERT INTO public."AlisverisSepeti" VALUES (47);


--
-- Data for Name: Duyurular; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Duyurular" VALUES (1, 'UYELIK ALIMLARIMIZ KISA SURELIGNE DURDURULMUSTUR', 'UYELIK SISTEMI');
INSERT INTO public."Duyurular" VALUES (3, 'IKINCI KEZ DENIYORUM', 'IKINCI DENEM');
INSERT INTO public."Duyurular" VALUES (12, 'ADMIN ALIMLARI ICIN xyx@hotmail.com adresinden ulasabilirsiniz', 'ADMIN ALIMI');
INSERT INTO public."Duyurular" VALUES (14, 'asdjkgdfgldfg', 'yeni duyuru');
INSERT INTO public."Duyurular" VALUES (15, 'uygulama guncellenmistir bazi sorunlar fixlendi.', 'guncelleme');


--
-- Data for Name: Fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Fatura" VALUES (1, 4, NULL);
INSERT INTO public."Fatura" VALUES (2, 6, '2019-12-06 01:34:11.232093');
INSERT INTO public."Fatura" VALUES (3, 7, '2019-12-07 00:16:59.572631');
INSERT INTO public."Fatura" VALUES (4, 8, '2019-12-07 00:16:59.592966');
INSERT INTO public."Fatura" VALUES (5, 9, '2019-12-07 00:17:02.698468');
INSERT INTO public."Fatura" VALUES (6, 10, '2019-12-07 00:19:24.942561');
INSERT INTO public."Fatura" VALUES (7, 11, '2019-12-07 00:20:19.984177');
INSERT INTO public."Fatura" VALUES (8, 12, '2019-12-07 00:20:19.998862');
INSERT INTO public."Fatura" VALUES (9, 13, '2019-12-07 00:20:24.195263');


--
-- Data for Name: KargoFirmasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KargoFirmasi" VALUES (1, 'A KARGOSU', 'B BINASININ YANI');
INSERT INTO public."KargoFirmasi" VALUES (2, 'B KARGOSU', 'C BINASININ YANI');


--
-- Data for Name: Kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kategori" VALUES (1, 'TELEFON');
INSERT INTO public."Kategori" VALUES (2, 'BILGISAYAR');
INSERT INTO public."Kategori" VALUES (3, 'BEYAZ ESYA');
INSERT INTO public."Kategori" VALUES (4, 'Ev Esyasi');
INSERT INTO public."Kategori" VALUES (5, 'kategoriAdi');
INSERT INTO public."Kategori" VALUES (6, 'Kozmetik');
INSERT INTO public."Kategori" VALUES (7, 'Gaming');


--
-- Data for Name: KategoriUrun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KategoriUrun" VALUES (1, 1, 2);
INSERT INTO public."KategoriUrun" VALUES (2, 2, 3);
INSERT INTO public."KategoriUrun" VALUES (3, 3, 4);
INSERT INTO public."KategoriUrun" VALUES (4, 4, 5);
INSERT INTO public."KategoriUrun" VALUES (5, 6, 6);
INSERT INTO public."KategoriUrun" VALUES (6, 7, 7);


--
-- Data for Name: Kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kullanici" VALUES (2);
INSERT INTO public."Kullanici" VALUES (3);
INSERT INTO public."Kullanici" VALUES (4);
INSERT INTO public."Kullanici" VALUES (7);
INSERT INTO public."Kullanici" VALUES (10);
INSERT INTO public."Kullanici" VALUES (11);
INSERT INTO public."Kullanici" VALUES (12);
INSERT INTO public."Kullanici" VALUES (13);
INSERT INTO public."Kullanici" VALUES (19);
INSERT INTO public."Kullanici" VALUES (25);
INSERT INTO public."Kullanici" VALUES (26);
INSERT INTO public."Kullanici" VALUES (41);
INSERT INTO public."Kullanici" VALUES (44);
INSERT INTO public."Kullanici" VALUES (46);
INSERT INTO public."Kullanici" VALUES (47);
INSERT INTO public."Kullanici" VALUES (48);
INSERT INTO public."Kullanici" VALUES (1);
INSERT INTO public."Kullanici" VALUES (50);


--
-- Data for Name: NeZamanUyeOldu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."NeZamanUyeOldu" VALUES (1, 25, '2019-12-05 23:19:40.763704');
INSERT INTO public."NeZamanUyeOldu" VALUES (9, NULL, '2019-12-06 00:26:19.816004');
INSERT INTO public."NeZamanUyeOldu" VALUES (10, NULL, '2019-12-06 00:28:29.594625');
INSERT INTO public."NeZamanUyeOldu" VALUES (14, 46, '2019-12-06 00:58:06.465768');
INSERT INTO public."NeZamanUyeOldu" VALUES (15, 47, '2019-12-06 00:59:30.911307');
INSERT INTO public."NeZamanUyeOldu" VALUES (16, 48, '2019-12-06 01:02:32.496193');
INSERT INTO public."NeZamanUyeOldu" VALUES (18, 50, '2019-12-06 22:03:31.458645');


--
-- Data for Name: SilinenUye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."SilinenUye" VALUES (1, 'yepyeni111111', '123', '23443', 'aaaa', 20, 'aaaa', 'K', 39, '2019-12-06 19:26:56.610275');
INSERT INTO public."SilinenUye" VALUES (3, 'asdasd11111', '123', 'asdasd', 'sadsadasd', 20, 'asdasdasd1', 'K', 27, '2019-12-06 21:57:49.311811');
INSERT INTO public."SilinenUye" VALUES (6, 'yenikullanicii65', '123', '123', 'qwe', 20, 'qwe', 'K', 49, '2019-12-06 22:07:37.905901');
INSERT INTO public."SilinenUye" VALUES (7, 'deneme', '123', '666666', 'asdasd', 123, 'asdsad', 'K', 6, '2019-12-06 22:14:17.06524');


--
-- Data for Name: Urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Urun" VALUES (2, 'X TELEFONU', 'FIYAT PERFORMANS URUNU', '11', 59.990000000000002);
INSERT INTO public."Urun" VALUES (3, 'Y Bilgisayari', '4GB RAM i5 7. nesil islemci 480 GB SSD ', '124', 1899.99000000000001);
INSERT INTO public."Urun" VALUES (4, 'BUZDOLABI', 'DERIN DONDURUCULU BUZDOLABI', '87', 249.990000000000009);
INSERT INTO public."Urun" VALUES (7, 'Kulaklik', '7.1 DESTEKLI GAMING KULAKLIK', '38', 199.990000000000009);
INSERT INTO public."Urun" VALUES (6, 'Diş Macunu', '3 BOYUTLU BEYAZLIK', '521', 9.99000000000000021);
INSERT INTO public."Urun" VALUES (5, 'Kilim', 'Yerli Uretim Kilim', '155', 19.9899999999999984);


--
-- Data for Name: UrunAlisverisSepeti; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: UrunUye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UrunUye" VALUES (1, 2, 1, 1);
INSERT INTO public."UrunUye" VALUES (2, 2, 2, NULL);
INSERT INTO public."UrunUye" VALUES (3, 2, 2, NULL);
INSERT INTO public."UrunUye" VALUES (4, 2, 2, NULL);
INSERT INTO public."UrunUye" VALUES (6, 2, 2, NULL);
INSERT INTO public."UrunUye" VALUES (7, 6, 2, NULL);
INSERT INTO public."UrunUye" VALUES (8, 7, 2, NULL);
INSERT INTO public."UrunUye" VALUES (9, 6, 2, NULL);
INSERT INTO public."UrunUye" VALUES (10, 6, 2, NULL);
INSERT INTO public."UrunUye" VALUES (11, 6, 2, NULL);
INSERT INTO public."UrunUye" VALUES (12, 6, 2, NULL);
INSERT INTO public."UrunUye" VALUES (13, 5, 2, NULL);


--
-- Data for Name: Uye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Uye" VALUES (41, 'yeni111111', '123', '23443', 'aaaa', 20, 'aaaa', 'K', 39);
INSERT INTO public."Uye" VALUES (44, 'simdiuyeoldu', '123', '123', '123', 20, '123', 'K', 41);
INSERT INTO public."Uye" VALUES (46, 'uyeee222', '2222', '222', '22', 20, '22', 'K', 43);
INSERT INTO public."Uye" VALUES (47, 'uyeee2225', '2222', '222', '22', 20, '22', 'K', 44);
INSERT INTO public."Uye" VALUES (48, 'ensonuyebu', '123', '123', '123', 20, '123', 'K', 45);
INSERT INTO public."Uye" VALUES (10, 'kullaniciKaydi', '123', '9999955544', 'asddfgdfsdf', 651, 'example@hotmail.com', 'K', 7);
INSERT INTO public."Uye" VALUES (1, 'kutay', '123', '5380160925', 'KKKKKKKK', 158, 'KKKK@gmail.com', 'K', 1);
INSERT INTO public."Uye" VALUES (14, 'badonline', '123', '05345800860', 'istanbul\fatih', 567.019999999999982, 'bahadirgungor95@gmail.com', 'A', 11);
INSERT INTO public."Uye" VALUES (50, 'asdsad', 'asdasdasd', '2324234', 'asdsad', 20, 'asdasdsad', 'K', 47);
INSERT INTO public."Uye" VALUES (3, 'admin', '123', '5555555', 'istanbul bayrampasa', 187, 'degistirrrrr@hotmail.com', 'A', 3);
INSERT INTO public."Uye" VALUES (4, 'yeniuye', '123', '6354577788', 'ankara kizilay', 687, 'yeniuye@gmail.com', 'K', 4);
INSERT INTO public."Uye" VALUES (7, 'ali2', '123', '666666', 'asdasd', 123, 'asdsad', 'K', 6);
INSERT INTO public."Uye" VALUES (11, 'bahadir', '123', '123', 'istanbul balat', 0, 'bahadir@gmail.com', 'K', 8);
INSERT INTO public."Uye" VALUES (12, 'bahadir1', '123', '123', 'qwe', 20, 'qwe', 'K', 9);
INSERT INTO public."Uye" VALUES (13, 'kutay2', '123', '123', 'qwe', 20, 'qwe', 'K', 10);
INSERT INTO public."Uye" VALUES (19, 'sdf', 'sdf', '234234', 'sdfsdf', 342, 'sdfsdf', 'K', 12);
INSERT INTO public."Uye" VALUES (2, 'kullanici', '123', '22222', 'bobobobobob', 77.1299999999999528, '11bobobobo@gmail.com', 'K', 2);
INSERT INTO public."Uye" VALUES (25, 'aaaaa', '123', '123123123', 'aaaaa', 123, 'aaaaa', 'K', 22);
INSERT INTO public."Uye" VALUES (26, 'aa111', '123', '1111', 'asdadads', 20, '123123', 'K', 25);


--
-- Name: AlisverisSepeti_AlisverisSepetiID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AlisverisSepeti_AlisverisSepetiID_seq"', 47, true);


--
-- Name: Duyurular_DuyuruID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Duyurular_DuyuruID_seq"', 15, true);


--
-- Name: Fatura_FaturaID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Fatura_FaturaID_seq"', 9, true);


--
-- Name: KargoFirmasi_KargoFirmasiID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KargoFirmasi_KargoFirmasiID_seq"', 2, true);


--
-- Name: KategoriUrun_KategoriUrunID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KategoriUrun_KategoriUrunID_seq"', 6, true);


--
-- Name: Kategori_KategoriID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kategori_KategoriID_seq"', 7, true);


--
-- Name: NeZamanUyeOldu_NeZamanUyeOlduPK_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."NeZamanUyeOldu_NeZamanUyeOlduPK_seq"', 18, true);


--
-- Name: SilinenUye_SilinenUyeID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SilinenUye_SilinenUyeID_seq"', 7, true);


--
-- Name: UrunAlisverisSepeti_UrunAlisverisSepetiID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunAlisverisSepeti_UrunAlisverisSepetiID_seq"', 1, false);


--
-- Name: UrunUye_UrunUyeID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunUye_UrunUyeID_seq"', 13, true);


--
-- Name: Urun_UrunID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Urun_UrunID_seq"', 7, true);


--
-- Name: Uye_UyeID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Uye_UyeID_seq"', 50, true);


--
-- Name: Admin AdminPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "AdminPK" PRIMARY KEY ("UyeID");


--
-- Name: AlisverisSepeti AlisverisSepetiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AlisverisSepeti"
    ADD CONSTRAINT "AlisverisSepetiPK" PRIMARY KEY ("AlisverisSepetiID");


--
-- Name: Duyurular DuyuruPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Duyurular"
    ADD CONSTRAINT "DuyuruPK" PRIMARY KEY ("DuyuruID");


--
-- Name: Fatura FaturaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "FaturaPK" PRIMARY KEY ("FaturaID");


--
-- Name: KargoFirmasi KargoFirmasiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KargoFirmasi"
    ADD CONSTRAINT "KargoFirmasiPK" PRIMARY KEY ("KargoFirmasiID");


--
-- Name: Kategori KategoriPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategori"
    ADD CONSTRAINT "KategoriPK" PRIMARY KEY ("KategoriID");


--
-- Name: KategoriUrun KategoriUrunPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KategoriUrun"
    ADD CONSTRAINT "KategoriUrunPK" PRIMARY KEY ("KategoriUrunID");


--
-- Name: Kullanici KullaniciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "KullaniciPK" PRIMARY KEY ("UyeID");


--
-- Name: NeZamanUyeOldu NeZamanUyeOlduPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."NeZamanUyeOldu"
    ADD CONSTRAINT "NeZamanUyeOlduPK" PRIMARY KEY ("NeZamanUyeOlduPK");


--
-- Name: SilinenUye SilinenUyePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SilinenUye"
    ADD CONSTRAINT "SilinenUyePK" PRIMARY KEY ("SilinenUyeID");


--
-- Name: Uye UNIQUE_KULLANICIADI; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "UNIQUE_KULLANICIADI" UNIQUE ("KullaniciAdi");


--
-- Name: UrunAlisverisSepeti UrunAlisverisSepetiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunAlisverisSepeti"
    ADD CONSTRAINT "UrunAlisverisSepetiPK" PRIMARY KEY ("UrunAlisverisSepetiID");


--
-- Name: Urun UrunPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Urun"
    ADD CONSTRAINT "UrunPK" PRIMARY KEY ("UrunID");


--
-- Name: UrunUye UrunUyePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunUye"
    ADD CONSTRAINT "UrunUyePK" PRIMARY KEY ("UrunUyeID");


--
-- Name: Uye UyePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "UyePK" PRIMARY KEY ("UyeID");


--
-- Name: Uye unique_Uye_AlisverisSepetiID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "unique_Uye_AlisverisSepetiID" UNIQUE ("AlisverisSepetiID");


--
-- Name: UrunUye FaturaOlusturTRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "FaturaOlusturTRIGGER" AFTER INSERT ON public."UrunUye" FOR EACH ROW EXECUTE PROCEDURE public."FaturaOlusturFONKSIYON"();


--
-- Name: Uye NeZamanUyeOlduTRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "NeZamanUyeOlduTRIGGER" AFTER INSERT ON public."Uye" FOR EACH ROW EXECUTE PROCEDURE public."NeZamanUyeOlduFONKSIYON"();


--
-- Name: Uye YeniUyeKullaniciTRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "YeniUyeKullaniciTRIGGER" AFTER INSERT ON public."Uye" FOR EACH ROW EXECUTE PROCEDURE public."YeniUyeKullanici"();


--
-- Name: Uye uyeSilindiTRIGGER; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "uyeSilindiTRIGGER" BEFORE DELETE ON public."Uye" FOR EACH ROW EXECUTE PROCEDURE public."uyeSilindi"();


--
-- Name: Admin AdminFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "AdminFK1" FOREIGN KEY ("UyeID") REFERENCES public."Uye"("UyeID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Fatura FaturaFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "FaturaFK1" FOREIGN KEY ("UrunUyeID") REFERENCES public."UrunUye"("UrunUyeID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KategoriUrun KategoriUrunFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KategoriUrun"
    ADD CONSTRAINT "KategoriUrunFK1" FOREIGN KEY ("KategoriID") REFERENCES public."Kategori"("KategoriID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KategoriUrun KategoriUrunFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KategoriUrun"
    ADD CONSTRAINT "KategoriUrunFK2" FOREIGN KEY ("UrunID") REFERENCES public."Urun"("UrunID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kullanici KullaniciFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "KullaniciFK1" FOREIGN KEY ("UyeID") REFERENCES public."Uye"("UyeID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: NeZamanUyeOldu NeZamanUyeOlduFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."NeZamanUyeOldu"
    ADD CONSTRAINT "NeZamanUyeOlduFK" FOREIGN KEY ("UyeID") REFERENCES public."Uye"("UyeID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UrunAlisverisSepeti UrunAlisverisSepetiFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunAlisverisSepeti"
    ADD CONSTRAINT "UrunAlisverisSepetiFK1" FOREIGN KEY ("UrunID") REFERENCES public."Urun"("UrunID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UrunAlisverisSepeti UrunAlisverisSepetiFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunAlisverisSepeti"
    ADD CONSTRAINT "UrunAlisverisSepetiFK2" FOREIGN KEY ("AlisverisSepetiID") REFERENCES public."AlisverisSepeti"("AlisverisSepetiID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UrunUye UrunUyeFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunUye"
    ADD CONSTRAINT "UrunUyeFK1" FOREIGN KEY ("UrunID") REFERENCES public."Urun"("UrunID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UrunUye UrunUyeFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunUye"
    ADD CONSTRAINT "UrunUyeFK2" FOREIGN KEY ("UyeID") REFERENCES public."Uye"("UyeID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UrunUye UrunUyeFK3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunUye"
    ADD CONSTRAINT "UrunUyeFK3" FOREIGN KEY ("KargoFirmasiID") REFERENCES public."KargoFirmasi"("KargoFirmasiID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Uye UyeAlisverisSepetiFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "UyeAlisverisSepetiFK" FOREIGN KEY ("AlisverisSepetiID") REFERENCES public."AlisverisSepeti"("AlisverisSepetiID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

