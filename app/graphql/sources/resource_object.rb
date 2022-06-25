module Sources
  class ResourceObject < GraphQL::Dataloader::Source

    def fetch(ids)
      Resource
        .includes(:tweets)
        .where(tweets: { id: ids })
        .map { |res| [res] }
    end
  end
end
