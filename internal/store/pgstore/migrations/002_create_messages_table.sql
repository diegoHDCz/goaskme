CREATE TABLE IF NOT EXISTS messages (
    "id"                uuid            PRIMARY KEY     NOT NULL    DEFAULT gen_random_uuid(),
    "room_id"           uuid                            NOT NULL,
    "message"           VARCHAR(255)                    NOT NULL,
    "reaction_count"    BIGINT                          NOT NULL    DEFAULT 0,
    "answered"          BOOLEAN                         NOT NULL    DEFAULT false,
    "author_id"         varchar(255)                    NOT NULL,
    "author_name"       varchar(255)                    NOT NULL,
    "created_at"        timestamptz                     NOT NULL,   DEFAULT now(),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

---- create above / drop below ----

DROP TABLE IF EXISTS messages;