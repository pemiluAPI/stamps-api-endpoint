module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :stamps do     
      
      desc "Return all Stamps"
      get do
        stamps = Array.new
        tags = params[:tags].split(',') unless params[:tags].nil?
        
        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 100 : params[:limit]
        
        search = ["text LIKE ?", "%#{params[:text]}%"]
        
        unless params[:tags].nil?
          arr_tags = Array.new
          tags.each do |tag|
            arr_tags << tag.tr("_", " ")
          end
          tags_search = ["tags.tag in (?)", arr_tags]
        end
        
        Stamp.includes(:tags)
          .where(search)
          .where(tags_search)
          .references(:tags)
          .limit(limit)
          .offset(params[:offset])
          .each do |stamp|
            tags_collection = params[:tags].nil? ? stamp.tags : Tag.where("id_stamp = ?", stamp.id)
            stamps << {
              id: stamp.id,
              text: stamp.text,
              url_small: stamp.url_small,
              width_small: stamp.width_small,
              height_small: stamp.height_small,
              url_medium: stamp.url_medium,
              width_medium: stamp.width_medium,
              height_medium: stamp.height_medium,
              url_large: stamp.url_large,
              width_large: stamp.width_large,
              height_large: stamp.height_large,
              tags: tags_collection.map { |tag| tag.tag }
            }
          end
          {
          results: {
            count: stamps.count,
            total: Stamp.includes(:tags).where(search).where(tags_search).references(:tags).count,
            stamps: stamps
          }
        }
      end
      
      desc "Return a single Stamp object with all its details"
      params do
        requires :id, type: String, desc: "Stamp ID."
      end
      route_param :id do
        get do
          stamp = Stamp.find_by(id: params[:id])
          {
            results: {
              count: 1,
              total: 1,
              stamp: [{
                id: stamp.id,
                text: stamp.text,
                url_small: stamp.url_small,
                width_small: stamp.width_small,
                height_small: stamp.height_small,
                url_medium: stamp.url_medium,
                width_medium: stamp.width_medium,
                height_medium: stamp.height_medium,
                url_large: stamp.url_large,
                width_large: stamp.width_large,
                height_large: stamp.height_large,
                tags: stamp.tags.map { |tag| tag.tag }
              }]
            }
          }
        end
      end
    end
    
    resource :tags do
      desc 'return a list of Tags objects'
      get do
        tags = Array.new
        Tag.group('tag').count.each do |field|
          tags << {
            tag: field[0],
            stamp_count: field[1]
          }
        end
        {
          results: {
            count: tags.count,
            tags: tags
          }
        }
      end
    end
  end
end