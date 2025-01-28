class TagService
  def self.createtag(post, tagnames)
    tagnames.each do |tagname|
      tag = Tag.find_or_create_by(name: tagname)
      PostTag.create(post: post, tag: tag) unless post.tags.include?(tag)
    end
  end

  def self.updatetag(post, tagnames)
    tagnames.each do |tagname|
      tag = Tag.find_or_create_by(name: tagname)
      post.tags << tag unless post.tags.include?(tag)
    end

    post.tags.where.not(name: tagnames).find_each do |tag|
      post.tags.delete(tag)
    end
  end
end
