module DadataMetro
  class Constants
    BASE_URL = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/metro'.freeze

    FILTERS_FIELDS = %i[city_kladr_id city_fias_id city line_id is_closed].freeze

    QUERY_MAX_LENGTH = 300
  end
end
