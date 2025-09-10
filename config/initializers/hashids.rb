require "hashids"
# Hashids padrão
HASHIDS_DEFAULT = Hashids.new("global secret salt", 12)

# Hashids específico para Categories
HASHIDS_CATEGORY = Hashids.new("category-id", 12)

# Hashids específico para Tags
HASHIDS_TAG = Hashids.new("tag-id", 12)

# Hashids específico para Posts
HASHIDS_POST = Hashids.new("post-id", 12)

# Hashids específico para Comments
HASHIDS_COMMENT = Hashids.new("comment-id", 12)
