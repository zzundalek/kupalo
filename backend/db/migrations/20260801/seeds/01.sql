INSERT INTO
	users (id, created_at, updated_at)
VALUES
	(
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		NOW(),
		NOW()
	);

INSERT INTO
	tags (id, user_id, name, created_at, updated_at)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Sleeping',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Backpack',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Cooking',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a3',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'OneDay',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a4',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'MultiDay',
		NOW(),
		NOW()
	);

INSERT INTO
	gear (
		id,
		user_id,
		name,
		description,
		weight_grams,
		created_at,
		updated_at
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Granite Gear Crown 2',
		'Capacity: 60l, Size: Long',
		1120,
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'TrailBum Big Turtle Spectra 19l',
		'Capacity: 19l, Color: Gray',
		290,
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'MSR Folding Spork',
		'Color: Red',
		10,
		NOW(),
		NOW()
	);

INSERT INTO
	gear_tags (gear_id, tag_id, created_at, updated_at)
VALUES
	-- CROWN
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a3',
		NOW(),
		NOW()
	),
	--- BUM
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a4',
		NOW(),
		NOW()
	),
	--- MSR Spork
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		NOW(),
		NOW()
	);

INSERT INTO
	gear_lists (
		id,
		user_id,
		name,
		description,
		created_at,
		updated_at
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Test gear list 1',
		'Test gear list 1 - description',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae',
		'Test gear list 2',
		'Test gear list 2 - description',
		NOW(),
		NOW()
	);

INSERT INTO
	gear_list_categories (
		gear_list_id,
		category_id,
		name,
		description,
		created_at,
		updated_at
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'Sleeping',
		'Sleeping category description',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'Cooking',
		'Cooking category description',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'fff67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'Sleeping',
		'Sleeping category description',
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'fff67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'Cooking',
		'Cooking category description',
		NOW(),
		NOW()
	);

INSERT INTO
	gear_list_items (
		id,
		gear_list_id,
		gear_id,
		category_id,
		quantity,
		created_at,
		updated_at
	)
VALUES
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		1,
		NOW(),
		NOW()
	),
	(
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0',
		'eee67ad5-1730-476c-8d88-7ff5d5c3e4a2',
		NULL,
		2,
		NOW(),
		NOW()
	);
