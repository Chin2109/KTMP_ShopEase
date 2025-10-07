--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-10-07 19:29:26

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
-- TOC entry 217 (class 1259 OID 57796)
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id uuid NOT NULL,
    city character varying(255) NOT NULL,
    name character varying(255),
    phone_number character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    street character varying(255) NOT NULL,
    zip_code character varying(255) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 57801)
-- Name: auth_authority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_authority (
    id uuid NOT NULL,
    role_code character varying(255) NOT NULL,
    role_description character varying(255) NOT NULL
);


ALTER TABLE public.auth_authority OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 57806)
-- Name: auth_user_authority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_authority (
    user_id uuid NOT NULL,
    authorities_id uuid NOT NULL
);


ALTER TABLE public.auth_user_authority OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 57809)
-- Name: auth_user_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_details (
    id uuid NOT NULL,
    created_on timestamp(6) without time zone,
    email character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    password character varying(255),
    phone_number character varying(255),
    provider character varying(255),
    updated_on timestamp(6) without time zone,
    verification_code character varying(255)
);


ALTER TABLE public.auth_user_details OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 57814)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 57819)
-- Name: category_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_type (
    id uuid NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    category_id uuid NOT NULL
);


ALTER TABLE public.category_type OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 57824)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid NOT NULL,
    item_price double precision,
    product_variant_id uuid,
    quantity integer NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 57827)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    discount double precision,
    expected_delivery_date timestamp(6) without time zone,
    order_date timestamp(6) without time zone,
    order_status character varying(255) NOT NULL,
    payment_method character varying(255) NOT NULL,
    shipment_tracking_number character varying(255),
    total_amount double precision NOT NULL,
    address_id uuid NOT NULL,
    user_id uuid NOT NULL,
    CONSTRAINT orders_order_status_check CHECK (((order_status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('IN_PROGRESS'::character varying)::text, ('SHIPPED'::character varying)::text, ('DELIVERED'::character varying)::text, ('CANCELLED'::character varying)::text])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 57833)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id uuid NOT NULL,
    amount double precision NOT NULL,
    payment_date timestamp(6) without time zone NOT NULL,
    payment_method character varying(255) NOT NULL,
    payment_status character varying(255) NOT NULL,
    order_id uuid NOT NULL,
    CONSTRAINT payment_payment_status_check CHECK (((payment_status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('COMPLETED'::character varying)::text, ('FAILED'::character varying)::text])))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 57839)
-- Name: product_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_resources (
    id uuid NOT NULL,
    is_primary boolean NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.product_resources OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 57844)
-- Name: product_variant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variant (
    id uuid NOT NULL,
    color character varying(255) NOT NULL,
    size character varying(255) NOT NULL,
    stock_quantity integer NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.product_variant OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 57849)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    brand character varying(255) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    description character varying(255),
    is_new_arrival boolean NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(38,2) NOT NULL,
    rating real,
    slug character varying(255) NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category_id uuid NOT NULL,
    category_type_id uuid NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 4961 (class 0 OID 57796)
-- Dependencies: 217
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, city, name, phone_number, state, street, zip_code, user_id) FROM stdin;
\.


--
-- TOC entry 4962 (class 0 OID 57801)
-- Dependencies: 218
-- Data for Name: auth_authority; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_authority (id, role_code, role_description) FROM stdin;
\.


--
-- TOC entry 4963 (class 0 OID 57806)
-- Dependencies: 219
-- Data for Name: auth_user_authority; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_authority (user_id, authorities_id) FROM stdin;
\.


--
-- TOC entry 4964 (class 0 OID 57809)
-- Dependencies: 220
-- Data for Name: auth_user_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_details (id, created_on, email, enabled, first_name, last_name, password, phone_number, provider, updated_on, verification_code) FROM stdin;
c775026d-67b2-454d-8518-31e3c2bcb936	\N	chinchindethw@gmail.com	t	Huy	Trang	\N	\N	google	\N	\N
b7cd36aa-70aa-4da1-99d9-c27d212b0d2e	\N	chinchindethw123@gmail.com	f			{bcrypt}$2a$10$/i2vZOGcn7StHcs740UA/.YOmWfz7WW4DCIAoOOZfGD0GLIQrha/a	\N	manual	\N	954349
4b2fd91c-2dec-4142-8dd3-9ce5dec77967	\N	huytrang21994@gmail.com	f			{bcrypt}$2a$10$IxmKvYKvrCnSRcg650qB9.A.QVZ7MWCS1mLsOHad6GTxRw1g4OOqq	\N	manual	\N	728000
50800ab9-35b1-402b-b5d4-01f3e3d399d6	\N	jasnaminemine@gmail.com	t	Nguyễn	Hương	\N	\N	google	\N	\N
\.


--
-- TOC entry 4965 (class 0 OID 57814)
-- Dependencies: 221
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, code, description, name) FROM stdin;
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	Women	Women clothes	Women
2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	Men	Men clothes	Men
\.


--
-- TOC entry 4966 (class 0 OID 57819)
-- Dependencies: 222
-- Data for Name: category_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_type (id, code, description, name, category_id) FROM stdin;
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e914	two	Crop Top	Crop Top	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e913	one	Dresses	Dresses	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	three	Shorts	Shorts	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e916	four	Jeans	Jeans	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e917	five	Hoodie/Sweatshirt	Hoodie/Sweatshirt	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e920	six	Jeans	Jeans	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e921	seven	Shirts	Shirts	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e922	eight	Shorts	Shorts	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42
b9f7a5f1-30e1-49a6-83a2-2c93a8b6e924	nine	Hoodie	Hoodie	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42
a1d127dd-509c-4cbd-9c29-58493dc00e8f	TOPS	Hoa	Tops	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
\.


--
-- TOC entry 4967 (class 0 OID 57824)
-- Dependencies: 223
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) FROM stdin;
\.


--
-- TOC entry 4968 (class 0 OID 57827)
-- Dependencies: 224
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) FROM stdin;
\.


--
-- TOC entry 4969 (class 0 OID 57833)
-- Dependencies: 225
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, amount, payment_date, payment_method, payment_status, order_id) FROM stdin;
\.


--
-- TOC entry 4970 (class 0 OID 57839)
-- Dependencies: 226
-- Data for Name: product_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_resources (id, is_primary, name, type, url, product_id) FROM stdin;
db11dffd-5411-49ca-9f3f-e8c4dea6d2bb	f	Picture 1	image	https://codedev.b-cdn.net/a2.png	e13144e3-e540-4117-8e7f-21552b4be47b
f5c9e0f9-465a-4b3a-89c7-ebaf00e6545d	t	thumbnail	thumbnail	https://codedev.b-cdn.net/Screenshot-2025-10-05-230204.png	e13144e3-e540-4117-8e7f-21552b4be47b
a8467cf0-da95-4dcb-9aa4-5b8644c294ee	t	thumbnail	thumbnail	https://codedev.b-cdn.net/Screenshot-2024-03-28-001459.png	7c0b5dde-c8a4-4e0e-930a-ef47c67d1abc
4690fe5c-3d47-4e40-8240-e311a47b7811	t	thumbnail	thumbnail	https://codedev.b-cdn.net/49429dd8a7c82be3672f7bbbc359bdb3.png	caf4b186-8865-48db-a4ab-db311223b788
cb0d28d4-82ff-4928-a9a4-a3ef38aabaea	t	thumbnail	thumbnail	https://codedev.b-cdn.net/474062_SP.avif	7af5f5e9-a1c4-49d5-bb60-c70a35afe114
73d2e965-984d-42ff-8fd5-5e59952a12d7	t	thumbnail	thumbnail	https://codedev.b-cdn.net/e493fe37029c47308d4b2dae57ae0711.webp	8ce27242-3941-4f77-b206-402b5876bf2b
09131bb2-d062-483c-9754-0012ccc8d445	t	thumbnail	thumbnail	https://codedev.b-cdn.net/edcf4a3b25fe8cd7794cd2e35fb0ffa7fb34c2e4_original.jpeg	ccc6c6d4-005a-4937-9a0b-6f4edf22898c
4a8f1bdf-d56c-4e0c-b25f-101c985bf760	t	thumbnail	thumbnail	https://codedev.b-cdn.net/goods_01_458352_3x4.avif	fa909007-3edb-4f3a-80e8-625fb561f83d
02130262-fa1b-4640-bd0f-791aea7e8d28	t	thumbnail	thumbnail	https://codedev.b-cdn.net/goods_01_469283_3x4.avif	dc547225-1c35-47b2-a6c1-65155294fb4b
7dbaf3e4-847f-43d0-bf8b-950f977416b6	t	thumbnail	thumbnail	https://codedev.b-cdn.net/goods_11_467052_3x4.avif	af6e3447-bd40-4195-8ea8-dffac0d04462
a8617b42-6d43-4c86-8b14-43b67babf2ca	t	thumbnail	thumbnail	https://codedev.b-cdn.net/goods_12_446362_3x4.avif	ba6633d7-debc-4077-a515-ed2e9c231d47
e1c735b7-8bbf-42c3-abdb-d7e546369d82	t	thumbnail	thumbnail	https://codedev.b-cdn.net/uniqlo-womens-shorts-multi-black-s-shorts-from.jpg	256d3f0c-d9d7-43d6-a92f-cc0feeb14748
dc88d4d7-02f1-4495-883b-b40cc4f752d0	t	thumbnail	thumbnail	https://codedev.b-cdn.net/goods_452928_sub14_3x4.avif	01f6a99c-7f7f-41ec-bc2e-746c736e5771
a7a4e7e6-397c-4aec-b3df-b34895c0be0e	t	thumbnail	thumbnail	https://codedev.b-cdn.net/goods_474600_sub14_3x4.avif	ccb58e9f-af46-4281-9687-1f34340c4056
3dd6c963-f208-4273-bf41-c990019a31aa	t	thumbnail	thumbnail	https://codedev.b-cdn.net/images-(1).jfif	f58c4da4-1b9c-4423-ab35-1609ddf9fa0d
8da89578-ba5e-40f5-8bb1-e31e66466154	t	thumbnail	thumbnail	https://codedev.b-cdn.net/images.jfif	be30a4f5-8db9-4dec-8815-86a86933ab5c
ae1fa8ae-62f3-4574-97d9-530a8f3a579f	t	thumbnail	thumbnail	https://codedev.b-cdn.net/Jeans.jpg	aa4f90b1-2183-4399-9a6e-e243d9c73bdd
66c0046a-73f8-4793-bee8-92619e97ab87	t	thumbnail	thumbnail	https://codedev.b-cdn.net/il_300x300.5066263634_7ptz.webp	f49bf162-6a7d-44b5-bfae-dd3e7509d8e7
8ac3ad5b-27a1-4ef1-a042-0b78076de503	t	thumbnail	thumbnail	https://codedev.b-cdn.net/-original-imaheybpkhkghtgp.webp	f41649b7-4a92-4835-a541-3a3b208d2035
90995595-de2b-4648-b42f-110cde5ba357	t	thumbnail	thumbnail	https://codedev.b-cdn.net/uniqlo-navy-chino-shorts-xl.jpg	de047c5d-89a1-40dd-aef1-2d4b5cef1479
3ed973b3-a551-4493-ba0e-73b39a005366	t	thumbnail	thumbnail	https://codedev.b-cdn.net/UoN-College-Hoodie-USA-Burgundy-Portrait.jpg	ff62b492-5240-4201-a5dc-2d0a1579712c
088d7bb7-b8b6-4264-8634-29744417ed49	t	thumbnail	thumbnail	https://codedev.b-cdn.net/VG-UNIHOODIE-NAVY_316.webp	2e5cfa3b-29ef-4c1c-b14f-dc5580769a8c
148fd971-8d63-40b4-8798-ddb89b2950c7	t	thumbnail	thumbnail	https://codedev.b-cdn.net/a1.png	516847d9-c7dc-4711-9c45-d440db81ea1c
\.


--
-- TOC entry 4971 (class 0 OID 57844)
-- Dependencies: 227
-- Data for Name: product_variant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variant (id, color, size, stock_quantity, product_id) FROM stdin;
e689da9e-d825-4a10-ba94-42b98e37e01b	Gray	S	3	e13144e3-e540-4117-8e7f-21552b4be47b
b7495625-ae63-464f-9c76-ad92dfe4a4d1	Navy	M	5	caf4b186-8865-48db-a4ab-db311223b788
c617b647-f74c-4e46-abdc-95f3511aa184	Navy	L	5	caf4b186-8865-48db-a4ab-db311223b788
356e001c-f7ef-4206-8330-b62fe70d9fe0	Navy	XL	1	caf4b186-8865-48db-a4ab-db311223b788
d0bfeea9-8f52-432b-876e-4ccbe426612c	Pink	XL	5	7af5f5e9-a1c4-49d5-bb60-c70a35afe114
6d8fdf8a-c107-4227-9844-220a743f1ce3	Green	L	1	8ce27242-3941-4f77-b206-402b5876bf2b
75e24ec7-167b-4fc8-a946-83ffb732a2d3	Green	XL	10	8ce27242-3941-4f77-b206-402b5876bf2b
008ba511-65b5-4df2-b346-d46258695d92	Blue	L	5	ccc6c6d4-005a-4937-9a0b-6f4edf22898c
501ce86b-f129-4501-a2d6-1c72ae815466	Yellow	XL	1	fa909007-3edb-4f3a-80e8-625fb561f83d
05fe6645-ab65-4c80-9352-8f030a593922	Red	XL	12	dc547225-1c35-47b2-a6c1-65155294fb4b
9ad6f91b-9ab3-4dc2-87c3-bad6bf138e3c	Pink	L	12	af6e3447-bd40-4195-8ea8-dffac0d04462
e58ed1d4-5b67-49ca-95ac-602ff834cb9d	Red	L	12	ba6633d7-debc-4077-a515-ed2e9c231d47
7c285589-ec14-4a08-b8cb-fc561fc798ff	Red	XL	11	ba6633d7-debc-4077-a515-ed2e9c231d47
710a3164-e692-4174-b916-4b6f1a027794	Green	L	11	256d3f0c-d9d7-43d6-a92f-cc0feeb14748
b6042e65-d878-4fd5-99a2-eea1ce47daa1	Navy	M	11	01f6a99c-7f7f-41ec-bc2e-746c736e5771
7f9836e6-fa11-4a73-ac0d-f66bcac171f8	Navy	L	11	01f6a99c-7f7f-41ec-bc2e-746c736e5771
14d3c63d-9099-4278-9dd7-b1f1c7403d63	Green	XL	12	ccb58e9f-af46-4281-9687-1f34340c4056
6fec04e6-3d3f-4770-8f42-8c6a133d6b0f	Blue	XL	11	f58c4da4-1b9c-4423-ab35-1609ddf9fa0d
a7f5915f-f6a7-4618-ade4-d6bc10ab1cdd	Navy	XL	11	be30a4f5-8db9-4dec-8815-86a86933ab5c
2770cbec-60da-404d-8296-efd726d8a628	Blue	L	11	aa4f90b1-2183-4399-9a6e-e243d9c73bdd
23cb61a6-744c-4e26-820b-000c96d014e5	Navy	XL	11	f49bf162-6a7d-44b5-bfae-dd3e7509d8e7
bce8e534-19e6-4287-918e-572d6a56cb3d	Blue	XL	12	f41649b7-4a92-4835-a541-3a3b208d2035
72c03138-2eca-4845-8520-1c2e92ee0c29	Navy	XL	12	f41649b7-4a92-4835-a541-3a3b208d2035
93b9fa51-7864-453e-ab25-6bba0783d025	Black	XXL	11	de047c5d-89a1-40dd-aef1-2d4b5cef1479
564d165a-4d3d-4127-96d4-a04837455f50	Red	XL	65	ff62b492-5240-4201-a5dc-2d0a1579712c
79371ee5-914a-4304-9e5e-54fcd5c220cd	Navy	XL	11	2e5cfa3b-29ef-4c1c-b14f-dc5580769a8c
5ca1609e-c534-4c21-aee1-291aa0705f6d	Blue	S	3	516847d9-c7dc-4711-9c45-d440db81ea1c
\.


--
-- TOC entry 4972 (class 0 OID 57849)
-- Dependencies: 228
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) FROM stdin;
f49bf162-6a7d-44b5-bfae-dd3e7509d8e7	Uniqlo	2025-10-06 15:20:24.942	Stay cozy and stylish with this Dark Navy Hoodie, featuring modern design elements for a contemporary look. Made from soft, durable materials, it ensures comfort for everyday wear	f	Dark Navy Hoodie - Modern Designs	33.00	\N	Dark Navy Hoodie - Modern Designs	2025-10-06 15:20:24.942	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e917
e13144e3-e540-4117-8e7f-21552b4be47b	Python	2025-10-06 10:16:26.324	Women's Clothing	f	hoa hong	234.00	\N	shirt-hehe	2025-10-06 10:16:26.324	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e913
7c0b5dde-c8a4-4e0e-930a-ef47c67d1abc	123123	2025-10-06 13:42:22.658	123	t	Chin123	123123.00	\N	chin123	2025-10-06 13:42:22.658	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e914
caf4b186-8865-48db-a4ab-db311223b788	Uniqlo	2025-10-06 14:45:30.514	Embracing the spirit of the ocean and the joy of summer adventures, the Sailor Navy Crop is a must-have piece for your 2025 wardrobe.  Designed with a cropped silhouette and classic navy tone, it captures both elegance and youthful energy. 	t	Sailor Navy Crop – Summer Collection 2025	50.00	5	navy-1	2025-10-06 14:45:30.514	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e914
7af5f5e9-a1c4-49d5-bb60-c70a35afe114	NLQH	2025-10-06 14:48:02.781	Linen Summer Dress – A light and breathable dress designed for warm, sunny days. Made from premium linen for a natural, airy feel that keeps you cool and effortlessly elegant all summer long.	t	Linen Summer Dress	30.00	5	Linen Summer Dress	2025-10-06 14:48:02.781	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e913
8ce27242-3941-4f77-b206-402b5876bf2b	NLQH	2025-10-06 14:50:18.358	Kaki Shorts Wide Form – Comfortable and versatile shorts with a relaxed wide-leg fit. Crafted from soft cotton-khaki fabric for a cool, casual look that’s perfect for everyday wear or summer outings.	f	Kaki Shorts Wide Form	20.00	5	Kaki Shorts Wide Form	2025-10-06 14:50:18.358	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e922
ccc6c6d4-005a-4937-9a0b-6f4edf22898c	LilSneeze	2025-10-06 14:54:03.987	Elegant and timeless, the Blue Checkered Sleeveless Midi Dress is crafted from soft, breathable fabric with a subtle plaid pattern. Featuring a fitted waist and flowing skirt, it offers effortless grace and comfort for casual outings	t	Sleeveless Midi Dress - Smart Casual Collection	60.00	5	Sleeveless Midi Dress	2025-10-06 14:54:03.987	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e913
fa909007-3edb-4f3a-80e8-625fb561f83d	NLQH	2025-10-06 14:56:34.411	Simple yet refined, the Natural Linen Short-Sleeve Dress embodies effortless summer style. Made from soft linen-blend fabric, it offers breathability and a relaxed fit that keeps you cool and elegant all day long.	t	Natural Linen Short - Summer Collection	26.00	\N	Natural Linen Short	2025-10-06 14:56:34.411	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e921
dc547225-1c35-47b2-a6c1-65155294fb4b	Uniqlo	2025-10-06 14:59:27.772	A classic essential for everyday wear. The Basic Red Tee features a soft cotton fabric, relaxed fit, and vibrant red tone that adds a fresh pop of color to your back-to-school look. Easy to mix and match with jeans, skirts	t	Basic Red Tee - Back To School 	15.00	\N	Basic Red Tee - Back To School 	2025-10-06 14:59:27.772	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e921
af6e3447-bd40-4195-8ea8-dffac0d04462	Uniqlo	2025-10-06 15:01:46.077	Soft, comfy, and irresistibly cute. The Cotton Pinky Shorts are made from premium cotton fabric with a gentle touch and relaxed fit, perfect for lounging or bedtime comfort. A pastel pink tone brings a dreamy	f	Cotton Pinky Shorts - Sweet Dreams Collection 2025	15.00	\N	Cotton Pinky Shorts - Sweet Dreams Collection 2025	2025-10-06 15:01:46.077	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
ba6633d7-debc-4077-a515-ed2e9c231d47	NLQH	2025-10-06 15:04:12.716	A timeless wardrobe staple designed for both comfort and sophistication. The Basic Formal Shirt features a crisp silhouette, smooth cotton-blend fabric, and a tailored fit that’s perfect for work, meetings	f	Basic Formal Shirt - Daily Coffee Collection 2024	20.00	\N	Basic Formal Shirt - Daily Coffee Collection 2024	2025-10-06 15:04:12.716	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e914
256d3f0c-d9d7-43d6-a92f-cc0feeb14748	LilSneeze	2025-10-06 15:06:36.284	Lightweight, breezy, and full of tropical spirit. The Linen Hawaii Shorts are crafted from soft linen-blend fabric for maximum comfort and breathability. Featuring a relaxed fit and summer-inspired design	t	Linen Hawaii Shorts - Summer Site 2025	35.00	\N	Linen Hawaii Shorts - Summer Site 2025	2025-10-06 15:06:36.284	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915
01f6a99c-7f7f-41ec-bc2e-746c736e5771	Uniqlo	2025-10-06 15:08:31.477	Casual, comfy, and effortlessly stylish. The Basic Tee – Coffee Date features a soft cotton fabric with a relaxed fit, perfect for everyday wear. Its minimal design and neutral tone make it easy to pair	t	Basic Tee - Coffee Date 2024 New Design	19.00	\N	Basic Tee - Coffee Date 2024 New Design	2025-10-06 15:08:31.477	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e914
ccb58e9f-af46-4281-9687-1f34340c4056	Uniqlo	2025-10-06 15:10:37.758	Sporty and full of campus energy, the University Basketball Team Inspired Tee brings a retro athletic vibe to your everyday style. Made from soft, breathable cotton with bold varsity-style graphics	t	University Basketball Team Inspired Tee	22.00	\N	University Basketball Team Inspired Tee	2025-10-06 15:10:37.758	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e922
f58c4da4-1b9c-4423-ab35-1609ddf9fa0d	NLQH	2025-10-06 15:13:17.72	Elegant and timeless, crafted from soft, breathable fabric with a subtle plaid pattern. Featuring a fitted waist and flowing skirt, it offers effortless grace and comfort for casual	t	Marine Adventure T-Shirt - Aquatic New Collections	25.00	\N	Marine Adventure T-Shirt - Aquatic New Collections	2025-10-06 15:13:17.72	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e922
be30a4f5-8db9-4dec-8815-86a86933ab5c	LilSneeze	2025-10-06 15:16:20.577	Upgrade your wardrobe with these Denim Jeans, featuring a fresh streetwear-inspired design. Crafted for comfort and durability, they offer a perfect fit for everyday wear, effortlessly stylish	t	Denim Jean - New Street Wear Design	30.00	\N	Denim Jean - New Street Wear Design	2025-10-06 15:16:20.577	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e920
aa4f90b1-2183-4399-9a6e-e243d9c73bdd	NLQH	2025-10-06 15:18:03.189	Upgrade your wardrobe with these Denim Jeans, featuring a fresh streetwear-inspired design. Crafted for comfort and durability	t	Baggy Form Jean - Bright Color 	23.00	\N	Baggy Form Jean - Bright Color 	2025-10-06 15:18:03.189	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e916
f41649b7-4a92-4835-a541-3a3b208d2035	NLQH	2025-10-06 15:22:35.375	Step into style with the Classic Slight Form Jean from our Back To School 2025 Collection. Designed for a comfortable yet flattering fit, these jeans are perfect for everyday wear	t	Classic Slight Form Jean - Back To School 2025 Collection	21.00	\N	Classic Slight Form Jean - Back To School 2025 Collection	2025-10-06 15:22:35.375	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e920
de047c5d-89a1-40dd-aef1-2d4b5cef1479	NLQH	2025-10-06 15:24:16.835	Experience ultimate comfort with our Basic Shorts in a relaxing fit. Perfect for lounging or casual outings, they combine ease of movement with a clean, minimalist style	f	Basic Shorts Relaxing Form 	13.00	\N	Basic Shorts Relaxing Form 	2025-10-06 15:24:16.835	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e922
ff62b492-5240-4201-a5dc-2d0a1579712c	Uniqlo	2025-10-06 15:26:03.229	Make a bold statement with the Red Hoodie in a wide fit from our Back To School 2025 Collection. Designed for comfort and a relaxed silhouette, it’s perfect for layering or casual wear.	t	Red Hoodie Wide Form - Back To School 2025 Collection	34.00	\N	Red Hoodie Wide Form - Back To School 2025 Collection	2025-10-06 15:26:03.229	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e924
2e5cfa3b-29ef-4c1c-b14f-dc5580769a8c	NLQH	2025-10-06 15:27:35.492	Stay effortlessly stylish with the Boxy Form Hoodie, inspired by daily school wear. Its relaxed fit and soft fabric provide all-day comfort, making it perfect for classes or casual outings.	t	Boxy Form Hoodie - Daily School Wear Inspiration 	34.00	\N	Boxy Form Hoodie - Daily School Wear Inspiration 	2025-10-06 15:27:35.492	2a1c5c78-13b3-4b2b-85f1-8d6dcd9e7b42	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e924
516847d9-c7dc-4711-9c45-d440db81ea1c	Nike	2025-10-06 17:46:16.881	Women's Clothing	f	Skirt long	296.00	\N	shirt-long	2025-10-06 17:52:00.776	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e915	b9f7a5f1-30e1-49a6-83a2-2c93a8b6e914
\.


--
-- TOC entry 4776 (class 2606 OID 57855)
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 4778 (class 2606 OID 57857)
-- Name: auth_authority auth_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_authority
    ADD CONSTRAINT auth_authority_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 57859)
-- Name: auth_user_details auth_user_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_details
    ADD CONSTRAINT auth_user_details_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 57861)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4786 (class 2606 OID 57863)
-- Name: category_type category_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_type
    ADD CONSTRAINT category_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 57865)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 57867)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4792 (class 2606 OID 57869)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 57871)
-- Name: product_resources product_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT product_resources_pkey PRIMARY KEY (id);


--
-- TOC entry 4798 (class 2606 OID 57873)
-- Name: product_variant product_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT product_variant_pkey PRIMARY KEY (id);


--
-- TOC entry 4800 (class 2606 OID 57875)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4782 (class 2606 OID 57877)
-- Name: auth_user_details uki096w0jnvgjp70hpgqx5v1tbi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_details
    ADD CONSTRAINT uki096w0jnvgjp70hpgqx5v1tbi UNIQUE (email);


--
-- TOC entry 4794 (class 2606 OID 57879)
-- Name: payment ukmf7n8wo2rwrxsd6f3t9ub2mep; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT ukmf7n8wo2rwrxsd6f3t9ub2mep UNIQUE (order_id);


--
-- TOC entry 4802 (class 2606 OID 57881)
-- Name: products ukostq1ec3toafnjok09y9l7dox; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT ukostq1ec3toafnjok09y9l7dox UNIQUE (slug);


--
-- TOC entry 4814 (class 2606 OID 57882)
-- Name: products fk2pw105qhy1aca2a6bqc19rbxn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk2pw105qhy1aca2a6bqc19rbxn FOREIGN KEY (category_type_id) REFERENCES public.category_type(id);


--
-- TOC entry 4809 (class 2606 OID 57887)
-- Name: orders fk2r5d9dwditf15m06s7x6yusmf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk2r5d9dwditf15m06s7x6yusmf FOREIGN KEY (user_id) REFERENCES public.auth_user_details(id);


--
-- TOC entry 4812 (class 2606 OID 57892)
-- Name: product_resources fk3k1pn3x472fqhckh85qc6m6y7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT fk3k1pn3x472fqhckh85qc6m6y7 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 4807 (class 2606 OID 57897)
-- Name: order_items fkbioxgbv59vetrxe0ejfubep1w; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fkbioxgbv59vetrxe0ejfubep1w FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 4803 (class 2606 OID 57902)
-- Name: addresses fkbrvi7t6vo4g7pp8bij4dhlejv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fkbrvi7t6vo4g7pp8bij4dhlejv FOREIGN KEY (user_id) REFERENCES public.auth_user_details(id);


--
-- TOC entry 4810 (class 2606 OID 57907)
-- Name: orders fkhlglkvf5i60dv6dn397ethgpt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fkhlglkvf5i60dv6dn397ethgpt FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- TOC entry 4811 (class 2606 OID 57912)
-- Name: payment fklouu98csyullos9k25tbpk4va; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fklouu98csyullos9k25tbpk4va FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 4806 (class 2606 OID 57917)
-- Name: category_type fkmgwrsyriidy42m9273cybb8tr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_type
    ADD CONSTRAINT fkmgwrsyriidy42m9273cybb8tr FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4804 (class 2606 OID 57922)
-- Name: auth_user_authority fkn7t2r8oft6j1w61po11wnb19w; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_authority
    ADD CONSTRAINT fkn7t2r8oft6j1w61po11wnb19w FOREIGN KEY (authorities_id) REFERENCES public.auth_authority(id);


--
-- TOC entry 4805 (class 2606 OID 57927)
-- Name: auth_user_authority fko4vmid5kx45903pdsst9qu1p0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_authority
    ADD CONSTRAINT fko4vmid5kx45903pdsst9qu1p0 FOREIGN KEY (user_id) REFERENCES public.auth_user_details(id);


--
-- TOC entry 4808 (class 2606 OID 57932)
-- Name: order_items fkocimc7dtr037rh4ls4l95nlfi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fkocimc7dtr037rh4ls4l95nlfi FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 4815 (class 2606 OID 57937)
-- Name: products fkog2rp4qthbtt2lfyhfo32lsw9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fkog2rp4qthbtt2lfyhfo32lsw9 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4813 (class 2606 OID 57942)
-- Name: product_variant fktk6wrh1xwqq4vn2pf11mwycgv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT fktk6wrh1xwqq4vn2pf11mwycgv FOREIGN KEY (product_id) REFERENCES public.products(id);


-- Completed on 2025-10-07 19:29:27

--
-- PostgreSQL database dump complete
--

