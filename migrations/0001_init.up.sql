CREATE TABLE IF NOT EXISTS cars (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    permissions JSONB NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP WITHOUT TIME ZONE
);
