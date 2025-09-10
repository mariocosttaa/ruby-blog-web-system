# app/helpers/hashid_helper.rb
module HashidHelper
  # Sobrescreve o `id` de cada objeto ou objeto único
  def hashify_ids(data, hashids)
    return data if data.blank? || !hashids.present?

    if data.respond_to?(:each) # collection (array or ActiveRecord::Relation)
      data.each do |record|
        overwrite_id(record, hashids)
      end
    else # single object
      overwrite_id(data, hashids)
    end
    data
  end

  private
  # Helper interno para sobrescrever id
  def overwrite_id(record, hashids)
    real_id = record.id
    record.define_singleton_method(:id) do
      hashids.encode(real_id)
    end
  end
end
