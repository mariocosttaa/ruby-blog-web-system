require "hashids"
# Hashids padrão
HASHIDS_DEFAULT = Hashids.new("global secret salt", 12)

# Hashids específico para Categories
HASHIDS_CATEGORY = Hashids.new("category-id", 12)
