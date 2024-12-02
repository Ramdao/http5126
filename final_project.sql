-- Creating tables
CREATE TABLE star_type (
    star_type_id INT AUTO_INCREMENT,
    PRIMARY KEY (star_type_id),
    name VARCHAR(200) NOT NULL
);

CREATE TABLE star (
    star_id INT AUTO_INCREMENT,
    PRIMARY KEY (star_id),
    name VARCHAR(200) NOT NULL UNIQUE,
    mass_kg FLOAT NOT NULL CHECK (mass_kg > 0),
    radius_km FLOAT NOT NULL CHECK (radius_km > 0),
    star_type_id INT, 
    FOREIGN KEY (star_type_id) REFERENCES star_type (star_type_id),
    formatted_mass_kg VARCHAR(255),
    formatted_radius_km VARCHAR(255)
);

CREATE TABLE planet_type (
    planet_type_id INT AUTO_INCREMENT,
    PRIMARY KEY (planet_type_id),
    name VARCHAR(200) NOT NULL
);

CREATE TABLE planet (
    planet_id INT AUTO_INCREMENT,
    PRIMARY KEY (planet_id),
    name VARCHAR(200) NOT NULL UNIQUE,
    mass_kg FLOAT NOT NULL CHECK (mass_kg > 0),
    radius_km FLOAT NOT NULL CHECK (radius_km > 0),
    habitable_zone CHAR(1) CHECK (habitable_zone IN ('Y', 'N')),
    planet_type_id INT, 
    FOREIGN KEY (planet_type_id) REFERENCES planet_type (planet_type_id),
    star_id INT, 
    FOREIGN KEY (star_id) REFERENCES star (star_id) ON DELETE CASCADE,
    formatted_mass_kg VARCHAR(255),
    formatted_radius_km VARCHAR(255)
);

CREATE TABLE moon_type (
    moon_type_id INT AUTO_INCREMENT,
    PRIMARY KEY (moon_type_id),
    name VARCHAR(200) NOT NULL
);

CREATE TABLE moon (
    moon_id INT AUTO_INCREMENT,
    PRIMARY KEY (moon_id),
    name VARCHAR(200) NOT NULL UNIQUE,
    mass_kg FLOAT NOT NULL CHECK (mass_kg > 0),
    radius_km FLOAT NOT NULL CHECK (radius_km > 0),
    moon_type_id INT, 
    FOREIGN KEY (moon_type_id) REFERENCES moon_type (moon_type_id),
    planet_id INT, 
    FOREIGN KEY (planet_id) REFERENCES planet (planet_id) ON DELETE CASCADE,
    formatted_mass_kg VARCHAR(255),
    formatted_radius_km VARCHAR(255)
);

-- Create view

CREATE VIEW view_layout AS 
SELECT 
    star.name AS star_name, 
    planet.name AS planet_name, 
    GROUP_CONCAT(moon.name ORDER BY moon.name SEPARATOR ', ') AS moon_names
FROM 
    star 
INNER JOIN 
    planet ON star.star_id = planet.star_id
LEFT JOIN 
    moon ON planet.planet_id = moon.planet_id
GROUP BY 
    star.star_id, planet.planet_id;

CREATE VIEW star_with_planets_view AS 
SELECT 
    star.name AS star_name, 
    GROUP_CONCAT(planet.name ORDER BY planet.name SEPARATOR ', ') AS planet_names
FROM 
    star
INNER JOIN 
    planet ON star.star_id = planet.star_id
GROUP BY 
    star.star_id;

-- Create Trigger 
DELIMITER //

CREATE TRIGGER trg_change_scientific_value_star
BEFORE INSERT ON star
FOR EACH ROW
BEGIN
    DECLARE base_value DOUBLE;
    DECLARE exponent_value INT;

    -- Format the mass_kg into scientific notation
    SET exponent_value = FLOOR(LOG10(NEW.mass_kg)); -- Get the exponent
    SET base_value = NEW.mass_kg / POW(10, exponent_value); -- Calculate the base value
    SET NEW.formatted_mass_kg = CONCAT(FORMAT(base_value, 3), ' × 10^', exponent_value);

    -- Format the radius_km into scientific notation
    SET exponent_value = FLOOR(LOG10(NEW.radius_km)); -- Get the exponent
    SET base_value = NEW.radius_km / POW(10, exponent_value); -- Calculate the base value
    SET NEW.formatted_radius_km = CONCAT(FORMAT(base_value, 3), ' × 10^', exponent_value);
END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER trg_change_scientific_value_planet
BEFORE INSERT ON planet
FOR EACH ROW
BEGIN
    DECLARE base_value DOUBLE;
    DECLARE exponent_value INT;

    -- Format the mass_kg into scientific notation
    SET exponent_value = FLOOR(LOG10(NEW.mass_kg));
    SET base_value = NEW.mass_kg / POW(10, exponent_value);
    SET NEW.formatted_mass_kg = CONCAT(FORMAT(base_value, 3), ' × 10^', exponent_value);

    -- Format the radius_km into scientific notation
    SET exponent_value = FLOOR(LOG10(NEW.radius_km));
    SET base_value = NEW.radius_km / POW(10, exponent_value);
    SET NEW.formatted_radius_km = CONCAT(FORMAT(base_value, 3), ' × 10^', exponent_value);
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_change_scientific_value_moon
BEFORE INSERT ON moon
FOR EACH ROW
BEGIN
    DECLARE base_value DOUBLE;
    DECLARE exponent_value INT;

    -- Format the mass_kg into scientific notation
    SET exponent_value = FLOOR(LOG10(NEW.mass_kg));
    SET base_value = NEW.mass_kg / POW(10, exponent_value);
    SET NEW.formatted_mass_kg = CONCAT(FORMAT(base_value, 3), ' × 10^', exponent_value);

    -- Format the radius_km into scientific notation
    SET exponent_value = FLOOR(LOG10(NEW.radius_km));
    SET base_value = NEW.radius_km / POW(10, exponent_value);
    SET NEW.formatted_radius_km = CONCAT(FORMAT(base_value, 3), ' × 10^', exponent_value);
END //

DELIMITER ;

-- Create function

DELIMITER //

CREATE FUNCTION fn_gravitational_calculator(mass DOUBLE, radius_km DOUBLE) 
RETURNS DOUBLE
BEGIN
    DECLARE meter DOUBLE;
    DECLARE gravity DOUBLE;
    DECLARE force_g DOUBLE;

    -- Convert radius from kilometers to meters
    SET meter = radius_km * 1000;

    -- Gravitational constant (in m^3 kg^-1 s^-2)
    SET gravity = 6.67430e-11;

    -- Calculate gravitational force (F = G * M / r^2)
    SET force_g = (gravity * mass) / (meter * meter);

    RETURN force_g;
END //

DELIMITER ;

-- insert into star
INSERT INTO star_type(name) 
VALUES ("yellow"),
('blue'),
('red dwarf');

INSERT INTO star (name, mass_kg, radius_km, star_type_id)
VALUES ('Sun', 1.989e30, 696340, 1),
       ('Alpha Centauri B', 1.804e30, 702060, 1),
       ('Proxima Centauri', 0.122e30, 200960, 3),
       ('Rigel', 21.0e30, 7850000, 2),
       ('Bellatrix', 8.6e30, 5800000, 2),
       ('Sirius A', 2.063e30, 1189640, 1),
       ('Sirius B', 0.978e30, 59020, 1),
       ('Vega', 2.1e30, 978460, 1),
       ('Altair', 1.79e30, 846870, 1),
       ('Betelgeuse', 20.0e30, 6171400, 1);

-- Insert into planet

-- planet types
INSERT INTO planet_type(name) VALUES ("rocky"),("gas giant"), ("ice giant");

INSERT INTO planet (name, mass_kg, radius_km, habitable_zone, planet_type_id, star_id)
VALUES ('Earth', 5.972e24, 6371, 'Y', 1, 1),
       ('Mercury', 3.301e23, 2439.7, 'N', 1, 1),
       ('Venus', 4.867e24, 6051.8, 'Y', 1, 1),
       ('Mars', 6.417e23, 3389.5, 'Y', 1, 1),
       ('Jupiter', 1.898e27, 69911, 'N', 2, 1),
       ('Saturn', 5.683e26, 58232, 'N', 2, 1),
       ('Uranus', 8.681e25, 25362, 'N', 3, 1),
       ('Neptune', 1.024e26, 24622, 'N', 3, 1),
       ('Proxima b', 1.27e24, 6371, 'Y', 1, 3),
       ('Proxima c', 2.13e24, 5432, 'N', 1, 3),
       ('Barnard b', 3.23e24, 6300, 'N', 1, 4),
       ('Barnard c', 4.12e24, 5400, 'N', 1, 4),
       ('Sirius b-I', 5.3e24, 6900, 'Y', 2, 5),
       ('Sirius b-II', 1.2e24, 5500, 'N', 1, 5),
       ('Vega b', 4.4e24, 6400, 'N', 1, 7),
       ('Vega c', 2.1e24, 5200, 'N', 3, 7),
       ('Altair b', 3.3e24, 6500, 'Y', 1, 8),
       ('Altair c', 2.8e24, 5800, 'N', 2, 8),
       ('Betelgeuse b', 6.0e24, 7300, 'N', 2, 9),
       ('Betelgeuse c', 4.5e24, 6000, 'Y', 3, 9);

-- Insert into moon

-- moon types
INSERT INTO moon_type(name) VALUES ("rocky"), ("icy");


INSERT INTO moon (name, mass_kg, radius_km, moon_type_id, planet_id)
-- Earth
VALUES ('Moon', 7.35e22, 1737.4, 1, 1),

-- Mars
('Phobos', 1.0659e16, 11.27, 1, 4),
('Deimos', 1.4762e15, 6.2, 1, 4),

-- Jupiter
('Io', 8.9319e22, 1821.6, 1, 5),
('Europa', 4.7998e22, 1560.8, 1, 5),

-- Saturn
('Titan', 1.3452e23, 2574.73, 1, 6),
('Enceladus', 1.08e20, 252.1, 1, 6),

-- Uranus
('Titania', 3.527e21, 788.9, 1, 7),
('Oberon', 3.014e21, 761.4, 1, 7),

-- Neptune
('Triton', 2.14e22, 1353.4, 1, 8),
('Proteus', 4.4e19, 210, 1, 8),

('Proxima b-I', 1.07e21, 500, 1, 9),
('Proxima b-II', 9.2e20, 430, 1, 9),
('Proxima c-I', 1.32e21, 510, 1, 10),
('Proxima c-II', 8.9e20, 400, 1, 10),
('Barnard b-I', 2.1e21, 600, 1, 11),
('Barnard b-II', 1.9e21, 550, 1, 11),
('Barnard c-I', 1.15e21, 480, 1, 12),
('Barnard c-II', 9.6e20, 410, 1, 12),
('Sirius b-I-a', 2.7e21, 670, 2, 13),
('Sirius b-I-b', 2.1e21, 640, 2, 13),
('Sirius b-II-a', 1.75e21, 500, 1, 14),
('Sirius b-II-b', 1.2e21, 480, 1, 14),
('Vega b-I', 1.9e21, 510, 1, 15),
('Vega b-II', 1.4e21, 450, 1, 15),
('Vega c-I', 2.2e21, 600, 1, 16),
('Vega c-II', 1.6e21, 540, 1, 16),
('Altair b-I', 1.8e21, 520, 2, 17),
('Altair b-II', 1.4e21, 490, 2, 17),
('Altair c-I', 2.1e21, 600, 1, 18),
('Altair c-II', 1.5e21, 550, 1, 18),
('Betelgeuse b-I', 3.0e21, 700, 2, 19),
('Betelgeuse b-II', 2.5e21, 680, 2, 19),
('Betelgeuse c-I', 2.8e21, 650, 1, 20),
 ('Betelgeuse c-II', 2.0e21, 620, 1, 20);

-- Function
-- SELECT name, fn_gravitational_calculator(mass_kg, radius_km) AS surface_gravity
-- FROM planet WHERE name = 'Earth';

-- Delete Cascade
-- DELETE FROM star WHERE name = 'Sun';