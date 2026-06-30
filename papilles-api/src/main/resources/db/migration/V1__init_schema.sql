-- ============================================================
--  PAPILLES — V1__init_schema.sql
--  Migration initiale : structure complète de la base
-- ============================================================

-- ─── Extension UUID (optionnel, on garde SERIAL pour simplicité) ─
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
--  CATEGORIES
-- ============================================================
CREATE TABLE categories (
    id_category   SERIAL          PRIMARY KEY,
    category_name VARCHAR(100)    NOT NULL UNIQUE
);

-- ============================================================
--  USERS
-- ============================================================
CREATE TABLE users (
    user_id        SERIAL          PRIMARY KEY,
    email          VARCHAR(255)    NOT NULL UNIQUE,
    password_hash  VARCHAR(255)    NOT NULL,
    name           VARCHAR(100)    NOT NULL,
    surname        VARCHAR(100),
    phone          VARCHAR(20),
    picture        VARCHAR(500),
    role           VARCHAR(20)     NOT NULL DEFAULT 'USER',
    created_at     TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at     TIMESTAMP
);

-- ============================================================
--  RESTAURANTS
-- ============================================================
CREATE TABLE restaurants (
    restaurant_id          SERIAL          PRIMARY KEY,
    name                   VARCHAR(255)    NOT NULL,
    description            TEXT,
    website                VARCHAR(500),
    phone                  VARCHAR(20),
    address                VARCHAR(255)    NOT NULL,
    address_complementary  VARCHAR(255),
    code_postal            VARCHAR(10)     NOT NULL,
    city                   VARCHAR(100)    NOT NULL,
    country                VARCHAR(100)    NOT NULL DEFAULT 'France',
    latitude               DECIMAL(10, 7)  NOT NULL,
    longitude              DECIMAL(10, 7)  NOT NULL,
    picture                VARCHAR(500),
    category               INTEGER         NOT NULL REFERENCES categories(id_category),
    price_min              INTEGER,
    price_max              INTEGER,
    is_best                BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at             TIMESTAMP       NOT NULL DEFAULT NOW(),
    created_by             INTEGER         NOT NULL REFERENCES users(user_id),
    deleted_at             TIMESTAMP
);

-- ============================================================
--  OPINIONS (avis)
-- ============================================================
CREATE TABLE opinions (
    opinion_id     SERIAL          PRIMARY KEY,
    user_id        INTEGER         NOT NULL REFERENCES users(user_id),
    restaurant_id  INTEGER         NOT NULL REFERENCES restaurants(restaurant_id),
    rate           SMALLINT        NOT NULL CHECK (rate BETWEEN 1 AND 5),
    content        TEXT,
    date_created   TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_at     TIMESTAMP,
    UNIQUE (user_id, restaurant_id)
);

-- ============================================================
--  OPINIONS PICTURES
-- ============================================================
CREATE TABLE opinions_picture (
    opinion_picture_id  SERIAL       PRIMARY KEY,
    opinion_id          INTEGER      NOT NULL REFERENCES opinions(opinion_id) ON DELETE CASCADE,
    picture             VARCHAR(500) NOT NULL
);

-- ============================================================
--  OPINION LIKES
-- ============================================================
CREATE TABLE opinion_like (
    opinion_like_id  SERIAL    PRIMARY KEY,
    user_id          INTEGER   NOT NULL REFERENCES users(user_id),
    opinion_id       INTEGER   NOT NULL REFERENCES opinions(opinion_id) ON DELETE CASCADE,
    UNIQUE (user_id, opinion_id)
);

-- ============================================================
--  FAVOURITES
-- ============================================================
CREATE TABLE favourites (
    favourite_id   SERIAL    PRIMARY KEY,
    user_id        INTEGER   NOT NULL REFERENCES users(user_id),
    restaurant_id  INTEGER   NOT NULL REFERENCES restaurants(restaurant_id),
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, restaurant_id)
);

-- ============================================================
--  REPORTS
-- ============================================================
CREATE TABLE reports (
    report_id      SERIAL       PRIMARY KEY,
    user_id        INTEGER      NOT NULL REFERENCES users(user_id),
    reported_id    INTEGER      NOT NULL REFERENCES users(user_id),
    opinion_id     INTEGER      REFERENCES opinions(opinion_id),
    date_reported  TIMESTAMP    NOT NULL DEFAULT NOW(),
    reason         TEXT         NOT NULL,
    decision       TEXT,
    status         VARCHAR(20)  NOT NULL DEFAULT 'PENDING'
);

-- ============================================================
--  INSCRIPTIONS (demandes d'accès)
-- ============================================================
CREATE TABLE inscriptions (
    inscription_id  SERIAL       PRIMARY KEY,
    user_id         INTEGER      NOT NULL REFERENCES users(user_id),
    date_asked      TIMESTAMP    NOT NULL DEFAULT NOW(),
    reason          TEXT,
    status          VARCHAR(20)  NOT NULL DEFAULT 'PENDING'
);

-- ============================================================
--  NOTIFICATIONS
-- ============================================================
CREATE TABLE notifications (
    notification_id  SERIAL       PRIMARY KEY,
    user_id          INTEGER      NOT NULL REFERENCES users(user_id),
    notified_id      INTEGER      NOT NULL REFERENCES users(user_id),
    type             VARCHAR(50)  NOT NULL,
    is_read          BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
--  NOTIFICATIONS PREFERENCES
-- ============================================================
CREATE TABLE notifications_preferences (
    notification_preference_id  SERIAL      PRIMARY KEY,
    user_id                     INTEGER     NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    type                        VARCHAR(50) NOT NULL,
    enabled                     BOOLEAN     NOT NULL DEFAULT TRUE,
    UNIQUE (user_id, type)
);

-- ============================================================
--  REFRESH TOKENS (JWT — non présent dans le schéma initial)
-- ============================================================
CREATE TABLE refresh_tokens (
    token_id    SERIAL        PRIMARY KEY,
    user_id     INTEGER       NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    token       VARCHAR(500)  NOT NULL UNIQUE,
    expires_at  TIMESTAMP     NOT NULL,
    created_at  TIMESTAMP     NOT NULL DEFAULT NOW(),
    revoked     BOOLEAN       NOT NULL DEFAULT FALSE
);

-- ============================================================
--  INDEX — performances sur les colonnes fréquemment requêtées
-- ============================================================

-- users
CREATE INDEX idx_users_email        ON users(email);
CREATE INDEX idx_users_deleted_at   ON users(deleted_at);

-- restaurants
CREATE INDEX idx_restaurants_category    ON restaurants(category);
CREATE INDEX idx_restaurants_created_by  ON restaurants(created_by);
CREATE INDEX idx_restaurants_deleted_at  ON restaurants(deleted_at);
CREATE INDEX idx_restaurants_location    ON restaurants(latitude, longitude);
CREATE INDEX idx_restaurants_is_best     ON restaurants(is_best);

-- opinions
CREATE INDEX idx_opinions_user_id        ON opinions(user_id);
CREATE INDEX idx_opinions_restaurant_id  ON opinions(restaurant_id);
CREATE INDEX idx_opinions_deleted_at     ON opinions(deleted_at);

-- opinion_like
CREATE INDEX idx_opinion_like_opinion_id  ON opinion_like(opinion_id);
CREATE INDEX idx_opinion_like_user_id     ON opinion_like(user_id);

-- favourites
CREATE INDEX idx_favourites_user_id        ON favourites(user_id);
CREATE INDEX idx_favourites_restaurant_id  ON favourites(restaurant_id);

-- notifications
CREATE INDEX idx_notifications_user_id    ON notifications(user_id);
CREATE INDEX idx_notifications_is_read    ON notifications(is_read);

-- refresh_tokens
CREATE INDEX idx_refresh_tokens_user_id  ON refresh_tokens(user_id);
CREATE INDEX idx_refresh_tokens_token    ON refresh_tokens(token);
