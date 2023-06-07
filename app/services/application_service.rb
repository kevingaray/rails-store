class ApplicationService

  def self.call(*args)
      new(*args).call
  end

  def create_or_delete_items_tags(item, tags)
    item.taggables.destroy_all
    tags = tags.split(',')
    tags.each do |tag|
      item.tags << Tag.find_or_create_by(name: tag.strip)
    end
  end

end
