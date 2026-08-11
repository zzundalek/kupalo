CREATE TABLE users (
	id UUID PRIMARY KEY,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE tags (
	id UUID PRIMARY KEY,
	user_id UUID NOT NULL,
	name TEXT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	archived_at TIMESTAMPTZ
);

CREATE TABLE gear_list_categories (
	gear_list_id UUID NOT NULL,
	category_id UUID NOT NULL,
	PRIMARY KEY (gear_list_id, category_id),
	name TEXT NOT NULL,
	description TEXT,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	archived_at TIMESTAMPTZ
);

CREATE TABLE gear (
	id UUID PRIMARY KEY,
	user_id UUID NOT NULL,
	name TEXT NOT NULL,
	description TEXT,
	weight_grams INTEGER,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	archived_at TIMESTAMPTZ
);

CREATE TABLE gear_lists (
	id UUID PRIMARY KEY,
	user_id UUID NOT NULL,
	name TEXT NOT NULL,
	description TEXT,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	archived_at TIMESTAMPTZ
);

CREATE TABLE gear_list_items (
	id UUID PRIMARY KEY,
	gear_id UUID NOT NULL,
	gear_list_id UUID NOT NULL,
	category_id UUID,
	quantity INTEGER NOT NULL,
	packing_type TEXT NOT NULL DEFAULT 'PACKED',
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	archived_at TIMESTAMPTZ
);

CREATE TABLE gear_tags (
	gear_id UUID NOT NULL,
	tag_id UUID NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	archived_at TIMESTAMPTZ,
	PRIMARY KEY (gear_id, tag_id)
);
