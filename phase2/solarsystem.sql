DROP SCHEMA IF EXISTS SolarSystem CASCADE;
CREATE SCHEMA SolarSystem;
SET SEARCH_PATH TO SolarSystem;
	
-- A domain representing the category of planet in Planet
CREATE DOMAIN Category AS VARCHAR(5)
	NOT NULL
	CHECK (VALUE IN ('dwarf', 'full'));

-- A planet in the the universe.
-- PID is the planet's ID, name is the English name of the planet, category is 
-- the size of the planet (dwarf vs. full size). Mass is the mass of the planet,
-- volume is the volume of the planet, moon_num is the number of moons in 
-- orbit, escape_speed is the speed needed for a rocket to escape the planet's 
-- orbit. Gravity is the gravitational force at the surface of the planet. 
CREATE TABLE Planet (
	BID TEXT,
	name TEXT NOT NULL,
	category Category NOT NULL,
	mass FLOAT NOT NULL,
	volume FLOAT NOT NULL,
	escape_speed FLOAT NOT NULL,
	gravity FLOAT NOT NULL,
	PRIMARY KEY (BID)
);

-- A moon not large enough to have significant mass, volume or gravity
-- BID is the ID of the moon. Name is the english name of the moon.
CREATE TABLE SmallerMoon (
	BID TEXT,
	name TEXT NOT NULL,
	PRIMARY KEY(BID)
);

-- A moon not large enough to have significant volume and gravity
-- BID is the ID of the moon. Name is the english name of the moon. Mass is the 
-- mass of the moon.
CREATE TABLE SmallMoon (
	BID TEXT,
	name TEXT NOT NULL,
	mass FLOAT NOT NULL,
	PRIMARY KEY(BID)
);

-- A moon large enough to have significant mass, volume, gravity and escape
-- BID is the ID of the moon. Name is the english name of the moon. Mass is the 
-- mass of the moon. Volume is the volume of the moon, escape_speed is the 
-- speed needed for a rocket to escape the moon's orbit. gravity is the 
-- force of the gravitational field on the moon's surface.
CREATE TABLE LargeMoon (
	BID TEXT,
	name TEXT NOT NULL,
	mass FLOAT NOT NULL,
	volume FLOAT NOT NULL,
	escape_speed FLOAT NOT NULL,
	gravity FLOAT NOT NULL,
	PRIMARY KEY(BID)
);

-- The orbit of a moon around a planet or a planet around the sun.
-- satellite is the ID of the satellite. parent_body is the ID of the parent body
-- perihelion, aphelion and eccentricity are the perihelion, aphelion and eccentricity of the
-- orbit.
CREATE TABLE Orbit (
	satellite TEXT,
	parent_body TEXT NOT NULL,
	perihelion FLOAT NOT NULL,
	aphelion FLOAT NOT NULL,
	eccentricity FLOAT NOT NULL,
	PRIMARY KEY(satellite, parent_body)
);

-- An asteriod which does not orbit around any planet. 
-- Asteriods don't have significant volume, gravity or escape.
CREATE TABLE Asteroid (
	BID TEXT,
	name TEXT NOT NULL,
	mass FLOAT NOT NULL,
	PRIMARY KEY(BID)
);

-- An astronomer
-- AID is the ID of the astronomer. name is the astronomer's name and 
-- nationality is his nationality.
CREATE TABLE Astronomer (
	AID INT,
	name TEXT NOT NULL,
	nationality TEXT,
	PRIMARY KEY(AID)
);

-- The relationship of a celestial body being discovered by an astronomer.
-- BID is the ID of the celestial body discovered. AID is the ID of the 
-- astronomer that discovered the body and discover_date is the date the 
--discovery was made.
CREATE TABLE Discovered (
	BID TEXT, 
	AID INT, 
	discovery_date TIMESTAMP,
	PRIMARY KEY(BID, AID),
	FOREIGN KEY (AID) REFERENCES Astronomer(AID)
);
