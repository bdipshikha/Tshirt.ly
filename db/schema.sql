CREATE TABLE IF NOT EXISTS shirts (
	id INTEGER PRIMARY KEY,
	style TEXT,
	color TEXT,
	instock INTEGER,
	price REAL,
	shirt_image TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
	id INTEGER PRIMARY KEY,
	email TEXT,
	shirt_id INTEGER,
	quantity INTEGER,
	status TEXT DEFAULT "purchased",
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TRIGGER shirt_delete_trig BEFORE DELETE ON shirts BEGIN
  DELETE FROM orders WHERE shirt_id = OLD.id;
END;