# app/helpers/hashid_helper.rb
module HashidHelper
  # Sobrescreve o `id` de cada objeto da collection
  def hashify_ids(collection, hashids)
    if collection.blank? || !hashids.present?
      collection
    else
    collection.each do |record|
      real_id = record.id
      record.define_singleton_method(:id) do
        hashids.encode(real_id)
      end
    end
    end
  end
end
