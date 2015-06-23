module SunFrog
  class Service
    def self.post(orders:)
      Fulfiller::SunFrog::Models::Batch.new(orders: orders).process
    end
  end
end
