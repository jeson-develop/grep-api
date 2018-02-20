module Upsertable
  extend ActiveSupport::Concern

  module ClassMethods
    def upsert(selector, setter={})
      found_or_created = find_or_create_by(selector) do |obj|
        setter.each do |name, value|
          obj[name] = value
        end
      end
      found_or_created.update_attributes setter
      found_or_created
    end

    def bare_upsert(selector, setter={})
      ActiveRecord::Base.connection_pool.with_connection do |conn|
        upsert = Upsert.new conn, table_name
        upsert.row selector, setter
      end
    end

    def bare_batch_upsert(rows)
      ActiveRecord::Base.connection_pool.with_connection do |conn|
        Upsert.batch(conn, table_name) do |upsert|
          rows.map { |row| upsert.row row[0], row[1] }
        end
      end
    end
  end
end
