--
-- PostgreSQL database dump
--

\restrict zYGK72MtcemBdtpOZm28bsDkot8gTeAxz5PGFMC675BrUG2OSNYrOtbL8eTPm4a

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

-- Started on 2026-11-22 13:51:06

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
-- TOC entry 220 (class 1259 OID 32891)
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    address_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    address_line character varying(255) NOT NULL,
    city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    postal_code character varying(10) NOT NULL,
    country character varying(100) DEFAULT 'India'::character varying,
    is_default boolean DEFAULT false
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32890)
-- Name: addresses_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.addresses ALTER COLUMN address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.addresses_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 244 (class 1259 OID 33096)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    cart_item_id bigint NOT NULL,
    cart_id bigint NOT NULL,
    listing_id bigint NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_cart_quantity CHECK ((quantity > 0))
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 33095)
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cart_items ALTER COLUMN cart_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_items_cart_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 242 (class 1259 OID 33081)
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    cart_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 33080)
-- Name: carts_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.carts ALTER COLUMN cart_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.carts_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 32917)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id bigint NOT NULL,
    category_name character varying(100) NOT NULL,
    description text,
    parent_category_id bigint
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 32916)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.categories ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 32882)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id bigint NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(15),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 32881)
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customers ALTER COLUMN customer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customers_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 32970)
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    inventory_id bigint NOT NULL,
    listing_id bigint NOT NULL,
    stock_quantity integer DEFAULT 0 NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_stock_quantity CHECK ((stock_quantity >= 0))
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 32969)
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory ALTER COLUMN inventory_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 33007)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id bigint NOT NULL,
    order_id bigint NOT NULL,
    listing_id bigint NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    CONSTRAINT chk_item_price CHECK ((unit_price >= (0)::numeric)),
    CONSTRAINT chk_item_quantity CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 33006)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_items ALTER COLUMN order_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_items_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 32986)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    shipping_address_id bigint NOT NULL,
    order_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(12,2) DEFAULT 0 NOT NULL,
    order_status character varying(20) DEFAULT 'PLACED'::character varying NOT NULL,
    CONSTRAINT chk_order_amount CHECK ((total_amount >= (0)::numeric)),
    CONSTRAINT chk_order_status CHECK (((order_status)::text = ANY ((ARRAY['PLACED'::character varying, 'CONFIRMED'::character varying, 'SHIPPED'::character varying, 'DELIVERED'::character varying, 'CANCELLED'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 32985)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 33027)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id bigint NOT NULL,
    order_id bigint NOT NULL,
    payment_method character varying(20) NOT NULL,
    payment_amount numeric(12,2) NOT NULL,
    payment_status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    transaction_reference character varying(100),
    payment_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_payment_amount CHECK ((payment_amount > (0)::numeric)),
    CONSTRAINT chk_payment_method CHECK (((payment_method)::text = ANY ((ARRAY['UPI'::character varying, 'CARD'::character varying, 'NET_BANKING'::character varying, 'COD'::character varying])::text[]))),
    CONSTRAINT chk_payment_status CHECK (((payment_status)::text = ANY ((ARRAY['PENDING'::character varying, 'SUCCESS'::character varying, 'FAILED'::character varying, 'REFUNDED'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 33026)
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.payments ALTER COLUMN payment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payments_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 32932)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id bigint NOT NULL,
    product_name character varying(200) NOT NULL,
    description text,
    category_id bigint NOT NULL,
    brand character varying(100),
    product_status character varying(20) DEFAULT 'ACTIVE'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_product_status CHECK (((product_status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 32931)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 250 (class 1259 OID 33159)
-- Name: refunds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refunds (
    refund_id bigint NOT NULL,
    return_id bigint NOT NULL,
    payment_id bigint NOT NULL,
    refund_amount numeric(12,2) NOT NULL,
    refund_status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    refund_reference character varying(100),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    processed_at timestamp with time zone,
    CONSTRAINT chk_refund_amount CHECK ((refund_amount > (0)::numeric)),
    CONSTRAINT chk_refund_status CHECK (((refund_status)::text = ANY ((ARRAY['PENDING'::character varying, 'PROCESSING'::character varying, 'SUCCESS'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.refunds OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 33158)
-- Name: refunds_refund_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.refunds ALTER COLUMN refund_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.refunds_refund_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 248 (class 1259 OID 33141)
-- Name: returns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.returns (
    return_id bigint NOT NULL,
    order_item_id bigint NOT NULL,
    return_quantity integer DEFAULT 1 NOT NULL,
    return_reason text NOT NULL,
    return_status character varying(20) DEFAULT 'REQUESTED'::character varying NOT NULL,
    requested_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    approved_at timestamp with time zone,
    CONSTRAINT chk_return_quantity CHECK ((return_quantity > 0)),
    CONSTRAINT chk_return_status CHECK (((return_status)::text = ANY ((ARRAY['REQUESTED'::character varying, 'APPROVED'::character varying, 'REJECTED'::character varying, 'PICKED_UP'::character varying, 'COMPLETED'::character varying])::text[])))
);


ALTER TABLE public.returns OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 33140)
-- Name: returns_return_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.returns ALTER COLUMN return_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.returns_return_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 246 (class 1259 OID 33118)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    rating integer NOT NULL,
    review_title character varying(150),
    review_text text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_review_rating CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 33117)
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ALTER COLUMN review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reviews_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 32948)
-- Name: seller_listings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seller_listings (
    listing_id bigint NOT NULL,
    product_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    price numeric(12,2) NOT NULL,
    listing_status character varying(20) DEFAULT 'ACTIVE'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_listing_price CHECK ((price > (0)::numeric)),
    CONSTRAINT chk_listing_status CHECK (((listing_status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE public.seller_listings OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 32947)
-- Name: seller_listings_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.seller_listings ALTER COLUMN listing_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.seller_listings_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 32906)
-- Name: sellers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sellers (
    seller_id bigint NOT NULL,
    seller_name character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(15),
    business_city character varying(100),
    seller_status character varying(20) DEFAULT 'ACTIVE'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_seller_status CHECK (((seller_status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying, 'SUSPENDED'::character varying])::text[])))
);


ALTER TABLE public.sellers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 32905)
-- Name: sellers_seller_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sellers ALTER COLUMN seller_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sellers_seller_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 33045)
-- Name: shipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipments (
    shipment_id bigint NOT NULL,
    order_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    courier_name character varying(100),
    tracking_number character varying(100),
    shipment_status character varying(30) DEFAULT 'CREATED'::character varying NOT NULL,
    shipped_at timestamp with time zone,
    delivered_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_shipment_status CHECK (((shipment_status)::text = ANY ((ARRAY['CREATED'::character varying, 'SHIPPED'::character varying, 'IN_TRANSIT'::character varying, 'OUT_FOR_DELIVERY'::character varying, 'DELIVERED'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.shipments OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 33044)
-- Name: shipments_shipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipments ALTER COLUMN shipment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipments_shipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 33066)
-- Name: tracking_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracking_events (
    tracking_event_id bigint NOT NULL,
    shipment_id bigint NOT NULL,
    event_status character varying(30) NOT NULL,
    location character varying(150),
    event_description text,
    event_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_tracking_status CHECK (((event_status)::text = ANY ((ARRAY['CREATED'::character varying, 'SHIPPED'::character varying, 'IN_TRANSIT'::character varying, 'OUT_FOR_DELIVERY'::character varying, 'DELIVERED'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.tracking_events OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 33065)
-- Name: tracking_events_tracking_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tracking_events ALTER COLUMN tracking_event_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tracking_events_tracking_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5000 (class 0 OID 32891)
-- Dependencies: 220
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (address_id, customer_id, address_line, city, state, postal_code, country, is_default) FROM stdin;
1	1	House 25, Saket	New Delhi	Delhi	110017	India	f
2	1	Sector 62, Noida	Noida	Uttar Pradesh	201309	India	f
3	2	MG Road	Gurugram	Haryana	122001	India	f
4	3	Civil Lines	Bijnor	Uttar Pradesh	246701	India	f
\.


--
-- TOC entry 5024 (class 0 OID 33096)
-- Dependencies: 244
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (cart_item_id, cart_id, listing_id, quantity, added_at) FROM stdin;
1	1	1	2	2026-11-21 22:54:52.680022+05:30
2	1	4	1	2026-11-21 22:54:52.680022+05:30
\.


--
-- TOC entry 5022 (class 0 OID 33081)
-- Dependencies: 242
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (cart_id, customer_id, created_at, updated_at) FROM stdin;
1	1	2026-11-21 22:46:52.116783+05:30	2026-11-21 22:46:52.116783+05:30
\.


--
-- TOC entry 5004 (class 0 OID 32917)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name, description, parent_category_id) FROM stdin;
1	Electronics	Electronic products	\N
2	Computers	Computers and accessories	1
3	Keyboards	Computer keyboards and accessories	2
\.


--
-- TOC entry 4998 (class 0 OID 32882)
-- Dependencies: 218
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, full_name, email, phone, created_at) FROM stdin;
1	Rahul Sharma	rahul@example.com	9876543210	2026-11-15 17:27:18.783286+05:30
2	Priya Singh	priya@example.com	9876543211	2026-11-15 17:27:18.783286+05:30
3	Aman Verma	aman@example.com	9876543212	2026-11-15 17:27:18.783286+05:30
\.


--
-- TOC entry 5010 (class 0 OID 32970)
-- Dependencies: 230
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (inventory_id, listing_id, stock_quantity, updated_at) FROM stdin;
1	1	50	2026-11-17 07:29:17.482338+05:30
2	2	20	2026-11-17 07:29:17.482338+05:30
3	3	35	2026-11-17 07:29:17.482338+05:30
4	4	25	2026-11-17 07:29:17.482338+05:30
5	5	40	2026-11-17 07:29:17.482338+05:30
6	6	15	2026-11-17 07:29:17.482338+05:30
7	7	10	2026-11-17 07:29:17.482338+05:30
8	8	12	2026-11-17 07:29:17.482338+05:30
\.


--
-- TOC entry 5014 (class 0 OID 33007)
-- Dependencies: 234
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (order_item_id, order_id, listing_id, quantity, unit_price) FROM stdin;
1	1	1	1	650.00
2	1	2	1	700.00
\.


--
-- TOC entry 5012 (class 0 OID 32986)
-- Dependencies: 232
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, shipping_address_id, order_date, total_amount, order_status) FROM stdin;
1	1	1	2026-11-18 08:38:01.141406+05:30	1350.00	SHIPPED
\.


--
-- TOC entry 5016 (class 0 OID 33027)
-- Dependencies: 236
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, order_id, payment_method, payment_amount, payment_status, transaction_reference, payment_date) FROM stdin;
1	1	UPI	1350.00	SUCCESS	DEMO-UPI-001	2026-11-19 07:03:52.942991+05:30
\.


--
-- TOC entry 5006 (class 0 OID 32932)
-- Dependencies: 226
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, product_name, description, category_id, brand, product_status, created_at) FROM stdin;
1	Logitech K120 Keyboard	USB wired keyboard	3	Logitech	ACTIVE	2026-11-17 06:52:28.839583+05:30
2	HP K1500 Keyboard	Wired keyboard	3	HP	ACTIVE	2026-11-17 06:52:28.839583+05:30
3	Dell KB216 Keyboard	Multimedia wired keyboard	3	Dell	ACTIVE	2026-11-17 06:52:28.839583+05:30
4	Lenovo Laptop	8GB RAM and 512GB SSD	2	Lenovo	ACTIVE	2026-11-17 06:52:28.839583+05:30
5	HP Pavilion Laptop	16GB RAM and 512GB SSD	2	HP	ACTIVE	2026-11-17 06:52:28.839583+05:30
\.


--
-- TOC entry 5030 (class 0 OID 33159)
-- Dependencies: 250
-- Data for Name: refunds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refunds (refund_id, return_id, payment_id, refund_amount, refund_status, refund_reference, created_at, processed_at) FROM stdin;
1	1	1	650.00	PENDING	\N	2026-11-22 11:26:55.412721+05:30	\N
\.


--
-- TOC entry 5028 (class 0 OID 33141)
-- Dependencies: 248
-- Data for Name: returns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.returns (return_id, order_item_id, return_quantity, return_reason, return_status, requested_at, approved_at) FROM stdin;
1	1	1	Defective keyboard	REQUESTED	2026-11-22 10:23:11.792281+05:30	\N
\.


--
-- TOC entry 5026 (class 0 OID 33118)
-- Dependencies: 246
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, customer_id, product_id, rating, review_title, review_text, created_at) FROM stdin;
1	1	1	5	Excellent Keyboard	Good quality keyboard and easy to use	2026-11-22 09:11:30.77854+05:30
\.


--
-- TOC entry 5008 (class 0 OID 32948)
-- Dependencies: 228
-- Data for Name: seller_listings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seller_listings (listing_id, product_id, seller_id, price, listing_status, created_at) FROM stdin;
1	1	1	650.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
2	1	2	700.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
3	2	1	550.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
4	2	3	580.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
5	3	2	750.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
6	4	1	45000.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
7	4	3	44000.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
8	5	2	62000.00	ACTIVE	2026-11-17 07:07:58.931698+05:30
\.


--
-- TOC entry 5002 (class 0 OID 32906)
-- Dependencies: 222
-- Data for Name: sellers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sellers (seller_id, seller_name, email, phone, business_city, seller_status, created_at) FROM stdin;
1	TechWorld India	techworld@example.com	9876500001	Delhi	ACTIVE	2026-11-16 08:22:38.934133+05:30
2	Smart Electronics	smart@example.com	9876500002	Mumbai	ACTIVE	2026-11-16 08:22:38.934133+05:30
3	Digital Store	digital@example.com	9876500003	Bengaluru	ACTIVE	2026-11-16 08:22:38.934133+05:30
4	Quick Gadgets	quick@example.com	9876500004	Noida	INACTIVE	2026-11-16 08:22:38.934133+05:30
\.


--
-- TOC entry 5018 (class 0 OID 33045)
-- Dependencies: 238
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipments (shipment_id, order_id, seller_id, courier_name, tracking_number, shipment_status, shipped_at, delivered_at, created_at) FROM stdin;
1	1	1	Delhivery	DEMO-DEL-001	SHIPPED	2026-11-19 07:38:18.037912+05:30	\N	2026-11-19 07:38:18.037912+05:30
2	1	2	Blue Dart	DEMO-BD-002	IN_TRANSIT	2026-11-19 07:38:18.037912+05:30	\N	2026-11-19 07:38:18.037912+05:30
\.


--
-- TOC entry 5020 (class 0 OID 33066)
-- Dependencies: 240
-- Data for Name: tracking_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracking_events (tracking_event_id, shipment_id, event_status, location, event_description, event_time) FROM stdin;
1	1	CREATED	Delhi	Shipment created	2026-11-19 05:53:05.428156+05:30
2	1	SHIPPED	Delhi	Parcel dispatched	2026-11-19 06:53:05.428156+05:30
3	2	CREATED	Mumbai	Shipment created	2026-11-19 03:53:05.428156+05:30
4	2	SHIPPED	Mumbai	Parcel dispatched	2026-11-19 04:53:05.428156+05:30
5	2	IN_TRANSIT	Delhi Hub	Parcel arrived at transit hub	2026-11-19 07:53:05.428156+05:30
6	1	CREATED	Delhi	Shipment created	2026-11-21 19:08:52.980541+05:30
7	1	SHIPPED	Delhi	Parcel dispatched	2026-11-21 20:08:52.980541+05:30
8	2	CREATED	Mumbai	Shipment created	2026-11-21 17:08:52.980541+05:30
9	2	SHIPPED	Mumbai	Parcel dispatched	2026-11-21 18:08:52.980541+05:30
10	2	IN_TRANSIT	Delhi Hub	Parcel arrived at transit hub	2026-11-21 21:08:52.980541+05:30
\.


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 219
-- Name: addresses_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_address_id_seq', 4, true);


--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 243
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 2, true);


--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 241
-- Name: carts_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_cart_id_seq', 1, true);


--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 3, true);


--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 217
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 3, true);


--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 229
-- Name: inventory_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_inventory_id_seq', 8, true);


--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 233
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 3, true);


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 231
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, true);


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 235
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, true);


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 225
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 5, true);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 249
-- Name: refunds_refund_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refunds_refund_id_seq', 1, true);


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 247
-- Name: returns_return_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.returns_return_id_seq', 1, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 245
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 227
-- Name: seller_listings_listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seller_listings_listing_id_seq', 8, true);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 221
-- Name: sellers_seller_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sellers_seller_id_seq', 7, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 237
-- Name: shipments_shipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipments_shipment_id_seq', 2, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 239
-- Name: tracking_events_tracking_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracking_events_tracking_event_id_seq', 10, true);


--
-- TOC entry 4775 (class 2606 OID 32899)
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (address_id);


--
-- TOC entry 4815 (class 2606 OID 33103)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);


--
-- TOC entry 4811 (class 2606 OID 33089)
-- Name: carts carts_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_customer_id_key UNIQUE (customer_id);


--
-- TOC entry 4813 (class 2606 OID 33087)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);


--
-- TOC entry 4781 (class 2606 OID 32925)
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- TOC entry 4783 (class 2606 OID 32923)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4771 (class 2606 OID 32889)
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- TOC entry 4773 (class 2606 OID 32887)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 4791 (class 2606 OID 32979)
-- Name: inventory inventory_listing_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_listing_id_key UNIQUE (listing_id);


--
-- TOC entry 4793 (class 2606 OID 32977)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- TOC entry 4797 (class 2606 OID 33013)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 4795 (class 2606 OID 32995)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4801 (class 2606 OID 33036)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4803 (class 2606 OID 33038)
-- Name: payments payments_transaction_reference_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_transaction_reference_key UNIQUE (transaction_reference);


--
-- TOC entry 4785 (class 2606 OID 32941)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4825 (class 2606 OID 33167)
-- Name: refunds refunds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_pkey PRIMARY KEY (refund_id);


--
-- TOC entry 4827 (class 2606 OID 33171)
-- Name: refunds refunds_refund_reference_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_refund_reference_key UNIQUE (refund_reference);


--
-- TOC entry 4829 (class 2606 OID 33169)
-- Name: refunds refunds_return_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT refunds_return_id_key UNIQUE (return_id);


--
-- TOC entry 4823 (class 2606 OID 33152)
-- Name: returns returns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_pkey PRIMARY KEY (return_id);


--
-- TOC entry 4819 (class 2606 OID 33126)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 4787 (class 2606 OID 32956)
-- Name: seller_listings seller_listings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_listings
    ADD CONSTRAINT seller_listings_pkey PRIMARY KEY (listing_id);


--
-- TOC entry 4777 (class 2606 OID 32915)
-- Name: sellers sellers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_email_key UNIQUE (email);


--
-- TOC entry 4779 (class 2606 OID 32913)
-- Name: sellers sellers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (seller_id);


--
-- TOC entry 4805 (class 2606 OID 33052)
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (shipment_id);


--
-- TOC entry 4807 (class 2606 OID 33054)
-- Name: shipments shipments_tracking_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_tracking_number_key UNIQUE (tracking_number);


--
-- TOC entry 4809 (class 2606 OID 33074)
-- Name: tracking_events tracking_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_events
    ADD CONSTRAINT tracking_events_pkey PRIMARY KEY (tracking_event_id);


--
-- TOC entry 4817 (class 2606 OID 33105)
-- Name: cart_items uq_cart_listing; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT uq_cart_listing UNIQUE (cart_id, listing_id);


--
-- TOC entry 4821 (class 2606 OID 33128)
-- Name: reviews uq_customer_product_review; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT uq_customer_product_review UNIQUE (customer_id, product_id);


--
-- TOC entry 4799 (class 2606 OID 33015)
-- Name: order_items uq_order_listing; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT uq_order_listing UNIQUE (order_id, listing_id);


--
-- TOC entry 4789 (class 2606 OID 32958)
-- Name: seller_listings uq_seller_product; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_listings
    ADD CONSTRAINT uq_seller_product UNIQUE (seller_id, product_id);


--
-- TOC entry 4844 (class 2606 OID 33090)
-- Name: carts fk_cart_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_cart_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- TOC entry 4845 (class 2606 OID 33106)
-- Name: cart_items fk_cart_item_cart; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_item_cart FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id);


--
-- TOC entry 4846 (class 2606 OID 33111)
-- Name: cart_items fk_cart_item_listing; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_item_listing FOREIGN KEY (listing_id) REFERENCES public.seller_listings(listing_id);


--
-- TOC entry 4830 (class 2606 OID 32900)
-- Name: addresses fk_customer_address; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_customer_address FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- TOC entry 4835 (class 2606 OID 32980)
-- Name: inventory fk_inventory_listing; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT fk_inventory_listing FOREIGN KEY (listing_id) REFERENCES public.seller_listings(listing_id);


--
-- TOC entry 4833 (class 2606 OID 32959)
-- Name: seller_listings fk_listing_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_listings
    ADD CONSTRAINT fk_listing_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4834 (class 2606 OID 32964)
-- Name: seller_listings fk_listing_seller; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_listings
    ADD CONSTRAINT fk_listing_seller FOREIGN KEY (seller_id) REFERENCES public.sellers(seller_id);


--
-- TOC entry 4836 (class 2606 OID 33001)
-- Name: orders fk_order_address; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_address FOREIGN KEY (shipping_address_id) REFERENCES public.addresses(address_id);


--
-- TOC entry 4837 (class 2606 OID 32996)
-- Name: orders fk_order_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- TOC entry 4838 (class 2606 OID 33021)
-- Name: order_items fk_order_item_listing; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_item_listing FOREIGN KEY (listing_id) REFERENCES public.seller_listings(listing_id);


--
-- TOC entry 4839 (class 2606 OID 33016)
-- Name: order_items fk_order_item_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4831 (class 2606 OID 32926)
-- Name: categories fk_parent_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_parent_category FOREIGN KEY (parent_category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4840 (class 2606 OID 33039)
-- Name: payments fk_payment_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4832 (class 2606 OID 32942)
-- Name: products fk_product_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 4850 (class 2606 OID 33177)
-- Name: refunds fk_refund_payment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT fk_refund_payment FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id);


--
-- TOC entry 4851 (class 2606 OID 33172)
-- Name: refunds fk_refund_return; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refunds
    ADD CONSTRAINT fk_refund_return FOREIGN KEY (return_id) REFERENCES public.returns(return_id);


--
-- TOC entry 4849 (class 2606 OID 33153)
-- Name: returns fk_return_order_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT fk_return_order_item FOREIGN KEY (order_item_id) REFERENCES public.order_items(order_item_id);


--
-- TOC entry 4847 (class 2606 OID 33129)
-- Name: reviews fk_review_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- TOC entry 4848 (class 2606 OID 33134)
-- Name: reviews fk_review_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4841 (class 2606 OID 33055)
-- Name: shipments fk_shipment_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4842 (class 2606 OID 33060)
-- Name: shipments fk_shipment_seller; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_seller FOREIGN KEY (seller_id) REFERENCES public.sellers(seller_id);


--
-- TOC entry 4843 (class 2606 OID 33075)
-- Name: tracking_events fk_tracking_shipment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracking_events
    ADD CONSTRAINT fk_tracking_shipment FOREIGN KEY (shipment_id) REFERENCES public.shipments(shipment_id);


-- Completed on 2026-11-22 13:51:06

--
-- PostgreSQL database dump complete
--

\unrestrict zYGK72MtcemBdtpOZm28bsDkot8gTeAxz5PGFMC675BrUG2OSNYrOtbL8eTPm4a

