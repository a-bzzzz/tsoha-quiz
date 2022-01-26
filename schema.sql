CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role INTEGER DEFAULT '2',
    active BOOLEAN,
    created_at TIMESTAMP
);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    role_name VARCHAR NOT NULL UNIQUE
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL UNIQUE
);

CREATE TABLE levels (
    id SERIAL PRIMARY KEY,
    level_name TEXT NOT NULL UNIQUE
);

CREATE TABLE answers (
    id SERIAL PRIMARY KEY,
    answer TEXT NOT NULL
);

CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    level_id INTEGER REFERENCES levels(id) ON DELETE CASCADE,
    answer_id INTEGER REFERENCES answers(id) ON DELETE CASCADE,
    created_at TIMESTAMP,
    creator INTEGER REFERENCES users(id) ON DELETE CASCADE 
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    points INTEGER,
    answers_count INTEGER,
    session_count INTEGER,
    category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    level_id INTEGER REFERENCES levels(id) ON DELETE CASCADE,
    created_at TIMESTAMP
);

CREATE TABLE game_questions (
    game_id INTEGER REFERENCES games(id) ON DELETE CASCADE,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE
);

CREATE TABLE stats (
    game_id INTEGER REFERENCES games(id) ON DELETE CASCADE,
    player_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO roles(role_name) VALUES ('admin');
INSERT INTO roles(role_name) VALUES ('user');
INSERT INTO roles(role_name) VALUES ('visitor');

INSERT INTO categories(category_name) VALUES ('tiede/maantiede');
INSERT INTO categories(category_name) VALUES ('historia');
INSERT INTO categories(category_name) VALUES ('urheilu/vapaa-aika/ruoka');
INSERT INTO categories(category_name) VALUES ('musiikki/taide//kirjallisuus');
INSERT INTO categories(category_name) VALUES ('elokuvat/TV/viihde');
INSERT INTO categories(category_name) VALUES ('satunnainen aihe');

INSERT INTO levels(level_name) VALUES ('helppo');
INSERT INTO levels(level_name) VALUES ('keskitaso');
INSERT INTO levels(level_name) VALUES ('vaikea');
