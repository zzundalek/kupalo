ALTER TABLE
	tags
ADD
	CONSTRAINT fk_tags_users FOREIGN KEY (user_id) REFERENCES users(id),
ADD
	CONSTRAINT chk_tags_name_max_length CHECK (char_length(name) <= 100),
ADD
	CONSTRAINT uq_tags_user_id_name UNIQUE (user_id, name);

ALTER TABLE
	gear_list_categories
ADD
	CONSTRAINT fk_gear_list_categories_gear_lists FOREIGN KEY (gear_list_id) REFERENCES gear_lists(id),
ADD
	CONSTRAINT chk_gear_list_categories_name_max_length CHECK (char_length(name) <= 100),
ADD
	CONSTRAINT chk_gear_list_categories_description_max_length CHECK (
		description IS NULL
		OR char_length(description) <= 5000
	),
ADD
	CONSTRAINT uq_gear_list_categories_gear_list_id_name UNIQUE (gear_list_id, name);

ALTER TABLE
	gear
ADD
	CONSTRAINT fk_gear_users FOREIGN KEY (user_id) REFERENCES users(id),
ADD
	CONSTRAINT chk_gear_name_max_length CHECK (char_length(name) <= 100),
ADD
	CONSTRAINT chk_gear_description_max_length CHECK (
		description IS NULL
		OR char_length(description) <= 5000
	),
ADD
	CONSTRAINT chk_gear_weight_grams_null_or_positive CHECK (
		weight_grams IS NULL
		OR weight_grams > 0
	);

ALTER TABLE
	gear_lists
ADD
	CONSTRAINT fk_gear_lists_users FOREIGN KEY (user_id) REFERENCES users(id),
ADD
	CONSTRAINT chk_gear_lists_name_max_length CHECK (char_length(name) <= 100),
ADD
	CONSTRAINT chk_gear_lists_description_max_length CHECK (
		description IS NULL
		OR char_length(description) <= 5000
	),
ADD
	CONSTRAINT uq_gear_lists_user_id_name UNIQUE (user_id, name);

ALTER TABLE
	gear_list_items
ADD
	CONSTRAINT fk_gear_list_items_gear FOREIGN KEY (gear_id) REFERENCES gear(id),
ADD
	CONSTRAINT fk_gear_list_items_gear_lists FOREIGN KEY (gear_list_id) REFERENCES gear_lists(id),
ADD
	CONSTRAINT fk_gear_list_items_categories FOREIGN KEY (category_id, gear_list_id) REFERENCES gear_list_categories(category_id, gear_list_id),
ADD
	CONSTRAINT chk_gear_list_items_quantity_positive CHECK (quantity > 0),
ADD
	CONSTRAINT chk_gear_list_items_packing_type_enum CHECK (
		packing_type IN ('PACKED', 'WORN', 'CONSUMABLE')
	);

ALTER TABLE
	gear_tags
ADD
	CONSTRAINT fk_gear_tags_gear FOREIGN KEY (gear_id) REFERENCES gear(id),
ADD
	CONSTRAINT fk_gear_tags_tags FOREIGN KEY (tag_id) REFERENCES tags(id);
