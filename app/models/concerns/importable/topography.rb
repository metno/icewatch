module Importable
  module Topography
    extend ActiveSupport::Concern

    ASSIGNABLE_ATTRIBUTES = %w( concentration ridge_height consolidated
                                old snow_covered topography_lookup_code).freeze

    def from_export(json)
      obs_data = json.dup

      assign_attributes(obs_data.select { |k, _v| ASSIGNABLE_ATTRIBUTES.include?(k) })
    end
  end
end
