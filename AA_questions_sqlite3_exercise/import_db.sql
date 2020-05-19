DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;




PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(40) NOT NULL
);

INSERT INTO
    users(fname, lname)
VALUES
    ('Tom', 'Shamp'),
    ('Amber', 'Shamp'),
    ('Kai', 'Shamp'),
    ('Joe', 'Shamp'),
    ('Ted', 'Shamp');


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(30),
    body VARCHAR(250),
    author_id INTEGER,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('I love programming!', 'Hey fam! Does anyone know any new things about SQL?', (SELECT id FROM users WHERE fname = 'Tom' AND lname = 'Shamp')),
    ('Cats are rude...', 'Last night, I tried to eat some of Joes food and she hissed at me! WTF??!!?! Why did she do that?', (SELECT id FROM users WHERE fname = 'Kai' AND lname = 'Shamp')),
    ('Does anyone have food?', 'I think I need a nap....is that food you have?!', (SELECT id FROM users WHERE fname = 'Joe' AND lname = 'Shamp'));

CREATE TABLE questions_follows (
    id INTEGER PRIMARY KEY,
    users_question_id INTEGER,
    question_follower_id INTEGER,

    FOREIGN KEY (users_question_id) REFERENCES questions(id),
    FOREIGN KEY (question_follower_id) REFERENCES users(id)
);

INSERT INTO 
    questions_follows(users_question_id, question_follower_id)
VALUES
    (1, (SELECT id FROM users WHERE fname = 'Joe' AND lname = 'Shamp'));


CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject_question INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (subject_question) REFERENCES questions(id),
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

INSERT INTO 
    replies(subject_question, author_id, body)
VALUES
    (2, (SELECT id FROM users WHERE fname = 'Joe' AND lname = 'Shamp'), 'Excuse me ?! I will hiss at whoever I so please! Silly dog...' );


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    liked_question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (liked_question_id) REFERENCES questions(id)
);

INSERT INTO 
    question_likes(user_id, liked_question_id)
VALUES 
    (1, 3),
    (2, 1),
    (2, 3);

