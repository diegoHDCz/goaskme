---- create above ----

ALTER TABLE messages 
    ADD COLUMN visualized_at TIMESTAMPTZ,
    ADD COLUMN visualized BOOLEAN NOT NULL DEFAULT false;

---- drop below ----

ALTER TABLE messages 
    DROP COLUMN visualized_at,
    DROP COLUMN visualized;