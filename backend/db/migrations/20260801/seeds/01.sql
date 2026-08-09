INSERT INTO
	users (id)
VALUES
	('1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae');

INSERT INTO
	tags (id, user_id, name)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Sleeping'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Backpack'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Cooking'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a3',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'OneDay'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a4',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'MultiDay'
	);

INSERT INTO
	gear (
		id,
		user_id,
		name,
		description,
		weight_grams
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Granite Gear Crown 2',
		'Capacity: 60l, Size: Long',
		1120
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'TrailBum Big Turtle Spectra 19l',
		'Capacity: 19l, Color: Gray',
		290
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'MSR Folding Spork',
		'Color: Red',
		10
	);

INSERT INTO
	gear_tags (gear_id, tag_id)
VALUES
	-- CROWN
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a3'
	),
	--- BUM
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a4'
	),
	--- MSR Spork
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2'
	);

INSERT INTO
	gear_lists (id, user_id, name, description)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Test gear list 1',
		'Test gear list 1 - description'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Test gear list 2',
		'Test gear list 2 - description'
	);

INSERT INTO
	gear_list_categories (
		gear_list_id,
		category_id,
		name,
		description
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'Sleeping',
		'Sleeping category description'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'Cooking',
		'Cooking category description'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'fff67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'Sleeping',
		'Sleeping category description'
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'fff67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'Cooking',
		'Cooking category description'
	);

INSERT INTO
	gear_list_items (
		id,
		gear_list_id,
		gear_id,
		category_id,
		quantity
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		1
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		NULL,
		2
	);
