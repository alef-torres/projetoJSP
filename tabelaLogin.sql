create table login
(
    log_codigo integer not null,
    log_usuario character varying(100) not null,
    log_senha character varying(10) not null,
    log_nivelacesso character(1),
    CONSTRAINT pk_login PRIMARY KEY (log_codigo)
);
