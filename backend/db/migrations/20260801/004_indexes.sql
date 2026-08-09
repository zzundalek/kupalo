CREATE INDEX idx_tags_user_id_updated_at ON tags(user_id, updated_at);

CREATE INDEX idx_gear_list_categories_gear_list_id_category_id_updated_at ON gear_list_categories(gear_list_id, category_id, updated_at);

CREATE INDEX idx_gear_user_id_updated_at ON gear(user_id, updated_at);

CREATE INDEX idx_gear_lists_user_id_updated_at ON gear_lists(user_id, updated_at);

CREATE INDEX idx_gear_list_items_gear_list_id_updated_at ON gear_list_items(gear_list_id, updated_at);

CREATE INDEX idx_gear_tags_gear_id_updated_at ON gear_tags(gear_id, updated_at);
