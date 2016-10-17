module Sort
  extend ActiveSupport::Concern
  included do
    scope :sort_desc, -> {order(created_at: :desc)}
  end
end
